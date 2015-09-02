From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 02 Sep 2015 17:01:25 +0100
Subject: [PATCH v3 2/2] arm64: don't load 32-bit binaries if platform
 has no aarch32_el0
In-Reply-To: <1441209000-26746-3-git-send-email-ynorov@caviumnetworks.com>
References: <1441209000-26746-1-git-send-email-ynorov@caviumnetworks.com>
 <1441209000-26746-3-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <55E71D55.3060700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/15 16:50, Yury Norov wrote:
> Kernel option COMPAT defines the ability of executing aarch32 binaries.
> Some platforms does not support aarch32 mode, and so cannot execute that
> binaries. But we cannot just disable COMPAT for them because the same
> kernel binary may be used by multiple platforms.
>
> In this patch, system_supports_aarch32_el0() is introduced to detect
> aarch32 support at run-time.
>

As such the patch looks good. With my CPU Feature export API patch series,
this will be much more simpler, as we have an API to read the system wide safe
value of pfr0(in this case). I will post the next version of my series
after the merge window.


> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>   arch/arm64/include/asm/cpufeature.h |  1 +
>   arch/arm64/include/asm/cputype.h    |  9 +++++++++
>   arch/arm64/include/asm/elf.h        |  6 ++++--
>   arch/arm64/kernel/cpuinfo.c         | 12 ++++++++++++
>   4 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index f0e4017..35f2654 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -83,6 +83,7 @@ void check_local_cpu_errata(void);
>   void check_local_cpu_features(void);
>   bool cpu_supports_mixed_endian_el0(void);
>   bool system_supports_mixed_endian_el0(void);
> +bool system_supports_aarch32_el0(void);
>
>   #endif /* __ASSEMBLY__ */
>
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index a84ec60..5fb5585 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -81,6 +81,10 @@
>   #define ID_AA64MMFR0_BIGEND(mmfr0)	\
>   	(((mmfr0) & ID_AA64MMFR0_BIGEND_MASK) >> ID_AA64MMFR0_BIGEND_SHIFT)
>
> +#define ID_AA64PFR0_EL0_64	1
> +#define ID_AA64PFR0_EL0_6432	2
> +#define ID_AA64PFR0_EL0_MASK	0xf
> +
>   #define SCTLR_EL1_CP15BEN	(0x1 << 5)
>   #define SCTLR_EL1_SED		(0x1 << 8)
>
> @@ -116,6 +120,11 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
>   	return read_cpuid(CTR_EL0);
>   }
>
> +static inline bool id_aa64pfr0_aarch32_el0(u64 pfr0)
> +{
> +	return (pfr0 & ID_AA64PFR0_EL0_MASK) == ID_AA64PFR0_EL0_6432;

Or you could use (with aarch64 for-next/core branch) :

	return (cpuid_feature_extract_field(pfr0, 0) == ID_AA64PFR0_EL0_6432);


Thanks
Suzuki
