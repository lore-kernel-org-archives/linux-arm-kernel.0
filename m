From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Jan 2017 10:53:49 +0000
Subject: [RFC PATCH 02/10] arm64: cpufeature: Don't enforce system-wide
 SPE capability
In-Reply-To: <1483467027-14547-3-git-send-email-will.deacon@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-3-git-send-email-will.deacon@arm.com>
Message-ID: <20170104105349.GC8329@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 06:10:19PM +0000, Will Deacon wrote:
> The statistical profiling extension (SPE) is an optional feature of
> ARMv8.1 and is unlikely to be supported by all of the CPUs in a
> heterogeneous system.
> 
> This patch updates the cpufeature checks so that such systems are not
> tainted as unsupported.
> 
> Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I couldn't find this in the ARMV8.1 supplement, but it is in the SPE
spec. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/include/asm/sysreg.h | 1 +
>  arch/arm64/kernel/cpufeature.c  | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 98ae03f8eedd..e156e7793a65 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -190,6 +190,7 @@
>  #define ID_AA64MMFR2_CNP_SHIFT		0
>  
>  /* id_aa64dfr0 */
> +#define ID_AA64DFR0_PMSVER_SHIFT	32
>  #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
>  #define ID_AA64DFR0_WRPS_SHIFT		20
>  #define ID_AA64DFR0_BRPS_SHIFT		12
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 47d0226620e8..c18eb78d3a00 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -180,7 +180,8 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
> +	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 36, 28, 0),

As a heads-up, this line will disappear with Suzuki's cpufeature updates
series, so you may spot a clash later on.

Thanks,
Mark.

> +	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_PMSVER_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
> -- 
> 2.1.4
> 
