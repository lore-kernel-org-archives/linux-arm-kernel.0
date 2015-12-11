From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2015 19:10:31 +0000
Subject: [PATCH] arm64: mm: ensure that the zero page is visible to the
 page table walker
In-Reply-To: <20151211181952.GB23638@leverpostej>
References: <1449769199-31361-1-git-send-email-will.deacon@arm.com>
 <20151210181412.GL495@leverpostej> <20151211175849.GM18828@arm.com>
 <20151211181952.GB23638@leverpostej>
Message-ID: <20151211191031.GN18828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 06:19:52PM +0000, Mark Rutland wrote:
> > > > +	/* Ensure the zero page is visible to the page table walker */
> > > > +	dsb(ishst);
> > > 
> > > I think this should live in early_alloc (likewise in late_alloc).
> > > 
> > > In the other cases we call early_alloc or late_allot we assume the
> > > zeroing is visible to the page table walker.
> > > 
> > > For example in in alloc_init_pte we do:
> > > 	
> > > 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
> > > 		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
> > > 		if (pmd_sect(*pmd))
> > > 			split_pmd(pmd, pte);
> > > 		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
> > > 		flush_tlb_all();
> > > 	}
> > > 
> > > There's a dsb in __pmd_populate, but it's _after_ the write to the pmd
> > > entry, so the walker might start walking the newly-allocated pte table
> > > before the zeroing is visible.
> > 
> > Urgh. The reason this is a problem is because we're modifying the page
> > tables live (which I know that you're fixing) without using
> > break-before-make. Consequently, the usual ordering guarantees that we
> > get from the tlb flush after installing the invalid entry do not apply
> > and we end up with the issue you point out.
> 
> My feeling was that in these paths we usually assume all prior page
> table updates have been made visible to the page table walkers. Given
> that, having the allocator guarantee the zeroing was already visible
> felt like the natural thing to do.
> 
> That said, having looked at mm/memory.c, we seem to follow the exact
> same pattern when plumbing tables together dynamically, with only an
> smp_wmb() between the zeroed allocation and plumbing a table entry in.
> 
> e.g. in __pte_alloc we have the pattern:
> 
> 	pgtable_t new = pte_alloc_one(mm, address);
> 	smp_wmb();
> 	if (pmd_none(*pmd))
> 		pmd_populate(mm, pmd, new);

I suspect this is potentially broken if somebody builds a CPU with a
"cool feature" in the page table walker that allows it to walk out of
order without respecting address dependencies.

The easiest fix is adding dsb(ishst) to the page table alloc functions.

Will
