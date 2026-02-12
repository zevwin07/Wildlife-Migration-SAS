/* Link Excel files */
libname mydata1 xlsx "/home/u64310908/my_shared_file_links/ltaylor180/STS 2120 (Fall 2025)/STS 2120 Project Data Sets/salmon_all.xlsx";
libname mydata2 xlsx "/home/u64310908/my_shared_file_links/ltaylor180/STS 2120 (Fall 2025)/STS 2120 Project Data Sets/salmon_migration.xlsx";

/* Save sheets as SAS datasets */
data salmon_all;
    set mydata1.all;
run;

data salmon_migration;
    set mydata2.migration;
run;

/* Summary stats for length */
proc means data=salmon_all;
    class treatment;
    var length_mm;
run;

/* Box plot for length */
proc sgplot data=salmon_all;
    hbox length_mm / category=treatment;
run;

/* Summary stats for migration time */
proc means data=salmon_migration;
    class treatment;
    var migration_finish_time_days;
run;

/* Box plot for migration time */
proc sgplot data=salmon_migration;
    hbox migration_finish_time_days / category=treatment;
run;

/* Test length differences by treatment */
proc glm data=salmon_all;
    class treatment;
    model length_mm = treatment;
run;

/* Test migration time differences by treatment */
proc glm data=salmon_migration;
    class treatment;
    model migration_finish_time_days = treatment;
run;

/* Enter Yes/No counts */
data salmon_migration2;
    input status $ count;
    cards;
Yes  4
No   31
;
run;

/* Binomial test for Yes/No */
proc freq data=salmon_migration2;
    weight count;
    tables status / binomial(p=0.5 level="Yes") alpha=0.05 plots=freqplot;
run;

/* Show dataset columns */
proc contents data=salmon_all;
run;

proc contents data=salmon_migration;
run;