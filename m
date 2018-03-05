From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2018 17:22:56 +0000
Subject: [RFC PATCH v3 3/3] arm64/kernel: enable A53 erratum #8434319
 handling at runtime
In-Reply-To: <20180214113645.16793-4-ard.biesheuvel@linaro.org>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-4-ard.biesheuvel@linaro.org>
Message-ID: <20180305172256.GC12869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 11:36:45AM +0000, Ard Biesheuvel wrote:
> Omit patching of ADRP instruction at module load time if the current
> CPUs are not susceptible to the erratum.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Open question: how should we handle big.LITTLE configurations where affected
> Cortex-A53s may appear late.

We should fail to bring them online. I think the infrastructure already
exists for this and we used it for other errata already.

> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index bb263820de13..39134c46bb13 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -45,7 +45,8 @@
>  #define ARM64_HARDEN_BRANCH_PREDICTOR		24
>  #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
>  #define ARM64_HAS_RAS_EXTN			26
> +#define ARM64_WORKAROUND_843419			27
>  
> -#define ARM64_NCAPS				27
> +#define ARM64_NCAPS				28
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 07823595b7f0..c065d5649b1b 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -228,6 +228,23 @@ static int qcom_enable_link_stack_sanitization(void *data)
>  }
>  #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  
> +static bool __maybe_unused
> +needs_erratum_843419_workaround(const struct arm64_cpu_capabilities *entry,
> +				int scope)
> +{
> +	u32 cpuid = read_cpuid_id();
> +
> +	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
> +
> +	if ((cpuid & MIDR_CPU_MODEL_MASK) != MIDR_CORTEX_A53)
> +		return false;
> +	else if ((cpuid & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK)) == 0x4)
> +		/* erratum was fixed in some versions of r0p4 */
> +		return !(read_cpuid(REVIDR_EL1) & BIT(8));

The rXpY information is in the MIDR, so this is checking for something else
afaict.

Will
