From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 5 Dec 2017 12:42:30 +0530
Subject: [PATCH v9 3/5] perf utils: use pmu->is_uncore to detect PMU
 UNCORE devices
In-Reply-To: <6fdad34d-1612-0447-e58e-5c748f92668d@linux.intel.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
 <20171016183222.25750-4-ganapatrao.kulkarni@cavium.com>
 <6fdad34d-1612-0447-e58e-5c748f92668d@linux.intel.com>
Message-ID: <CAKTKpr7oM4h_gxj1P=r_J_T5L_Mmtqqj_Uvji-fARKnQRnCP1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thanks Jin Yao for point this out.

looks like logic of leveraging uncore device type(which i have changed
in v9) does not go well
with some json events of x86.
can you please try below diff(logic used till v8), which keeps the
original logic of identifying core/cpu PMUs.


diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5ad8a18..57e38fd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -538,6 +538,34 @@ static bool pmu_is_uncore(const char *name)
 }

 /*
+ *  PMU CORE devices have different name other than cpu in sysfs on some
+ *  platforms. looking for possible sysfs files to identify as core device.
+ */
+static int is_pmu_core(const char *name)
+{
+ struct stat st;
+ char path[PATH_MAX];
+ const char *sysfs = sysfs__mountpoint();
+
+ if (!sysfs)
+ return 0;
+
+ /* Look for cpu sysfs (x86 and others) */
+ scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
+ if ((stat(path, &st) == 0) &&
+ (strncmp(name, "cpu", strlen("cpu")) == 0))
+ return 1;
+
+ /* Look for cpu sysfs (specific to arm) */
+ scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
+ sysfs, name);
+ if (stat(path, &st) == 0)
+ return 1;
+
+ return 0;
+}
+
+/*
  * Return the CPU id as a raw string.
  *
  * Each architecture should provide a more precise id string that
@@ -641,7 +669,7 @@ static void pmu_add_cpu_aliases(struct list_head
*head, struct perf_pmu *pmu)
  break;
  }

- if (pmu->is_uncore) {
+ if (!is_pmu_core(name)) {
  /* check for uncore devices */
  if (pe->pmu == NULL)
  continue;

i have tried this diff on my x86 PC(haswell) and looks to be ok.
please confirm your testing on skylake.

gkulkarni at gkFc25>perf>> ./perf stat --per-thread -p 12663 -M CPI,IPC sleep 1

 Performance counter stats for process id '12663':

            bash-12663               278,886      inst_retired.any:u
            bash-12663               482,284      cycles:u
            bash-12663               278,886      inst_retired.any:u
            bash-12663               483,597
cpu_clk_unhalted.thread:u

       1.000923760 seconds time elapsed


On Tue, Dec 5, 2017 at 7:42 AM, Jin, Yao <yao.jin@linux.intel.com> wrote:
> Hi Kulkarni, Arnaldo,
>
> This patch has been merged in perf/core branch today.
>
> But I see a regression issue when I run the 'perf stat'.
>
> With bisect checking, I locate to this patch.
>
> commit ad8737a08973f5dca632bdd63cf2abc99670e540
> Author: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Date:   Tue Oct 17 00:02:20 2017 +0530
>
>     perf pmu: Use pmu->is_uncore to detect UNCORE devices
>
> For example (on Intel skylake desktop),
>
> 1. The correct output should be (without this patch):
>
> root at skl:/tmp# perf stat --per-thread -p 1754 -M CPI,IPC
> ^C
>  Performance counter stats for process id '1754':
>
>           vmstat-1754              1,882,798      inst_retired.any     #
> 0.8 CPI
>           vmstat-1754              1,589,720      cycles
>           vmstat-1754              1,882,798      inst_retired.any     #
> 1.2 IPC
>           vmstat-1754              1,589,720      cpu_clk_unhalted.thread
>
>        2.647443167 seconds time elapsed
>
> 2. With this patch, the output will be:
>
> root at skl:/tmp# perf stat --per-thread -p 1754 -M CPI,IPC
> ^C
>  Performance counter stats for process id '1754':
>
>           vmstat-1754              1,945,589      inst_retired.any
>           vmstat-1754        <not supported>      inst_retired.any
>           vmstat-1754              1,609,892      cycles
>           vmstat-1754              1,945,589      inst_retired.any
>           vmstat-1754        <not supported>      inst_retired.any
>           vmstat-1754              1,609,892      cpu_clk_unhalted.thread
>           vmstat-1754        <not supported>      cpu_clk_unhalted.thread
>
>        3.051274166 seconds time elapsed
>
> Could you please help to take a look?
>
> Thanks
> Jin Yao
>
>
> On 10/17/2017 2:32 AM, Ganapatrao Kulkarni wrote:
>>
>> PMU CORE devices are identified using sysfs filename cpu, however
>> on some platforms(like arm/arm64), PMU CORE sysfs name is not cpu.
>> Hence cpu cannot be used to differentiate PMU CORE/UNCORE devices.
>>
>> commit:
>>   66ec1191 ("perf pmu: Unbreak perf record for arm/arm64 with events with
>> explicit PMU")
>>
>> has introduced pmu->is_uncore, which is set to PMU UNCORE devices only.
>> Adding changes to use pmu->is_uncore to identify UNCORE devices.
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>   tools/perf/util/pmu.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 8b17db5..9110718 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -603,7 +603,6 @@ static void pmu_add_cpu_aliases(struct list_head
>> *head, struct perf_pmu *pmu)
>>          */
>>         i = 0;
>>         while (1) {
>> -               const char *pname;
>>                 pe = &map->table[i++];
>>                 if (!pe->name) {
>> @@ -612,9 +611,13 @@ static void pmu_add_cpu_aliases(struct list_head
>> *head, struct perf_pmu *pmu)
>>                         break;
>>                 }
>>   -             pname = pe->pmu ? pe->pmu : "cpu";
>> -               if (strncmp(pname, name, strlen(pname)))
>> -                       continue;
>> +               if (pmu->is_uncore) {
>> +                       /* check for uncore devices */
>> +                       if (pe->pmu == NULL)
>> +                               continue;
>> +                       if (strncmp(pe->pmu, name, strlen(pe->pmu)))
>> +                               continue;
>> +               }
>>                 /* need type casts to override 'const' */
>>                 __perf_pmu__new_alias(head, NULL, (char *)pe->name,
>>
>

thanks
Ganapat
