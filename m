From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 12:50:10 +0100
Subject: [PATH V2 3/6] arm: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <1408635812-31584-4-git-send-email-steve.capper@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20140827115010.GJ6968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 04:43:29PM +0100, Steve Capper wrote:
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -35,12 +35,39 @@
>  
>  #define MMU_GATHER_BUNDLE	8
>  
> +#ifdef CONFIG_HAVE_RCU_TABLE_FREE
> +static inline void __tlb_remove_table(void *_table)
> +{
> +	free_page_and_swap_cache((struct page *)_table);
> +}
> +
> +struct mmu_table_batch {
> +	struct rcu_head		rcu;
> +	unsigned int		nr;
> +	void			*tables[0];
> +};
> +
> +#define MAX_TABLE_BATCH		\
> +	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
> +
> +extern void tlb_table_flush(struct mmu_gather *tlb);
> +extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
> +
> +#define tlb_remove_entry(tlb, entry)	tlb_remove_table(tlb, entry)
> +#else
> +#define tlb_remove_entry(tlb, entry)	tlb_remove_page(tlb, entry)
> +#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
> +
>  /*
>   * TLB handling.  This allows us to remove pages from the page
>   * tables, and efficiently handle the TLB issues.
>   */
>  struct mmu_gather {
>  	struct mm_struct	*mm;
> +#ifdef CONFIG_HAVE_RCU_TABLE_FREE
> +	struct mmu_table_batch	*batch;
> +	unsigned int		need_flush;
> +#endif

We add need_flush here just because it is set by tlb_remove_table() but
it won't actually be checked by anything since arch/arm uses its own
version of tlb_flush_mmu(). But I wouldn't go for #ifdefs in the core
code either.

We should (as a separate patchset) convert arch/arm to generic
mmu_gather. I know Russell had objections in the past but mmu_gather has
evolved since and it's not longer inefficient (I think the only case is
shift_arg_pages but that's pretty much lost in the noise).

For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
