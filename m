From: jays.lee@samsung.com (Jungseok Lee)
Date: Tue, 29 Apr 2014 13:12:27 +0900
Subject: [PATCH v3 6/7] arm64: mm: Implement 4 levels of translation tables
In-Reply-To: <20140428132338.GA26829@linaro.org>
References: <000701cf5adc$1aa35350$4fe9f9f0$@samsung.com>
 <20140423160149.GA2895@linaro.org>
 <000f01cf61ca$099017c0$1cb04740$@samsung.com>
 <20140428132338.GA26829@linaro.org>
Message-ID: <00e401cf6361$3dc9b300$b95d1900$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 28, 2014 10:24 PM, Steve Capper wrote:
> On Sun, Apr 27, 2014 at 12:37:35PM +0900, Jungseok Lee wrote:
> > On Thursday, April 24, 2014 1:02 AM, Steve Capper wrote:
> > > On Fri, Apr 18, 2014 at 04:59:20PM +0900, Jungseok Lee wrote:
> 
> [ ... ]
> 
> > >
> > > This is overly complicated. For <4 levels we set x0 to be:
> > > ttbr1 + 2*PAGE_SIZE. For 4-levels, we set x0 to be ttbr1 +
> > > PAGE_SIZE, then inside the create_pgd_entry macro, we check the VA
> > > for FIXADDR_TOP then add another PAGE_SIZE. This is presumably done so the same PUD is used for
> the swapper block map and the FIXADDR map.
> >
> > Is it too complicated to understand the logic?
> >
> > 1) For <4 levels:
> > PAGE_SIZE is added for FIXADDR map and x0 is passed to create pgd entry.
> > 2) For =4 levels:
> > PAGE_SIZE is added in the create_pgd_entry macro since FIXADDR map
> > info is needed to create pud entry.
> >
> > However, I agree that the code should be revised if other people feel
> > like it is a labyrinthine logic.
> >
> > > If you assume that the PUD always follows the PGD for 4-levels, then
> > > you can remove this #ifdef and the conditional VA logic in
> > > set_pgd_entry. To make the logic simpler for <4 levels, you could call create_pud_entry in the
> middle of create_pgd_entry, then put down the actual pgd after.
> >
> > create_pud_entry should distinguish block map from FIXADDR map
> > although PUD always follows the PGD in case of 4 levels. If we would
> > like to avoid unnecessary #ifdef, the conditional logic should be
> > introduced in create_ pgd_entry macro.
> >
> > I cannot find the "best" way even though I've tried to figure it out.
> > I would like to find out the most clear and self-descriptive expression.
> >
> > Could you give an idea on how to remove both conditional VA logic and #ifdef?
> 
> 
> Hello Jungseok,
> I had the following logic in my head:
> It compiles and runs on the model, but I've not tried it in anger.

Hello Steve,
It works well as both host and guest on the model.

