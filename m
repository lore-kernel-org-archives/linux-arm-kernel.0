From: labbott@redhat.com (Laura Abbott)
Date: Thu, 4 Jan 2018 15:15:13 -0800
Subject: [PATCH 03/11] arm64: Take into account ID_AA64PFR0_EL1.CSV3
In-Reply-To: <1515078515-13723-4-git-send-email-will.deacon@arm.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
 <1515078515-13723-4-git-send-email-will.deacon@arm.com>
Message-ID: <1a94f5a0-3e9a-60ea-a6fa-1db432c8c464@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2018 07:08 AM, Will Deacon wrote:
> For non-KASLR kernels where the KPTI behaviour has not been overridden
> on the command line we can use ID_AA64PFR0_EL1.CSV3 to determine whether
> or not we should unmap the kernel whilst running at EL0.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/include/asm/sysreg.h | 1 +
>   arch/arm64/kernel/cpufeature.c  | 7 ++++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 08cc88574659..ae519bbd3f9e 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -437,6 +437,7 @@
>   #define ID_AA64ISAR1_DPB_SHIFT		0
>   
>   /* id_aa64pfr0 */
> +#define ID_AA64PFR0_CSV3_SHIFT		60
>   #define ID_AA64PFR0_SVE_SHIFT		32
>   #define ID_AA64PFR0_GIC_SHIFT		24
>   #define ID_AA64PFR0_ASIMD_SHIFT		20
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9f0545dfe497..e11c11bb5b02 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -145,6 +145,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_GIC_SHIFT, 4, 0),
>   	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
> @@ -851,6 +852,8 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>   static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>   				int __unused)
>   {
> +	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> +
>   	/* Forced on command line? */
>   	if (__kpti_forced) {
>   		pr_info_once("kernel page table isolation forced %s by command line option\n",
> @@ -862,7 +865,9 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>   		return true;
>   
> -	return false;
> +	/* Defer to CPU feature registers */
> +	return !cpuid_feature_extract_unsigned_field(pfr0,
> +						     ID_AA64PFR0_CSV3_SHIFT);
>   }
>   
>   static int __init parse_kpti(char *str)
> 

Nit: we only print a message if it's forced on the command line,
can we get a message similar to x86 regardless of state to
clearly indicate if KPTI is enabled?

Thanks,
Laura
