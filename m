From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 30 Jun 2017 15:02:41 +0100
Subject: [PATCH] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <20170628204310.b45fd92458a2fba810a7520b@arm.com>
References: <20170612112048.69561e8d067488e8689de755@arm.com>
 <20170615105735.b89183a9190a261d3b8d132a@arm.com>
 <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
 <20170628113249.GF5981@leverpostej>
 <20170628201638.01204c14719514217433e82d@arm.com>
 <20170628204310.b45fd92458a2fba810a7520b@arm.com>
Message-ID: <20170630140240.GB27839@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,

On Wed, Jun 28, 2017 at 08:43:10PM -0500, Kim Phillips wrote:
> 'perf record' and 'perf report --dump-raw-trace' supported in this
> release.
> 
> Example usage:
> 
> taskset -c 2 ./perf record -C 2 -c 1024 -e arm_spe_0/ts_enable=1,pa_enable=1/ \
> 		dd if=/dev/zero of=/dev/null count=10000
> 
> perf report --dump-raw-trace
> 
> Note that the perf.data file is portable, so the report can be run on another
> architecture host if necessary.
> 
> Output will contain raw SPE data and its textual representation, such as:
> 
> 0xc7d0 [0x30]: PERF_RECORD_AUXTRACE size: 0x82f70  offset: 0  ref: 0x1e947e88189  idx: 0  tid: -1  cpu: 2
> .
> . ... ARM SPE data: size 536432 bytes
> .  00000000:  4a 01                                           B COND
> .  00000002:  b1 00 00 00 00 00 00 00 80                      TGT 0 el0 ns=1
> .  0000000b:  42 42                                           RETIRED NOT-TAKEN
> .  0000000d:  b0 20 41 c0 ad ff ff 00 80                      PC ffffadc04120 el0 ns=1
> .  00000016:  98 00 00                                        LAT 0 TOT
> .  00000019:  71 80 3e f7 46 e9 01 00 00                      TS 2101429616256
> .  00000022:  49 01                                           ST
> .  00000024:  b2 50 bd ba 73 00 80 ff ff                      VA ffff800073babd50
> .  0000002d:  b3 50 bd ba f3 00 00 00 80                      PA f3babd50 ns=1
> .  00000036:  9a 00 00                                        LAT 0 XLAT
> .  00000039:  42 16                                           RETIRED L1D-ACCESS TLB-ACCESS
> .  0000003b:  b0 8c b4 1e 08 00 00 ff ff                      PC ff0000081eb48c el3 ns=1
> .  00000044:  98 00 00                                        LAT 0 TOT
> .  00000047:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
> .  00000050:  48 00                                           INSN-OTHER
> .  00000052:  42 02                                           RETIRED
> .  00000054:  b0 58 54 1f 08 00 00 ff ff                      PC ff0000081f5458 el3 ns=1
> .  0000005d:  98 00 00                                        LAT 0 TOT
> .  00000060:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
> ...
> 
> Other release notes:
> 
> - applies to acme's perf/{core,urgent} branches, likely elsewhere
> 
> - Record requires Will's SPE driver, currently undergoing upstream review
> 
> - the intel-bts implementation was used as a starting point; its
>   min/default/max buffer sizes and power of 2 pages granularity need to be
>   revisited for ARM SPE
> 
> - not been tested on platforms with multiple SPE clusters/domains
> 
> - snapshot support (record -S), and conversion to native perf events
>   (e.g., via 'perf inject --itrace'), are still in development
> 
> - technically both cs-etm and spe can be used simultaneously, however
>   disabled for simplicity in this release
> 
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c   |  20 +-
>  tools/perf/arch/arm/util/pmu.c        |   3 +
>  tools/perf/arch/arm64/util/Build      |   3 +-
>  tools/perf/arch/arm64/util/arm-spe.c  | 210 ++++++++++++++++
>  tools/perf/util/Build                 |   2 +
>  tools/perf/util/arm-spe-pkt-decoder.c | 448 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/arm-spe-pkt-decoder.h |  52 ++++
>  tools/perf/util/arm-spe.c             | 318 ++++++++++++++++++++++++
>  tools/perf/util/arm-spe.h             |  39 +++
>  tools/perf/util/auxtrace.c            |   3 +
>  tools/perf/util/auxtrace.h            |   1 +
>  11 files changed, 1095 insertions(+), 4 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/arm-spe.c
>  create mode 100644 tools/perf/util/arm-spe-pkt-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-pkt-decoder.h
>  create mode 100644 tools/perf/util/arm-spe.c
>  create mode 100644 tools/perf/util/arm-spe.h
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 8edf2cb71564..ec071609e8ac 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -22,29 +22,43 @@
>  #include "../../util/evlist.h"
>  #include "../../util/pmu.h"
>  #include "cs-etm.h"
> +#include "arm-spe.h"
>  
>  struct auxtrace_record
>  *auxtrace_record__init(struct perf_evlist *evlist, int *err)
>  {
> -	struct perf_pmu	*cs_etm_pmu;
> +	struct perf_pmu	*cs_etm_pmu, *arm_spe_pmu;
>  	struct perf_evsel *evsel;
> -	bool found_etm = false;
> +	bool found_etm = false, found_spe = false;
>  
>  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> +	arm_spe_pmu = perf_pmu__find(ARM_SPE_PMU_NAME);
>  
>  	if (evlist) {
>  		evlist__for_each_entry(evlist, evsel) {
>  			if (cs_etm_pmu &&
>  			    evsel->attr.type == cs_etm_pmu->type)
>  				found_etm = true;
> +			if (arm_spe_pmu &&
> +			    evsel->attr.type == arm_spe_pmu->type)
> +				found_spe = true;

Given ARM_SPE_PMU_NAME is defined as "arm_spe_0", this won't detect all
SPE PMUs in heterogeneous setups (e.g. this'll fail to match "arm_spe_1"
and so on).

Can we not find all PMUs with a "arm_spe_" prefix?

... or, taking a step back, do we need some sysfs "class" attribute to
identify multi-instance PMUs?

>  		}
>  	}
>  
> +	if (found_etm && found_spe) {
> +		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> +		*err = -EOPNOTSUPP;
> +		return NULL;
> +	}
> +
>  	if (found_etm)
>  		return cs_etm_record_init(err);
>  
> +	if (found_spe)
> +		return arm_spe_recording_init(err);

... so given the above, this will fail.

AFAICT, this means that perf record opens the event, but doesn't touch
the aux buffer at all.

> +
>  	/*
> -	 * Clear 'err' even if we haven't found a cs_etm event - that way perf
> +	 * Clear 'err' even if we haven't found an event - that way perf
>  	 * record can still be used even if tracers aren't present.  The NULL
>  	 * return value will take care of telling the infrastructure HW tracing
>  	 * isn't available.
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 98d67399a0d6..71fb8f13b40a 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -20,6 +20,7 @@
>  #include <linux/perf_event.h>
>  
>  #include "cs-etm.h"
> +#include "arm-spe.h"
>  #include "../../util/pmu.h"
>  
>  struct perf_event_attr
> @@ -31,6 +32,8 @@ struct perf_event_attr
>  		pmu->selectable = true;
>  		pmu->set_drv_config = cs_etm_set_drv_config;
>  	}
> +	if (!strcmp(pmu->name, ARM_SPE_PMU_NAME))
> +		pmu->selectable = true;

... likewise I here.

I guess we need an is_arm_spe_pmu() helper for both cases, iterating over
all PMUs.

>  #endif
>  	return NULL;
>  }
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index cef6fb38d17e..f9969bb88ccb 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -3,4 +3,5 @@ libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  
>  libperf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
>  			      ../../arm/util/auxtrace.o \
> -			      ../../arm/util/cs-etm.o
> +			      ../../arm/util/cs-etm.o \
> +			      arm-spe.o
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> new file mode 100644
> index 000000000000..07172764881c
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -0,0 +1,210 @@
> +/*
> + * ARM Statistical Profiling Extensions (SPE) support
> + * Copyright (c) 2017, ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/bitops.h>
> +#include <linux/log2.h>
> +
> +#include "../../util/cpumap.h"
> +#include "../../util/evsel.h"
> +#include "../../util/evlist.h"
> +#include "../../util/session.h"
> +#include "../../util/util.h"
> +#include "../../util/pmu.h"
> +#include "../../util/debug.h"
> +#include "../../util/tsc.h"
> +#include "../../util/auxtrace.h"
> +#include "../../util/arm-spe.h"
> +
> +#define KiB(x) ((x) * 1024)
> +#define MiB(x) ((x) * 1024 * 1024)
> +#define KiB_MASK(x) (KiB(x) - 1)
> +#define MiB_MASK(x) (MiB(x) - 1)

It's a shame we don't have a UAPI version of <linux/sizes.h>, though I
guess it's good to do the same thing as the x86 code.

I was a little worried that the *_MASK() helpers might be used with a
non power-of-two x, but it seems they're unused even for x86. Can we
please delete them?

> +struct arm_spe_recording {
> +	struct auxtrace_record		itr;
> +	struct perf_pmu			*arm_spe_pmu;
> +	struct perf_evlist		*evlist;
> +};

A user may wich to record trace on separate uarches simultaneously, so
having a singleton arm_spe_pmu for the entire evlist doesn't seem right.

e.g. I don't see why we should allow a user to do:

./perf record -c 1024 \
	-e arm_spe_0/ts_enable=1,pa_enable=0/ \
	-e arm_spe_1/ts_enable=1,pa_enable=0/ \
	${WORKLOAD}

... which perf-record seems to accept today, but I don't seem to get any
aux trace, regardless of whether I taskset the entire thing to any
particular CPU.

It also seems that the events aren't task bound, judging by -vv output:

------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             112
  config                           0x1
  { sample_period, sample_freq }   1024
  sample_type                      IP|TID|TIME|CPU|IDENTIFIER
  read_format                      ID
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 8
------------------------------------------------------------
perf_event_attr:
  type                             8
  size                             112
  config                           0x1
  { sample_period, sample_freq }   1024
  sample_type                      IP|TID|TIME|IDENTIFIER
  read_format                      ID
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 12
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             112
  config                           0x9
  { sample_period, sample_freq }   1024
  sample_type                      IP|TID|TIME|IDENTIFIER
  read_format                      ID
  disabled                         1
  inherit                          1
  exclude_kernel                   1
  exclude_hv                       1
  mmap                             1
  comm                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
sys_perf_event_open: pid 2181  cpu 0  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid 2181  cpu 1  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid 2181  cpu 2  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid 2181  cpu 3  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid 2181  cpu 4  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid 2181  cpu 5  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid 2181  cpu 6  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid 2181  cpu 7  group_fd -1  flags 0x8 = 20



I see something similar (i.e. perf doesn't try to bind the events to the
workload PID) when I try to record with only a single PMU. In that case,
perf-record blows up because it can't handle events on a subset of CPUs
(though it should be able to):

nanook at torsk:~$ ./perf record -vv -c 1024 -e arm_spe_0/ts_enable=1,pa_enable=0/ true
WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
check /proc/sys/kernel/kptr_restrict.

Samples in kernel functions may not be resolved if a suitable vmlinux
file is not found in the buildid cache or in the vmlinux path.

Samples in kernel modules won't be resolved at all.

If some relocation was applied (e.g. kexec) symbols may be misresolved
even with a suitable vmlinux or kallsyms file.

Problems creating module maps, continuing anyway...
------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             112
  config                           0x1
  { sample_period, sample_freq }   1024
  sample_type                      IP|TID|TIME|CPU|IDENTIFIER
  read_format                      ID
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 8
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             112
  config                           0x9
  { sample_period, sample_freq }   1024
  sample_type                      IP|TID|TIME|IDENTIFIER
  read_format                      ID
  disabled                         1
  inherit                          1
  exclude_kernel                   1
  exclude_hv                       1
  mmap                             1
  comm                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
sys_perf_event_open: pid 2185  cpu 0  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 2185  cpu 1  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 2185  cpu 2  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 2185  cpu 3  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 2185  cpu 4  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid 2185  cpu 5  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid 2185  cpu 6  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid 2185  cpu 7  group_fd -1  flags 0x8 = 16
mmap size 266240B
AUX area mmap length 131072
perf event ring buffer mmapped per cpu
failed to mmap AUX area
failed to mmap with 524 (INTERNAL ERROR: strerror_r(524, 0xffffc8596038, 512)=22)



... with a SW event, this works as expected, being bound to the workload PID:

nanook at torsk:~$ ./perf record -vvv -e context-switches true
WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
check /proc/sys/kernel/kptr_restrict.

Samples in kernel functions may not be resolved if a suitable vmlinux
file is not found in the buildid cache or in the vmlinux path.

Samples in kernel modules won't be resolved at all.

If some relocation was applied (e.g. kexec) symbols may be misresolved
even with a suitable vmlinux or kallsyms file.

Problems creating module maps, continuing anyway...
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             112
  config                           0x3
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|PERIOD
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
sys_perf_event_open: pid 2220  cpu 0  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid 2220  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 2220  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 2220  cpu 3  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid 2220  cpu 4  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 2220  cpu 5  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 2220  cpu 6  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 2220  cpu 7  group_fd -1  flags 0x8 = 12
mmap size 528384B
perf event ring buffer mmapped per cpu
Couldn't record kernel reference relocation symbol
Symbol resolution may be skewed if relocation was used (e.g. kexec).
Check /proc/kallsyms permission or run as root.
[ perf record: Woken up 1 times to write data ]
overlapping maps in /lib/aarch64-linux-gnu/ld-2.19.so (disable tui for more info)
overlapping maps in [vdso] (disable tui for more info)
overlapping maps in /tmp/perf-2220.map (disable tui for more info)
Looking at the vmlinux_path (8 entries long)
No kallsyms or vmlinux with build-id cc083c873190ff1254624d3137142c6841c118c3 was found
[kernel.kallsyms] with build id cc083c873190ff1254624d3137142c6841c118c3 not found, continuing without symbols
overlapping maps in /etc/ld.so.cache (disable tui for more info)
overlapping maps in /lib/aarch64-linux-gnu/libc-2.19.so (disable tui for more info)
overlapping maps in /tmp/perf-2220.map (disable tui for more info)
overlapping maps in /tmp/perf-2220.map (disable tui for more info)
overlapping maps in /tmp/perf-2220.map (disable tui for more info)
overlapping maps in /tmp/perf-2220.map (disable tui for more info)
overlapping maps in /lib/aarch64-linux-gnu/libc-2.19.so (disable tui for more info)
overlapping maps in /bin/true (disable tui for more info)
overlapping maps in /lib/aarch64-linux-gnu/ld-2.19.so (disable tui for more info)
failed to write feature HEADER_CPUDESC
failed to write feature HEADER_CPUID
[ perf record: Captured and wrote 0.002 MB perf.data (4 samples) ]



... so I guess this has something to do with the way the tool tries to
use the cpumask, maknig the wrong assumption that this implies
system-wide collection is mandatory / expected.

> +
> +static size_t
> +arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> +			 struct perf_evlist *evlist __maybe_unused)
> +{
> +	return ARM_SPE_AUXTRACE_PRIV_SIZE;
> +}
> +
> +static int arm_spe_info_fill(struct auxtrace_record *itr,
> +			       struct perf_session *session,
> +			       struct auxtrace_info_event *auxtrace_info,
> +			       size_t priv_size)
> +{
> +	struct arm_spe_recording *sper =
> +			container_of(itr, struct arm_spe_recording, itr);
> +	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
> +
> +	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
> +		return -EINVAL;
> +
> +	if (!session->evlist->nr_mmaps)
> +		return -EINVAL;
> +
> +	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
> +	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
> +
> +	return 0;
> +}
> +
> +static int arm_spe_recording_options(struct auxtrace_record *itr,
> +				       struct perf_evlist *evlist,
> +				       struct record_opts *opts)
> +{
> +	struct arm_spe_recording *sper =
> +			container_of(itr, struct arm_spe_recording, itr);
> +	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
> +	struct perf_evsel *evsel, *arm_spe_evsel = NULL;
> +	const struct cpu_map *cpus = evlist->cpus;
> +	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
> +	struct perf_evsel *tracking_evsel;
> +	int err;
> +
> +	sper->evlist = evlist;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel->attr.type == arm_spe_pmu->type) {
> +			if (arm_spe_evsel) {
> +				pr_err("There may be only one " ARM_SPE_PMU_NAME " event\n");
> +				return -EINVAL;
> +			}
> +			evsel->attr.freq = 0;
> +			evsel->attr.sample_period = 1;
> +			arm_spe_evsel = evsel;
> +			opts->full_auxtrace = true;
> +		}
> +	}

Theoretically, we could ask for different events on different CPUs, but
otehrwise, this looks sane.

> +
> +	if (!opts->full_auxtrace)
> +		return 0;
> +
> +	/* We are in full trace mode but '-m,xyz' wasn't specified */
> +	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
> +		if (privileged) {
> +			opts->auxtrace_mmap_pages = MiB(4) / page_size;
> +		} else {
> +			opts->auxtrace_mmap_pages = KiB(128) / page_size;
> +			if (opts->mmap_pages == UINT_MAX)
> +				opts->mmap_pages = KiB(256) / page_size;
> +		}
> +	}
> +
> +	/* Validate auxtrace_mmap_pages */
> +	if (opts->auxtrace_mmap_pages) {
> +		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
> +		size_t min_sz = KiB(8);
> +
> +		if (sz < min_sz || !is_power_of_2(sz)) {
> +			pr_err("Invalid mmap size for ARM SPE: must be at least %zuKiB and a power of 2\n",
> +			       min_sz / 1024);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> +	 * must come first.
> +	 */
> +	perf_evlist__to_front(evlist, arm_spe_evsel);

Huh? *what* needs the auxtrace buffer fd?

This seems really fragile. Can't we store this elsewhere?

> +
> +	/*
> +	 * In the case of per-cpu mmaps, we need the CPU on the
> +	 * AUX event.
> +	 */
> +	if (!cpu_map__empty(cpus))
> +		perf_evsel__set_sample_bit(arm_spe_evsel, CPU);
> +
> +	/* Add dummy event to keep tracking */
> +	err = parse_events(evlist, "dummy:u", NULL);
> +	if (err)
> +		return err;
> +
> +	tracking_evsel = perf_evlist__last(evlist);
> +	perf_evlist__set_tracking_event(evlist, tracking_evsel);
> +
> +	tracking_evsel->attr.freq = 0;
> +	tracking_evsel->attr.sample_period = 1;
> +
> +	/* In per-cpu case, always need the time of mmap events etc */
> +	if (!cpu_map__empty(cpus))
> +		perf_evsel__set_sample_bit(tracking_evsel, TIME);
> +
> +	return 0;
> +}
> +
> +static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
> +{
> +	u64 ts;
> +
> +	asm volatile ("isb; mrs %0, cntvct_el0" : "=r" (ts));
> +
> +	return ts;
> +}

I do not think it's a good idea to read the counter directly like this.

What is this "reference" intended to be meaningful relative to?

Why do we need to do this in userspace?

Can we not ask the kernel to output timestamps instead?

> +
> +static void arm_spe_recording_free(struct auxtrace_record *itr)
> +{
> +	struct arm_spe_recording *sper =
> +			container_of(itr, struct arm_spe_recording, itr);
> +
> +       free(sper);
> +}
> +
> +static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
> +{
> +	struct arm_spe_recording *sper =
> +			container_of(itr, struct arm_spe_recording, itr);
> +	struct perf_evsel *evsel;
> +
> +	evlist__for_each_entry(sper->evlist, evsel) {
> +		if (evsel->attr.type == sper->arm_spe_pmu->type)
> +			return perf_evlist__enable_event_idx(sper->evlist,
> +							     evsel, idx);
> +	}
> +	return -EINVAL;
> +}
> +
> +struct auxtrace_record *arm_spe_recording_init(int *err)
> +{
> +	struct perf_pmu *arm_spe_pmu = perf_pmu__find(ARM_SPE_PMU_NAME);
> +	struct arm_spe_recording *sper;
> +
> +	if (!arm_spe_pmu)
> +		return NULL;

No need to set *err here?

> +
> +	sper = zalloc(sizeof(struct arm_spe_recording));
> +	if (!sper) {
> +		*err = -ENOMEM;
> +		return NULL;
> +	}

... as we do here?

[...]

> +
> +	sper->arm_spe_pmu = arm_spe_pmu;
> +	sper->itr.recording_options = arm_spe_recording_options;
> +	sper->itr.info_priv_size = arm_spe_info_priv_size;
> +	sper->itr.info_fill = arm_spe_info_fill;
> +	sper->itr.free = arm_spe_recording_free;
> +	sper->itr.reference = arm_spe_reference;
> +	sper->itr.read_finish = arm_spe_read_finish;
> +	sper->itr.alignment = 0;
> +	return &sper->itr;
> +}
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 79dea95a7f68..4ed31e88b8ee 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -82,6 +82,8 @@ libperf-$(CONFIG_AUXTRACE) += auxtrace.o
>  libperf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
>  libperf-$(CONFIG_AUXTRACE) += intel-pt.o
>  libperf-$(CONFIG_AUXTRACE) += intel-bts.o
> +libperf-$(CONFIG_AUXTRACE) += arm-spe.o
> +libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
>  libperf-y += parse-branch-options.o
>  libperf-y += dump-insn.o
>  libperf-y += parse-regs-options.o
> diff --git a/tools/perf/util/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-pkt-decoder.c
> new file mode 100644
> index 000000000000..ca3813d5b91a
> --- /dev/null
> +++ b/tools/perf/util/arm-spe-pkt-decoder.c
> @@ -0,0 +1,448 @@
> +/*
> + * ARM Statistical Profiling Extensions (SPE) support
> + * Copyright (c) 2017, ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <endian.h>
> +#include <byteswap.h>
> +
> +#include "arm-spe-pkt-decoder.h"
> +
> +#define BIT(n)		(1 << (n))
> +
> +#define BIT61		((uint64_t)1 << 61)
> +#define BIT62		((uint64_t)1 << 62)
> +#define BIT63		((uint64_t)1 << 63)
> +
> +#define NS_FLAG		BIT63
> +#define EL_FLAG		(BIT62 | BIT61)
> +
> +#if __BYTE_ORDER == __BIG_ENDIAN
> +#define le16_to_cpu bswap_16
> +#define le32_to_cpu bswap_32
> +#define le64_to_cpu bswap_64
> +#define memcpy_le64(d, s, n) do { \
> +	memcpy((d), (s), (n));    \
> +	*(d) = le64_to_cpu(*(d)); \
> +} while (0)
> +#else
> +#define le16_to_cpu
> +#define le32_to_cpu
> +#define le64_to_cpu
> +#define memcpy_le64 memcpy
> +#endif
> +
> +static const char * const arm_spe_packet_name[] = {
> +	[ARM_SPE_PAD]		= "PAD",
> +	[ARM_SPE_END]		= "END",
> +	[ARM_SPE_TIMESTAMP]	= "TS",
> +	[ARM_SPE_ADDRESS]	= "ADDR",
> +	[ARM_SPE_COUNTER]	= "LAT",
> +	[ARM_SPE_CONTEXT]	= "CONTEXT",
> +	[ARM_SPE_INSN_TYPE]	= "INSN-TYPE",
> +	[ARM_SPE_EVENTS]	= "EVENTS",
> +	[ARM_SPE_DATA_SOURCE]	= "DATA-SOURCE",
> +};
> +
> +const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
> +{
> +	return arm_spe_packet_name[type];
> +}
> +
> +/* return ARM SPE payload size from its encoding:
> + * 00 : byte
> + * 01 : halfword (2)
> + * 10 : word (4)
> + * 11 : doubleword (8)
> + */
> +static int payloadlen(unsigned char byte)
> +{
> +	return 1 << ((byte & 0x30) >> 4);
> +}
> +
> +static int arm_spe_get_pad(struct arm_spe_pkt *packet)
> +{
> +	packet->type = ARM_SPE_PAD;
> +	return 1;
> +}
> +
> +static int arm_spe_get_alignment(const unsigned char *buf, size_t len,
> +				 struct arm_spe_pkt *packet)
> +{
> +	unsigned int alignment = 1 << ((buf[0] & 0xf) + 1);
> +
> +	if (len < alignment)
> +		return ARM_SPE_NEED_MORE_BYTES;
> +
> +	packet->type = ARM_SPE_PAD;
> +	return alignment - (((uint64_t)buf) & (alignment - 1));
> +}
> +
> +static int arm_spe_get_end(struct arm_spe_pkt *packet)
> +{
> +	packet->type = ARM_SPE_END;
> +	return 1;
> +}
> +
> +static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
> +				 struct arm_spe_pkt *packet)
> +{
> +	if (len < 8)
> +		return ARM_SPE_NEED_MORE_BYTES;
> +
> +	packet->type = ARM_SPE_TIMESTAMP;
> +	memcpy_le64(&packet->payload, buf + 1, 8);
> +
> +	return 1 + 8;
> +}
> +
> +static int arm_spe_get_events(const unsigned char *buf, size_t len,
> +			      struct arm_spe_pkt *packet)
> +{
> +	unsigned int events_len = payloadlen(buf[0]);
> +
> +	if (len < events_len)
> +		return ARM_SPE_NEED_MORE_BYTES;

Isn't len the size of the whole buffer? So isn't this failing to account
for the header byte?

> +
> +	packet->type = ARM_SPE_EVENTS;
> +	packet->index = events_len;

Huh? The events packet has no "index" field, so why do we need this?

> +	switch (events_len) {
> +	case 1: packet->payload = *(uint8_t *)(buf + 1); break;
> +	case 2: packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1)); break;
> +	case 4: packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1)); break;
> +	case 8: packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1)); break;
> +	default: return ARM_SPE_BAD_PACKET;
> +	}
> +
> +	return 1 + events_len;
> +}
> +
> +static int arm_spe_get_data_source(const unsigned char *buf,
> +				   struct arm_spe_pkt *packet)
> +{
> +	int len = payloadlen(buf[0]);
> +
> +	packet->type = ARM_SPE_DATA_SOURCE;
> +	if (len == 1)
> +		packet->payload = buf[1];
> +	else if (len == 2)
> +		packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
> +
> +	return 1 + len;
> +}

