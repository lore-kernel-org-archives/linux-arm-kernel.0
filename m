From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jul 2015 18:49:15 +0100
Subject: [PATCH 2/2] arm64: Use last level TLBI for user pte changes
In-Reply-To: <1437728396-5408-3-git-send-email-catalin.marinas@arm.com>
References: <1437728396-5408-1-git-send-email-catalin.marinas@arm.com>
 <1437728396-5408-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20150727174915.GM3358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 09:59:56AM +0100, Catalin Marinas wrote:
> The flush_tlb_page() function is used on user address ranges when PTEs
> (or PMDs/PUDs for huge pages) were changed (attributes or clearing). For
> such cases, it is more efficient to invalidate only the last level of
> the TLB with the "tlbi vale1is" instruction.
> 
> In the TLB shoot-down case, the TLB caching of the intermediate page
> table levels (pmd, pud, pgd) is handled by __flush_tlb_pgtable() via the
> __(pte|pmd|pud)_free_tlb() functions and it is not deferred to
> tlb_finish_mmu() (as of commit 285994a62c80 - "arm64: Invalidate the TLB
> corresponding to intermediate page table levels"). The tlb_flush()
> function only needs to invalidate the TLB for the last level of page
> tables; a new arm64-specific __flush_tlb_page_range() function performs
> only the last level TLBI.

[...]

> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 1643908eb5f3..48794ab79cc0 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -87,7 +87,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>  		((unsigned long)ASID(vma->vm_mm) << 48);
>  
>  	dsb(ishst);
> -	asm("tlbi	vae1is, %0" : : "r" (addr));
> +	asm("tlbi	vale1is, %0" : : "r" (addr));
>  	dsb(ish);
>  }
>  
> @@ -97,6 +97,26 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>   */
>  #define MAX_TLB_RANGE	(1024UL << PAGE_SHIFT)
>  
> +static inline void __flush_tlb_page_range(struct vm_area_struct *vma,
> +					  unsigned long start, unsigned long end)
> +{
> +	unsigned long asid = (unsigned long)ASID(vma->vm_mm) << 48;
> +	unsigned long addr;
> +
> +	if ((end - start) > MAX_TLB_RANGE) {
> +		flush_tlb_mm(vma->vm_mm);
> +		return;
> +	}
> +
> +	start = asid | (start >> 12);
> +	end = asid | (end >> 12);
> +
> +	dsb(ishst);
> +	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
> +		asm("tlbi vale1is, %0" : : "r"(addr));
> +	dsb(ish);
> +}

This is identical to __flush_tlb_range apart from the asm op.

What happens if you add a "const bool leaf" parameter and stick a
conditional inside the loop?

Will
