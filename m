From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Aug 2016 10:22:13 +0100
Subject: [PATCH 2/2] arm64: Use static keys for CPU features
In-Reply-To: <1472145992-10660-3-git-send-email-catalin.marinas@arm.com>
References: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
 <1472145992-10660-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <f690f532-a05e-5c13-6b97-b94203701d3d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/16 18:26, Catalin Marinas wrote:
> This patch adds static keys transparently for all the cpu_hwcaps
> features by implementing an array of default-false static keys and
> enabling them when detected. The cpus_have_cap() check uses the static
> keys if the feature being checked is a constant, otherwise the compiler
> generates the bitmap test.
>
> Because of the early call to static_branch_enable() via
> check_local_cpu_errata() -> update_cpu_capabilities(), the jump labels
> are initialised in cpuinfo_store_boot_cpu().
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---


>  static inline int __attribute_const__
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 62272eac1352..919b2d0d68ae 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -46,6 +46,9 @@ unsigned int compat_elf_hwcap2 __read_mostly;
>
>  DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>
> +DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
> +EXPORT_SYMBOL(cpu_hwcap_keys);
> +
>  #define __ARM64_FTR_BITS(SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
>  	{						\
>  		.sign = SIGNED,				\
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index ed1b84fe6925..6a141e399daf 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -377,6 +377,12 @@ void cpuinfo_store_cpu(void)
>  void __init cpuinfo_store_boot_cpu(void)
>  {
>  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
> +
> +	/*
> +	 * Initialise the static keys early as they may be enabled by
> +	 * check_local_cpu_errata() -> update_cpu_capabilities().
> +	 */
> +	jump_label_init();
>  	__cpuinfo_store_cpu(info);

Catalin,

Just a heads up. I have a patch [1] which moves the "check_local_cpu_errata()"
around to smp_prepare_boot_cpu(). This patch should still work fine with that
case. Only that may be we could move the jump_lable_init() to smp_prepare_boot_cpu(),
before we call "update_cpu_errata_work_arounds()" for Boot CPU.

Either way, this will be useful for some of the other feature checks.

Thanks
Suzuki

[1] https://lkml.kernel.org/r/1471525832-21209-4-git-send-email-suzuki.poulose at arm.com