> =========================================================================
> 
> 	.macro create_pud_entry, pgd, tbl, virt, pud, tmp1, tmp2 #ifdef CONFIG_ARM64_4_LEVELS
> 	add	\tbl, \tbl, #PAGE_SIZE		// bump tbl 1 page up.
> 						// to make room for pud
> 	add	\pud, \pgd, #PAGE_SIZE		// pgd points to pud which
> 						// follows pgd
> 	lsr	\tmp1, \virt, #PUD_SHIFT
> 	and	\tmp1, \tmp1, #PTRS_PER_PUD - 1	// PUD index
> 	orr	\tmp2, \tbl, #3			// PUD entry table type
> 	str	\tmp2, [\pud, \tmp1, lsl #3]
> #else
> 	mov	\pud, \tbl			// pgd points to section table
> 						// directly for < 4 levels
> #endif
> 	.endm
> 
> /*
>  * Macro to populate the PGD for the corresponding block entry in the next
>  * level (tbl) for the given virtual address.
>  *
>  * Preserves:	pgd, virt
>  * Corrupts:	tmp1, tmp2, tmp3
>  * Returns:	tbl -> page where block mappings can be placed
>  *	(changed to make room for pud with 4levels, preserved otherwise)
>  */
> 	.macro	create_pgd_entry, pgd, tbl, virt, tmp1, tmp2, tmp3
> 	create_pud_entry \pgd, \tbl, \virt, \tmp3, \tmp1, \tmp2
> 	lsr	\tmp1, \virt, #PGDIR_SHIFT
> 	and	\tmp1, \tmp1, #PTRS_PER_PGD - 1	// PGD index
> 	orr	\tmp2, \tmp3, #3		// PGD entry table type
> 	str	\tmp2, [\pgd, \tmp1, lsl #3]
> 	.endm
> 
> =========================================================================
> 
> [Note I've changed the extra argument to create_pgd_entry to be at the end to make it easier to diff
> callers]
> 
> So essentially, we bump up tbl if we are running with 4 levels of page table. We put the pgd down
> after the pud, and this allows us to sneak a pud in after the pgd if we need to, otherwise it points
> to the target for the section mapping.
> 
> Does this work for you? (I go cross-eyed with too much assembler, so could have easily missed
> something).

It is a better description compared to my logic.
I fully understand your intention now.
It would be good to adopt your code instead of mine.

How about participating as an author of this part if you are okay?

I am posting v4 patches as soon as possible and then
figuring out a way to take you as an author of this head.S.

> >
> > > > +	create_pgd_entry x26, x0, x1, x5, x6, x7
> > > >
> > >
> > > So before this patch we have the following created by
> > > __create_page_tables:
> > >
> > > +========================+ <--- TEXT_OFFSET + PHYS_OFFSET
> > > | FIXADDR (pmd or pte)   |
> > > +------------------------+
> > > | block map (pmd or pte) |
> > > +------------------------+
> > > | PGDs for swapper       |
> > > +========================+ <--- TTBR1 swapper_pg_dir
> > > | block map for idmap    |
> > > +------------------------+
> > > | PGDs for idmap         |
> > > +------------------------+ <--- TTBR0 idmap_pg_dir
> > >
> > >
> > > After the patch, for 4 levels activated we have:
> > > +========================+ <--- TEXT_OFFSET + PHYS_OFFSET
> > > | FIXADDR (ptes)         |
> > > +------------------------+
> > > | block map (ptes)       |
> > > +------------------------+
> > > | PUDs for swapper       |
> > > +------------------------+
> > > | PGDs for swapper       |
> > > +========================+ <--- TTBR1 swapper_pg_dir
> > > | block map for idmap    |
> > > +------------------------+
> > > | PUDs for idmap         |
> > > +------------------------+
> > > | PGDs for idmap         |
> > > +------------------------+ <--- TTBR0 idmap_pg_dir
> > >
> > > and without 4 levels activated we have:
> > > +========================+ <--- TEXT_OFFSET + PHYS_OFFSET
> > > | ZERO BYTES             |
> > > +------------------------+
> > > | FIXADDR (pmd or pte)   |
> > > +------------------------+
> > > | block map (pmd or pte) |
> > > +------------------------+
> > > | PGDs for swapper       |
> > > +========================+ <--- TTBR1 swapper_pg_dir
> > > | ZERO BYTES             |
> > > +------------------------+
> > > | block map for idmap    |
> > > +------------------------+
> > > | PGDs for idmap         |
> > > +------------------------+ <--- TTBR0 idmap_pg_dir
> >
> > This is definitely helpful to understand head.S.
> > It would be good to add these figures to Documentation or comments.
> 
> Please feel free to grab it if you want... :-).
> Otherwise, I can put a patch in for this, as I am working on some logic to remap the physical memory a
> PUD blocks for 4K granule.

It is better to write a patch by you, not me.
Then, I will review it.

Best Regards
Jungseok Lee
