From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Fri, 14 Apr 2017 15:01:58 +0100
Subject: [PATCH 4/5] Hot-remove implementation for arm64
In-Reply-To: <20170411171210.GD32267@leverpostej>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
 <897973dd5d3fc91c70aba4b44350099a61c3a12c.1491920513.git.ar@linux.vnet.ibm.com>
 <20170411171210.GD32267@leverpostej>
Message-ID: <20170414140158.GA17950@samekh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

thanks for your thorough feedback, it is really appreciated.

I have a few comments and I'd like to ask for further clarification,
if you don't mind, in order to help us work on a new version of the
patch.

Before I go into details, let me point out that, as you have noted
yourself, the structure of the patch is largely derived from the
x86_64 hot-remove code (mostly introduced in commit ae9aae9eda2db7
"memory-hotplug: common APIs to support page tables hot-remove") trying
to account for architectural differences. In this process, I guess it
is likely that I might have made assumptions that are true for x86_64
but do not hold for arm64. Whenever you feel this is the case, I would
be really grateful if you could help identify them.

Please, find detailed replies to your comments in-line.

On Tue, Apr 11, 2017 at 06:12:11PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Tue, Apr 11, 2017 at 03:55:42PM +0100, Andrea Reale wrote:
> > +static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> > +{
> > +	return (unsigned long) __va(pmd_page_paddr(pmd));
> > +}
> > +
> >  /* Find an entry in the third-level page table. */
> >  #define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
> >  
> > @@ -450,6 +455,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
> >  	return pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK;
> >  }
> >  
> > +static inline unsigned long pud_page_vaddr(pud_t pud)
> > +{
> > +	return (unsigned long) __va(pud_page_paddr(pud));
> > +}
> > +
> >  /* Find an entry in the second-level page table. */
> >  #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
> >  
> > @@ -502,6 +512,11 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
> >  	return pgd_val(pgd) & PHYS_MASK & (s32)PAGE_MASK;
> >  }
> >  
> > +static inline unsigned long pgd_page_vaddr(pgd_t pgd)
> > +{
> > +	return (unsigned long) __va(pgd_page_paddr(pgd));
> > +}
> > +
> 
> These duplicate the existing p*d_offset*() functions, and I do not think
> they are necessary. More on that below.

I agree they are redundant. It just seemed cleaner rather than
offsetting 0, but fair enough. 

> [...]
> 
> > @@ -551,7 +551,6 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
> >  	unsigned long nr_pages = size >> PAGE_SHIFT;
> >  	unsigned long end_pfn = start_pfn + nr_pages;
> >  	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
> > -	unsigned long pfn;
> >  	int ret;
> >  
> >  	if (end_pfn > max_sparsemem_pfn) {
> 
> Should this have been part of a prior patch?
> 
> This patch doesn't remove any users of this variable.
> 
> [...]

Indeed, the unused pfn variable is a leftover of patch 3/5. We will
fix that in the next version.

> > +static void  free_pagetable(struct page *page, int order, bool direct)
> 
> This "direct" parameter needs a better name, and a description in a
> comment block above this function.
 
The name direct is inherited directly from the x86_64 hot remove code.
It serves to distinguish if we are removing either a pagetable page that
is mapping to the direct mapping space (I think it is called also linear
mapping area somewhere else) or a pagetable page or a data page 
from vmemmap.

In this specific set of functions, the flag is needed because the various
alloc_init_p*d used for allocating entries for direct memory mapping
rely on pgd_pgtable_alloc, which in its turn calls  pgtable_page_ctor;
hence, we need to call the dtor.  On the contrary, vmemmap entries
are created using vmemmap_alloc_block (from within vmemmap_populate),
which does not call pgtable_page_ctor when allocating pages.

I am not sure I understand why the pgtable_page_ctor is not called when
allocating vmemmap page tables, but that's the current situation.

> > +{
> > +	unsigned long magic;
> > +	unsigned int nr_pages = 1 << order;
> > +	struct vmem_altmap *altmap = to_vmem_altmap((unsigned long) page);
> > +
> > +	if (altmap) {
> > +		vmem_altmap_free(altmap, nr_pages);
> > +		return;
> > +	}
> > +
> > +	/* bootmem page has reserved flag */
> > +	if (PageReserved(page)) {
> > +		__ClearPageReserved(page);
> > +
> > +		magic = (unsigned long)page->lru.next;
> > +		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
> > +			while (nr_pages--)
> > +				put_page_bootmem(page++);
> > +		} else {
> > +			while (nr_pages--)
> > +				free_reserved_page(page++);
> > +		}
> > +	} else {
> > +		/*
> > +		 * Only direct pagetable allocation (those allocated via
> > +		 * hotplug) call the pgtable_page_ctor; vmemmap pgtable
> > +		 * allocations don't.
> > +		 */
> > +		if (direct)
> > +			pgtable_page_dtor(page);
> > +
> > +		free_pages((unsigned long)page_address(page), order);
> > +	}
> > +}
> 
> This largely looks like a copy of the x86 code. Why can that not be
> factored out to an arch-neutral location?

