From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Apr 2016 12:28:00 +0100
Subject: [PATCH v2 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <1460997334-26232-2-git-send-email-suzuki.poulose@arm.com>
References: <1460997334-26232-1-git-send-email-suzuki.poulose@arm.com>
 <1460997334-26232-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160420112800.GC2514@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 05:35:30PM +0100, Suzuki K Poulose wrote:
> Add scope parameter to the arm64_cpu_capabilities::matches(), so that
> this can be reused for checking the capability on a given CPU vs the
> system wide. The system uses the default scope associated with the
> capability for initialising the CPU_HWCAPs and ELF_HWCAPs.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> ---
> Changes since V1:
>  - Add a default scope for capabilities used by the system checks.
>  - Add WARN_ON() for !SCOPE_CPU for midr checks
> ---
>  arch/arm64/include/asm/cpufeature.h |    9 ++++++-
>  arch/arm64/kernel/cpu_errata.c      |    4 ++-
>  arch/arm64/kernel/cpufeature.c      |   46 ++++++++++++++++++++++-------------
>  3 files changed, 40 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ca8fb4b..a5a6502 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -78,10 +78,17 @@ struct arm64_ftr_reg {
>  	struct arm64_ftr_bits	*ftr_bits;
>  };
>  
> +/* scope of capability check */
> +enum {
> +	SCOPE_SYSTEM,
> +	SCOPE_CPU,
> +};

I think I actually prefer the GLOBAL/LOCAL naming, since SYSTEM is going
to be the scope you want when talking about all CPUs. Or maybe just
rename SCOPE_CPU to SCOPE_LOCAL_CPU.

We might want a preemptible() check when probing SCOPE_CPU properties,
too.

> +
>  struct arm64_cpu_capabilities {
>  	const char *desc;
>  	u16 capability;
> -	bool (*matches)(const struct arm64_cpu_capabilities *);
> +	int def_scope;			/* default scope */
> +	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
>  	void (*enable)(void *);		/* Called on all active CPUs */
>  	union {
>  		struct {	/* To be used for erratum handling only */
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 06afd04..e171a14 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -22,14 +22,16 @@
>  #include <asm/cpufeature.h>
>  
>  static bool __maybe_unused
> -is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
> +is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
>  {
> +	WARN_ON(scope != SCOPE_CPU);
>  	return MIDR_IS_CPU_MODEL_RANGE(read_cpuid_id(), entry->midr_model,
>  				       entry->midr_range_min,
>  				       entry->midr_range_max);
>  }
>  
>  #define MIDR_RANGE(model, min, max) \
> +	.def_scope = SCOPE_CPU, \
>  	.matches = is_affected_midr_range, \
>  	.midr_model = model, \
>  	.midr_range_min = min, \
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 8c46621..db392c5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -71,7 +71,9 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>  
>  /* meta feature for alternatives */
>  static bool __maybe_unused
> -cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry);
> +cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
> +
> +static u64 __raw_read_system_reg(u32 sys_id);

Can we not reorder the functions in this file to avoid the internal forward
declarations?

Will
