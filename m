From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Nov 2017 12:18:16 +0000
Subject: [PATCH 2/2] arm-ccn: perf: Prevent module unload while PMU is in
 use
In-Reply-To: <20171103114518.5311-2-suzuki.poulose@arm.com>
References: <20171103114518.5311-1-suzuki.poulose@arm.com>
 <20171103114518.5311-2-suzuki.poulose@arm.com>
Message-ID: <20171103121816.GC11628@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 11:45:18AM +0000, Suzuki K Poulose wrote:
> When the PMU driver is built as a module, the perf expects the
> pmu->module to be valid, so that the driver is prevented from
> being unloaded while it is in use. Fix the CCN pmu driver to
> fill in this field.
> 
> Fixes: commit a33b0daab73a0 ("bus: ARM CCN PMU driver")

nit: don't need "commit" here.

> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-ccn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
> index e8c6946fed9d..3063f5312397 100644
> --- a/drivers/bus/arm-ccn.c
> +++ b/drivers/bus/arm-ccn.c
> @@ -1276,6 +1276,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
>  
>  	/* Perf driver registration */
>  	ccn->dt.pmu = (struct pmu) {
> +		.module = THIS_MODULE,
>  		.attr_groups = arm_ccn_pmu_attr_groups,
>  		.task_ctx_nr = perf_invalid_context,
>  		.event_init = arm_ccn_pmu_event_init,

I'll pick this up since I'm taking the SPE fix via arm64 anyway.

Will
