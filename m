From: jays.lee@samsung.com (Jungseok Lee)
Date: Sun, 27 Apr 2014 12:37:35 +0900
Subject: [PATCH v3 6/7] arm64: mm: Implement 4 levels of translation tables
In-Reply-To: <20140423160149.GA2895@linaro.org>
References: <000701cf5adc$1aa35350$4fe9f9f0$@samsung.com>
 <20140423160149.GA2895@linaro.org>
Message-ID: <000f01cf61ca$099017c0$1cb04740$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 24, 2014 1:02 AM, Steve Capper wrote:
> On Fri, Apr 18, 2014 at 04:59:20PM +0900, Jungseok Lee wrote:

[ ... ]

> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S index
> > 0fd5650..f313a7a 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -37,8 +37,8 @@
> >
> >  /*
> >   * swapper_pg_dir is the virtual address of the initial page table.
> > We place
> > - * the page tables 3 * PAGE_SIZE below KERNEL_RAM_VADDR. The
> > idmap_pg_dir has
> > - * 2 pages and is placed below swapper_pg_dir.
> > + * the page tables 4 * PAGE_SIZE below KERNEL_RAM_VADDR. The
> > + idmap_pg_dir has
> > + * 3 pages and is placed below swapper_pg_dir.
> >   */
> >  #define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
> >
> > @@ -46,8 +46,8 @@
> >  #error KERNEL_RAM_VADDR must start at 0xXXX80000  #endif
> >
> > -#define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
> > -#define IDMAP_DIR_SIZE		(2 * PAGE_SIZE)
> > +#define SWAPPER_DIR_SIZE	(4 * PAGE_SIZE)
> > +#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
> >
> >  	.globl	swapper_pg_dir
> >  	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - SWAPPER_DIR_SIZE
> > @@ -371,16 +371,29 @@ ENDPROC(__calc_phys_offset)
> >
> >  /*
> >   * Macro to populate the PGD for the corresponding block entry in the
> > next
> > - * level (tbl) for the given virtual address.
> > + * levels (tbl1 and tbl2) for the given virtual address.
> >   *
> > - * Preserves:	pgd, tbl, virt
> > + * Preserves:	pgd, tbl1, tbl2, virt
> 
> tbl1 and tbl2 are *not* preserved for 4 level. tbl1 is bumped up one page to make space for the pud,
> then fed into create_block_mapping later.
> 
> >   * Corrupts:	tmp1, tmp2
> >   */
> > -	.macro	create_pgd_entry, pgd, tbl, virt, tmp1, tmp2
> > +	.macro	create_pgd_entry, pgd, tbl1, tbl2, virt, tmp1, tmp2
> >  	lsr	\tmp1, \virt, #PGDIR_SHIFT
> >  	and	\tmp1, \tmp1, #PTRS_PER_PGD - 1	// PGD index
> > -	orr	\tmp2, \tbl, #3			// PGD entry table type
> > +	orr	\tmp2, \tbl1, #3		// PGD entry table type
> >  	str	\tmp2, [\pgd, \tmp1, lsl #3]
> > +#ifdef CONFIG_ARM64_4_LEVELS
> > +	ldr	\tbl2, =FIXADDR_TOP
> > +	cmp	\tbl2, \virt
> 
> Do we need this extra logic? See my other comment below where the fixed mapping is placed down.
> 
> > +	add	\tbl2, \tbl1, #PAGE_SIZE
> > +	b.ne	1f
> > +	add	\tbl2, \tbl2, #PAGE_SIZE
> > +1:
> > +	lsr	\tmp1, \virt, #PUD_SHIFT
> > +	and	\tmp1, \tmp1, #PTRS_PER_PUD - 1	// PUD index
> > +	orr	\tmp2, \tbl2, #3		// PUD entry table type
> > +	str	\tmp2, [\tbl1, \tmp1, lsl #3]
> > +	mov	\tbl1, \tbl2
> > +#endif
> 
> It may be easier to read to have a create_pud_entry macro too?
> 
> >  	.endm
> >
> >  /*
> > @@ -444,7 +457,7 @@ __create_page_tables:
> >  	add	x0, x25, #PAGE_SIZE		// section table address
> >  	ldr	x3, =KERNEL_START
> >  	add	x3, x3, x28			// __pa(KERNEL_START)
> > -	create_pgd_entry x25, x0, x3, x5, x6
> > +	create_pgd_entry x25, x0, x1, x3, x5, x6
> >  	ldr	x6, =KERNEL_END
> >  	mov	x5, x3				// __pa(KERNEL_START)
> >  	add	x6, x6, x28			// __pa(KERNEL_END)
> > @@ -455,7 +468,7 @@ __create_page_tables:
> >  	 */
> >  	add	x0, x26, #PAGE_SIZE		// section table address
> >  	mov	x5, #PAGE_OFFSET
> > -	create_pgd_entry x26, x0, x5, x3, x6
> > +	create_pgd_entry x26, x0, x1, x5, x3, x6
> >  	ldr	x6, =KERNEL_END
> >  	mov	x3, x24				// phys offset
> >  	create_block_map x0, x7, x3, x5, x6
> > @@ -480,8 +493,11 @@ __create_page_tables:
> >  	 * Create the pgd entry for the fixed mappings.
> >  	 */
> >  	ldr	x5, =FIXADDR_TOP		// Fixed mapping virtual address
> > -	add	x0, x26, #2 * PAGE_SIZE		// section table address
> > -	create_pgd_entry x26, x0, x5, x6, x7
> > +	add	x0, x26, #PAGE_SIZE
> > +#ifndef CONFIG_ARM64_4_LEVELS
> > +	add	x0, x0, #PAGE_SIZE
> > +#endif
> 
> This is overly complicated. For <4 levels we set x0 to be:
> ttbr1 + 2*PAGE_SIZE. For 4-levels, we set x0 to be ttbr1 + PAGE_SIZE, then inside the create_pgd_entry
> macro, we check the VA for FIXADDR_TOP then add another PAGE_SIZE. This is presumably done so the same
> PUD is used for the swapper block map and the FIXADDR map.

Is it too complicated to understand the logic?

1) For <4 levels:
PAGE_SIZE is added for FIXADDR map and x0 is passed to create pgd entry.
2) For =4 levels:
PAGE_SIZE is added in the create_pgd_entry macro since FIXADDR map info
is needed to create pud entry.

