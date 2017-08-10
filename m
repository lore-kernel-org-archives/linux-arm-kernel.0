From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 10 Aug 2017 15:09:20 -0300
Subject: [PATCH v4 2/4] perf tools arm64: Add support for get_cpuid_str
 function.
In-Reply-To: <20170810171549.GE8173@arm.com>
References: <20170720055608.5333-1-ganapatrao.kulkarni@cavium.com>
 <20170720055608.5333-3-ganapatrao.kulkarni@cavium.com>
 <20170810171549.GE8173@arm.com>
Message-ID: <20170810180920.GC3900@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, Aug 10, 2017 at 06:15:50PM +0100, Will Deacon escreveu:
> On Thu, Jul 20, 2017 at 11:26:06AM +0530, Ganapatrao Kulkarni wrote:
> > function get_cpuid_str returns MIDR string of the first online
> > cpu from the range of cpus associated with the pmu core device.
> > 
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >  tools/perf/arch/arm64/util/Build    |  1 +
> >  tools/perf/arch/arm64/util/header.c | 59 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >  create mode 100644 tools/perf/arch/arm64/util/header.c
> > 
> > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> > index cef6fb3..b1ab72d 100644
> > --- a/tools/perf/arch/arm64/util/Build
> > +++ b/tools/perf/arch/arm64/util/Build
> > @@ -1,3 +1,4 @@
> > +libperf-y += header.o
> >  libperf-$(CONFIG_DWARF)     += dwarf-regs.o
> >  libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> >  
> > diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> > new file mode 100644
> > index 0000000..4e25498
> > --- /dev/null
> > +++ b/tools/perf/arch/arm64/util/header.c
> > @@ -0,0 +1,59 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <api/fs/fs.h>
> > +#include "header.h"
> > +
> > +#define MIDR "/regs/identification/midr_el1"
> > +#define MIDR_SIZE 128
> > +
> > +char *get_cpuid_str(struct perf_pmu *pmu)
> > +{
> > +	char *buf = malloc(MIDR_SIZE);
> > +	char *temp = NULL;
> > +	char path[PATH_MAX];
> > +	const char *sysfs = sysfs__mountpoint();
> > +	int cpu, ret;
> > +	unsigned long long midr;
> > +	struct cpu_map *cpus;
> > +	FILE *file;
> > +
> > +	if (!pmu->cpus)
> > +		return NULL;
> > +
> > +	if (!sysfs)
> > +		return NULL;
> > +
> > +	/* read midr from list of cpus mapped to this pmu */
> > +	cpus = cpu_map__get(pmu->cpus);
> > +	for (cpu = 0; cpu < cpus->nr; cpu++) {
> > +		ret = snprintf(path, PATH_MAX,
> > +				"%s/devices/system/cpu/cpu%d"MIDR,
> > +				sysfs, cpus->map[cpu]);
> > +		if (ret == PATH_MAX) {
> > +			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
> > +			goto err;
> > +		}
> > +
> > +		file = fopen(path, "r");
> > +		if (!file)
> > +			continue;
> > +
> > +		temp = fgets(buf, MIDR_SIZE, file);
> > +		fclose(file);
> > +		if (!temp)
> > +			continue;
> > +
> > +		/* Ignore/clear Variant[23:20] and
> > +		 * Revision[3:0] of MIDR
> > +		 */
> > +		midr = strtoll(buf, NULL, 16);
> > +		midr &= (~(0xf << 20 | 0xf));
> > +		snprintf(buf, MIDR_SIZE, "0x%016llx", midr);
> > +		cpu_map__put(cpus);
> > +		return buf;
> > +	}
> > +
> > +err:	cpu_map__put(cpus);
> > +	free(buf);
> > +	return NULL;
> > +}
> 
> Might just be me, but I found this really difficult to read. I think it
> works, but having the return at the end of loop is really counter-intuitive.
> 
> I'll leave it up to Arnaldo, since I can't find any functional problems
> with this series from the arm64 side.

And it uses malloc(128) and doesn't check its return as well, can you
please rewrite this having just one return, one refcount drop, etc,
outside of the loop?

And that fgets() return may be an error, don't you have to check it more
carefully?

Also please read the snprintf() man page, it doesn't return the number
of chars it actually wrote, but the number of chars it _would_ write, I
suggest you use scnprintf() instead.

Also it doesn't count the terminating null byte on what it returns, so
the check is flawed in that regard as well.

- Arnaldo
