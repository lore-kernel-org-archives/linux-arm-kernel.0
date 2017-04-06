From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 6 Apr 2017 19:45:04 +0100
Subject: [PATCH v2 5/6] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170406193307.e1046706e122d80c036ad1a9@arm.com>
References: <1491495496-1524-1-git-send-email-will.deacon@arm.com>
 <1491495496-1524-6-git-send-email-will.deacon@arm.com>
 <20170406193307.e1046706e122d80c036ad1a9@arm.com>
Message-ID: <20170406184503.GC11871@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 07:33:07PM +0100, Kim Phillips wrote:
> On Thu, 6 Apr 2017 17:18:15 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> 
> Hi Will,
> 
> > +/* Perf callbacks */
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
> Can you please explain why we're not emitting messages to dmesg here?:
> 
> https://patchwork.kernel.org/patch/9545979/

The above cases are not (system) errors, and using dev_err (even
ratelimited) is certainly not appropriate. These are pr_debug() at best.

The dmesg is not always the appropriate place to dump such information,
even if it happens to be convenient. As part of usual operation, dmesg
should be very quiet, and we don't log messages elsewhere where the user
passes some parameter the kernel does not like.

These messages are really only useful to those developing tools (such as
yourself). There are some cases where they're actively harmful (e.g.
when fuzzing).

Adding a single patch doesn't seem that difficult. Maybe we could add a
pr_debug() or two.

Thanks,
Mark.
