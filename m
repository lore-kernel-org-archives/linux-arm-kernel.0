From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 May 2018 10:06:50 +0100
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <1527012451-16117-1-git-send-email-rokhanna@nvidia.com>
References: <1527012451-16117-1-git-send-email-rokhanna@nvidia.com>
Message-ID: <20180523090638.GA26965@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rohit,

On Tue, May 22, 2018 at 11:07:31AM -0700, Rohit Khanna wrote:
> In the current implementation,  __apply_alternatives patches
> flush_icache_range and then executes it without invalidating the icache.
> Thus, icache can contain some of the old instructions for
> flush_icache_range. This can cause unpredictable behavior as during
> execution we can get a mix of old and new instructions for
> flush_icache_range.
> 
> This patch :
> 
> 1. Adds a new function flush_cache_kernel_range for flushing kernel
> memory range. This function is not patched during boot and can be safely
> used to flush cache during code patching.
> 
> 2. Modifies __apply_alternatives so that it uses
> flush_cache_kernel_range to flush the cache range after patching code.
> 
> Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
> ---
>  arch/arm64/include/asm/cacheflush.h |  1 +
>  arch/arm64/kernel/alternative.c     |  2 +-
>  arch/arm64/mm/cache.S               | 42 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 1 deletion(-)

Thanks for the patch; this is a horrible bug :)

Comments below.

> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 30334d81b021..1366f00297c3 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -81,6 +81,48 @@ ENDPROC(flush_icache_range)
>  ENDPROC(__flush_cache_user_range)
>  
>  /*
> + *	flush_cache_kernel_range(start,end)
> + *
> + *	Ensure that the I and D caches are coherent within specified kernel
> + *	region.
> + *	This is typically used when code has been written to a kernel memory
> + *	region and will be executed.
> + *
> + *	NOTE - This macro cannot have "alternatives" applied to it as its
> + *	used to update alternatives
> + *
> + *	- start   - virtual start address of region
> + *	- end     - virtual end address of region
> + */
> +ENTRY(flush_cache_kernel_range)
> +	raw_dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x4, x0, x3
> +1:
> +	dc	civac, x4	/* Use civac instead of cvau. This is required
> +				 * due to ARM errata 826319, 827319, 824069,
> +				 * 819472 on A53
> +				 */
> +	add	x4, x4, x2
> +	cmp	x4, x1
> +	b.lo	1b
> +	dsb	ish
> +
> +	raw_icache_line_size x2, x3

Won't this be broken on systems that misreport the line size in CTR?

> +	sub	x3, x2, #1
> +	bic	x4, x0, x3
> +1:
> +	ic	ivau, x4			// invalidate I line PoU
> +	add	x4, x4, x2
> +	cmp	x4, x1
> +	b.lo	1b
> +	dsb	ish
> +	isb
> +	mov	x0, #0
> +	ret
> +ENDPROC(flush_cache_kernel_range)

Generally, I don't think we want to expose this function as it's not going
to be the right thing to call outside of the alternatives patching. Instead,
can we:

  1. Code this up in alternative.c, mostly in C code and always using the
     sanitised feature register value for the CTR

  2. Just call __flush_icache_all once after patching is complete (and
     add a comment to __flush_icache_all saying that it's used by the
     patching code)

That way, we're keeping the implementation private and simple so we can
hopefully avoid running into this problem again.

Cheers,

Will
