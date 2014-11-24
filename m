From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Nov 2014 15:06:53 +0000
Subject: [PATCH v1] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1416652956-24207-1-git-send-email-js07.lee@gmail.com>
References: <1416652956-24207-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141124150652.GF15872@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 22, 2014 at 10:42:36AM +0000, Jungseung Lee wrote:
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index 78a7793..e63c633 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -17,6 +17,7 @@
>  #include <asm/processor.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
> +#include <asm/cputype.h>
>  
>  #define check_pgt_cache()		do { } while (0)
>  
> @@ -25,6 +26,19 @@
>  #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_USER))
>  #define _PAGE_KERNEL_TABLE	(PMD_TYPE_TABLE | PMD_BIT4 | PMD_DOMAIN(DOMAIN_KERNEL))
>  
> +static inline bool cpu_has_classic_pxn(void)
> +{
> +#ifdef CONFIG_CPU_V7

I don't think shouldn't trigger this when LPAE is enabled.

> +	unsigned int vmsa;
> +
> +	/* LPAE implies atomic ldrd/strd instructions */

How is this comment relevant? Copy/paste?

> +	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> +	if (vmsa == 4)
> +		return 1;
> +#endif
> +	return 0;
> +}

In general we put the #ifdef outside the function:

#if __LINUX_ARM_ARCH__ >= 7 && !defined(CONFIG_ARM_LPAE)
static inline bool cpu_has_classic_pxn(void)
{
	unsigned int vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
	return vmsa == 4;
}
#else
static inline bool cpu_has_classic_pxn(void)
{
	return false;
}
#endif

I used __LINUX_ARM_ARCH__ instead of CONFIG_CPU_V7 to cope with kernel
images built for both v6 and v7. You could also check for
cpu_architecture() >= 7, though with a bit of performance impact.

>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> @@ -157,7 +171,11 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
>  static inline void
>  pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
>  {
> -	__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
> +	if (cpu_has_classic_pxn())
> +		__pmd_populate(pmdp, page_to_phys(ptep),
> +				_PAGE_USER_TABLE | PMD_PXNTABLE);
> +	else
> +		__pmd_populate(pmdp, page_to_phys(ptep), _PAGE_USER_TABLE);
>  }

Nitpick (personal preference):

	pmdval_t pmdval = _PAGE_USER_TABLE;
	if (cpu_has_classic_pxn())
		pmdval |= PMD_PXNTABLE;
	__pmd_populate(pmdp, page_to_phys(ptep), pmdval);

>  #define pmd_pgtable(pmd) pmd_page(pmd)
>  
> diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
> index 5cfba15..5e68278 100644
> --- a/arch/arm/include/asm/pgtable-2level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
> @@ -20,12 +20,14 @@
>  #define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
>  #define PMD_TYPE_TABLE		(_AT(pmdval_t, 1) << 0)
>  #define PMD_TYPE_SECT		(_AT(pmdval_t, 2) << 0)
> +#define PMD_PXNTABLE		(_AT(pmdval_t, 1) << 2)     /* v7 */
>  #define PMD_BIT4		(_AT(pmdval_t, 1) << 4)
>  #define PMD_DOMAIN(x)		(_AT(pmdval_t, (x)) << 5)
>  #define PMD_PROTECTION		(_AT(pmdval_t, 1) << 9)		/* v5 */
>  /*
>   *   - section
>   */
> +#define PMD_SECT_PXN    (_AT(pmdval_t, 1) << 0)     /* v7 */
>  #define PMD_SECT_BUFFERABLE	(_AT(pmdval_t, 1) << 2)
>  #define PMD_SECT_CACHEABLE	(_AT(pmdval_t, 1) << 3)
>  #define PMD_SECT_XN		(_AT(pmdval_t, 1) << 4)		/* v6 */
> diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
> index 9fd61c7..f8f1cff 100644
> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -76,6 +76,7 @@
>  #define PTE_EXT_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
>  #define PTE_EXT_AF		(_AT(pteval_t, 1) << 10)	/* Access Flag */
>  #define PTE_EXT_NG		(_AT(pteval_t, 1) << 11)	/* nG */
> +#define PTE_EXT_PXN		(_AT(pteval_t, 1) << 53)	/* PXN */
>  #define PTE_EXT_XN		(_AT(pteval_t, 1) << 54)	/* XN */
>  
>  /*
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 3b30062..04db03c 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -247,6 +247,9 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  		if (!pte_special(pteval))
>  			__sync_icache_dcache(pteval);
>  		ext |= PTE_EXT_NG;
> +#ifdef CONFIG_ARM_LPAE
> +		ext |= PTE_EXT_PXN;
> +#endif

I think you can avoid touching set_pte_at() and instead:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec7fe1e..5b0a0472e689 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -605,6 +605,11 @@ static void __init build_mem_type_table(void)
 	}
 	kern_pgprot |= PTE_EXT_AF;
 	vecs_pgprot |= PTE_EXT_AF;
+
+	/*
+	 * Set PXN for user mappings
+	 */
+	user_pgprot |= PTE_EXT_PXN;
 #endif
 
 	for (i = 0; i < 16; i++) {

-- 
Catalin