Yes it probably can - the only difference being calling
pgtable_page_dtor when it needs to - but I am not confident enough to
say that it would really be architecture neutral or just specific to
only arm64 and x86.  For example, I don't see this used anywhere else
for hot-removing memory.

(Actually, also a large part of remove_*_table and free_*_table could
probably be factored, but I wouldn't be sure how to deal with the
differences in the pgtable.h macros used throughout)

> > +
> > +static void free_pte_table(pmd_t *pmd, bool direct)
> > +{
> > +	pte_t *pte_start, *pte;
> > +	struct page *page;
> > +	int i;
> > +
> > +	pte_start =  (pte_t *) pmd_page_vaddr(*pmd);
> > +	/* Check if there is no valid entry in the PMD */
> > +	for (i = 0; i < PTRS_PER_PTE; i++) {
> > +		pte = pte_start + i;
> > +		if (!pte_none(*pte))
> > +			return;
> > +	}
> 
> If we must walk the tables in this way, please use the existing pattern
> from arch/arm64/mm/dump.c.
> 
> e.g. 
> 
> 	pte_t *pte;
> 
> 	pte = pte_offset_kernel(pmd, 0UL);
> 	for (i = 0; i < PTRS_PER_PTE; i++, pte++)
> 		if (!pte_none)
> 			return;

Thanks.

> > +
> > +	page = pmd_page(*pmd);
> > +
> > +	free_pagetable(page, 0, direct);
> 
> The page has been freed here, and may be subject to arbitrary
> modification...
> 
> > +
> > +	/*
> > +	 * This spin lock could be only taken in _pte_aloc_kernel
> > +	 * in mm/memory.c and nowhere else (for arm64). Not sure if
> > +	 * the function above can be called concurrently. In doubt,
> > +	 * I am living it here for now, but it probably can be removed
> > +	 */
> > +	spin_lock(&init_mm.page_table_lock);
> > +	pmd_clear(pmd);
> 
> ... but we only remove it from the page tables here, so the page table
> walkers can see junk in the tables, were the page reused in the mean
> timer.
> 
> After clearing the PMD, it needs to be cleared from TLBs. We allow
> partial walks to be cached, so the TLBs may still start walking this
> entry or beyond.

I guess that the safe approach would be something along the lines:
1. clear the page table 
2. flush the tlbs
3. free the page

am I mistaken? When I am flushing intermediate p*d entries, would it be
more appropriate to use something like __flush_tlb_pgtable() to clear
cached partial walks rather than flushing the whole table? I mean,
hot-remove is not going to be a frequent operation anyway, so I don't
think that flushing the whole tlb would be a great deal of harm
anyway.

My question at this point would be: how come that the code structure above
works for x86_64 hot-remove? My assumption, when I was writing this, was
that there would be no problem since this code is called when we are sure
that all the memory mapped by these entries has been already offlined,
so nobody should be using those VAs anyway (also considering that there
cannot be any two mem hot-plug/remove actions running concurrently).
Is that correct?
 
> > +	spin_unlock(&init_mm.page_table_lock);
> > +}
> 
> The same comments apply to all the free_p*d_table() functions, so I
> shan't repeat them.
> 
> [...]
> 
> > +static void remove_pte_table(pte_t *pte, unsigned long addr,
> > +	unsigned long end, bool direct)
> > +{
> > +	unsigned long next;
> > +	void *page_addr;
> > +
> > +	for (; addr < end; addr = next, pte++) {
> > +		next = (addr + PAGE_SIZE) & PAGE_MASK;
> > +		if (next > end)
> > +			next = end;
> 
> Please use the usual p*d_addr_end() functions. See alloc_init_pmd() and
> friends in arch/arm64/mm/mmu.c for examples of how to use them.

we used the p*d_addr_end family of functions when dealing with p*d(s). I
cannot identify an equivalent for pte entries. Would you recommend adding
a pte_addr_end macro in pgtable.h?

> > +
> > +		if (!pte_present(*pte))
> > +			continue;
> > +
> > +		if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
> 
> When would those addresses *not* be page-aligned? By construction, next
> must be. Unplugging partial pages of memory makes no sense, so surely
> addr is page-aligned when passed in?

The issue here is that this function is called in one of two cases:
1. to clear pagetables of directly mapped (linear) memory 
2. Pagetables (and corresponding data pages) for vmemmap. 

It is my understanding that, in the second case, we might be clearing
only part of the page content (i.e, only a few struct pages). Note that
next is page aligned by construction only if next <= end.

> > +			/*
> > +			 * Do not free direct mapping pages since they were
> > +			 * freed when offlining, or simplely not in use.
> > +			 */
> > +			if (!direct)
> > +				free_pagetable(pte_page(*pte), 0, direct);
> > +
> > +			/*
> > +			 * This spin lock could be only
> > +			 * taken in _pte_aloc_kernel in
> > +			 * mm/memory.c and nowhere else
> > +			 * (for arm64). Not sure if the
> > +			 * function above can be called
> > +			 * concurrently. In doubt,
> > +			 * I am living it here for now,
> > +			 * but it probably can be removed.
> > +			 */
> > +			spin_lock(&init_mm.page_table_lock);
> > +			pte_clear(&init_mm, addr, pte);
> > +			spin_unlock(&init_mm.page_table_lock);
> > +		} else {
> > +			/*
> > +			 * If we are here, we are freeing vmemmap pages since
> > +			 * direct mapped memory ranges to be freed are aligned.
> > +			 *
> > +			 * If we are not removing the whole page, it means
> > +			 * other page structs in this page are being used and
> > +			 * we canot remove them. So fill the unused page_structs
> > +			 * with 0xFD, and remove the page when it is wholly
> > +			 * filled with 0xFD.
> > +			 */
> > +			memset((void *)addr, PAGE_INUSE, next - addr);
> 
> What's special about 0xFD?

Just used it as a constant symmetrically to x86_64 code.

> Why do we need to mess with the page array in this manner? Why can't we
> detect when a range is free by querying memblock, for example?

I am not sure I get your suggestion. I guess that the logic here
is that I cannot be sure that I can free the full page because other
entries might be in use for active vmemmap mappings. So we just "mark"
the unused once and only free the page when all of it is marked. See
again commit ae9aae9eda2db71, where all this comes from.

> > +
> > +			page_addr = page_address(pte_page(*pte));
> > +			if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
> > +				free_pagetable(pte_page(*pte), 0, direct);
> > +
> > +				/*
> > +				 * This spin lock could be only
> > +				 * taken in _pte_aloc_kernel in
> > +				 * mm/memory.c and nowhere else
> > +				 * (for arm64). Not sure if the
> > +				 * function above can be called
> > +				 * concurrently. In doubt,
> > +				 * I am living it here for now,
> > +				 * but it probably can be removed.
> > +				 */
> > +				spin_lock(&init_mm.page_table_lock);
> > +				pte_clear(&init_mm, addr, pte);
> > +				spin_unlock(&init_mm.page_table_lock);
> 
> This logic appears to be duplicated with the free_*_table functions, and
> looks incredibly suspicious.
> 
> To me, it doesn't make sense that we'd need the lock *only* to alter the
> leaf entries.

I admit I am still confused by the use of the page_table_lock and when
and where it should be used. Any hint on that would be more than
welcome.

> > +			}
> > +		}
> > +	}
> > +
> > +	// I am adding this flush here in simmetry to the x86 code.
> > +	// Why do I need to call it here and not in remove_p[mu]d
> > +	flush_tlb_all();
> 
> If the page tables weren't freed until this point, it might be that this
> is just amortizing the cost of removing them from the TLBs.
> 
> Given that they're freed first, this makes no sense to me.

