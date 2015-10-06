From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Oct 2015 12:15:42 +0100
Subject: [PATCH 6/7] arm64: Mark kernel page ranges contiguous
In-Reply-To: <1443818865-19846-7-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
 <1443818865-19846-7-git-send-email-jeremy.linton@arm.com>
Message-ID: <20151006111541.GC3069@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 03:47:44PM -0500, Jeremy Linton wrote:
>  static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
> -				  unsigned long end, unsigned long pfn,
> +				  unsigned long end, phys_addr_t phys,
>  				  pgprot_t prot,
>  				  void *(*alloc)(unsigned long size))
>  {
>  	pte_t *pte;
> +	unsigned long next;
>  
>  	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
>  		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
> @@ -104,10 +145,31 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  	BUG_ON(pmd_bad(*pmd));
>  
>  	pte = pte_offset_kernel(pmd, addr);
> -	do {
> -		set_pte(pte, pfn_pte(pfn, prot));
> -		pfn++;
> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> +	if (!cont_linear_ptes)
> +		__populate_init_pte(pte, addr, end, phys, prot);
> +	else
> +	    do {
> +		next = min(end, (addr + CONT_SIZE) & CONT_MASK);
> +		if (((addr | next | phys) & CONT_RANGE_MASK) == 0) {

~CONT_MASK directly here? We don't expect addr/next/phys to not be page
aligned (and if they are, the condition fails anyway).

> +			/* a block of CONT_RANGE_SIZE PTEs */

We don't have a CONT_RANGE_SIZE macro, I guess that's CONT_RANGE (or
CONT_PTES if you rename it).

> +			__populate_init_pte(pte, addr, next, phys,
> +					    prot | __pgprot(PTE_CONT));
> +		} else {
> +			/*
> +			 * If the range being split is already inside of a
> +			 * contiguous range but this PTE isn't going to be
> +			 * contiguous, then we want to unmark the adjacent
> +			 * ranges, then update the portion of the range we
> +			 * are interrested in.
> +			 */
> +			 clear_cont_pte_range(pte, addr);
> +			 __populate_init_pte(pte, addr, next, phys, prot);
> +		}
> +
> +		pte += (next - addr) >> PAGE_SHIFT;
> +		phys += next - addr;
> +		addr = next;
> +	} while (addr != end);
>  }

-- 
Catalin
