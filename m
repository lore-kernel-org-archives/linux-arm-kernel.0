From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Jan 2016 11:22:11 +0000
Subject: [RFC][PATCH 1/4] arm64: Drop alloc function from create_mapping
In-Reply-To: <1453740735-17898-2-git-send-email-labbott@fedoraproject.org>
References: <1453740735-17898-1-git-send-email-labbott@fedoraproject.org>
 <1453740735-17898-2-git-send-email-labbott@fedoraproject.org>
Message-ID: <20160126112211.GB5059@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 08:52:12AM -0800, Laura Abbott wrote:
> create_mapping is only used in fixmap_remap_fdt. All the create_mapping
> calls need to happen on existing translation table pages without
> additional allocations. Rather than have an alloc function be called
> and fail, just set it to NULL and catch it's use.

This looks sensible to me, though I think we should rename
create_mapping to something that makes it clear that not allocating
pages is a deliberate design decision, and thus it must be called with
care.

Perhaps create_mapping_noalloc?

Thanks,
Mark.

> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
>  arch/arm64/mm/mmu.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e141762..2d6e7cf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -116,7 +116,9 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  	pte_t *pte;
>  
>  	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
> -		phys_addr_t pte_phys = pgtable_alloc();
> +		phys_addr_t pte_phys;
> +		BUG_ON(!pgtable_alloc);
> +		pte_phys = pgtable_alloc();
>  		pte = pte_fixmap(pte_phys);
>  		if (pmd_sect(*pmd))
>  			split_pmd(pmd, pte);
> @@ -158,7 +160,9 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
>  	 * Check for initial section mappings in the pgd/pud and remove them.
>  	 */
>  	if (pud_none(*pud) || pud_sect(*pud)) {
> -		phys_addr_t pmd_phys = pgtable_alloc();
> +		phys_addr_t pmd_phys;
> +		BUG_ON(!pgtable_alloc);
> +		pmd_phys = pgtable_alloc();
>  		pmd = pmd_fixmap(pmd_phys);
>  		if (pud_sect(*pud)) {
>  			/*
> @@ -223,7 +227,9 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
>  	unsigned long next;
>  
>  	if (pgd_none(*pgd)) {
> -		phys_addr_t pud_phys = pgtable_alloc();
> +		phys_addr_t pud_phys;
> +		BUG_ON(!pgtable_alloc);
> +		pud_phys = pgtable_alloc();
>  		__pgd_populate(pgd, pud_phys, PUD_TYPE_TABLE);
>  	}
>  	BUG_ON(pgd_bad(*pgd));
> @@ -319,7 +325,7 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
>  		return;
>  	}
>  	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
> -			     early_pgtable_alloc);
> +			     NULL);
>  }
>  
>  void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> -- 
> 2.5.0
> 
