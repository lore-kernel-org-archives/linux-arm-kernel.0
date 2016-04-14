From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 18:38:10 +0100
Subject: [PATCH 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <1459941854-5190-2-git-send-email-suzuki.poulose@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
 <1459941854-5190-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160414173809.GN4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Wed, Apr 06, 2016 at 12:24:10PM +0100, Suzuki K Poulose wrote:
> Add scope parameter to the arm64_cpu_capabilities::matches(),
> so that this can be reused for checking the capability on a
> given CPU vs the system wide. By default, the system uses
> 'system' wide values for setting the CPU_HWCAPs and ELF_HWCAPs.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |    8 +++++++-
>  arch/arm64/kernel/cpu_errata.c      |    2 +-
>  arch/arm64/kernel/cpufeature.c      |   37 +++++++++++++++++++----------------
>  3 files changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ca8fb4b..5f10344 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -78,10 +78,16 @@ struct arm64_ftr_reg {
>  	struct arm64_ftr_bits	*ftr_bits;
>  };
>  
> +/* scope of capability check */
> +enum {
> +	SCOPE_SYSTEM,
> +	SCOPE_CPU,
> +};
> +
>  struct arm64_cpu_capabilities {
>  	const char *desc;
>  	u16 capability;
> -	bool (*matches)(const struct arm64_cpu_capabilities *);
> +	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
>  	void (*enable)(void *);		/* Called on all active CPUs */
>  	union {
>  		struct {	/* To be used for erratum handling only */
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 06afd04..2fd5780 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -22,7 +22,7 @@
>  #include <asm/cpufeature.h>
>  
>  static bool __maybe_unused
> -is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
> +is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int __unused)

Maybe it would be better to WARN if somebody passes SCOPE_SYSTEM, rather
than silently treat it as per-cpu?

Will
