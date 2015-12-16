From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Dec 2015 12:18:21 +0000
Subject: [PATCH v3 2/2] arm64: Use PoU cache instr for I/D coherency
In-Reply-To: <1450260690-5431-3-git-send-email-ashoks@broadcom.com>
References: <1450260690-5431-1-git-send-email-ashoks@broadcom.com>
 <1450260690-5431-3-git-send-email-ashoks@broadcom.com>
Message-ID: <20151216121821.GG4308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 02:11:30AM -0800, Ashok Kumar wrote:
> In systems with three levels of cache(PoU at L1 and PoC at L3),
> PoC cache flush instructions flushes L2 and L3 caches which could affect
> performance.
> For cache flushes for I and D coherency, PoU should suffice.
> So changing all I and D coherency related cache flushes to PoU.
> 
> Introduced a new __clean_dcache_area_pou API for dcache flush till PoU
> and provided a common macro for __flush_dcache_area and
> __clean_dcache_area_pou.
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> ---
>  arch/arm64/include/asm/cacheflush.h |  1 +
>  arch/arm64/mm/cache.S               | 50 +++++++++++++++++++++++++++++--------
>  arch/arm64/mm/flush.c               | 33 +++++++++++++-----------
>  3 files changed, 58 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index c75b8d0..6a5ecbd 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -68,6 +68,7 @@
>  extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
>  extern void flush_icache_range(unsigned long start, unsigned long end);
>  extern void __flush_dcache_area(void *addr, size_t len);
> +extern void __clean_dcache_area_pou(void *addr, size_t len);
>  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>  
>  static inline void flush_cache_mm(struct mm_struct *mm)
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index eb48d5d..b700a97 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -79,28 +79,56 @@ ENDPROC(flush_icache_range)
>  ENDPROC(__flush_cache_user_range)
>  
>  /*
> + * Macro to perform a data cache maintenance for the interval
> + * [kaddr, kaddr + size)
> + *
> + * 	op:		operation passed to dc instruction
> + * 	domain:		domain used in dsb instruciton
> + * 	kaddr:		starting virtual address of the region
> + * 	size:		size of the region
> + * 	Corrupts: 	kaddr, size, tmp1, tmp2
> + */
> +	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
> +	dcache_line_size \tmp1, \tmp2
> +	add	\size, \kaddr, \size
> +	sub	\tmp2, \tmp1, #1
> +	bic	\kaddr, \kaddr, \tmp2
> +1:	dc	\op, \kaddr
> +	add	\kaddr, \kaddr, \tmp1
> +	cmp	\kaddr, \size
> +	b.lo	1b
> +	dsb	\domain
> +	.endm

Minor comment, but can you stick this in proc-macros.S and change that
label from 1: to something like 9998 please?

Other than that, looks good. I can take the next version for 4.5.

Cheers,

Will
