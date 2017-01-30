From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 30 Jan 2017 13:03:12 -0600
Subject: [PATCH 09/10] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <1485540470-11469-10-git-send-email-will.deacon@arm.com>
References: <1485540470-11469-1-git-send-email-will.deacon@arm.com>
 <1485540470-11469-10-git-send-email-will.deacon@arm.com>
Message-ID: <20170130130312.09e4aef34c685f4c228aba50@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jan 2017 18:07:48 +0000
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

Please add below messaging such as to avoid users having to do
so themselves:

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b4906c3..7c2635c 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -655,24 +655,33 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	u64 reg;
 	struct perf_event_attr *attr = &event->attr;
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
+	struct device *dev = &spe_pmu->pdev->dev;
 
 	/* This is, of course, deeply driver-specific */
 	if (attr->type != event->pmu->type)
 		return -ENOENT;
 
 	if (event->cpu >= 0 &&
-	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
+	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus)) {
+		dev_err_ratelimited(dev, "CPU not supported by SPE\n");
 		return -ENOENT;
+	}
 
-	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0)
+	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0) {
+		dev_err_ratelimited(dev, "Unsupported event filter\n");
 		return -EOPNOTSUPP;
+	}
 
 	if (event->hw.sample_period < spe_pmu->min_period ||
-	    event->hw.sample_period & PMSIRR_EL1_IVAL_MASK)
+	    event->hw.sample_period & PMSIRR_EL1_IVAL_MASK) {
+		dev_err_ratelimited(dev, "Cannot set sample period below the minimum interval\n");
 		return -EOPNOTSUPP;
+	}
 
-	if (attr->exclude_idle)
+	if (attr->exclude_idle) {
+		dev_err_ratelimited(dev, "Cannot exclude profiling when idle\n");
 		return -EOPNOTSUPP;
+	}
 
 	/*
 	 * Feedback-directed frequency throttling doesn't work when we
@@ -681,28 +690,39 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	 * count to reflect that. Instead, force the user to specify a
 	 * sample period instead.
 	 */
-	if (attr->freq)
+	if (attr->freq) {
+		dev_err_ratelimited(dev, "a sample period must be specified\n");
 		return -EINVAL;
+	}
 
 	if (is_kernel_in_hyp_mode()) {
-		if (attr->exclude_kernel != attr->exclude_hv)
+		if (attr->exclude_kernel != attr->exclude_hv) {
+			dev_err_ratelimited(dev, "VHE is enabled but exclude_kernel and exclude_hv do not match\n");
 			return -EOPNOTSUPP;
+		}
 	} else if (!attr->exclude_hv) {
+		dev_err_ratelimited(dev, "VHE is disabled but exclude_hv is not set\n");
 		return -EOPNOTSUPP;
 	}
 
 	reg = arm_spe_event_to_pmsfcr(event);
 	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT)) {
+		dev_err_ratelimited(dev, "event filter feature not supported\n");
 		return -EOPNOTSUPP;
+	}
 
 	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP)) {
+		dev_err_ratelimited(dev, "event type filter feature not supported\n");
 		return -EOPNOTSUPP;
+	}
 
 	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT)) {
+		dev_err_ratelimited(dev, "latency filter feature not supported\n");
 		return -EOPNOTSUPP;
+	}
 
 	return 0;
 }


Thanks,

Kim
