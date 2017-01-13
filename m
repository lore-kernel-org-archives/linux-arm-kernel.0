From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 13 Jan 2017 10:40:42 -0600
Subject: [RFC PATCH v2 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <1484323429-15231-10-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-10-git-send-email-will.deacon@arm.com>
Message-ID: <20170113104042.169ceea12820d2b6b74b31f9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jan 2017 16:03:48 +0000
Will Deacon <will.deacon@arm.com> wrote:

> +#define DRVNAME				"arm_spe_pmu"

PMU is implied.  "arm_spe"?

> +static int arm_spe_pmu_event_init(struct perf_event *event)
> +{
> +	u64 reg;
> +	struct perf_event_attr *attr = &event->attr;
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> +
> +	/* This is, of course, deeply driver-specific */
> +	if (attr->type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->cpu >= 0 &&
> +	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> +		return -ENOENT;
> +
> +	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0)
> +		return -EOPNOTSUPP;
> +
> +	if (event->hw.sample_period < spe_pmu->min_period ||
> +	    event->hw.sample_period & PMSIRR_EL1_IVAL_MASK)
> +		return -EOPNOTSUPP;
> +
> +	if (attr->exclude_idle)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Feedback-directed frequency throttling doesn't work when we
> +	 * have a buffer of samples. We'd need to manually count the
> +	 * samples in the buffer when it fills up and adjust the event
> +	 * count to reflect that. Instead, force the user to specify a
> +	 * sample period instead.
> +	 */
> +	if (attr->freq)
> +		return -EINVAL;
> +
> +	if (is_kernel_in_hyp_mode()) {
> +		if (attr->exclude_kernel != attr->exclude_hv)
> +			return -EOPNOTSUPP;
> +	} else if (!attr->exclude_hv) {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	reg = arm_spe_event_to_pmsfcr(event);
> +	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
> +		return -EOPNOTSUPP;
> +
> +	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
> +		return -EOPNOTSUPP;
> +
> +	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}

Please insert pr_* statements before blindly returning errors before a
better facility becomes available.

Thanks,

Kim
