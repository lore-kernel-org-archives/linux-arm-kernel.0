From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 7 Feb 2018 10:38:37 +0000
Subject: [PATCH v2 09/20] arm64: capabilities: Introduce weak features
 based on local CPU
In-Reply-To: <20180131182807.32134-10-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-10-suzuki.poulose@arm.com>
Message-ID: <20180207103837.GZ5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:27:56PM +0000, Suzuki K Poulose wrote:
> Now that we have the flexibility of defining system features based
> on individual CPUs, introduce CPU feature type that can be detected
> on a local SCOPE and ignores the conflict on late CPUs. This is
> applicable for ARM64_HAS_NO_HW_PREFETCH, where it is fine for
> the system to have CPUs without hardware prefetch turning up
> later. We only suffer a performance penalty, nothing fatal.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/cpufeature.h | 8 ++++++++
>  arch/arm64/kernel/cpufeature.c      | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index cda62b70d338..7bb3fdec827e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -214,6 +214,14 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>   */
>  #define ARM64_CPUCAP_SYSTEM_FEATURE	\
>  	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
> +/*
> + * CPU feature detected at boot time based on feature of one or more CPUs.
> + * All possible conflicts for a late CPU are ignored.
> + */
> +#define ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE		\
> +	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
> +	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
> +	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
>  
>  struct arm64_cpu_capabilities {
>  	const char *desc;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c710ef28524e..ecc87aa74c64 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -956,7 +956,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  	{
>  		.desc = "Software prefetching using PRFM",
>  		.capability = ARM64_HAS_NO_HW_PREFETCH,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>  		.matches = has_no_hw_prefetch,
>  	},
>  #ifdef CONFIG_ARM64_UAO
> -- 
> 2.14.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
