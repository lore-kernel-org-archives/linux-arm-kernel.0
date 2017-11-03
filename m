From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 12:32:02 +0000
Subject: [PATCH 1/2] perf: arm_spe: Prevent module unload while the PMU
 is in use
In-Reply-To: <20171103114518.5311-1-suzuki.poulose@arm.com>
References: <20171103114518.5311-1-suzuki.poulose@arm.com>
Message-ID: <20171103123202.6qnaynwk6czhkrox@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 11:45:17AM +0000, Suzuki K Poulose wrote:
> When the PMU driver is built as a module, the perf expects the
> pmu->module to be valid, so that the driver is prevented from
> being unloaded while it is in use. Fix the SPE pmu driver to
> fill in this field.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_spe_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 50511b13fd35..8ce262fc2561 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -889,6 +889,7 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
>  	struct device *dev = &spe_pmu->pdev->dev;
>  
>  	spe_pmu->pmu = (struct pmu) {
> +		.module = THIS_MODULE,
>  		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>  		.attr_groups	= arm_spe_pmu_attr_groups,
>  		/*
> -- 
> 2.13.6
> 
