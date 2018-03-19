From: toshi.kani@hpe.com (Kani, Toshi)
Date: Mon, 19 Mar 2018 19:29:27 +0000
Subject: [PATCH v3 2/3] arm64: Implement page table free interfaces
In-Reply-To: <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
 <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
Message-ID: <1521487759.2693.224.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-03-19 at 18:10 +0530, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>  1) Freeing of the un-used next level page tables
>  2) Clearing off the current pud/pmd entry
>  3) Invalidate TLB which could have previously
>     valid but not stale entry
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index da98828..c70f139 100644
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
> @@ -975,10 +976,35 @@ int pmd_clear_huge(pmd_t *pmdp)
>  
>  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pmd_t *pmd;
> +	int i;
> +
> +	pmd = __va(pud_val(*pud));
> +	if (pud_val(*pud)) {
> +		for (i = 0; i < PTRS_PER_PMD; i++)
> +			pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE));
> +
> +		free_page((unsigned long) pmd);

Why do you want to free this pmd page before clearing the pud entry on
this arm64 version (as it seems you intentionally changed it from the
x86 version)?  It can be reused while being pointed by the pud.  Same
for pmd.

> +		pud_clear(pud);
> +		flush_tlb_kernel_range(addr, addr + PUD_SIZE);

Since you purge the entire pud range here, do you still need to call 
pmd_free_pte_page() to purge each pmd range?  This looks very expensive.
You may want to consider if calling internal __pmd_free_pte_page()
without the purge operation works.

-Toshi
