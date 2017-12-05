From: yao.jin@linux.intel.com (Jin, Yao)
Date: Tue, 5 Dec 2017 10:12:11 +0800
Subject: [PATCH v9 3/5] perf utils: use pmu->is_uncore to detect PMU
 UNCORE devices
In-Reply-To: <20171016183222.25750-4-ganapatrao.kulkarni@cavium.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
 <20171016183222.25750-4-ganapatrao.kulkarni@cavium.com>
Message-ID: <6fdad34d-1612-0447-e58e-5c748f92668d@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kulkarni, Arnaldo,

This patch has been merged in perf/core branch today.

But I see a regression issue when I run the 'perf stat'.

With bisect checking, I locate to this patch.

commit ad8737a08973f5dca632bdd63cf2abc99670e540
Author: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Date:   Tue Oct 17 00:02:20 2017 +0530

     perf pmu: Use pmu->is_uncore to detect UNCORE devices

For example (on Intel skylake desktop),

1. The correct output should be (without this patch):

root at skl:/tmp# perf stat --per-thread -p 1754 -M CPI,IPC
^C
  Performance counter stats for process id '1754':

           vmstat-1754              1,882,798      inst_retired.any 
     #      0.8 CPI
           vmstat-1754              1,589,720      cycles
           vmstat-1754              1,882,798      inst_retired.any 
     #      1.2 IPC
           vmstat-1754              1,589,720      cpu_clk_unhalted.thread

        2.647443167 seconds time elapsed

2. With this patch, the output will be:

root at skl:/tmp# perf stat --per-thread -p 1754 -M CPI,IPC
^C
  Performance counter stats for process id '1754':

           vmstat-1754              1,945,589      inst_retired.any
           vmstat-1754        <not supported>      inst_retired.any
           vmstat-1754              1,609,892      cycles
           vmstat-1754              1,945,589      inst_retired.any
           vmstat-1754        <not supported>      inst_retired.any
           vmstat-1754              1,609,892      cpu_clk_unhalted.thread
           vmstat-1754        <not supported>      cpu_clk_unhalted.thread

        3.051274166 seconds time elapsed

Could you please help to take a look?

Thanks
Jin Yao

On 10/17/2017 2:32 AM, Ganapatrao Kulkarni wrote:
> PMU CORE devices are identified using sysfs filename cpu, however
> on some platforms(like arm/arm64), PMU CORE sysfs name is not cpu.
> Hence cpu cannot be used to differentiate PMU CORE/UNCORE devices.
> 
> commit:
>   66ec1191 ("perf pmu: Unbreak perf record for arm/arm64 with events with explicit PMU")
> 
> has introduced pmu->is_uncore, which is set to PMU UNCORE devices only.
> Adding changes to use pmu->is_uncore to identify UNCORE devices.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>   tools/perf/util/pmu.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8b17db5..9110718 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -603,7 +603,6 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>   	 */
>   	i = 0;
>   	while (1) {
> -		const char *pname;
>   
>   		pe = &map->table[i++];
>   		if (!pe->name) {
> @@ -612,9 +611,13 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>   			break;
>   		}
>   
> -		pname = pe->pmu ? pe->pmu : "cpu";
> -		if (strncmp(pname, name, strlen(pname)))
> -			continue;
> +		if (pmu->is_uncore) {
> +			/* check for uncore devices */
> +			if (pe->pmu == NULL)
> +				continue;
> +			if (strncmp(pe->pmu, name, strlen(pe->pmu)))
> +				continue;
> +		}
>   
>   		/* need type casts to override 'const' */
>   		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
> 