Please, see above.

> > +}
> 
> The same commenst apply to all the remove_p*d_table() functions, so I
> shan't repeat them.
> 
> > +
> > +static void remove_pmd_table(pmd_t *pmd, unsigned long addr,
> > +	unsigned long end, bool direct)
> > +{
> > +	unsigned long next;
> > +	void *page_addr;
> > +	pte_t *pte;
> > +
> > +	for (; addr < end; addr = next, pmd++) {
> > +		next = pmd_addr_end(addr, end);
> > +
> > +		if (!pmd_present(*pmd))
> > +			continue;
> > +
> > +		// check if we are using 2MB section mappings
> > +		if (pmd_sect(*pmd)) {
> > +			if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
> 
> Surely you're intending to check if you can free the whole pmd? i.e.
> that addr and next are pmd-aligned?

Indeed, that's a mistake. It should have been IS_ALIGNED(addr, PMD_SIZE).

> Can we ever be in a situation where we're requested to free a partial
> pmd that could be section mapped?

Yes, as I said above, for vmemmap mappings.
 
> If that's the case, we'll *need* to split the pmd, which we can't do on
> live page tables.

Please, see below.

> > +				if (!direct) {
> > +					free_pagetable(pmd_page(*pmd),
> > +						get_order(PMD_SIZE), direct);
> > +				}
> > +				/*
> > +				 * This spin lock could be only
> > +				 * taken in _pte_aloc_kernel in
> > +				 * mm/memory.c and nowhere else
> > +				 * (for arm64). Not sure if the
> > +				 * function above can be called
> > +				 * concurrently. In doubt,
> > +				 * I am living it here for now,
> > +				 * but it probably can be removed.
> > +				 */
> > +				spin_lock(&init_mm.page_table_lock);
> > +				pmd_clear(pmd);
> > +				spin_unlock(&init_mm.page_table_lock);
> > +			} else {
> > +				/* If here, we are freeing vmemmap pages. */
> > +				memset((void *)addr, PAGE_INUSE, next - addr);
> > +
> > +				page_addr = page_address(pmd_page(*pmd));
> > +				if (!memchr_inv(page_addr, PAGE_INUSE,
> > +						PMD_SIZE)) {
> > +					free_pagetable(pmd_page(*pmd),
> > +						get_order(PMD_SIZE), direct);
> > +
> > +					/*
> > +					 * This spin lock could be only
> > +					 * taken in _pte_aloc_kernel in
> > +					 * mm/memory.c and nowhere else
> > +					 * (for arm64). Not sure if the
> > +					 * function above can be called
> > +					 * concurrently. In doubt,
> > +					 * I am living it here for now,
> > +					 * but it probably can be removed.
> > +					 */
> > +					spin_lock(&init_mm.page_table_lock);
> > +					pmd_clear(pmd);
> > +					spin_unlock(&init_mm.page_table_lock);
> > +				}
> 
> I don't think this is correct.
> 
> If we're getting rid of a partial pmd, we *must* split the pmd.
> Otherwise, we're leaving bits mapped that should not be. If we split the
> pmd, we can free the individual pages as we would for a non-section
> mapping.
> 
> As above, we can't split block entries within live tables, so that will
> be painful at best.
> 
> If we can't split a pmd, hen we cannot free a partial pmd, and will need
> to reject request to do so.
> 
> The same comments (with s/pmu/pud/, etc) apply for the higher level
> remove_p*d_table functions.
> 
> [...]

This only happens when we are clearing vmemmap memory.  My understanding
is that the whole hack of marking the content of partially unused areas
with the 0xFD constant is exactly to avoid splitting the PMD, but instead
to only clear the full area when we realize that there's no valid struct
page in it anymore. When would this kind of use be source of problems?

I am also realizing that vememmaps never use section maps at pud level, 
so this code would only need to stay when clearing pmds and ptes.

> > +void remove_pagetable(unsigned long start, unsigned long end, bool direct)
> > +{
> > +	unsigned long next;
> > +	unsigned long addr;
> > +	pgd_t *pgd;
> > +	pud_t *pud;
> > +
> > +	for (addr = start; addr < end; addr = next) {
> > +		next = pgd_addr_end(addr, end);
> > +
> > +		pgd = pgd_offset_k(addr);
> > +		if (pgd_none(*pgd))
> > +			continue;
> > +
> > +		pud = pud_offset(pgd, addr);
> > +		remove_pud_table(pud, addr, next, direct);
> > +		/*
> > +		 * When the PUD is folded on the PGD (three levels of paging),
> > +		 * I did already clear the PMD page in free_pmd_table,
> > +		 * and reset the corresponding PGD==PUD entry.
> > +		 */
> > +#if CONFIG_PGTABLE_LEVELS > 3
> > +		free_pud_table(pgd, direct);
> >  #endif
> 
> This looks suspicious. Shouldn't we have a similar check for PMD, to
> cater for CONFIG_PGTABLE_LEVELS == 2? e.g. 64K pages, 42-bit VA.
> 
> We should be able to hide this distinction in helpers for both cases.

True, we will fix it in the next version.

> > +	}
> > +
> > +	flush_tlb_all();
> 
> This is too late to be useful.
> 
> Thanks,
> Mark.
 
Thanks again for your comments.

Best,
Andrea
