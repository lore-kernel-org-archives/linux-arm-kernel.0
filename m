From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Jun 2018 10:03:22 +0100
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <1527799054-29592-1-git-send-email-rokhanna@nvidia.com>
References: <1527799054-29592-1-git-send-email-rokhanna@nvidia.com>
Message-ID: <20180601090321.sy3t64rtps7qn2nx@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As a general thing, could you please add a version number to patches in future?
i.e. this should be PATCHv4.

It really helps keeping track of patches, distinguishing versions, etc.

On Thu, May 31, 2018 at 01:37:34PM -0700, Rohit Khanna wrote:
> In the current implementation,  __apply_alternatives patches
> flush_icache_range and then executes it without invalidating the icache.
> Thus, icache can contain some of the old instructions for
> flush_icache_range. This can cause unpredictable behavior as during
> execution we can get a mix of old and new instructions for
> flush_icache_range.
> 
> This patch :
> 
> 1. Adds a new function clean_dcache_range_nopatch for flushing kernel
> memory range. This function uses non hot-patched code and can be
> safely used to flush cache during code patching.
> 
> 2. Modifies __apply_alternatives so that it uses
> clean_dcache_range_nopatch to flush the cache range after patching code.
> 
> Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
> ---
>  arch/arm64/include/asm/sysreg.h |  3 +++
>  arch/arm64/kernel/alternative.c | 37 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6171178075dc..9d1aee7c9aba 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -617,6 +617,9 @@
>  #define MVFR1_FPDNAN_SHIFT		4
>  #define MVFR1_FPFTZ_SHIFT		0
>  
> +/* SYS_CTR_EL0 */
> +#define SYS_CTR_ISIZE_SHIFT		0
> +#define SYS_CTR_DSIZE_SHIFT		16

We already have CTR_DMINLINE_SHIFT in <asm/cache.h>

Can we please add CTR_IMINLIN_SHIFT there too?

Maybe those should be moved into sysreg.h, but that can be a separate cleanup.

>  #define ID_AA64MMFR0_TGRAN4_SHIFT	28
>  #define ID_AA64MMFR0_TGRAN64_SHIFT	24
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 5c4bce4ac381..6b8c5438b37b 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -122,6 +122,41 @@ static void patch_alternative(struct alt_instr *alt,
>  	}
>  }
>  
> +/* This is used for flushing kernel memory range after
> + * __apply_alternatives has patched kernel code
> + */
> +static void clean_dcache_range_nopatch(void *start, void *end)
> +{
> +	u64 d_start, i_start, d_size, i_size, ctr_el0;

I don't think we need separate i_start and d_start variables. A 'start' or
'cur' variable could be used for both.

> +
> +	/* use sanitised value of ctr_el0 rather than raw value from CPU */
> +	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	/* size in bytes */
> +	d_size = cpuid_feature_extract_unsigned_field(ctr_el0,
> +			SYS_CTR_DSIZE_SHIFT);
> +	i_size = cpuid_feature_extract_unsigned_field(ctr_el0,
> +			SYS_CTR_ISIZE_SHIFT);

This isn't the size in bytes. Each is log2 the number of (4-byte) words.

i.e. the size in bytes is (xMinLine << 2).

> +
> +	d_start = (u64)start & ~(d_size - 1);
> +	while (d_start <= (u64)end) {
> +		/* Use civac instead of cvau. This is required
> +		 * due to ARM errata 826319, 827319, 824069,
> +		 * 819472 on A53
> +		 */
> +		asm volatile("dc civac, %0" : : "r" (d_start));

Either this needs a memory clobber, or we need barrier() first, to ensure that
the compiler doesn't re-order this against some of the patching code, however
unlikely that may be.

> +		d_start += d_size;
> +	}

The loop can be simplified to:

	do {
		asm ( ... );
	} while (d_start += d_size, d_start < (u64)end)

> +	dsb(ish);
> +
> +	i_start = (u64)start & ~(i_size - 1);
> +	while (i_start <= (u64)end) {
> +		asm volatile("ic ivau, %0" : : "r" (i_start));
> +		i_start += i_size;
> +	}

Likewise here.

Thanks,
Mark.

> +	dsb(ish);
> +	isb();
> +}
> +
>  static void __apply_alternatives(void *alt_region, bool use_linear_alias)
>  {
>  	struct alt_instr *alt;
> @@ -155,7 +190,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
>  
>  		alt_cb(alt, origptr, updptr, nr_inst);
>  
> -		flush_icache_range((uintptr_t)origptr,
> +		clean_dcache_range_nopatch((uintptr_t)origptr,
>  				   (uintptr_t)(origptr + nr_inst));
>  	}
>  }
> -- 
> 2.1.4
> 
