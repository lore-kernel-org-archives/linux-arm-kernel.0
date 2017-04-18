From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Apr 2017 19:21:26 +0100
Subject: [PATCH 4/5] Hot-remove implementation for arm64
In-Reply-To: <20170414140158.GA17950@samekh>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
 <897973dd5d3fc91c70aba4b44350099a61c3a12c.1491920513.git.ar@linux.vnet.ibm.com>
 <20170411171210.GD32267@leverpostej>
 <20170414140158.GA17950@samekh>
Message-ID: <20170418182125.GL17866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 03:01:58PM +0100, Andrea Reale wrote:
> I guess it is likely that I might have made assumptions that are true
> for x86_64 but do not hold for arm64. Whenever you feel this is the
> case, I would be really grateful if you could help identify them.

Sure thing.

> On Tue, Apr 11, 2017 at 06:12:11PM +0100, Mark Rutland wrote:
> > On Tue, Apr 11, 2017 at 03:55:42PM +0100, Andrea Reale wrote:

> > > +static void  free_pagetable(struct page *page, int order, bool direct)
> > 
> > This "direct" parameter needs a better name, and a description in a
> > comment block above this function.
>  
> The name direct is inherited directly from the x86_64 hot remove code.
> It serves to distinguish if we are removing either a pagetable page that
> is mapping to the direct mapping space (I think it is called also linear
> mapping area somewhere else) or a pagetable page or a data page 
> from vmemmap.

FWIW, I've largely heard the folk call that the "linear mapping", and
x86 folk call that the "direct mapping". The two are interchangeable.

> In this specific set of functions, the flag is needed because the various
> alloc_init_p*d used for allocating entries for direct memory mapping
> rely on pgd_pgtable_alloc, which in its turn calls  pgtable_page_ctor;
> hence, we need to call the dtor. 

AFAICT, that's not true for the arm64 linear map, since that's created
with our early_pgtable_alloc(), which doesn't call pgtable_page_ctor().

Judging by commit:

  1378dc3d4ba07ccd ("arm64: mm: run pgtable_page_ctor() on non-swapper
                     translation table pages")

... we only do this for non-swapper page tables.

> On the contrary, vmemmap entries are created using vmemmap_alloc_block
> (from within vmemmap_populate), which does not call pgtable_page_ctor
> when allocating pages.
> 
> I am not sure I understand why the pgtable_page_ctor is not called when
> allocating vmemmap page tables, but that's the current situation.

>From a quick scan, I see that it's necessary to use pgtable_page_ctor()
for pages that will be used for userspace page tables, but it's not
clear to me if it's ever necessary for pages used for kernel page
tables.

If it is, we appear to have a bug on arm64.

Laura, Ard, thoughts?

> > > +{
> > > +	unsigned long magic;
> > > +	unsigned int nr_pages = 1 << order;
> > > +	struct vmem_altmap *altmap = to_vmem_altmap((unsigned long) page);
> > > +
> > > +	if (altmap) {
> > > +		vmem_altmap_free(altmap, nr_pages);
> > > +		return;
> > > +	}
> > > +
> > > +	/* bootmem page has reserved flag */
> > > +	if (PageReserved(page)) {
> > > +		__ClearPageReserved(page);
> > > +
> > > +		magic = (unsigned long)page->lru.next;
> > > +		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
> > > +			while (nr_pages--)
> > > +				put_page_bootmem(page++);
> > > +		} else {
> > > +			while (nr_pages--)
> > > +				free_reserved_page(page++);
> > > +		}
> > > +	} else {
> > > +		/*
> > > +		 * Only direct pagetable allocation (those allocated via
> > > +		 * hotplug) call the pgtable_page_ctor; vmemmap pgtable
> > > +		 * allocations don't.
> > > +		 */
> > > +		if (direct)
> > > +			pgtable_page_dtor(page);
> > > +
> > > +		free_pages((unsigned long)page_address(page), order);
> > > +	}
> > > +}
> > 
> > This largely looks like a copy of the x86 code. Why can that not be
> > factored out to an arch-neutral location?
> 
> Yes it probably can - the only difference being calling
> pgtable_page_dtor when it needs to - but I am not confident enough to
> say that it would really be architecture neutral or just specific to
> only arm64 and x86.  For example, I don't see this used anywhere else
> for hot-removing memory.

