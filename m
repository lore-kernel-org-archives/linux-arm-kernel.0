From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Jan 2015 15:53:22 +0000
Subject: [PATCH 1/3] arm64: Track system support for mixed endian EL0
In-Reply-To: <1421325366-13263-2-git-send-email-suzuki.poulose@arm.com>
References: <1421325366-13263-1-git-send-email-suzuki.poulose@arm.com>
 <1421325366-13263-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150116155322.GX7091@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 12:36:04PM +0000, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> This patch keeps track of the mixed endian EL0 support across
> the system and provides helper functions to export it. The status
> is a boolean indicating whether all the CPUs on the system supports
> mixed endian at EL0.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |   10 ++++++++++
>  arch/arm64/kernel/cpuinfo.c         |   22 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 07547cc..c7f68d1 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -26,6 +26,9 @@
>  
>  #define ARM64_NCAPS				2
>  
> +#define ID_AA64MMFR0_EL1_BigEndEL0	(0x1UL << 16)
> +#define ID_AA64MMFR0_EL1_BigEnd		(0x1UL << 8)

I don't like the CaMeLcAsE. Also, perhaps these definitions should be
somewhere like cputype.h?

> +
>  #ifndef __ASSEMBLY__
>  
>  extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
> @@ -51,7 +54,14 @@ static inline void cpus_set_cap(unsigned int num)
>  		__set_bit(num, cpu_hwcaps);
>  }
>  
> +static inline bool id_aa64mmfr0_mixed_endian_el0(unsigned long mmfr0)
> +{
> +	return !!(mmfr0 & (ID_AA64MMFR0_EL1_BigEndEL0 | ID_AA64MMFR0_EL1_BigEnd));
> +}

These are 4-bit fields and I think you think you should be treating them
as such.

> +
>  void check_local_cpu_errata(void);
> +bool system_supports_mixed_endian_el0(void);
> +bool cpu_supports_mixed_endian_el0(void);
>  
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 07d435c..b6d1135 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -35,6 +35,7 @@
>   */
>  DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>  static struct cpuinfo_arm64 boot_cpu_data;
> +static bool mixed_endian_el0 = true;
>  
>  static char *icache_policy_str[] = {
>  	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
> @@ -68,6 +69,26 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>  	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
>  }
>  
> +bool cpu_supports_mixed_endian_el0(void)
> +{
> +	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
> +}

Can we not just define a mask/value pair and have code do the MMFR0 access
inline? It also feels a bit over-engineered like this.

Will
