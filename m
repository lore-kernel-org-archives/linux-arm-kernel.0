From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jan 2017 12:37:15 +0000
Subject: [RFC PATCH 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170110160419.4cc3d61c9d652e5d5da13f15@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-10-git-send-email-will.deacon@arm.com>
 <20170110160419.4cc3d61c9d652e5d5da13f15@arm.com>
Message-ID: <20170111123714.GK12388@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,

On Tue, Jan 10, 2017 at 04:04:19PM -0600, Kim Phillips wrote:
> On Tue, 3 Jan 2017 18:10:26 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > +#define DRVNAME				"arm_spe_pmu"
> 
> Based on Intel naming "intel_pt" and "intel_bts', I had expected
> "arm-spe" as the universal basename for SPE.  I don't really care about
> whether '_pmu' is included, but it's yet another naming inconsistency we
> have with coresight's "cs_etm" (the other being prefixed with "arm_").

It's consistent with the other PMUs under drivers/perf.

> Also, nit, since I don't know why perf userspace tools can't handle
> dashes in PMU names (commit 3d1ff755e367 "arm: perf: clean up PMU
> names" doesn't say), can we at least start to use dashes in our
> filenames?  arm-spe-pmu.c is easier to type than arm_spe_pmu.c.

I'd rather go for consistency both with the other PMU drivers under
drivers/perf, but also with the PMU name itself.

> > +static int arm_spe_pmu_event_init(struct perf_event *event)
> > +{
> > +	u64 reg;
> > +	struct perf_event_attr *attr = &event->attr;
> > +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> > +
> > +	/* This is, of course, deeply driver-specific */
> > +	if (attr->type != event->pmu->type)
> > +		return -ENOENT;
> > +
> > +	if (event->cpu >= 0 &&
> > +	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> > +		return -ENOENT;
> > +
> > +	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (event->hw.sample_period < spe_pmu->min_period ||
> > +	    event->hw.sample_period & PMSIRR_EL1_IVAL_MASK)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (attr->exclude_idle)
> > +		return -EOPNOTSUPP;
> > +
> > +	/*
> > +	 * Feedback-directed frequency throttling doesn't work when we
> > +	 * have a buffer of samples. We'd need to manually count the
> > +	 * samples in the buffer when it fills up and adjust the event
> > +	 * count to reflect that. Instead, force the user to specify a
> > +	 * sample period instead.
> > +	 */
> > +	if (attr->freq)
> > +		return -EINVAL;
> > +
> > +	if (is_kernel_in_hyp_mode()) {
> > +		if (attr->exclude_kernel != attr->exclude_hv)
> > +			return -EOPNOTSUPP;
> > +	} else if (!attr->exclude_hv) {
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	reg = arm_spe_event_to_pmsfcr(event);
> > +	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
> > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
> > +		return -EOPNOTSUPP;
> > +
> > +	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
> > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
> > +		return -EOPNOTSUPP;
> > +
> > +	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
> > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> 
> Without being provided instructions on how to use, I had to add
> debug printks here to find out e.g., an event period *must* be specified
> with record -c, and then again to find out that only a certain set of
> numbers is allowed by the h/w (256, 512, etc.). Is it possible to
> report why the driver is returning an error before it does?  Otherwise,
> all the user sees is, e.g.:
> 
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for event (arm_spe_pmu_0).
> /bin/dmesg may provide additional information.
> No CONFIG_PERF_EVENTS=y kernel support configured?
> 
> ...and, in this case, with nothing in dmesg.  And, IIRC, the above text
> is emitted only if perf is run with -v and/or built with DEBUG set.
> Granted, *that* problem is not explicitly relevant to this patch, but
> new drivers should nevertheless express their usage details better.

I don't disagree that the error reporting from the driver up to userspace
leaves much to be desired, but there currently isn't a sensible way to
communicate the exact reason for failure back from event_init and I
don't think we're different to other PMU drivers in this respect. Yes,
you can paper around the problem using pr_debug, but that really only
helps the developer writing the perf tool support, and much of the
constraints can also be inferred from the architecture spec.

There were patches to allow providing strings back via perf_err:

  https://lkml.org/lkml/2015/8/24/506

but I don't think it ended up getting merged. Other subsystems wanted to
use the same approach, and there are ABI considerations with all of this
(the thread is worth a read).

> Also, curiously, arm_spe_pmu doesn't appear in 'perf list' (even when
> SPE h/w is present).

Weird, it would be nice to understand why that is. The sysfs plumbing should
all be there, so I'd expect to see something. On my laptop, for example,
intel_pt appears as:

  intel_pt//                                         [Kernel PMU event]

and strace show perf doing the following:

stat("/sys/bus/event_source/devices/intel_pt/format", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
open("/sys/bus/event_source/devices/intel_pt/format", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 82
open("/sys/bus/event_source/devices/intel_pt/format/psb_period", O_RDONLY) = 83
open("/sys/bus/event_source/devices/intel_pt/format/noretcomp", O_RDONLY) = 83
open("/sys/bus/event_source/devices/intel_pt/format/tsc", O_RDONLY) = 83
open("/sys/bus/event_source/devices/intel_pt/format/cyc_thresh", O_RDONLY) = 83
open("/sys/bus/event_source/devices/intel_pt/format/mtc_period", O_RDONLY) = 83
open("/sys/bus/event_source/devices/intel_pt/format/cyc", O_RDONLY) = 83
open("/sys/bus/event_source/devices/intel_pt/format/mtc", O_RDONLY) = 83
stat("/sys/bus/event_source/devices/intel_pt/events", 0x7ffe54eebb40) = -1 ENOENT (No such file or directory)
stat("/sys/bus/event_source/devices/intel_pt/type", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
open("/sys/bus/event_source/devices/intel_pt/type", O_RDONLY) = 82
stat("/sys/bus/event_source/devices/intel_pt/cpumask", 0x7ffe54eedd60) = -1 ENOENT (No such file or directory)
stat("/sys/bus/event_source/devices/intel_pt/cpus", 0x7ffe54eedd60) = -1 ENOENT (No such file or directory)
stat("/sys/bus/event_source/devices/intel_pt/caps/mtc", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
open("/sys/bus/event_source/devices/intel_pt/caps/mtc", O_RDONLY) = 82
stat("/sys/bus/event_source/devices/intel_pt/caps/psb_cyc", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
open("/sys/bus/event_source/devices/intel_pt/caps/psb_cyc", O_RDONLY) = 82

What do you see for SPE?

> Other than that, this gets my:
> 
> Tested-by: Kim Phillips <kim.phillips@arm.com>

Thanks!

Will
