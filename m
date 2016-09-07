From: jbaron@akamai.com (Jason Baron)
Date: Wed, 7 Sep 2016 12:59:52 -0400
Subject: [PATCH v2 2/2] arm64: Use static keys for CPU features
In-Reply-To: <1473096348-19548-3-git-send-email-catalin.marinas@arm.com>
References: <1473096348-19548-1-git-send-email-catalin.marinas@arm.com>
 <1473096348-19548-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <48d10fa1-ee4c-e398-b5ae-9815bf0f18eb@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2016 01:25 PM, Catalin Marinas wrote:
> This patch adds static keys transparently for all the cpu_hwcaps
> features by implementing an array of default-false static keys and
> enabling them when detected. The cpus_have_cap() check uses the static
> keys if the feature being checked is a constant, otherwise the compiler
> generates the bitmap test.
>
> Because of the early call to static_branch_enable() via
> check_local_cpu_errata() -> update_cpu_capabilities(), the jump labels
> are initialised in cpuinfo_store_boot_cpu().

Was there a reason the jump_label_init() couldn't be moved
earlier in the common code?

Thanks,

-Jason

>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm64/include/asm/cpufeature.h | 14 +++++++++++---
>   arch/arm64/kernel/cpufeature.c      |  3 +++
>   arch/arm64/kernel/smp.c             |  5 +++++
>   3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7099f26e3702..c9dfb1e4c435 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -9,6 +9,8 @@
>   #ifndef __ASM_CPUFEATURE_H
>   #define __ASM_CPUFEATURE_H
>   
> +#include <linux/jump_label.h>
> +
>   #include <asm/hwcap.h>
>   #include <asm/sysreg.h>
>   
> @@ -109,6 +111,7 @@ struct arm64_cpu_capabilities {
>   };
>   
>   extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
> +extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
>   
>   bool this_cpu_has_cap(unsigned int cap);
>   
> @@ -121,16 +124,21 @@ static inline bool cpus_have_cap(unsigned int num)
>   {
>   	if (num >= ARM64_NCAPS)
>   		return false;
> -	return test_bit(num, cpu_hwcaps);
> +	if (__builtin_constant_p(num))
> +		return static_branch_unlikely(&cpu_hwcap_keys[num]);
> +	else
> +		return test_bit(num, cpu_hwcaps);
>   }
>   
>   static inline void cpus_set_cap(unsigned int num)
>   {
> -	if (num >= ARM64_NCAPS)
> +	if (num >= ARM64_NCAPS) {
>   		pr_warn("Attempt to set an illegal CPU capability (%d >= %d)\n",
>   			num, ARM64_NCAPS);
> -	else
> +	} else {
>   		__set_bit(num, cpu_hwcaps);
> +		static_branch_enable(&cpu_hwcap_keys[num]);
> +	}
>   }
>   
>   static inline int __attribute_const__
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 62272eac1352..919b2d0d68ae 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -46,6 +46,9 @@ unsigned int compat_elf_hwcap2 __read_mostly;
>   
>   DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>   
> +DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
> +EXPORT_SYMBOL(cpu_hwcap_keys);
> +
>   #define __ARM64_FTR_BITS(SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
>   	{						\
>   		.sign = SIGNED,				\
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d93d43352504..c3c08368a685 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -437,6 +437,11 @@ void __init smp_cpus_done(unsigned int max_cpus)
>   void __init smp_prepare_boot_cpu(void)
>   {
>   	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
> +	/*
> +	 * Initialise the static keys early as they may be enabled by the
> +	 * cpufeature code.
> +	 */
> +	jump_label_init();
>   	cpuinfo_store_boot_cpu();
>   	save_boot_cpu_run_el();
>   }
