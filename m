From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Apr 2015 14:41:53 +0100
Subject: [PATCH v3 07/11] arm64: fixmap: allow init before linear mapping
 is set up
In-Reply-To: <CAKv+Gu_sQnVMEFs5ubT=VK=LsptJkvVuUnhZMBJY81TmuU+iAg@mail.gmail.com>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428674035-26603-8-git-send-email-ard.biesheuvel@linaro.org>
 <20150414104711.GC28709@leverpostej>
 <CAKv+Gu_sQnVMEFs5ubT=VK=LsptJkvVuUnhZMBJY81TmuU+iAg@mail.gmail.com>
Message-ID: <20150414134153.GF28709@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 12:02:13PM +0100, Ard Biesheuvel wrote:
> On 14 April 2015 at 12:47, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Ard,
> >
> > On Fri, Apr 10, 2015 at 02:53:51PM +0100, Ard Biesheuvel wrote:
> >> This reworks early_ioremap_init() so it populates the various levels
> >> of translation tables while taking the following into account:
> >> - be prepared for any of the levels to have been populated already, as
> >>   this may be the case once we move the kernel text mapping out of the
> >>   linear mapping;
> >> - don't rely on __va() to translate the physical address in a page table
> >>   entry to a virtual address, since this produces linear mapping addresses;
> >>   instead, use the fact that at any level, we know exactly which page in
> >>   swapper_pg_dir an entry could be pointing to if it points anywhere.
> >
> > Can we not use Catalin's PHYS_OFFSET swizzling trick instead? i.e.
> >
> >  * Set PHYS_OFFSET so __va hits in the text mapping.
> >
> >  * Create the fixmap entries.
> >
> >  * Parse the DTB or UEFI memory map, figure out the real PHYS_OFFSET.
> >
> >  * Create linear mapping for the initial tables.
> >
> >  * Swap PHYS_OFFSET for the real version, and update init_mm->pgd to
> >    point at the linear map alias of the swapper pgd.
> >
> > It seemed like that would require less open-coding of table manipulation
> > code, as we could use __va() early.
> >
> > Is there a limitation with that approach that I'm missing?
> >
> 
> I didn't quite catch Catalin's suggestion to mean the above, but the
> way you put it seems viable to me. I'll have a go and see how far I
> get with it.

We discussed it (and wrote it up) on the plane back from the FW summit,
and it may have made more sense in person than it did on the list; I've
only skimmed Catalin's responses. ;)

> >> +#if CONFIG_ARM64_PGTABLE_LEVELS > 3
> >> +     pud_t   pud[PTRS_PER_PUD];
> >> +#endif
> >> +#if CONFIG_ARM64_PGTABLE_LEVELS > 2
> >> +     pmd_t   pmd[PTRS_PER_PMD];
> >> +#endif
> >> +     pte_t   pte[PTRS_PER_PTE];
> >> +};
> >> +
> >> +static void __init bootstrap_mem_region(unsigned long addr,
> >> +                                     struct mem_bootstrap_region *reg,
> >> +                                     pmd_t **ppmd, pte_t **ppte)
> >> +{
> >> +     /*
> >> +      * Avoid using the linear phys-to-virt translation __va() so that we
> >> +      * can use this code before the linear mapping is set up. Note that
> >> +      * any populated entries at any level can only point into swapper_pg_dir
> >> +      * since no other translation table pages have been allocated yet.
> >> +      * So at each level, we either need to populate it, or it has already
> >> +      * been populated by a swapper_pg_dir table at the same level, in which
> >> +      * case we can figure out its virtual address without applying __va()
> >> +      * on the contents of the entry, using the following struct.
> >> +      */
> >> +     extern struct mem_bootstrap_region __swapper_bs_region;
> >> +
> >> +     pgd_t *pgd = pgd_offset_k(addr);
> >> +     pud_t *pud = (pud_t *)pgd;
> >> +     pmd_t *pmd = (pmd_t *)pud;
> >> +
> >> +#if CONFIG_ARM64_PGTABLE_LEVELS > 3
> >> +     if (pgd_none(*pgd)) {
> >> +             clear_page(reg->pud);
> >> +             pgd_populate(&init_mm, pgd, reg->pud);
> >
> > What's PHYS_OFFSET expected to be at this point (for the purposes of
> > __pa() in the *_populate*() macros)?
> >
> > If we're relying on __pa() to convert text->phys, won't __va() convert
> > phys->text at this point?
> >
> 
> At this points, yes. But later on, when the kernel text moves out of
> the linear region, __pa() takes into account whether the input VA is
> above or below PAGE_OFFSET, and adds the kernel image offset in the
> latter case.

Ah, I see.

> Changing __va() so it implements the inverse would be a can of worms
> i'd rather keep closed.

I completely agree.

> >> +             pud = reg->pud;
> >> +     } else {
> >> +             pud = __swapper_bs_region.pud;
> >> +     }
> >> +     pud += pud_index(addr);
> >> +#endif
> >
> > Can we free the unused reg tables in the else cases? If __pa() works we
> > should be able to hand them to memblock, no?
> >
> 
> Only if we put the memblock_reserve() of the kernel image before
> early_fixmap_init(), otherwise we are freeing only to reserve it again
> later.

Damn. That gets really painful with the memory limit (which does a
memblock_remove), early_param, and so on. There's horrible ordering
dependencies between those.

We could get around that with an early page allocator. Have each user
(just fixmap and linear map init?) place an upper bound on the pages
they need into .pgtbl.pool, have them allocate from there as needed, and
immediately after the memblock_reserve of the kernel, unreserve (remove
+ add) any remaining pages.

Mark.
