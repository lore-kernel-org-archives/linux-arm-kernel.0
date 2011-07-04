From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 20:58:19 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704155835.GA30189@e102109-lin.cambridge.arm.com>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704155835.GA30189@e102109-lin.cambridge.arm.com>
Message-ID: <20110704195819.GG8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 04:58:35PM +0100, Catalin Marinas wrote:
> On Mon, Jul 04, 2011 at 12:13:38PM +0100, Russell King - ARM Linux wrote:
> > If we are tearing down a mapping, then we don't need any barrier for
> > individual PTE entries, but we do if we remove a higher-level (PMD/PUD)
> > table.
> 
> It depends on the use, I don't think we can generally assume that any
> tearing down is fine since there are cases where we need a guaranteed
> fault (zap_vma_ptes may only tear down PTE entries but the driver using
> it expects a fault if something else tries to access that location). A
> DSB would be enough.

It depends whether we're unmapping due to munmap or for kernel internal
stuff, or whether we're doing it as a result of disposing with the
page tables.  In the latter case, avoiding the DSBs would be a good
trick to pull.

> > That "However" clause is an interesting one though - it seems to imply
> > that no barrier is required when we zero out a new page table, before
> > we link the new page table into the higher order table.  The memory we
> > allocated for the page table doesn't become a page table until it is
> > linked into the page table tree. 
> 
> That's my understanding of that clause as well.
> 
> > It also raises the question about how
> > the system knows that a particular store is to something that's a page
> > table and something that isn't...  Given that normal memory accesses are
> > unordered, I think this paragraph is misleading and wrong.
> 
> Reordering of accesses can happen because of load speculation, store
> reordering in the write buffer or delays on the bus outside the CPU. The
> ARM processors do not issue stores speculatively. When a memory access
> is issued, it checks the TLB and may perform a PTW (otherwise the
> external bus wouldn't know the address. For explicit accesses, if the
> PTW fails, it raises a fault (and we also need a precise abort).

I think you missed my point.  The order in which stores to normal memory
appear is not determinable.  In the case of writeback caches, it depends
on the cache replacement algorithm, the state of the cache and its
allocation behaviour.

It is entirely possible that the store to the page tables _could_ appear
in memory (and therefore visible to the MMU) before the stores to the
new page table initializing it to zeros.

For instance, lets say that the L1 writeback cache is read allocate only,
and does not read entries from the L1 cache.

The new page table happens to contain some L1 cache lines, but the upper
table entry is not in the L1 cache.  This means that stores to the new
page table hit the L1 cache lines, which become dirty.  The store to the
upper table entry bypasses the L1 cache and is immediately placed into
the write buffer.

This means in all probability that the MMU will see the new page table
before it is visibly initialized.

> > As far as the BTB goes, I wonder if we can postpone that for user TLB
> > ops by setting a TIF_ flag and checking that before returning to userspace.
> > That would avoid having to needlessly destroy the cached branch information
> > for kernel space while looping over the page tables.  The only other place
> > that needs to worry about that is module_alloc() and vmap/vmalloc with
> > PROT_KERNEL_EXEC, all of which can be done in flush_cache_vmap().
> 
> With setting and checking the TIF_ flag we penalise newer hardware
> (Cortex-A8 onwards) where the BTB invalidation is a no-op. But I'll
> check with the people here if there are any implications with deferring
> the BTB invalidation.

Thanks.
