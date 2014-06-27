From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 12:39:34 +0100
Subject: [PATCH V5 2/2] arm: mm: Modify pte_write and pmd_write logic for
 LPAE
In-Reply-To: <1403612604-2645-3-git-send-email-steve.capper@linaro.org>
References: <1403612604-2645-1-git-send-email-steve.capper@linaro.org>
 <1403612604-2645-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20140627113933.GL26276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Steve,

On Tue, Jun 24, 2014 at 01:23:24PM +0100, Steve Capper wrote:
> For LPAE, we have the following means for encoding writable or dirty
> ptes:
>                               L_PTE_DIRTY       L_PTE_RDONLY
>     !pte_dirty && !pte_write        0               1
>     !pte_dirty && pte_write         0               1
>     pte_dirty && !pte_write         1               1
>     pte_dirty && pte_write          1               0
> 
> So we can't distinguish between writeable clean ptes and read only
> ptes. This can cause problems with ptes being incorrectly flagged as
> read only when they are writeable but not dirty.
> 
> This patch renumbers L_PTE_RDONLY from AP[2] to a software bit #58,
> and adds additional logic to set AP[2] whenever the pte is read only
> or not dirty. That way we can distinguish between clean writeable ptes
> and read only ptes.
> 
> HugeTLB pages will use this new logic automatically.
> 
> We need to add some logic to Transparent HugePages to ensure that they
> correctly interpret the revised pgprot permissions (L_PTE_RDONLY has
> moved and no longer matches PMD_SECT_RDONLY). In the process of
> revising THP, the names of the PMD software bits have been prefixed
> with L_ to make them easier to distinguish from their hardware bit
> counterparts.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Changed in V5 -> rather than re-introduce L_PTE_WRITE we change
> L_PTE_RDONLY to be a software bit #58. This allows us to leave the
> two level code alone.

Damnit, you owe me a beer every time I have to review this patch ;)
At least proc-macros.S is unscathed this time around!

> ---
>  arch/arm/include/asm/pgtable-3level-hwdef.h |  1 +
>  arch/arm/include/asm/pgtable-3level.h       | 37 +++++++++++++++++------------
>  arch/arm/mm/proc-v7-3level.S                |  9 +++++--
>  3 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
> index 626989f..552a5f7 100644
> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -72,6 +72,7 @@
>  #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
>  #define PTE_BUFFERABLE		(_AT(pteval_t, 1) << 2)		/* AttrIndx[0] */
>  #define PTE_CACHEABLE		(_AT(pteval_t, 1) << 3)		/* AttrIndx[1] */
> +#define PTE_AP2			(_AT(pteval_t, 1) << 7)		/* AP[2] */

PTE_RDONLY? AP2 is pretty cryptic.

>  #define PTE_EXT_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
>  #define PTE_EXT_AF		(_AT(pteval_t, 1) << 10)	/* Access Flag */
>  #define PTE_EXT_NG		(_AT(pteval_t, 1) << 11)	/* nG */
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 3b10ec6..24ba2d7 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -79,18 +79,19 @@
>  #define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Present */
>  #define L_PTE_FILE		(_AT(pteval_t, 1) << 2)		/* only when !PRESENT */
>  #define L_PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
> -#define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
>  #define L_PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
>  #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 10)	/* AF */
>  #define L_PTE_XN		(_AT(pteval_t, 1) << 54)	/* XN */
>  #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 55)	/* unused */
>  #define L_PTE_SPECIAL		(_AT(pteval_t, 1) << 56)	/* unused */
>  #define L_PTE_NONE		(_AT(pteval_t, 1) << 57)	/* PROT_NONE */
> +#define L_PTE_RDONLY		(_AT(pteval_t, 1) << 58)	/* READ ONLY */

