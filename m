From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Feb 2011 17:56:57 +0000
Subject: [PATCH v4 09/19] ARM: LPAE: Page table maintenance for the
	3-level format
In-Reply-To: <1295891761-18366-10-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-10-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110203175657.GD14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 05:55:51PM +0000, Catalin Marinas wrote:
> The patch also introduces the L_PGD_SWAPPER flag to mark pgd entries
> pointing to pmd tables pre-allocated in the swapper_pg_dir and avoid
> trying to free them at run-time. This flag is 0 with the classic page
> table format.

This shouldn't be necessary.

> diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
> index 709244c..003587d 100644
> --- a/arch/arm/mm/pgd.c
> +++ b/arch/arm/mm/pgd.c
> @@ -10,6 +10,7 @@
>  #include <linux/mm.h>
>  #include <linux/gfp.h>
>  #include <linux/highmem.h>
> +#include <linux/slab.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/page.h>
> @@ -17,6 +18,14 @@
>  
>  #include "mm.h"
>  
> +#ifdef CONFIG_ARM_LPAE
> +#define __pgd_alloc()	kmalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL)
> +#define __pgd_free(pgd)	kfree(pgd)
> +#else
> +#define __pgd_alloc()	(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
> +#define __pgd_free(pgd)	free_pages((unsigned long)pgd, 2)
> +#endif
> +
>  /*
>   * need to get a 16k page for level 1
>   */
> @@ -26,7 +35,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  	pmd_t *new_pmd, *init_pmd;
>  	pte_t *new_pte, *init_pte;
>  
> -	new_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, 2);
> +	new_pgd = __pgd_alloc();
>  	if (!new_pgd)
>  		goto no_pgd;
>  
> @@ -41,12 +50,21 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  
>  	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
>  
> +#ifdef CONFIG_ARM_LPAE
> +	/*
> +	 * Allocate PMD table for modules and pkmap mappings.
> +	 */
> +	new_pmd = pmd_alloc(mm, new_pgd + pgd_index(MODULES_VADDR), 0);
> +	if (!new_pmd)
> +		goto no_pmd;

This should be a copy of the same page tables found in swapper_pg_dir -
that's what the memcpy() above is doing.

> +#endif
> +
>  	if (!vectors_high()) {
>  		/*
>  		 * On ARM, first page must always be allocated since it
>  		 * contains the machine vectors.
>  		 */
> -		new_pmd = pmd_alloc(mm, new_pgd, 0);
> +		new_pmd = pmd_alloc(mm, new_pgd + pgd_index(0), 0);

However, the first pmd table, and the first pte table only need to be
present for the reason stated in the comment, and these need to be
allocated.

>  		if (!new_pmd)
>  			goto no_pmd;
>  
> @@ -66,7 +84,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  no_pte:
>  	pmd_free(mm, new_pmd);
>  no_pmd:
> -	free_pages((unsigned long)new_pgd, 2);
> +	__pgd_free(new_pgd);
>  no_pgd:
>  	return NULL;
>  }
> @@ -80,20 +98,36 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd_base)
>  	if (!pgd_base)
>  		return;
>  
> -	pgd = pgd_base + pgd_index(0);
> -	if (pgd_none_or_clear_bad(pgd))
> -		goto no_pgd;
> +	if (!vectors_high()) {

No, that's wrong.  As FIRST_USER_ADDRESS is nonzero, the first pmd and
pte table will remain allocated in spite of free_pgtables(), so this
results in a memory leak.

> +		pgd = pgd_base + pgd_index(0);
> +		if (pgd_none_or_clear_bad(pgd))
> +			goto no_pgd;
>  
> -	pmd = pmd_offset(pgd, 0);
> -	if (pmd_none_or_clear_bad(pmd))
> -		goto no_pmd;
> +		pmd = pmd_offset(pgd, 0);
> +		if (pmd_none_or_clear_bad(pmd))
> +			goto no_pmd;
>  
> -	pte = pmd_pgtable(*pmd);
> -	pmd_clear(pmd);
> -	pte_free(mm, pte);
> +		pte = pmd_pgtable(*pmd);
> +		pmd_clear(pmd);
> +		pte_free(mm, pte);
>  no_pmd:
> -	pgd_clear(pgd);
> -	pmd_free(mm, pmd);
> +		pgd_clear(pgd);
> +		pmd_free(mm, pmd);
> +	}
>  no_pgd:
> -	free_pages((unsigned long) pgd_base, 2);
> +#ifdef CONFIG_ARM_LPAE
> +	/*
> +	 * Free modules/pkmap or identity pmd tables.
> +	 */
> +	for (pgd = pgd_base; pgd < pgd_base + PTRS_PER_PGD; pgd++) {
> +		if (pgd_none_or_clear_bad(pgd))
> +			continue;
> +		if (pgd_val(*pgd) & L_PGD_SWAPPER)
> +			continue;
> +		pmd = pmd_offset(pgd, 0);
> +		pgd_clear(pgd);
> +		pmd_free(mm, pmd);
> +	}
> +#endif

And as kernel mappings in the pgd above TASK_SIZE are supposed to be
identical across all page tables, this shouldn't be necessary.
