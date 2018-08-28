From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 28 Aug 2018 15:48:42 +0200
Subject: [RFC PATCH 08/11] asm-generic/tlb: Track freeing of page-table
 directories in struct mmu_gather
In-Reply-To: <20180828134638.GK24082@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-9-git-send-email-will.deacon@arm.com>
 <20180827144457.3f4036e3@roar.ozlabs.ibm.com>
 <20180828134638.GK24082@hirez.programming.kicks-ass.net>
Message-ID: <20180828134842.GQ24142@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 03:46:38PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 27, 2018 at 02:44:57PM +1000, Nicholas Piggin wrote:
> 
> > powerpc may be able to use the unmap granule thing to improve
> > its page size dependent flushes, but it might prefer to go
> > a different way and track start-end for different page sizes.
> 
> I don't really see how tracking multiple ranges would help much with
> THP. The ranges would end up being almost the same if there is a good
> mix of page sizes.
> 
> But something like:
> 
> void tlb_flush_one(struct mmu_gather *tlb, unsigned long addr)
> {
> 	if (tlb->cleared_ptes && (addr << BITS_PER_LONG - PAGE_SHIFT))
> 		tblie_pte(addr);
> 	if (tlb->cleared_pmds && (addr << BITS_PER_LONG - PMD_SHIFT))
> 		tlbie_pmd(addr);
> 	if (tlb->cleared_puds && (addr << BITS_PER_LONG - PUD_SHIFT))
> 		tlbie_pud(addr);
> }

Sorry, those all should (of course) be !(addr << ...).

> void tlb_flush_range(struct mmu_gather *tlb)
> {
> 	unsigned long stride = 1UL << tlb_get_unmap_shift(tlb);
> 	unsigned long addr;
> 
> 	for (addr = tlb->start; addr < tlb->end; addr += stride)
> 		tlb_flush_one(tlb, addr);
> 
> 	ptesync();
> }

And one could; like x86 has; add a threshold above which you just kill
the complete mm.
