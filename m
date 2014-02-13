From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Feb 2014 17:12:11 +0000
Subject: [PATCH v2] ARM: mm: report both sections from PMD
In-Reply-To: <20140212224638.GA4558@www.outflux.net>
References: <20140212224638.GA4558@www.outflux.net>
Message-ID: <20140213171211.GJ19841@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 10:46:38PM +0000, Kees Cook wrote:
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 03243f7eeddf..fb3de59ee811 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -138,10 +138,6 @@
>  #define pud_none(pud)		(!pud_val(pud))
>  #define pud_bad(pud)		(!(pud_val(pud) & 2))
>  #define pud_present(pud)	(pud_val(pud))
> -#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> -						 PMD_TYPE_TABLE)
> -#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> -						 PMD_TYPE_SECT)
>  #define pmd_large(pmd)		pmd_sect(pmd)
>  
>  #define pud_clear(pudp)			\
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 7d59b524f2af..934aa5b60c7c 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -183,6 +183,10 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  
>  #define pmd_none(pmd)		(!pmd_val(pmd))
>  #define pmd_present(pmd)	(pmd_val(pmd))
> +#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> +						 PMD_TYPE_TABLE)
> +#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> +						 PMD_TYPE_SECT)

Do you still need to move these two if you only use pmd_large()? AFAICT,
it is equivalent to pmd_sect().

>  static inline pte_t *pmd_page_vaddr(pmd_t pmd)
>  {
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 2b342177f5de..32635b474832 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -260,8 +260,14 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
>  
>  	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
>  		addr = start + i * PMD_SIZE;
> -		if (pmd_none(*pmd) || pmd_large(*pmd) || !pmd_present(*pmd))
> +		if (pmd_none(*pmd) || pmd_large(*pmd) || !pmd_present(*pmd)) {
>  			note_page(st, addr, 3, pmd_val(*pmd));
> +			if (SECTION_SIZE < PMD_SIZE &&
> +			    pmd_sect(*pmd) && pmd_sect(pmd[1])) {

I think the first patch was better with pmd[0] and pmd[1] treated
independently if SECTION_SIZE < PMD_SIZE, only that it should have
checked for pmd_sect(pmd[1]). I don't see anything in
__map_init_section() that would prevent populating only the second pmd
leaving the first one empty.

-- 
Catalin
