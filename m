From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 18 Dec 2015 17:03:11 +0000
Subject: [PATCH v4] arm64: run-time detection for aarch32 support
In-Reply-To: <1450454429-22976-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450454429-22976-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <56743C4F.7060201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 16:00, Yury Norov wrote:
> Kernel option COMPAT defines the ability of executing aarch32 binaries.
> Some platforms does not support aarch32 mode, and so cannot execute that
> binaries. But we cannot just disable COMPAT for them because the same
> kernel binary may be used by multiple platforms.


> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 8f271b8..781a2f7 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -184,6 +184,13 @@ static inline bool system_supports_mixed_endian_el0(void)
>   	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
>   }
>
> +static inline bool system_supports_aarch32_el0(void)
> +{
> +	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
> +	return ((pfr0 >> ID_AA64PFR0_EL0_SHIFT) & ID_AA64PFR0_ELx_MASK)
> +						!= ID_AA64PFR0_EL0_64BIT_ONLY;

Could you please use

cpuid_feature_extract_field(pfr0, ID_AA64PFR0_EL0_SHIFT) != ID_AA64PFR0_EL0_64BIT_ONLY

instead and

> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -102,6 +102,7 @@
>   #define ID_AA64PFR0_EL2_SHIFT		8
>   #define ID_AA64PFR0_EL1_SHIFT		4
>   #define ID_AA64PFR0_EL0_SHIFT		0
> +#define ID_AA64PFR0_ELx_MASK		0xf

get rid of ^ ?

As per ARM ARM, AArch32 only ID register values are unknown if AArch32 is
not implemented. So I think we need to skip accessing the AArch32 ID registers
everywhere (feature tracking), if the CPU doesn't supports it, to avoid
unnecessary SANITY failures and TAINTing the kernel.


Cheers
Suzuki
