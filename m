From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Nov 2015 17:29:59 +0000
Subject: [PATCH 3/5] arm64: debug: Treat the BRPs/WRPs as unsigned
In-Reply-To: <1447866540-23207-3-git-send-email-suzuki.poulose@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151123172958.GC1702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 05:08:58PM +0000, Suzuki K. Poulose wrote:
> IDAA64DFR0_EL1: BRPs and WRPs are unsigned values. Use
> the appropriate helpers to extract those fields.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/hw_breakpoint.h |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Once you've got the dependencies sorted out:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
> index e54415e..9732908 100644
> --- a/arch/arm64/include/asm/hw_breakpoint.h
> +++ b/arch/arm64/include/asm/hw_breakpoint.h
> @@ -138,16 +138,18 @@ extern struct pmu perf_ops_bp;
>  /* Determine number of BRP registers available. */
>  static inline int get_num_brps(void)
>  {
> +	u64 dfr0 = read_system_reg(SYS_ID_AA64DFR0_EL1);
>  	return 1 +
> -		cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
> +		cpuid_feature_extract_unsigned_field(dfr0,
>  						ID_AA64DFR0_BRPS_SHIFT);
>  }
>  
>  /* Determine number of WRP registers available. */
>  static inline int get_num_wrps(void)
>  {
> +	u64 dfr0 = read_system_reg(SYS_ID_AA64DFR0_EL1);
>  	return 1 +
> -		cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
> +		cpuid_feature_extract_unsigned_field(dfr0,
>  						ID_AA64DFR0_WRPS_SHIFT);
>  }
>  
> -- 
> 1.7.9.5
> 
