From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 22 May 2017 07:32:49 -0500
Subject: [PATCH v3 4/5] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <1495128273-13941-5-git-send-email-will.deacon@arm.com>
References: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
 <1495128273-13941-5-git-send-email-will.deacon@arm.com>
Message-ID: <20170522073249.d95a6d7050d24e99261ceae6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 May 2017 18:24:32 +0100
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

I've consistently brought up lack of proper user error messaging in all
previous submissions of this driver:

Jan. 10 2017 (first RFC):
https://www.spinics.net/lists/arm-kernel/msg553322.html

Jan. 13 (second RFC):
https://patchwork.kernel.org/patch/9515967/

[I just went ahead and re-read https://lkml.org/lkml/2015/8/26/661 and
still think it's not a reason to not do this]

30 Jan 2017 (first PATCH series):
https://www.spinics.net/lists/arm-kernel/msg559232.html

6 apr 2017 (PATCH v2 series):
https://lkml.org/lkml/2017/4/6/790

AFAICT, my comments hold, yet the driver still gets resubmitted without
them being addressed.  How do we get out of this loop?

Kim
