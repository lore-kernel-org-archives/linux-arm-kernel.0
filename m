From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jun 2018 13:13:28 +0100
Subject: [PATCH v12 4/5] arm64: Implement page table free interfaces
In-Reply-To: <1527856758-27169-5-git-send-email-cpandya@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-5-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180604121328.GG9482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 06:09:17PM +0530, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>  1) Clearing off the current pud/pmd entry
>  2) Invalidate TLB which could have previously
>     valid but not stale entry
>  3) Freeing of the un-used next level page tables

Please can you rewrite this describing the problem that you're solving,
rather than a brief summary of some requirements?

> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8ae5d7a..6e7e16c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/tlbflush.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -977,12 +978,41 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pte_t *table;
> +	pmd_t pmd;
> +
> +	pmd = READ_ONCE(*pmdp);
> +	if (pmd_present(pmd)) {
> +		table = pmd_page_vaddr(pmd);
> +		pmd_clear(pmdp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pte_free_kernel(NULL, table);
> +	}
> +	return 1;
>  }
>  
> -int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> +int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>  {
> -	return pmd_none(*pmd);
> +	pmd_t *table;
> +	pmd_t *entry;
> +	pud_t pud;
> +	unsigned long next, end;
> +
> +	pud = READ_ONCE(*pudp);
> +	if (pud_present(pud)) {

Just some stylistic stuff, but please can you rewrite this as:

	if (!pud_present(pud) || VM_WARN_ON(!pud_table(pud)))
		return 1;

similarly for the pmd/pte code above.

> +		table = pud_page_vaddr(pud);
> +		entry = table;

Could you rename entry -> pmdp, please?

> +		next = addr;
> +		end = addr + PUD_SIZE;
> +		do {
> +			pmd_free_pte_page(entry, next);
> +		} while (entry++, next += PMD_SIZE, next != end);
> +
> +		pud_clear(pudp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pmd_free(NULL, table);
> +	}
> +	return 1;

So with these patches, we only ever return 1 from these helpers. It looks
like the same is true for x86, so how about we make them void and move the
calls inside the conditionals in lib/ioremap.c? Obviously, this would be a
separate patch on the end.

Will
