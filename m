From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Jul 2011 11:07:25 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704195819.GG8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704155835.GA30189@e102109-lin.cambridge.arm.com>
	<20110704195819.GG8286@n2100.arm.linux.org.uk>
Message-ID: <20110705100725.GC25956@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 08:58:19PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 04:58:35PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 04, 2011 at 12:13:38PM +0100, Russell King - ARM Linux wrote:
> > > That "However" clause is an interesting one though - it seems to imply
> > > that no barrier is required when we zero out a new page table, before
> > > we link the new page table into the higher order table.  The memory we
> > > allocated for the page table doesn't become a page table until it is
> > > linked into the page table tree. 
> > > 
> > > It also raises the question about how
> > > the system knows that a particular store is to something that's a page
> > > table and something that isn't...  Given that normal memory accesses are
> > > unordered, I think this paragraph is misleading and wrong.
> > 
> > Reordering of accesses can happen because of load speculation, store
> > reordering in the write buffer or delays on the bus outside the CPU. The
> > ARM processors do not issue stores speculatively. When a memory access
> > is issued, it checks the TLB and may perform a PTW (otherwise the
> > external bus wouldn't know the address. For explicit accesses, if the
> > PTW fails, it raises a fault (and we also need a precise abort).
> 
> I think you missed my point.  The order in which stores to normal memory
> appear is not determinable.  In the case of writeback caches, it depends
> on the cache replacement algorithm, the state of the cache and its
> allocation behaviour.
> 
> It is entirely possible that the store to the page tables _could_ appear
> in memory (and therefore visible to the MMU) before the stores to the
> new page table initializing it to zeros.

I think I got your point now. Do you mean:

1. allocate a page for pte
2. zero the page
3. write the pmd entry pointing to the pte page

In this case we need a DSB between 2 and 3 (and maybe a cache flush as
well, which we already do) otherwise we could speculatively load garbage
into the TLB.

Going back to the "however" clause - "any writes to the translation
tables are not seen by any explicit memory access that occurs in program
order before the write to the translation tables" - the important issue
here is the understanding of "seen". An explicit memory access "sees" a
write to the translation table if it uses the new translation to
calculate the physical address. But in the case above, point 3 doesn't
need to see the page zeroing at point 3, they are independent, hence the
need for a DSB.

Maybe the clause could be clarified a bit - I'll ping RG.

> For instance, lets say that the L1 writeback cache is read allocate only,
> and does not read entries from the L1 cache.
> 
> The new page table happens to contain some L1 cache lines, but the upper
> table entry is not in the L1 cache.  This means that stores to the new
> page table hit the L1 cache lines, which become dirty.  The store to the
> upper table entry bypasses the L1 cache and is immediately placed into
> the write buffer.
> 
> This means in all probability that the MMU will see the new page table
> before it is visibly initialized.

If the MMU can read the L1 cache, than we need a DSB before the write to
the upper memory (I wonder whether a DMB would do, since the MMU is just
another observer). If the MMU can't read the L1 cache, than we need a
cache clean as well.

-- 
Catalin
