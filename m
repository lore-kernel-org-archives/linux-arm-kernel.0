From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 23 Mar 2017 14:11:50 +0000
Subject: [RFC PATCH v2 38/41] arm64/sve: Detect SVE via the cpufeature
 framework
In-Reply-To: <1490194274-30569-39-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-39-git-send-email-Dave.Martin@arm.com>
Message-ID: <6466e33e-5d22-1a78-bacb-d9dc334ee6d7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/17 14:51, Dave Martin wrote:
> For robust feature detection and appropriate handling of feature
> mismatches between CPUs, this patch adds knowledge of the new
> feature fields and new registers ZCR_EL1 and ID_AA64ZFR0_EL1 to the
> cpufeature framework.

...

>
> The SVE field in AA64PFR0 is made visible visible to userspace MRS
> emulation.  This should make sense for future architecture
> extensions.

Please could you also update the following documentation :

  Documentation/arm64/cpu-feature-registers.txt

> +#ifdef CONFIG_ARM64_SVE
> +	{
> +		.desc = "Scalable Vector Extension",
> +		.capability = ARM64_SVE,
> +		.def_scope = SCOPE_SYSTEM,
> +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> +		.sign = FTR_UNSIGNED,
> +		.field_pos = ID_AA64PFR0_SVE_SHIFT,
> +		.min_field_value = ID_AA64PFR0_SVE,
> +		.matches = has_cpuid_feature,
> +	},
> +#endif /* CONFIG_ARM64_SVE */
>  	{},
>  };
>
> @@ -889,7 +923,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
>  	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
>  #ifdef CONFIG_ARM64_SVE
> -	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SVE),
> +	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),

>  #endif
>  	{},
>  };
> @@ -1120,6 +1154,8 @@ void __init setup_cpu_features(void)
>  	if (system_supports_32bit_el0())
>  		setup_elf_hwcaps(compat_elf_hwcaps);
>
> +	sve_setup();
> +
>  	/* Advertise that we have computed the system capabilities */
>  	set_sys_caps_initialised();
>
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 8dd410e..cb3b0dd 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -19,6 +19,7 @@
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/cpufeature.h>
> +#include <asm/fpsimd.h>
>
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
> @@ -325,6 +326,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
>  	info->reg_id_aa64mmfr2 = read_cpuid(ID_AA64MMFR2_EL1);
>  	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
>  	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
> +	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
>
>  	/* Update the 32bit ID registers only if AArch32 is implemented */
>  	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
> @@ -347,6 +349,17 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
>  		info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
>  	}
>
> +	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
> +		u64 zcr;
> +
> +		write_sysreg_s(ZCR_EL1_LEN_MASK, SYS_ZCR_EL1);
> +		zcr = read_sysreg_s(SYS_ZCR_EL1);
> +		zcr &= ~(u64)ZCR_EL1_LEN_MASK;
> +		zcr |= sve_get_vl() / 16 - 1;
> +
> +		info->reg_zcr = zcr;
> +	}
> +
>  	cpuinfo_detect_icache_policy(info);
>  }
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index ddb651a..34ec75e 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -340,6 +340,26 @@ int sve_get_task_vl(struct task_struct *task)
>  	return sve_prctl_status(task);
>  }
>
> +void __init sve_setup(void)
> +{
> +	u64 zcr;
> +
> +	if (!system_supports_sve())
> +		return;
> +
> +	zcr = read_system_reg(SYS_ZCR_EL1);
> +
> +	BUG_ON(((zcr & ZCR_EL1_LEN_MASK) + 1) * 16 > sve_max_vl);
> +
> +	sve_max_vl = ((zcr & ZCR_EL1_LEN_MASK) + 1) * 16;
> +	sve_default_vl = sve_max_vl > 64 ? 64 : sve_max_vl;
> +
> +	pr_info("SVE: maximum available vector length %u bytes per vector\n",
> +		sve_max_vl);
> +	pr_info("SVE: default vector length %u bytes per vector\n",
> +		sve_default_vl);

I think we may need an extra check in verify_local_cpu_capabilities() to make sure the new CPU,
which comes up late can support the SVE vector length that could possibly used, i.e, sve_max_vl.

Rest looks good to me.

Suzuki

> +}
> +
>  #ifdef CONFIG_PROC_FS
>
>  struct default_vl_write_state {
> @@ -898,9 +918,6 @@ static int __init fpsimd_init(void)
>  	if (!(elf_hwcap & HWCAP_ASIMD))
>  		pr_notice("Advanced SIMD is not implemented\n");
>
> -	if (!(elf_hwcap & HWCAP_SVE))
> -		pr_info("Scalable Vector Extension available\n");
> -
>  	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))

nit: You may use system_supports_sve() here, instead of the elf_hwcap check. Since this
is not a performance critical path it doesn't really matter, how we check it.

>  		return sve_procfs_init();
>
>
