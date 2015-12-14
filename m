From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Dec 2015 14:04:46 +0000
Subject: [RFC PATCH 2/2] arm64: Use PoU cache instr for I/D coherency
In-Reply-To: <1450099664-38554-3-git-send-email-ashoks@broadcom.com>
References: <1450099664-38554-1-git-send-email-ashoks@broadcom.com>
 <1450099664-38554-3-git-send-email-ashoks@broadcom.com>
Message-ID: <20151214140445.GC21356@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 14, 2015 at 05:27:44AM -0800, Ashok Kumar wrote:
> In systems with three levels of cache(PoU at L1 and PoC at L3),
> PoC cache flush instructions flushes L2 and L3 caches which could affect
> performance.
> For cache flushes for I and D coherency, PoU should suffice.
> So changing all I and D coherency related cache flushes to PoU.
> 
> Introduced a new __flush_dcache_area_pou API for dcache flush till PoU
>
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> ---
>  arch/arm64/include/asm/cacheflush.h |  1 +
>  arch/arm64/mm/cache.S               | 22 ++++++++++++++++++++++
>  arch/arm64/mm/flush.c               | 13 +++++++++----
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index c75b8d0..e4b13f7 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -68,6 +68,7 @@
>  extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
>  extern void flush_icache_range(unsigned long start, unsigned long end);
>  extern void __flush_dcache_area(void *addr, size_t len);
> +extern void __flush_dcache_area_pou(void *addr, size_t len);
>  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>  
>  static inline void flush_cache_mm(struct mm_struct *mm)
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index eb48d5d..037293c 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -101,6 +101,28 @@ ENTRY(__flush_dcache_area)
>  ENDPROC(__flush_dcache_area)
>  
>  /*
> + *	__flush_dcache_area_pou(kaddr, size)
> + *
> + *	Ensure that the data held in the page kaddr is written back to the
> + *	page in question till Point of Unification.
> + *
> + *	- kaddr   - kernel address
> + *	- size    - size in question
> + */

I think it would be better to call this __clean_dcache_area_pou, to make
it clean that there's no invalidate (i.e. it can only be used to push
data out to the PoU).

> +ENTRY(__flush_dcache_area_pou)
> +	dcache_line_size x2, x3
> +	add	x1, x0, x1
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +1:	dc	cvau, x0			// clean D line till PoU
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +ENDPROC(__flush_dcache_area_pou)

At the same time we can reduce the domin of that dsb to ish, given all
CPUs will be in the same Inner-Shareable domain.

We could also factor the common logic into a macro, e.g.

	/*
	 * x0 - kaddr
	 * x1 - size
	 */
	.macro dcache_by_line_op op, domain
	dcache_line_size x2, x3
	add	x1, x0, x1
	sub	x3, x2, #1
	bic	x0, x0, x3
1:	dc	\op, x0
	add	x0, x0, x2
	cmp	x0, x1
	b.lo	1b
	dsb	\domain
	.endm

ENTRY(__flush_dcache_area)
	dcache_by_line_op civac, sy
	ret
ENDPIPROC(__flush_dcache_area)

ENTRY(__clean_dcache_area_pou)
	dcache_by_line_op cvau, ish
	ret
ENDPIPROC(__clean_dcache_area)

> +
> +/*
>   *	__inval_cache_range(start, end)
>   *	- start   - start address of region
>   *	- end     - end address of region
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index c26b804..6235af6 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -41,7 +41,7 @@ static void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
>  	if (vma->vm_flags & VM_EXEC) {
>  		unsigned long addr = (unsigned long)kaddr;
>  		if (icache_is_aliasing()) {
> -			__flush_dcache_area(kaddr, len);
> +			__flush_dcache_area_pou(kaddr, len);
>  			__flush_icache_all();
>  		} else {
>  			flush_icache_range(addr, addr + len);
> @@ -75,9 +75,14 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
>  		return;
>  
>  	if (!test_and_set_bit(PG_dcache_clean, &page->flags)) {
> -		__flush_dcache_area(page_address(page),
> -				PAGE_SIZE << compound_order(page));
> -		__flush_icache_all();
> +		if (icache_is_aliasing()) {
> +			__flush_dcache_area_pou(page_address(page),
> +					    PAGE_SIZE << compound_order(page));
> +			__flush_icache_all();
> +		} else
> +			flush_icache_range(page_address(page),
> +					   page_address(page) +
> +					   (PAGE_SIZE << compound_order(page)));

Nit: If one side of an if/else has braces, the other side should too.

Other than those points, this looks good to me.

Thanks,
Mark.
