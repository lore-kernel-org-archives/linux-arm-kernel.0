From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 12 Oct 2017 10:45:08 +0530
Subject: [PATCH v6 2/4] perf tools arm64: Add support for get_cpuid_str
 function.
In-Reply-To: <20171011121332.GA11106@arm.com>
References: <20170824120349.2323-1-ganapatrao.kulkarni@cavium.com>
 <20170824120349.2323-3-ganapatrao.kulkarni@cavium.com>
 <20171011121332.GA11106@arm.com>
Message-ID: <CAKTKpr5SVfCTzveQaNmWaVmgYmcVs7L35AJSb_d4-6TTQ3z=kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 5:43 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Aug 24, 2017 at 05:33:47PM +0530, Ganapatrao Kulkarni wrote:
>> function get_cpuid_str returns MIDR string of the first online
>> cpu from the range of cpus associated with the pmu core device.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  tools/perf/arch/arm64/util/Build    |  1 +
>>  tools/perf/arch/arm64/util/header.c | 60 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+)
>>  create mode 100644 tools/perf/arch/arm64/util/header.c
>>
>> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
>> index cef6fb3..b1ab72d 100644
>> --- a/tools/perf/arch/arm64/util/Build
>> +++ b/tools/perf/arch/arm64/util/Build
>> @@ -1,3 +1,4 @@
>> +libperf-y += header.o
>>  libperf-$(CONFIG_DWARF)     += dwarf-regs.o
>>  libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>>
>> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
>> new file mode 100644
>> index 0000000..f02a32e
>> --- /dev/null
>> +++ b/tools/perf/arch/arm64/util/header.c
>> @@ -0,0 +1,60 @@
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <api/fs/fs.h>
>> +#include "header.h"
>> +
>> +#define MIDR "/regs/identification/midr_el1"
>> +#define MIDR_SIZE 19
>> +
>> +char *get_cpuid_str(struct perf_pmu *pmu)
>> +{
>> +     char *buf = NULL;
>> +     char path[PATH_MAX];
>> +     const char *sysfs = sysfs__mountpoint();
>> +     int cpu;
>> +     u64 midr = 0;
>> +     struct cpu_map *cpus;
>> +     FILE *file;
>> +
>> +     if (!sysfs || !pmu->cpus)
>> +             return NULL;
>> +
>> +     buf = malloc(MIDR_SIZE);
>> +     if (!buf)
>> +             return NULL;
>> +
>> +     /* read midr from list of cpus mapped to this pmu */
>> +     cpus = cpu_map__get(pmu->cpus);
>> +     for (cpu = 0; cpu < cpus->nr; cpu++) {
>> +             scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
>> +                             sysfs, cpus->map[cpu]);
>> +
>> +             file = fopen(path, "r");
>> +             if (!file) {
>> +                     pr_debug("fopen failed for file %s\n", path);
>> +                     continue;
>> +             }
>> +
>> +             if (!fgets(buf, MIDR_SIZE, file))
>> +                     continue;
>> +             fclose(file);
>
> Don't you want to fclose the file if the fgets fails?

thanks.
>
>> +
>> +             /* Ignore/clear Variant[23:20] and
>> +              * Revision[3:0] of MIDR
>> +              */
>> +             midr = strtoul(buf, NULL, 16);
>> +             midr &= (~(0xf << 20 | 0xf));
>
> It would be cleaner if you had #defines for the MIDR fields that you're
> masking.

ok, i can add it.
I felt, it is not to required, since it is not used anywhere else and
for better code readability.

>
>> +             scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
>> +             /* got midr break loop */
>> +             break;
>> +     }
>> +
>> +     if (!midr) {
>> +             pr_err("failed to get cpuid string\n");
>
> Might be helpful to print the PMU name and the CPU map if there's a way
> to do that.

ok, i can print name,  need to check for cpu map.
>
> Will

thanks
Ganapat
