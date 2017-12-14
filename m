From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 Dec 2017 14:06:21 +0000
Subject: [PATCH] arm64/sve: Report SVE to userspace via CPUID only if
 supported
In-Reply-To: <1513260094-9893-1-git-send-email-Dave.Martin@arm.com>
References: <1513260094-9893-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171214140621.nzczujcxz4atog6y@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 02:01:34PM +0000, Dave Martin wrote:
> Currently, the SVE field in ID_AA64PFR0_EL1 is visible
> unconditionally to userspace via the CPU ID register emulation,
> irrespective of the kernel config.  This means that if a kernel
> configured with CONFIG_ARM64_SVE=n is run on SVE-capable hardware,
> userspace will see SVE reported as present in the ID regs even
> though the kernel forbids execution of SVE instructions.
> 
> This patch makes the exposure of the SVE field in ID_AA64PFR0_EL1
> conditional on CONFIG_ARM64_SVE=y.
> 
> Since future architecture features are likely to encounter a
> similar requirement, this patch adds a suitable helper macros for
> use when declaring config-conditional ID register fields.

Makes sense to me; I can use this for pointer authentication fields.

> Fixes: 43994d824e84 ("arm64/sve: Detect SVE and activate runtime support")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
> This patch is proposed as a fix for v4.15, since we don't want to create
> unintentional ABI by exposing the wrong thing to userspace in a full
> kernel release.
> 
>  arch/arm64/include/asm/cpufeature.h | 3 +++
>  arch/arm64/kernel/cpufeature.c      | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ac67cfc..060e3a4 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -60,6 +60,9 @@ enum ftr_type {
>  #define FTR_VISIBLE	true	/* Feature visible to the user space */
>  #define FTR_HIDDEN	false	/* Feature is hidden from the user */
>  
> +#define FTR_VISIBLE_IF_IS_ENABLED(config)		\
> +	(IS_ENABLED(config) ? FTR_VISIBLE : FTR_HIDDEN)
> +
>  struct arm64_ftr_bits {
>  	bool		sign;	/* Value is signed ? */
>  	bool		visible;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c5ba009..a73a592 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -145,7 +145,8 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +				   FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_GIC_SHIFT, 4, 0),
>  	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
>  	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
> -- 
> 2.1.4
> 
