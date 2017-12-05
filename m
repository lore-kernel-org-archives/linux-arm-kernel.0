From: yao.jin@linux.intel.com (Jin, Yao)
Date: Tue, 5 Dec 2017 15:23:18 +0800
Subject: [PATCH v9 3/5] perf utils: use pmu->is_uncore to detect PMU
 UNCORE devices
In-Reply-To: <CAKTKpr7oM4h_gxj1P=r_J_T5L_Mmtqqj_Uvji-fARKnQRnCP1w@mail.gmail.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
 <20171016183222.25750-4-ganapatrao.kulkarni@cavium.com>
 <6fdad34d-1612-0447-e58e-5c748f92668d@linux.intel.com>
 <CAKTKpr7oM4h_gxj1P=r_J_T5L_Mmtqqj_Uvji-fARKnQRnCP1w@mail.gmail.com>
Message-ID: <d576d4c6-663c-dfc1-5618-3fa7c5102e7a@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I applied the diff but it's failed.

jinyao at skl:~/skl-ws/perf-dev/lck-4594/src$ patch -p1 < 1.pat
patching file tools/perf/util/pmu.c
patch: **** malformed patch at line 41: *head, struct perf_pmu *pmu)

Could you send the patch as attachment to me in another mail thread?

to yao.jin at linux.intel.com
cc yao.jin@intel.com

Thanks
Jin Yao

On 12/5/2017 3:12 PM, Ganapatrao Kulkarni wrote:
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 5ad8a18..57e38fd 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -538,6 +538,34 @@ static bool pmu_is_uncore(const char *name)
>   }
> 
>   /*
> + *  PMU CORE devices have different name other than cpu in sysfs on some
> + *  platforms. looking for possible sysfs files to identify as core device.
> + */
> +static int is_pmu_core(const char *name)
> +{
> + struct stat st;
> + char path[PATH_MAX];
> + const char *sysfs = sysfs__mountpoint();
> +
> + if (!sysfs)
> + return 0;
> +
> + /* Look for cpu sysfs (x86 and others) */
> + scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
> + if ((stat(path, &st) == 0) &&
> + (strncmp(name, "cpu", strlen("cpu")) == 0))
> + return 1;
> +
> + /* Look for cpu sysfs (specific to arm) */
> + scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
> + sysfs, name);
> + if (stat(path, &st) == 0)
> + return 1;
> +
> + return 0;
> +}
> +
> +/*
>    * Return the CPU id as a raw string.
>    *
>    * Each architecture should provide a more precise id string that
> @@ -641,7 +669,7 @@ static void pmu_add_cpu_aliases(struct list_head
> *head, struct perf_pmu *pmu)
>    break;
>    }
> 
> - if (pmu->is_uncore) {
> + if (!is_pmu_core(name)) {
>    /* check for uncore devices */
>    if (pe->pmu == NULL)
>    continue;
