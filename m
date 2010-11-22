From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 12:58:13 +0000
Subject: [PATCH v2 07/20] ARM: LPAE: Page table maintenance for the
	3-level format
In-Reply-To: <1289584840-18097-8-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-8-git-send-email-catalin.marinas@arm.com>
Message-ID: <20101122125813.GC31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 06:00:27PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 97a5de3..41236f0 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -124,7 +124,12 @@ extern pgprot_t		pgprot_kernel;
>  extern struct page *empty_zero_page;
>  #define ZERO_PAGE(vaddr)	(empty_zero_page)
>  
> +#ifdef CONFIG_ARM_LPAE
> +#define pte_pfn(pte)		((pte_val(pte) & PTE_PFN_MASK) >> PAGE_SHIFT)
> +#else
>  #define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
> +#endif

Just make LPAE and non-LPAE both provide PTE_PFN_MASK - for non-LPAE
this can be defined as ~0UL to optimize it away.  However, PTE_PFN_MASK
is the wrong name for this - you're not masking out the PFN, but the
physical address.  It only becomes a PFN when you shift.

This is important because...

> +static inline pte_t *pmd_page_vaddr(pmd_t pmd)
> +{
> +	return __va(pmd_val(pmd) & PTE_PFN_MASK);

... here it becomes much more confusing - it suggests that
"pmd_val(pmd) & PTE_PFN_MASK" gives you a PFN, which you then pass to
a function which takes a physical address.

Also, pmd_page_vaddr() in my patches ends up as:

 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
+       return __va(pmd_val(pmd) & PAGE_MASK);
 }

which is almost the same.  I'd suggest that this becomes for both:

 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
        return __va(pmd_val(pmd) & PTE_PFN_MASK & PAGE_MASK);
 }

but with PTE_PFN_MASK more appropriately named.

> +}
> +
> +#else	/* !CONFIG_ARM_LPAE */
> +
>  #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
>  
>  #define copy_pmd(pmdpd,pmdps)		\
> @@ -252,7 +285,13 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>  	return __va(ptr);
>  }
>  
> +#endif	/* CONFIG_ARM_LPAE */
> +
> +#ifdef CONFIG_ARM_LPAE
> +#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PTE_PFN_MASK))
> +#else
>  #define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd)))
> +#endif

Ditto.

> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index 8fdae9b..f00ae99 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -263,6 +263,18 @@
>  
>  #define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
>  
> +#ifdef CONFIG_ARM_LPAE
> +#define cpu_get_pgd()	\
> +	({						\
> +		unsigned long pg, pg2;			\
> +		__asm__("mrrc	p15, 0, %0, %1, c2"	\
> +			: "=r" (pg), "=r" (pg2)		\
> +			:				\
> +			: "cc");			\
> +		pg &= ~(PTRS_PER_PGD*sizeof(pgd_t)-1);	\
> +		(pgd_t *)phys_to_virt(pg);		\
> +	})
> +#else
>  #define cpu_get_pgd()	\
>  	({						\
>  		unsigned long pg;			\
> @@ -271,6 +283,7 @@
>  		pg &= ~0x3fff;				\

I think this wants updating to use similar math to the one above.

> @@ -81,7 +90,8 @@ void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd)
>  	if (!pgd)
>  		return;
>  
> -	/* pgd is always present and good */
> +	if (pgd_none(*pgd))
> +		goto free;

This actually wants to become something more like:

+       pgd = pgd_base + pgd_index(0);
+       if (pgd_none_or_clear_bad(pgd))
+               goto no_pgd;

+       pmd = pmd_offset(pgd, 0);
+       if (pmd_none_or_clear_bad(pmd))
+               goto no_pmd;

        pte = pmd_pgtable(*pmd);
        pmd_clear(pmd);
        pte_free(mm, pte);
+no_pmd:
+       pgd_clear(pgd);
        pmd_free(mm, pmd);
+no_pgd:
	free_pgd(pgd_base);
