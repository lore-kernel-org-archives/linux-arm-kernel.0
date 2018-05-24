From: cpandya@codeaurora.org (Chintan Pandya)
Date: Thu, 24 May 2018 20:29:31 +0530
Subject: [PATCH v10 3/4] arm64: Implement page table free interfaces
In-Reply-To: <1527170250-5291-4-git-send-email-cpandya@codeaurora.org>
References: <1527170250-5291-1-git-send-email-cpandya@codeaurora.org>
 <1527170250-5291-4-git-send-email-cpandya@codeaurora.org>
Message-ID: <9cecab0d-3045-39dd-638e-59e4e951d23a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/24/2018 7:27 PM, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>   1) Clearing off the current pud/pmd entry
>   2) Invalidate TLB which could have previously
>      valid but not stale entry
>   3) Freeing of the un-used next level page tables
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>   arch/arm64/mm/mmu.c | 34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index da98828..17d9282 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>   #include <asm/memblock.h>
>   #include <asm/mmu_context.h>
>   #include <asm/ptdump.h>
> +#include <asm/tlbflush.h>
>   
>   #define NO_BLOCK_MAPPINGS	BIT(0)
>   #define NO_CONT_MAPPINGS	BIT(1)
> @@ -973,12 +974,37 @@ int pmd_clear_huge(pmd_t *pmdp)
>   	return 1;
>   }
>   
> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>   {
> -	return pud_none(*pud);
> +	pmd_t *table;
> +	pmd_t pmd;
> +
> +	pmd = READ_ONCE(*pmdp);
> +	if (pmd_present(pmd)) {
> +		table = __va(pmd_val(pmd));
> +		pmd_clear(pmdp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pte_free_kernel(NULL, (pte_t *) table);
> +	}
> +	return 1;
>   }
>   
> -int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> +int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>   {
> -	return pmd_none(*pmd);
> +	pmd_t *table;
> +	pud_t pud;
> +	int i = 0;
> +
> +	pud = READ_ONCE(*pudp);
> +	if (pud_present(pud)) {
> +		table = __va(pud_val(pud));
> +		do {
> +			pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE));
> +		} while (i++, i < PTRS_PER_PMD);
Hi Will,

Right after sending these patches, I realized that do-while condition
can be made to look like what we see in ioremap/vmalloc code. I guess,
that's what you suggested. So, I'll raise v11 fixing that. Any more
concerns ?

> +
> +		pud_clear(pudp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pmd_free(NULL, table);
> +	}
> +	return 1;
>   }
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
