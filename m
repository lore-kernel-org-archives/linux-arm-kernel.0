From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 26 Jan 2018 13:50:13 +0000
Subject: [PATCH 11/16] arm64: errata: Clean up midr range helpers
In-Reply-To: <20180123122809.16269-12-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-12-suzuki.poulose@arm.com>
Message-ID: <20180126135013.GS5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 12:28:04PM +0000, Suzuki K Poulose wrote:
> We are about to introduce generic MIDR range helpers. Clean
> up the existing helpers in errat handling, preparing them

errata/erratum

> to use generic version.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 76 +++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 550ac8a0854b..054b17009f41 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -179,14 +179,23 @@ static int qcom_enable_link_stack_sanitization(
>  }
>  #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  
> -#define MIDR_RANGE(model, min, max) \
> +#define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max) \
>  	.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM, \
>  	.matches = is_affected_midr_range, \
>  	.midr_model = model, \
> -	.midr_range_min = min, \
> -	.midr_range_max = max
> +	.midr_range_min = MIDR_CPU_VAR_REV(v_min, r_min), \
> +	.midr_range_max = MIDR_CPU_VAR_REV(v_max, r_max)
>  
> -#define MIDR_ALL_VERSIONS(model) \
> +/* Errata affecting a range of revisions of  given model variant */
> +#define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max) \
> +	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
> +
> +/* Errata affecting a single variant/revision of a model */
> +#define ERRATA_MIDR(model, var, rev)	\

Maybe call this ERRATA_MIDR_REV() since it's similar to
ERRATA_MIDR_REV_RANGE() but describes a single revision?

[...]

Cheers
---Dave
