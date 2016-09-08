From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Sep 2016 12:29:03 +0100
Subject: [RFCv4 0/7]  arm_pmu/perf tools: play nicely with CPU PMU cpumasks
In-Reply-To: <20160908103849.GF1493@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
 <20160908103849.GF1493@arm.com>
Message-ID: <20160908112902.GA26570@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 11:38:49AM +0100, Will Deacon wrote:
> On Thu, Sep 08, 2016 at 11:21:45AM +0100, Mark Rutland wrote:
> > Complicating matters, prior to commit 00e727bb389359c8 ("perf stat: Balance
> > opening and reading events"), from version two of this series, perf-stat would
> > behave erroneously in the presence of a cpumask file, blocking forever after
> > the workload completed. While this is now fixed, existing binaries (e.g. those
> > shipped by distributions) would be broken by the addition of a cpumask file
> > kernel-side.
> > 
> > To cater for this, this series adds support for a new PMU sysfs file, named
> > 'cpus' rather than 'cpumask', listing a number of CPUs that a logical PMU
> > covers. As old binaries will not look for this, this can be safely added to the
> > kernel without risk of breakage.
> 
> On my x86 laptop, I have the following under /sys/bus/event_source/devices:
> 
> power/cpumask 0
> uncore_arb/cpumask 0
> uncore_imc/cpumask 0
> uncore_cbox_0/cpumask 0
> uncore_cbox_1/cpumask 0
> cstate_core/cpumask 0-1
> cstate_pkg/cpumask 0
> 
> Are you saying that, prior to 00e727bb3893, perf stat blocks forever on
> those PMUs? If so, wouldn't we need to rename all those files too?

No. I should have better described the issue above.

The issue fixed by commit 00e727bb3893 only affects task-bound events,
when perf-stat opens a counter per-thread.

All of the above are uncore PMUs, and only support cpu-bound events.
Thus they are not affected.

Thanks,
Mark.
