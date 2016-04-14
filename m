From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 17:43:06 +0100
Subject: [PATCH v3 5/7] arm64: cpufeature: Track 32bit EL0 support
In-Reply-To: <1459445255-15653-6-git-send-email-suzuki.poulose@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
 <1459445255-15653-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160414164305.GH4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 06:27:33PM +0100, Suzuki K Poulose wrote:
> Add cpu_hwcap bit for keeping track of the support for 32bit EL0.
> 
> Tested-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |    8 +++++++-
>  arch/arm64/kernel/cpufeature.c      |    9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7f64285..ca8fb4b 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -35,8 +35,9 @@
>  #define ARM64_ALT_PAN_NOT_UAO			10
>  #define ARM64_HAS_VIRT_HOST_EXTN		11
>  #define ARM64_WORKAROUND_CAVIUM_27456		12
> +#define ARM64_HAS_32BIT_EL0			13
>  
> -#define ARM64_NCAPS				13
> +#define ARM64_NCAPS				14
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -192,6 +193,11 @@ static inline bool cpu_supports_mixed_endian_el0(void)
>  	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
>  }
>  
> +static inline bool system_supports_32bit_el0(void)
> +{
> +	return cpus_have_cap(ARM64_HAS_32BIT_EL0);
> +}
> +
>  static inline bool system_supports_mixed_endian_el0(void)
>  {
>  	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cfc0cfd..739314b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -733,6 +733,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.capability = ARM64_HAS_VIRT_HOST_EXTN,
>  		.matches = runs_at_el2,
>  	},
> +	{
> +		.desc = "32bit EL0 Support",

Nit: missing hyphen (32-bit).

Will
