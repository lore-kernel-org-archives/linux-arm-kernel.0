From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Nov 2018 18:02:41 +0000
Subject: [PATCH v6 03/24] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
In-Reply-To: <1542023835-21446-4-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-4-git-send-email-julien.thierry@arm.com>
Message-ID: <c17e8470-ad13-ca1d-d8aa-71feebd1a32d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/11/2018 11:56, Julien Thierry wrote:
> Add a cpufeature indicating whether a cpu supports masking interrupts
> by priority.
> 
> The feature will be properly enabled in a later patch.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/include/asm/cpucaps.h    |  3 ++-
>   arch/arm64/include/asm/cpufeature.h |  6 ++++++
>   arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++++
>   3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 6e2d254..f367e5c 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -54,7 +54,8 @@
>   #define ARM64_HAS_CRC32				33
>   #define ARM64_SSBS				34
>   #define ARM64_WORKAROUND_1188873		35
> +#define ARM64_HAS_IRQ_PRIO_MASKING		36
>   
> -#define ARM64_NCAPS				36
> +#define ARM64_NCAPS				37
>   
>   #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7e2ec64..a6e063f 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -514,6 +514,12 @@ static inline bool system_supports_cnp(void)
>   		cpus_have_const_cap(ARM64_HAS_CNP);
>   }
>   
> +static inline bool system_supports_irq_prio_masking(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
> +	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
> +}
> +
>   #define ARM64_SSBD_UNKNOWN		-1
>   #define ARM64_SSBD_FORCE_DISABLE	0
>   #define ARM64_SSBD_KERNEL		1
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 03a9d96..1b5b553 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1145,6 +1145,14 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>   }
>   #endif /* CONFIG_ARM64_RAS_EXTN */
>   
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
> +static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
> +				   int scope)
> +{
> +	return false;
> +}
> +#endif
> +
>   static const struct arm64_cpu_capabilities arm64_features[] = {
>   	{
>   		.desc = "GIC system register CPU interface",
> @@ -1368,6 +1376,21 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>   		.cpu_enable = cpu_enable_cnp,
>   	},
>   #endif
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
> +	{
> +		/*
> +		 * Depends on having GICv3
> +		 */
> +		.desc = "IRQ priority masking",
> +		.capability = ARM64_HAS_IRQ_PRIO_MASKING,
> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> +		.matches = can_use_gic_priorities,
> +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> +		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> +		.sign = FTR_UNSIGNED,
> +		.min_field_value = 1,
> +	},
> +#endif
>   	{},
>   };
>   
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
