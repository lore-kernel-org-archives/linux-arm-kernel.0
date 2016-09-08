From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 8 Sep 2016 13:25:02 -0300
Subject: [RFCv4 0/7]  arm_pmu/perf tools: play nicely with CPU PMU cpumasks
In-Reply-To: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160908162502.GB4801@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, Sep 08, 2016 at 11:21:45AM +0100, Mark Rutland escreveu:
> Hi,
> 
> I'm trying to make the perf tool play better with PMUs in heterogeneous systems
> (e.g. big.LITTLE), where there are several logical PMUs, each covering a subset
> of CPUs.

So I added 6/7 and 7/7 to my local perf/core branch, I think they can go
before the others, Peter, do you want me to take the kernel parts as
well?

- Arnaldo
 
> Currently perf-record doesn't work for these PMUs, unless forced to use
> per-thread mmaps. In the absence of a cpumask, it tries to open events on CPUs
> not supported by a PMU, and gives up. In the presence of a cpumask, it ends up
> failing to mmap, as the evlist->cpus map contains a different set of CPUs from
> the evsel->cpus map populated from the cpumask. This is addressed by the
> penultimate patch in this series.
> 
> Complicating matters, prior to commit 00e727bb389359c8 ("perf stat: Balance
> opening and reading events"), from version two of this series, perf-stat would
> behave erroneously in the presence of a cpumask file, blocking forever after
> the workload completed. While this is now fixed, existing binaries (e.g. those
> shipped by distributions) would be broken by the addition of a cpumask file
> kernel-side.
> 
> To cater for this, this series adds support for a new PMU sysfs file, named
> 'cpus' rather than 'cpumask', listing a number of CPUs that a logical PMU
> covers. As old binaries will not look for this, this can be safely added to the
> kernel without risk of breakage.
> 
> I've included the kernel and userspace parts in this series as they've proven
> difficult to review in isolation.
> 
> Thanks,
> Mark.
> 
> Since v1 [1]:
> * Avoid double cpu_map__idx() call in perf_evlist__mmap_per_evsel
> * Look for a supported_cpumask file when a cpumask file is not present
> 
> Since v2 [2]:
> * Drop patches which have been picked up from v2
> * Rebase to v4.8-rc1
> * Better describe the issue in the supported_cpumask patch
> 
> Since v3 [3]:
> * Prepend patches exporting the cpus file for ARM PMUs
> * s/supported_cpus/cpus/
> 
> [1] http://lkml.kernel.org/r/1467907474-3290-1-git-send-email-mark.rutland at arm.com
> [2] http://lkml.kernel.org/r/1468577293-19667-1-git-send-email-mark.rutland at arm.com
> [3] http://lkml.kernel.org/r/1470933366-1364-1-git-send-email-mark.rutland at arm.com
> 
> Mark Rutland (7):
>   drivers/perf: arm_pmu: add common attr group fields
>   arm64: perf: move to common attr_group fields
>   arm: perf: move to common attr_group fields
>   drivers/perf: arm_pmu: only use common attr_groups
>   drivers/perf: arm_pmu: expose a cpumask in sysfs
>   perf: util: only open events on CPUs an evsel permits
>   perf: util: support alternative sysfs cpumask
> 
>  arch/arm/kernel/perf_event_v7.c | 47 ++++++++++++++++++++++++-----------------
>  arch/arm64/kernel/perf_event.c  | 36 ++++++++++++++++++++-----------
>  drivers/perf/arm_pmu.c          | 23 ++++++++++++++++++++
>  include/linux/perf/arm_pmu.h    | 10 ++++++++-
>  tools/perf/util/evlist.c        |  8 ++++++-
>  tools/perf/util/pmu.c           | 15 ++++++++++---
>  6 files changed, 103 insertions(+), 36 deletions(-)
> 
> -- 
> 1.9.1
