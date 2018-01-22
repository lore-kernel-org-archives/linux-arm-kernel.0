From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 22 Jan 2018 12:05:52 +0000
Subject: [PATCH v2 1/6] arm64: cpufeature: Allow early detect of specific
 features
In-Reply-To: <1516190084-18978-2-git-send-email-julien.thierry@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <1516190084-18978-2-git-send-email-julien.thierry@arm.com>
Message-ID: <ce6469ab-b864-fec7-7d97-d44340f5b2e0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/18 11:54, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently it is not possible to detect features of the boot CPU
> until the other CPUs have been brought up.
> 
> This prevents us from reacting to features of the boot CPU until
> fairly late in the boot process. To solve this we allow a subset
> of features (that are likely to be common to all clusters) to be
> detected based on the boot CPU alone.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> [julien.thierry at arm.com: check non-boot cpu missing early features, avoid
> 			 duplicates between early features and normal
> 			 features]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 69 ++++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index a73a592..6698404 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -52,6 +52,8 @@
>   DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>   EXPORT_SYMBOL(cpu_hwcaps);
> 
> +static void __init setup_early_feature_capabilities(void);
> +
>   /*
>    * Flag to indicate if we have computed the system wide
>    * capabilities based on the boot time active CPUs. This
> @@ -542,6 +544,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>   		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
>   		sve_init_vq_map();
>   	}
> +
> +	setup_early_feature_capabilities();
>   }
> 
>   static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> @@ -846,7 +850,7 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
>   					ID_AA64PFR0_FP_SHIFT) < 0;
>   }
> 
> -static const struct arm64_cpu_capabilities arm64_features[] = {
> +static const struct arm64_cpu_capabilities arm64_early_features[] = {
>   	{
>   		.desc = "GIC system register CPU interface",
>   		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> @@ -857,6 +861,10 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
>   		.sign = FTR_UNSIGNED,
>   		.min_field_value = 1,
>   	},
> +	{}
> +};
> +


Julien,

One potential problem with this is that we don't have a way
to make this work on a "theoretical" system with and without
GIC system reg interface. i.e, if we don't have the CONFIG
enabled for using ICC system regs for IRQ flags, the kernel
could still panic. I understand this is not a "normal" configuration
but, may be we could make the panic option based on whether
we actually use the system regs early enough ?

Btw, I am rewriting the capabilities infrastructure to allow per-cap
control on how it should be treated. I might add an EARLY scope for
caps which could cover this and may be VHE.

Suzuki
