From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Sep 2016 11:38:49 +0100
Subject: [RFCv4 0/7]  arm_pmu/perf tools: play nicely with CPU PMU cpumasks
In-Reply-To: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160908103849.GF1493@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 11:21:45AM +0100, Mark Rutland wrote:
> I'm trying to make the perf tool play better with PMUs in heterogeneous systems
> (e.g. big.LITTLE), where there are several logical PMUs, each covering a subset
> of CPUs.
> 
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

On my x86 laptop, I have the following under /sys/bus/event_source/devices:

power/cpumask 0
uncore_arb/cpumask 0
uncore_imc/cpumask 0
uncore_cbox_0/cpumask 0
uncore_cbox_1/cpumask 0
cstate_core/cpumask 0-1
cstate_pkg/cpumask 0

Are you saying that, prior to 00e727bb3893, perf stat blocks forever on
those PMUs? If so, wouldn't we need to rename all those files too?

I don't want to be the odd duck kernel-side, because of a bug that's
been fixed in userspace.

Will