Can you fix those `unused' comments above while you're here, please? Whilst
they are unused by the hardware, they're very much used by Linux. Well,
SPECIAL isn't yet, but it could be...

> -#define PMD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
> -#define PMD_SECT_DIRTY		(_AT(pmdval_t, 1) << 55)
> -#define PMD_SECT_SPLITTING	(_AT(pmdval_t, 1) << 56)
> -#define PMD_SECT_NONE		(_AT(pmdval_t, 1) << 57)
> +#define L_PMD_SECT_VALID	(_AT(pmdval_t, 1) << 0)
> +#define L_PMD_SECT_DIRTY	(_AT(pmdval_t, 1) << 55)
> +#define L_PMD_SECT_SPLITTING	(_AT(pmdval_t, 1) << 56)
> +#define L_PMD_SECT_NONE		(_AT(pmdval_t, 1) << 57)
> +#define L_PMD_SECT_RDONLY	(_AT(pteval_t, 1) << 58)

Boo-hoo, that's our last remaining software bit for LPAE. It's a sad day.

>  /*
>   * To be used in assembly code with the upper page attributes.
> @@ -214,24 +215,25 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  #define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
>  
>  #define __HAVE_ARCH_PMD_WRITE
> -#define pmd_write(pmd)		(pmd_isclear((pmd), PMD_SECT_RDONLY))
> +#define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
> +#define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
>  
>  #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
>  #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define pmd_trans_huge(pmd)	(pmd_val(pmd) && pmd_isclear((pmd), PMD_TABLE_BIT))
> -#define pmd_trans_splitting(pmd) (pmd_isset((pmd), PMD_SECT_SPLITTING))
> +#define pmd_trans_splitting(pmd) (pmd_isset((pmd),  L_PMD_SECT_SPLITTING))

I take it we only call this on something we've decided is huge already (as
opposed to, e.g. a swap entry)?

>  #endif
>  
>  #define PMD_BIT_FUNC(fn,op) \
>  static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
>  
> -PMD_BIT_FUNC(wrprotect,	|= PMD_SECT_RDONLY);
> +PMD_BIT_FUNC(wrprotect,	|= L_PMD_SECT_RDONLY);
>  PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
> -PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
> -PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
> -PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
> +PMD_BIT_FUNC(mksplitting, |= L_PMD_SECT_SPLITTING);
> +PMD_BIT_FUNC(mkwrite,   &= ~L_PMD_SECT_RDONLY);
> +PMD_BIT_FUNC(mkdirty,   |= L_PMD_SECT_DIRTY);
>  PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
>  
>  #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
> @@ -245,8 +247,8 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
>  
>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  {
> -	const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_RDONLY |
> -				PMD_SECT_VALID | PMD_SECT_NONE;
> +	const pmdval_t mask = PMD_SECT_USER | PMD_SECT_XN | L_PMD_SECT_RDONLY |
> +				L_PMD_SECT_VALID | L_PMD_SECT_NONE;
>  	pmd_val(pmd) = (pmd_val(pmd) & ~mask) | (pgprot_val(newprot) & mask);
>  	return pmd;
>  }
> @@ -257,8 +259,13 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  	BUG_ON(addr >= TASK_SIZE);
>  
>  	/* create a faulting entry if PROT_NONE protected */
> -	if (pmd_val(pmd) & PMD_SECT_NONE)
> -		pmd_val(pmd) &= ~PMD_SECT_VALID;
> +	if (pmd_val(pmd) & L_PMD_SECT_NONE)
> +		pmd_val(pmd) &= ~L_PMD_SECT_VALID;
> +
> +	if (pmd_write(pmd) && pmd_dirty(pmd))
> +		pmd_val(pmd) &= ~PMD_SECT_RDONLY;

pmd_mkwrite?

> +	else
> +		pmd_val(pmd) |= PMD_SECT_RDONLY;

pmd_wrprotect?

>  
>  	*pmdp = __pmd(pmd_val(pmd) | PMD_SECT_nG);
>  	flush_pmd_entry(pmdp);
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> index 22e3ad6..eb81123 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -86,8 +86,13 @@ ENTRY(cpu_v7_set_pte_ext)
>  	tst	rh, #1 << (57 - 32)		@ L_PTE_NONE
>  	bicne	rl, #L_PTE_VALID
>  	bne	1f
> -	tst	rh, #1 << (55 - 32)		@ L_PTE_DIRTY
> -	orreq	rl, #L_PTE_RDONLY
> +
> +	eor	ip, rh, #1 << (55 - 32)	@ toggle L_PTE_DIRTY in temp reg to
> +					@ test for !L_PTE_DIRTY || L_PTE_RDONLY

Since you already set RDONLY for pmds based on dirty, can we do the same for
ptes and avoid this check here...?

> +	tst	ip, #1 << (55 - 32) | 1 << (58 - 32)
> +	orrne	rl, #PTE_AP2
> +	biceq	rl, #PTE_AP2

... Then use Russell's ubfx trick to copy L_PTE_RDONLY into PTE_RDONLY?

Will
