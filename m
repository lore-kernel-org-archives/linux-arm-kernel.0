From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 7 Feb 2018 10:39:11 +0000
Subject: [PATCH v2 13/20] arm64: capabilities: Clean up midr range helpers
In-Reply-To: <20180131182807.32134-14-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-14-suzuki.poulose@arm.com>
Message-ID: <20180207103911.GD5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:28:00PM +0000, Suzuki K Poulose wrote:
> We are about to introduce generic MIDR range helpers. Clean
> up the existing helpers in erratum handling, preparing them
> to use generic version.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 100 +++++++++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 22ec3960a0c5..4351d48b0b0f 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -174,20 +174,35 @@ static void qcom_enable_link_stack_sanitization(
>  }
>  #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  
> -#define MIDR_RANGE(model, min, max) \
> -	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
> -	.matches = is_affected_midr_range, \
> -	.midr_model = model, \
> -	.midr_range_min = min, \
> -	.midr_range_max = max
> +#define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
> +	.matches = is_affected_midr_range,			\
> +	.midr_model = model,					\
> +	.midr_range_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
> +	.midr_range_max = MIDR_CPU_VAR_REV(v_max, r_max)
>  
> -#define MIDR_ALL_VERSIONS(model) \
> -	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
> -	.matches = is_affected_midr_range, \
> -	.midr_model = model, \
> -	.midr_range_min = 0, \
> +#define CAP_MIDR_ALL_VERSIONS(model)					\
> +	.matches = is_affected_midr_range,				\
> +	.midr_model = model,						\
> +	.midr_range_min = MIDR_CPU_VAR_REV(0, 0),			\
>  	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
>  
> +#define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max)		\
> +	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
> +	CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)
> +
> +/* Errata affecting a range of revisions of  given model variant */
> +#define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max)	 \
> +	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
> +
> +/* Errata affecting a single variant/revision of a model */
> +#define ERRATA_MIDR_REV(model, var, rev)	\
> +	ERRATA_MIDR_RANGE(model, var, rev, var, rev)
> +
> +/* Errata affecting all variants/revisions of a given a model */
> +#define ERRATA_MIDR_ALL_VERSIONS(model)				\
> +	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
> +	CAP_MIDR_ALL_VERSIONS(model)
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
>  	defined(CONFIG_ARM64_ERRATUM_827319) || \
> @@ -196,7 +211,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  	/* Cortex-A53 r0p[012] */
>  		.desc = "ARM errata 826319, 827319, 824069",
>  		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
> -		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x02),
> +		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x2),

Nit: since you're mostly ommiting the redundant 0x0* prefixes in new
ERRATA_MIDR_RANGE(), maybe it's worth getting rid of all of them.
Not a big deal though.

The prefixes are a bit random prior to this patch (0x00 versus 0x0
etc.)

[...]

Otherwise,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