For those packets with a payload, the header has a uniform format
describing the payload size. Given that, can't we make the payload
extraction generic, regardless of the packet type?

e.g. something like:

static int arm_spe_get_payload(const unsigned char *buf, size_t len,
			       struct arm_spe_pkt *packet)
{
	<determine paylaod size>
	<length check>
	<switch>
	<return nr consumed bytes (inc header), or error>
}

static int arm_spe_get_events(const unsigned char *buf, size_t len,
			      struct arm_spe_pkt *packet)
{
	packet->type = ARM_SPE_EVENTS;
	return arm_spe_get_payload(buf, len, packet);
}

static int arm_spe_get_data_source(const unsigned char *buf,
				   struct arm_spe_pkt *packet)
{
	packet->type = ARM_SPE_DATA_SOURCE;
	return arm_spe_get_payload(buf, len, packet);
}

... and so on for the other packets with a payload.

> +static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
> +				 struct arm_spe_pkt *packet)
> +{
> +	unsigned int byte;
> +
> +	memset(packet, 0, sizeof(struct arm_spe_pkt));
> +
> +	if (!len)
> +		return ARM_SPE_NEED_MORE_BYTES;
> +
> +	byte = buf[0];
> +	if (byte == 0)
> +		return arm_spe_get_pad(packet);
> +	else if (byte == 1) /* no timestamp at end of record */
> +		return arm_spe_get_end(packet);
> +	else if (byte & 0xc0 /* 0y11000000 */) {
> +		if (byte & 0x80) {
> +			/* 0x38 is 0y00111000 */
> +			if ((byte & 0x38) == 0x30) /* address packet (short) */
> +				return arm_spe_get_addr(buf, len, 0, packet);
> +			if ((byte & 0x38) == 0x18) /* counter packet (short) */
> +				return arm_spe_get_counter(buf, len, 0, packet);
> +		} else
> +			if (byte == 0x71)
> +				return arm_spe_get_timestamp(buf, len, packet);
> +			else if ((byte & 0xf) == 0x2)
> +				return arm_spe_get_events(buf, len, packet);
> +			else if ((byte & 0xf) == 0x3)
> +				return arm_spe_get_data_source(buf, packet);
> +			else if ((byte & 0x3c) == 0x24)
> +				return arm_spe_get_context(buf, len, packet);
> +			else if ((byte & 0x3c) == 0x8)
> +				return arm_spe_get_insn_type(buf, packet);

Could we have some mnemonics for these?

e.g.

#define SPE_HEADER0_PAD		0x0
#define SPE_HEADER0_END		0x1

#define SPE_HEADER0_EVENTS	0x42
#define SPE_HEADER0_EVENTS_MASK	0xcf

if (byte == SPE_HEADER0_PAD) { 
	...
} else if (byte == SPE_HEADER0_END) {
	...
} else if ((byte & SPE_HEADER0_EVENTS_MASK) == SPE_HEADER0_EVENTS) {
	...
}

... which could even be turned into something table-driven.

> +	} else if ((byte & 0xe0) == 0x20 /* 0y00100000 */) {
> +		/* 16-bit header */
> +		byte = buf[1];
> +		if (byte == 0)
> +			return arm_spe_get_alignment(buf, len, packet);
> +		else if ((byte & 0xf8) == 0xb0)
> +			return arm_spe_get_addr(buf, len, 1, packet);
> +		else if ((byte & 0xf8) == 0x98)
> +			return arm_spe_get_counter(buf, len, 1, packet);
> +	}
> +
> +	return ARM_SPE_BAD_PACKET;
> +}
> +
> +int arm_spe_get_packet(const unsigned char *buf, size_t len,
> +		       struct arm_spe_pkt *packet)
> +{
> +	int ret;
> +
> +	ret = arm_spe_do_get_packet(buf, len, packet);
> +	if (ret > 0) {
> +		while (ret < 1 && len > (size_t)ret && !buf[ret])
> +			ret += 1;
> +	}

What is this trying to do?

> +	return ret;
> +}
> +
> +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> +		     size_t buf_len)
> +{
> +	int ret, ns, el, index = packet->index;
> +	unsigned long long payload = packet->payload;
> +	const char *name = arm_spe_pkt_name(packet->type);
> +
> +	switch (packet->type) {
> +	case ARM_SPE_BAD:
> +	case ARM_SPE_PAD:
> +	case ARM_SPE_END:
> +		return snprintf(buf, buf_len, "%s", name);
> +	case ARM_SPE_EVENTS: {

[...]

> +	case ARM_SPE_DATA_SOURCE:
> +	case ARM_SPE_TIMESTAMP:
> +		return snprintf(buf, buf_len, "%s %lld", name, payload);
> +	case ARM_SPE_ADDRESS:
> +		switch (index) {
> +		case 0:
> +		case 1: ns = !!(packet->payload & NS_FLAG);
> +			el = (packet->payload & EL_FLAG) >> 61;
> +			payload &= ~(0xffULL << 56);
> +			return snprintf(buf, buf_len, "%s %llx el%d ns=%d",
> +				        (index == 1) ? "TGT" : "PC", payload, el, ns);

For TTBR1 addresses, this ends up losing the leading 0xff, giving us
invalid addresses, which look odd.

Can we please sign-extend bit 55 so that this gives us valid addresses
regardless of TTBR?

Could we please add a '0x' prefix to hex numbers, and use 0x%016llx so
that things get padded consistently?

Thanks,
Mark.
