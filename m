From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 5 Jun 2017 10:55:16 -0500
Subject: [PATCH v4 4/5] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <1496676177-29356-5-git-send-email-will.deacon@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <1496676177-29356-5-git-send-email-will.deacon@arm.com>
Message-ID: <20170605105516.b09400781b2bde1621a44205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jun 2017 16:22:56 +0100
Will Deacon <will.deacon@arm.com> wrote:

> +/* Perf callbacks */
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

AFAICT, my comments from the last submission have still not been fully
addressed:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/508027.html

Thanks,

Kim