Mhmmm. As above, it's also not clear to me if the ctor()/dtor() dance is
necessary in the first place.

I'm also not clear on why x86_64 and powerpc are the only architectures
that appear to clear up their page tables after __remove_pages(). Do
other architectures not have "real" hot-remove?

> (Actually, also a large part of remove_*_table and free_*_table could
> probably be factored, but I wouldn't be sure how to deal with the
> differences in the pgtable.h macros used throughout)

Let's figure out what's necessary first. Then we'll know if/how we can
align on a common pattern.

[...]

>> > +	page = pmd_page(*pmd);
> > > +
> > > +	free_pagetable(page, 0, direct);
> > 
> > The page has been freed here, and may be subject to arbitrary
> > modification...
> > 
> > > +
> > > +	/*
> > > +	 * This spin lock could be only taken in _pte_aloc_kernel
> > > +	 * in mm/memory.c and nowhere else (for arm64). Not sure if
> > > +	 * the function above can be called concurrently. In doubt,
> > > +	 * I am living it here for now, but it probably can be removed
> > > +	 */
> > > +	spin_lock(&init_mm.page_table_lock);
> > > +	pmd_clear(pmd);
> > 
> > ... but we only remove it from the page tables here, so the page table
> > walkers can see junk in the tables, were the page reused in the mean
> > timer.
> > 
> > After clearing the PMD, it needs to be cleared from TLBs. We allow
> > partial walks to be cached, so the TLBs may still start walking this
> > entry or beyond.
> 
> I guess that the safe approach would be something along the lines:
> 1. clear the page table 
> 2. flush the tlbs
> 3. free the page

Yes. That's the sequence we follow elsewhere.

> When I am flushing intermediate p*d entries, would it be
> more appropriate to use something like __flush_tlb_pgtable() to clear
> cached partial walks rather than flushing the whole table? I mean,
> hot-remove is not going to be a frequent operation anyway, so I don't
> think that flushing the whole tlb would be a great deal of harm
> anyway.

Using __flush_tlb_pgtable() sounds sane to me. That's what we do when
tearing down user mappings.

> My question at this point would be: how come that the code structure above
> works for x86_64 hot-remove?

I don't know enough about x86 to say.

> My assumption, when I was writing this, was
> that there would be no problem since this code is called when we are sure
> that all the memory mapped by these entries has been already offlined,
> so nobody should be using those VAs anyway (also considering that there
> cannot be any two mem hot-plug/remove actions running concurrently).
> Is that correct?

The problem is that speculation, Out-of-Order execution, HW prefetching,
and other such things *can* result in those VAs being accessed,
regardless of what code explicitly does in a sequential execution.

If any table relevant to one of those VAs has been freed (and
potentially modified by the allocator, or in another thread), it's
possible that the CPU performs a page table walk and sees junk as a
valid page table entry. As a result, a number of bad things can happen.

If the entry was a pgd, pud, or pmd, the CPU may try to continue to walk
to the relevant pte, accessing a junk address. That could change the
state of MMIO, trigger an SError, etc, or allocate more junk into the
TLBs.

For any level, the CPU might allocate the entry into a TLB, regardless
of whether an existing entry existed. The new entry can conflict with
the existing one, either leading to a TLB conflict abort, or to the TLB
returning junk for that address. Speculation and so on can now access
junk based on that, etc.

[...]

