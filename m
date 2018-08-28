From: npiggin@gmail.com (Nicholas Piggin)
Date: Wed, 29 Aug 2018 00:12:34 +1000
Subject: [RFC PATCH 08/11] asm-generic/tlb: Track freeing of page-table
 directories in struct mmu_gather
In-Reply-To: <20180828134638.GK24082@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-9-git-send-email-will.deacon@arm.com>
 <20180827144457.3f4036e3@roar.ozlabs.ibm.com>
 <20180828134638.GK24082@hirez.programming.kicks-ass.net>
Message-ID: <20180829001113.1b8b8031@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Aug 2018 15:46:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 27, 2018 at 02:44:57PM +1000, Nicholas Piggin wrote:
> 
> > powerpc may be able to use the unmap granule thing to improve
> > its page size dependent flushes, but it might prefer to go
> > a different way and track start-end for different page sizes.  
> 
> I don't really see how tracking multiple ranges would help much with
> THP. The ranges would end up being almost the same if there is a good
> mix of page sizes.

That's assuming quite large unmaps. But a lot of the time they are
going to go to a full PID flush.

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
> 
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
> 
> Should workd I think. You'll only issue multiple TLBIEs on the
> boundaries, not every stride.

Yeah we already do basically that today in the flush_tlb_range path,
just without the precise test for which page sizes

                if (hflush) {
                        hstart = (start + PMD_SIZE - 1) & PMD_MASK;
                        hend = end & PMD_MASK;
                        if (hstart == hend)
                                hflush = false;
                }

                if (gflush) {
                        gstart = (start + PUD_SIZE - 1) & PUD_MASK;
                        gend = end & PUD_MASK;
                        if (gstart == gend)
                                gflush = false;
                }

                asm volatile("ptesync": : :"memory");
                if (local) {
                        __tlbiel_va_range(start, end, pid, page_size, mmu_virtual_psize);
                        if (hflush)
                                __tlbiel_va_range(hstart, hend, pid,
                                                PMD_SIZE, MMU_PAGE_2M);
                        if (gflush)
                                __tlbiel_va_range(gstart, gend, pid,
                                                PUD_SIZE, MMU_PAGE_1G);
                        asm volatile("ptesync": : :"memory");

Thing is I think it's the smallish range cases you want to optimize
for. And for those we'll probably do something even smarter (like keep
a bitmap of pages to flush) because we really want to keep tlbies off
the bus whereas that's less important for x86.

Still not really seeing a reason not to implement a struct
arch_mmu_gather. A little bit of data contained to the arch is nothing
compared with the multitude of hooks and divergence of code.

Thanks,
Nick
