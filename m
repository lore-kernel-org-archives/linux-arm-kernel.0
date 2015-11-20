From: yalin.wang2010@gmail.com (yalin wang)
Date: Fri, 20 Nov 2015 18:07:21 +0800
Subject: [PATCH v3] arm64: Add support for PTE contiguous bit.
In-Reply-To: <1447952231-17631-1-git-send-email-dwoods@ezchip.com>
References: <1447952231-17631-1-git-send-email-dwoods@ezchip.com>
Message-ID: <5D0C7112-063F-4116-9585-ADF4ADF97AAE@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Nov 20, 2015, at 00:57, David Woods <dwoods@ezchip.com> wrote:
> 
> The arm64 MMU supports a Contiguous bit which is a hint that the TTE
> is one of a set of contiguous entries which can be cached in a single
> TLB entry.  Supporting this bit adds new intermediate huge page sizes.
> 
> The set of huge page sizes available depends on the base page size.
> Without using contiguous pages the huge page sizes are as follows.
> 
> 4KB:   2MB  1GB
> 64KB: 512MB
> 
> With a 4KB granule, the contiguous bit groups together sets of 16 pages
> and with a 64KB granule it groups sets of 32 pages.  This enables two new
> huge page sizes in each case, so that the full set of available sizes
> is as follows.
> 
> 4KB:  64KB   2MB  32MB  1GB
> 64KB:   2MB 512MB  16GB
> 
> If a 16KB granule is used then the contiguous bit groups 128 pages
> at the PTE level and 32 pages at the PMD level.
> 
> If the base page size is set to 64KB then 2MB pages are enabled by
> default.  It is possible in the future to make 2MB the default huge
> page size for both 4KB and 64KB granules.
> 
> Signed-off-by: David Woods <dwoods@ezchip.com>
> Reviewed-by: Chris Metcalf <cmetcalf@ezchip.com>
> ---
> 
> This patch should resolve the comments on v2 and is now based on on the 
> arm64 next tree which includes 16K granule support.  I've added definitions 
> which should enable 2M and 1G huge page sizes with a 16K granule.  
> Unfortunately, the A53 model we have does not support 16K so I don't 
> have a way to test this.
> 
> arch/arm64/Kconfig                     |   3 -
> arch/arm64/include/asm/hugetlb.h       |  44 ++----
> arch/arm64/include/asm/pgtable-hwdef.h |  18 ++-
> arch/arm64/include/asm/pgtable.h       |  10 +-
> arch/arm64/mm/hugetlbpage.c            | 267 ++++++++++++++++++++++++++++++++-
> include/linux/hugetlb.h                |   2 -
> 6 files changed, 306 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 40e1151..077bb7c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -480,9 +480,6 @@ config HW_PERF_EVENTS
> config SYS_SUPPORTS_HUGETLBFS
> 	def_bool y
> 
> -config ARCH_WANT_GENERAL_HUGETLB
> -	def_bool y
> -
> config ARCH_WANT_HUGE_PMD_SHARE
> 	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index bb4052e..bbc1e35 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -26,36 +26,7 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
> 	return *ptep;
> }
> 
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> -{
> -	set_pte_at(mm, addr, ptep, pte);
> -}
> -
> -static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> -					 unsigned long addr, pte_t *ptep)
> -{
> -	ptep_clear_flush(vma, addr, ptep);
> -}
> -
> -static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> -					   unsigned long addr, pte_t *ptep)
> -{
> -	ptep_set_wrprotect(mm, addr, ptep);
> -}
> 
> -static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> -{
> -	return ptep_get_and_clear(mm, addr, ptep);
> -}
> -
> -static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> -					     unsigned long addr, pte_t *ptep,
> -					     pte_t pte, int dirty)
> -{
> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> -}
> 
> static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> 					  unsigned long addr, unsigned long end,
> @@ -97,4 +68,19 @@ static inline void arch_clear_hugepage_flags(struct page *page)
> 	clear_bit(PG_dcache_clean, &page->flags);
> }
> 
> +extern pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
> +				struct page *page, int writable);
> +#define arch_make_huge_pte arch_make_huge_pte
> +extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> +			    pte_t *ptep, pte_t pte);
> +extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> +				      unsigned long addr, pte_t *ptep,
> +				      pte_t pte, int dirty);
> +extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> +				     unsigned long addr, pte_t *ptep);
> +extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
> +				    unsigned long addr, pte_t *ptep);
> +extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
> +				  unsigned long addr, pte_t *ptep);
> +
> #endif /* __ASM_HUGETLB_H */
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index d6739e8..5c25b83 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -90,7 +90,23 @@
> /*
>  * Contiguous page definitions.
>  */
> -#define CONT_PTES		(_AC(1, UL) << CONT_SHIFT)
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define CONT_PTE_SHIFT		5
> +#define CONT_PMD_SHIFT		5
> +#elif defined(CONFIG_ARM64_16K_PAGES)
> +#define CONT_PTE_SHIFT		7
> +#define CONT_PMD_SHIFT		5
> +#else
> +#define CONT_PTE_SHIFT		4
> +#define CONT_PMD_SHIFT		4
> +#endif
> +
> +#define CONT_PTES		(1 << CONT_PTE_SHIFT)
> +#define CONT_PTE_SIZE		(CONT_PTES * PAGE_SIZE)
> +#define CONT_PTE_MASK		(~(CONT_PTE_SIZE - 1))
> +#define CONT_PMDS		(1 << CONT_PMD_SHIFT)
> +#define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
> +#define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
> /* the the numerical offset of the PTE within a range of CONT_PTES */
> #define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_PTES-1))
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 1c99d56..d259332 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -214,7 +214,8 @@ static inline pte_t pte_mkspecial(pte_t pte)
> 
> static inline pte_t pte_mkcont(pte_t pte)
> {
> -	return set_pte_bit(pte, __pgprot(PTE_CONT));
> +	pte = set_pte_bit(pte, __pgprot(PTE_CONT));
> +	return set_pte_bit(pte, __pgprot(PTE_TYPE_PAGE));
> }
> 
> static inline pte_t pte_mknoncont(pte_t pte)
> @@ -222,6 +223,11 @@ static inline pte_t pte_mknoncont(pte_t pte)
> 	return clear_pte_bit(pte, __pgprot(PTE_CONT));
> }
> 
> +static inline pmd_t pmd_mkcont(pmd_t pmd)
> +{
> +	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
> +}
> +
> static inline void set_pte(pte_t *ptep, pte_t pte)
> {
> 	*ptep = pte;
> @@ -291,7 +297,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> /*
>  * Hugetlb definitions.
>  */
> -#define HUGE_MAX_HSTATE		2
> +#define HUGE_MAX_HSTATE		4
> #define HPAGE_SHIFT		PMD_SHIFT
> #define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
> #define HPAGE_MASK		(~(HPAGE_SIZE - 1))
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 383b03f..1688445 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -41,17 +41,282 @@ int pud_huge(pud_t pud)
> #endif
> }
> 
> +static int find_num_contig(struct mm_struct *mm, unsigned long addr,
> +			   pte_t *ptep, pte_t pte, size_t *pgsize)
> +{
> +	pgd_t *pgd = pgd_offset(mm, addr);
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	if (!pte_cont(pte))
> +		return 1;
> +	if (!pgd_present(*pgd)) {
> +		VM_BUG_ON(!pgd_present(*pgd));
> +		return 1;
> +	}
> +	pud = pud_offset(pgd, addr);
> +	if (!pud_present(*pud)) {
> +		VM_BUG_ON(!pud_present(*pud));
> +		return 1;
> +	}
> +	pmd = pmd_offset(pud, addr);
> +	if (!pmd_present(*pmd)) {
> +		VM_BUG_ON(!pmd_present(*pmd));
> +		return 1;
> +	}
> +	if ((pte_t *)pmd == ptep) {
> +		*pgsize = PMD_SIZE;
> +		return CONT_PMDS;
> +	}
> +	*pgsize = PAGE_SIZE;
> +	return CONT_PTES;
> +}
> +
> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> +			    pte_t *ptep, pte_t pte)
> +{
> +	size_t pgsize;
> +	int i;
> +	int ncontig = find_num_contig(mm, addr, ptep, pte, &pgsize);
> +	unsigned long pfn;
> +	pgprot_t hugeprot;
> +
> +	if (ncontig == 1) {
> +		set_pte_at(mm, addr, ptep, pte);
> +		return;
> +	}
> +
> +	pfn = pte_pfn(pte);
> +	hugeprot = __pgprot(pte_val(pfn_pte(pfn, 0) ^ pte_val(pte)));
is this should be pte_val(pfn_pte(pfn, 0)) ^ pte_val(pte)  ?

> +	for (i = 0; i < ncontig; i++) {
> +		pr_debug("%s: set pte %p to 0x%llx\n", __func__, ptep,
> +			 pfn_pte(pfn, hugeprot));
> +		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
> +		ptep++;
> +		pfn += pgsize >> PAGE_SHIFT;
> +		addr += pgsize;
> +	}
> +}
> 
