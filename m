From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 18:14:12 +0000
Subject: [PATCH] arm64: mm: ensure that the zero page is visible to the
 page table walker
In-Reply-To: <1449769199-31361-1-git-send-email-will.deacon@arm.com>
References: <1449769199-31361-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151210181412.GL495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Dec 10, 2015 at 05:39:59PM +0000, Will Deacon wrote:
> In paging_init, we allocate the zero page, memset it to zero and then
> point TTBR0 to it in order to avoid speculative fetches through the
> identity mapping.
> 
> In order to guarantee that the freshly zeroed page is indeed visible to
> the page table walker, we need to execute a dsb instruction prior to
> writing the TTBR.
> 
> Cc: <stable@vger.kernel.org> # v3.14+, for older kernels need to drop the 'ishst'
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c04def90f3e4..c5bd5bca8e3d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -464,6 +464,9 @@ void __init paging_init(void)
>  
>  	empty_zero_page = virt_to_page(zero_page);
>  
> +	/* Ensure the zero page is visible to the page table walker */
> +	dsb(ishst);

I think this should live in early_alloc (likewise in late_alloc).

In the other cases we call early_alloc or late_allot we assume the
zeroing is visible to the page table walker.

For example in in alloc_init_pte we do:
	
	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
		if (pmd_sect(*pmd))
			split_pmd(pmd, pte);
		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
		flush_tlb_all();
	}

There's a dsb in __pmd_populate, but it's _after_ the write to the pmd
entry, so the walker might start walking the newly-allocated pte table
before the zeroing is visible.

Either we need a barrier after every alloc, or we fold the barrier into
the two allocation functions.

Thanks,
Mark.
