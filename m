From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Jan 2015 16:21:26 +0000
Subject: [PATCHv2] arm64:mm: free the useless initial page table
In-Reply-To: <1418110007-13270-1-git-send-email-zhichang.yuan@linaro.org>
References: <1418110007-13270-1-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20150123162126.GD9557@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 07:26:47AM +0000, zhichang.yuan at linaro.org wrote:
> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
> 
> For 64K page system, after mapping a PMD section, the corresponding initial
> page table is not needed any more. That page can be freed.
> 
> Changes since v1:
> 
> * make consistent code between alloc_init_pmd and alloc_init_pud;
> * flush the TLB before the unused page table is freed;
> 
> Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>

I thought about queuing this patch but I realised that
alloc_init_pmd/pud may be called in a late context where memblock_free()
would no longer make sense. Cc'ing Laura and Ard for any ideas here but
I think we may just end up with a few old page table pages sitting
around (not many though). In general we don't go from smaller to larger
mappings (that's what this patch targets) but given the API, I'm not
sure we have any guarantee.

One solution would be to check for alloc == early_alloc or something
similar. Cc'ing Laura and Ard as they added the create_mapping_late()
code.

> ---
>  arch/arm64/include/asm/pgtable.h |    3 +++
>  arch/arm64/mm/mmu.c              |   15 ++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 41a43bf..8a135b6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -337,9 +337,12 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  
>  #ifdef CONFIG_ARM64_64K_PAGES
>  #define pud_sect(pud)		(0)
> +#define pud_table(pud)		(1)
>  #else
>  #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
>  				 PUD_TYPE_SECT)
> +#define pud_table(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
> +					PUD_TYPE_TABLE)
>  #endif
>  
>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f4f8b50..515f75b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -191,8 +191,14 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>  			 * Check for previous table entries created during
>  			 * boot (__create_page_tables) and flush them.
>  			 */
> -			if (!pmd_none(old_pmd))
> +			if (!pmd_none(old_pmd)) {
>  				flush_tlb_all();
> +				if (pmd_table(old_pmd)) {
> +					phys_addr_t table = __pa(pte_offset_map(&old_pmd, 0));
> +
> +					memblock_free(table, PAGE_SIZE);
> +				}
> +			}
>  		} else {
>  			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
>  				       prot_pte);
> @@ -234,9 +240,12 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>  			 * Look up the old pmd table and free it.
>  			 */
>  			if (!pud_none(old_pud)) {
> -				phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
> -				memblock_free(table, PAGE_SIZE);
>  				flush_tlb_all();
> +				if (pud_table(old_pud)) {
> +					phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
> +
> +					memblock_free(table, PAGE_SIZE);
> +				}
>  			}
>  		} else {
>  			alloc_init_pmd(pud, addr, next, phys, map_io);
> -- 
> 1.7.9.5