> > > +static void remove_pte_table(pte_t *pte, unsigned long addr,
> > > +	unsigned long end, bool direct)
> > > +{
> > > +	unsigned long next;
> > > +	void *page_addr;
> > > +
> > > +	for (; addr < end; addr = next, pte++) {
> > > +		next = (addr + PAGE_SIZE) & PAGE_MASK;
> > > +		if (next > end)
> > > +			next = end;
> > 
> > Please use the usual p*d_addr_end() functions. See alloc_init_pmd() and
> > friends in arch/arm64/mm/mmu.c for examples of how to use them.
> 
> we used the p*d_addr_end family of functions when dealing with p*d(s). I
> cannot identify an equivalent for pte entries.

Ah; my bad.

I guess we should follow the same pattern as alloc_init_pte() does here,
assuming we use p*d_addr_end() for all the levels above (as for
alloc_init_p*d()).

> Would you recommend adding a pte_addr_end macro in pgtable.h?

That shouldn't be necessary. Sorry for the confusion.

> > > +
> > > +		if (!pte_present(*pte))
> > > +			continue;
> > > +
> > > +		if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
> > 
> > When would those addresses *not* be page-aligned? By construction, next
> > must be. Unplugging partial pages of memory makes no sense, so surely
> > addr is page-aligned when passed in?
> 
> The issue here is that this function is called in one of two cases:
> 1. to clear pagetables of directly mapped (linear) memory 
> 2. Pagetables (and corresponding data pages) for vmemmap. 
> 
> It is my understanding that, in the second case, we might be clearing
> only part of the page content (i.e, only a few struct pages). Note that
> next is page aligned by construction only if next <= end.

Ok. A comment to that effect immediately above this check would be
helpful.

> > > +			/*
> > > +			 * Do not free direct mapping pages since they were
> > > +			 * freed when offlining, or simplely not in use.
> > > +			 */
> > > +			if (!direct)
> > > +				free_pagetable(pte_page(*pte), 0, direct);
> > > +
> > > +			/*
> > > +			 * This spin lock could be only
> > > +			 * taken in _pte_aloc_kernel in
> > > +			 * mm/memory.c and nowhere else
> > > +			 * (for arm64). Not sure if the
> > > +			 * function above can be called
> > > +			 * concurrently. In doubt,
> > > +			 * I am living it here for now,
> > > +			 * but it probably can be removed.
> > > +			 */
> > > +			spin_lock(&init_mm.page_table_lock);
> > > +			pte_clear(&init_mm, addr, pte);
> > > +			spin_unlock(&init_mm.page_table_lock);
> > > +		} else {
> > > +			/*
> > > +			 * If we are here, we are freeing vmemmap pages since
> > > +			 * direct mapped memory ranges to be freed are aligned.
> > > +			 *
> > > +			 * If we are not removing the whole page, it means
> > > +			 * other page structs in this page are being used and
> > > +			 * we canot remove them. So fill the unused page_structs
> > > +			 * with 0xFD, and remove the page when it is wholly
> > > +			 * filled with 0xFD.
> > > +			 */
> > > +			memset((void *)addr, PAGE_INUSE, next - addr);
> > 
> > What's special about 0xFD?
> 
> Just used it as a constant symmetrically to x86_64 code.
> 
> > Why do we need to mess with the page array in this manner? Why can't we
> > detect when a range is free by querying memblock, for example?
> 
> I am not sure I get your suggestion. I guess that the logic here
> is that I cannot be sure that I can free the full page because other
> entries might be in use for active vmemmap mappings. So we just "mark"
> the unused once and only free the page when all of it is marked. See
> again commit ae9aae9eda2db71, where all this comes from.

I understood that this is deferring freeing until a whole page of struct
pages has been freed.

My concern is that filling the unused memory with an array of junk chars
feels like a hack. We don't do this at the edges when we allocate
memblock today, AFAICT, so this doesn't seem complete.

Is there no "real" datastructure we can use to keep track of what memory
is present? e.g. memblock?

[...]

> > > +static void remove_pmd_table(pmd_t *pmd, unsigned long addr,
> > > +	unsigned long end, bool direct)
> > > +{
> > > +	unsigned long next;
> > > +	void *page_addr;
> > > +	pte_t *pte;
> > > +
> > > +	for (; addr < end; addr = next, pmd++) {
> > > +		next = pmd_addr_end(addr, end);
> > > +
> > > +		if (!pmd_present(*pmd))
> > > +			continue;
> > > +
> > > +		// check if we are using 2MB section mappings
> > > +		if (pmd_sect(*pmd)) {
> > > +			if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
> > 
> > Surely you're intending to check if you can free the whole pmd? i.e.
> > that addr and next are pmd-aligned?
> 
> Indeed, that's a mistake. It should have been IS_ALIGNED(addr, PMD_SIZE).

Ok.

> > Can we ever be in a situation where we're requested to free a partial
> > pmd that could be section mapped?
> 
> Yes, as I said above, for vmemmap mappings.

Ok.

> > If that's the case, we'll *need* to split the pmd, which we can't do on
> > live page tables.
> 
> Please, see below.
> 
> > > +				if (!direct) {
> > > +					free_pagetable(pmd_page(*pmd),
> > > +						get_order(PMD_SIZE), direct);
> > > +				}
> > > +				/*
> > > +				 * This spin lock could be only
> > > +				 * taken in _pte_aloc_kernel in
> > > +				 * mm/memory.c and nowhere else
> > > +				 * (for arm64). Not sure if the
> > > +				 * function above can be called
> > > +				 * concurrently. In doubt,
> > > +				 * I am living it here for now,
> > > +				 * but it probably can be removed.
> > > +				 */
> > > +				spin_lock(&init_mm.page_table_lock);
> > > +				pmd_clear(pmd);
> > > +				spin_unlock(&init_mm.page_table_lock);
> > > +			} else {
> > > +				/* If here, we are freeing vmemmap pages. */
> > > +				memset((void *)addr, PAGE_INUSE, next - addr);
> > > +
> > > +				page_addr = page_address(pmd_page(*pmd));
> > > +				if (!memchr_inv(page_addr, PAGE_INUSE,
> > > +						PMD_SIZE)) {
> > > +					free_pagetable(pmd_page(*pmd),
> > > +						get_order(PMD_SIZE), direct);
> > > +
> > > +					/*
> > > +					 * This spin lock could be only
> > > +					 * taken in _pte_aloc_kernel in
> > > +					 * mm/memory.c and nowhere else
> > > +					 * (for arm64). Not sure if the
> > > +					 * function above can be called
> > > +					 * concurrently. In doubt,
> > > +					 * I am living it here for now,
> > > +					 * but it probably can be removed.
> > > +					 */
> > > +					spin_lock(&init_mm.page_table_lock);
> > > +					pmd_clear(pmd);
> > > +					spin_unlock(&init_mm.page_table_lock);
> > > +				}
> > 
> > I don't think this is correct.
> > 
> > If we're getting rid of a partial pmd, we *must* split the pmd.
> > Otherwise, we're leaving bits mapped that should not be. If we split the
> > pmd, we can free the individual pages as we would for a non-section
> > mapping.
> > 
> > As above, we can't split block entries within live tables, so that will
> > be painful at best.
> > 
> > If we can't split a pmd, hen we cannot free a partial pmd, and will need
> > to reject request to do so.
> > 
> > The same comments (with s/pmu/pud/, etc) apply for the higher level
> > remove_p*d_table functions.
> > 
> > [...]
> 
> This only happens when we are clearing vmemmap memory. 

Is that definitely the case?

Currently, I can't see what prevents adding 2M of memory, and then
removing the first 4K of that. We'll use a 2M section for the linear map
of that, but won't unmap the 4K when removing.

Likewise for the next level up, with s/2M/1G/ and s/4K/2M/.

> My understanding
> is that the whole hack of marking the content of partially unused areas
> with the 0xFD constant is exactly to avoid splitting the PMD, but instead
> to only clear the full area when we realize that there's no valid struct
> page in it anymore. When would this kind of use be source of problems?

I understand what's going on for the vmemmap. So long as we don't use
hotpluggable memory to back the vmemmap, that's fine.

As above, my concern is whether splitting a section can ever occur for
the linear map.

Thanks,
Mark.