However, I agree that the code should be revised if other people feel
like it is a labyrinthine logic.

> If you assume that the PUD always follows the PGD for 4-levels, then you can remove this #ifdef and
> the conditional VA logic in set_pgd_entry. To make the logic simpler for <4 levels, you could call
> create_pud_entry in the middle of create_pgd_entry, then put down the actual pgd after.

create_pud_entry should distinguish block map from FIXADDR map although
PUD always follows the PGD in case of 4 levels. If we would like to avoid
unnecessary #ifdef, the conditional logic should be introduced in create_
pgd_entry macro.

I cannot find the "best" way even though I've tried to figure it out.
I would like to find out the most clear and self-descriptive expression.

Could you give an idea on how to remove both conditional VA logic and #ifdef?

> > +	create_pgd_entry x26, x0, x1, x5, x6, x7
> >
> 
> So before this patch we have the following created by
> __create_page_tables:
> 
> +========================+ <--- TEXT_OFFSET + PHYS_OFFSET
> | FIXADDR (pmd or pte)   |
> +------------------------+
> | block map (pmd or pte) |
> +------------------------+
> | PGDs for swapper       |
> +========================+ <--- TTBR1 swapper_pg_dir
> | block map for idmap    |
> +------------------------+
> | PGDs for idmap         |
> +------------------------+ <--- TTBR0 idmap_pg_dir
> 
> 
> After the patch, for 4 levels activated we have:
> +========================+ <--- TEXT_OFFSET + PHYS_OFFSET
> | FIXADDR (ptes)         |
> +------------------------+
> | block map (ptes)       |
> +------------------------+
> | PUDs for swapper       |
> +------------------------+
> | PGDs for swapper       |
> +========================+ <--- TTBR1 swapper_pg_dir
> | block map for idmap    |
> +------------------------+
> | PUDs for idmap         |
> +------------------------+
> | PGDs for idmap         |
> +------------------------+ <--- TTBR0 idmap_pg_dir
> 
> and without 4 levels activated we have:
> +========================+ <--- TEXT_OFFSET + PHYS_OFFSET
> | ZERO BYTES             |
> +------------------------+
> | FIXADDR (pmd or pte)   |
> +------------------------+
> | block map (pmd or pte) |
> +------------------------+
> | PGDs for swapper       |
> +========================+ <--- TTBR1 swapper_pg_dir
> | ZERO BYTES             |
> +------------------------+
> | block map for idmap    |
> +------------------------+
> | PGDs for idmap         |
> +------------------------+ <--- TTBR0 idmap_pg_dir

This is definitely helpful to understand head.S.
It would be good to add these figures to Documentation or comments.

Best Regards
Jungseok Lee
