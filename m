From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 18 Dec 2017 16:36:46 +0000
Subject: [PATCH 06/10] arm64: handle 52-bit physical addresses in page
 table entries
In-Reply-To: <1513184845-8711-7-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-7-git-send-email-kristina.martsenko@arm.com>
Message-ID: <a0a81fd9-e11c-bd85-5484-48b2e638c65a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/17 17:07, Kristina Martsenko wrote:
> The top 4 bits of a 52-bit physical address are positioned at bits
> 12..15 of a page table entry. Introduce macros to convert between a
> physical address and its placement in a table entry, and change all
> macros/functions that access PTEs to use them.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Kristina

Patch looks good, except for a couple of nits below


> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index c59c69e02036..60e0432df559 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -168,10 +168,12 @@
>   #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
>   #define PTE_HYP_XN		(_AT(pteval_t, 1) << 54)	/* HYP XN */
>   
> -#ifdef CONFIG_ARM64_PA_BITS_52
>   #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
> +#ifdef CONFIG_ARM64_PA_BITS_52
>   #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
> -#define PTE_ADDR_MASK_52	(PTE_ADDR_LOW | PTE_ADDR_HIGH)
> +#define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
> +#else
> +#define PTE_ADDR_MASK		PTE_ADDR_LOW
>   #endif
>   
>   /*
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 5d9554fb2692..65856a81e692 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -57,9 +57,20 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>   
>   #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
>   
> -#define pte_pfn(pte)		((pte_val(pte) & PHYS_MASK) >> PAGE_SHIFT)
> +/*
> + * Macros to convert between a physical address and its placement in a
> + * page table entry, taking care of 52-bit addresses.
> + */
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +#define __pte_to_phys(pte)	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))

nit: The line is too long, 100+, it may be worth putting it in a separate line :

i.e,

+#define __pte_to_phys(pte)	\
   ((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))

similarly below.

> +#define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)
> +#else
> +#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
> +#define __phys_to_pte_val(phys)	(phys)
> +#endif
>   
> -#define pfn_pte(pfn,prot)	(__pte(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
> +#define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
> +#define pfn_pte(pfn,prot)	__pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>   
>   #define pte_none(pte)		(!pte_val(pte))
>   #define pte_clear(mm,addr,ptep)	set_pte(ptep, __pte(0))
> @@ -284,6 +295,11 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
>   
>   #define __HAVE_ARCH_PTE_SPECIAL
>   
> +static inline pte_t pgd_pte(pgd_t pgd)
> +{
> +	return __pte(pgd_val(pgd));
> +}
> +
>   static inline pte_t pud_pte(pud_t pud)
>   {
>   	return __pte(pud_val(pud));
> @@ -349,16 +365,24 @@ static inline int pmd_protnone(pmd_t pmd)
>   
>   #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
>   
> -#define pmd_pfn(pmd)		(((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
> -#define pfn_pmd(pfn,prot)	(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
> +#define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
> +#define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
> +#define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
> +#define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>   #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
>   
>   #define pud_write(pud)		pte_write(pud_pte(pud))
> -#define pud_pfn(pud)		(((pud_val(pud) & PUD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
> -#define pfn_pud(pfn,prot)	(__pud(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
> +
> +#define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
> +#define __phys_to_pud_val(phys)	__phys_to_pte_val(phys)
> +#define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
> +#define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>   
>   #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
>   
> +#define __pgd_to_phys(pgd)	__pte_to_phys(pgd_pte(pgd))
> +#define __phys_to_pgd_val(phys)	__phys_to_pte_val(phys)
> +
>   #define __pgprot_modify(prot,mask,bits) \
>   	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
>   
> @@ -409,7 +433,7 @@ static inline void pmd_clear(pmd_t *pmdp)
>   
>   static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>   {
> -	return pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK;
> +	return __pmd_to_phys(pmd);
>   }
>   
>   /* Find an entry in the third-level page table. */
> @@ -427,7 +451,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>   #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
>   #define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
>   
> -#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
> +#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(__pmd_to_phys(pmd)))

You could simplify the above to :

#define pmd_page(pmd)			pfn_to_page(pmd_pfn(pmd))

? similarly for pud_page.


Other than the above nits:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
