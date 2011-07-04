From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 4 Jul 2011 16:58:35 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704111338.GD8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
Message-ID: <20110704155835.GA30189@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 12:13:38PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 11:43:29AM +0100, Catalin Marinas wrote:
> > According to the ARM ARM, the TLB invalidation sequence should be:
> > 
> > STR rx, [Translation table entry]          ; write new entry to the translation table
> > Clean cache line [Translation table entry] ; This operation is not required with the
> >                                            ; Multiprocessing Extensions.
> > DSB            ; ensures visibility of the data cleaned from the D Cache
> > Invalidate TLB entry by MVA (and ASID if non-global) [page address]
> > Invalidate BTC
> > DSB            ; ensure completion of the Invalidate TLB operation
> > ISB            ; ensure table changes visible to instruction fetch
> > 
> > So we have a DSB and ISB (when we don't return to user) unconditionally.
> 
> That is the "cover all cases of following code" example sequence - it
> is intended that at the end of the sequence, the CPU will be able to
> execute whatever code irrespective of what it is.
> 
> The clarity of that comes from reading the actual rules given before
> the example code:
> 
> | For TLB maintenance, the translation table walk is treated as a separate
> | observer:
> | ? A write to the translation tables, after it has been cleaned from the
> |   cache if appropriate, is only guaranteed to be seen by a translation
> |   table walk caused by an explicit load or store after the execution of
> |   both a DSB and an ISB.
> |
> |   However, it is guaranteed that any writes to the translation tables are
> |   not seen by any explicit memory access that occurs in program order
> |   before the write to the translation tables.
> 
> In other words, if we write to the translation tables to setup a new
> mapping where one did not previously exist, we only need an intervening
> DSB and ISB when we want to access data through that that mapping.  So,
> ioremap(), vmalloc(), vmap(), module allocation, etc would require this.

Yes.

> If we are tearing down a mapping, then we don't need any barrier for
> individual PTE entries, but we do if we remove a higher-level (PMD/PUD)
> table.

It depends on the use, I don't think we can generally assume that any
tearing down is fine since there are cases where we need a guaranteed
fault (zap_vma_ptes may only tear down PTE entries but the driver using
it expects a fault if something else tries to access that location). A
DSB would be enough.

> That "However" clause is an interesting one though - it seems to imply
> that no barrier is required when we zero out a new page table, before
> we link the new page table into the higher order table.  The memory we
> allocated for the page table doesn't become a page table until it is
> linked into the page table tree. 

That's my understanding of that clause as well.

> It also raises the question about how
> the system knows that a particular store is to something that's a page
> table and something that isn't...  Given that normal memory accesses are
> unordered, I think this paragraph is misleading and wrong.

Reordering of accesses can happen because of load speculation, store
reordering in the write buffer or delays on the bus outside the CPU. The
ARM processors do not issue stores speculatively. When a memory access
is issued, it checks the TLB and may perform a PTW (otherwise the
external bus wouldn't know the address. For explicit accesses, if the
PTW fails, it raises a fault (and we also need a precise abort).

So in case of load from memory vs store to page table, just because the
store is always issued after the load, the address translation for the
load is done before the changes to the page table.

In case of store vs store, AFAIK the stores in the write buffer already
have the physical address (hence the TLB look-up) and give that they are
issued in program order, there is no risk of one being visible before
the other (which should have gone through the write buffer).

> So, I think we need a DSB+ISB in clean_pte_table() to ensure that the
> zeroing of that page will be visible to everyone coincidentally or before
> the table is linked into the page table tree.  Maybe the arch people can
> clarify that?

I can ask if you need a better explanation than above.

> | ? For the base ARMv7 architecture and versions of the architecture before
> |   ARMv7, if the translation tables are held in Write-Back Cacheable memory,
> |   the caches must be cleaned to the point of unification after writing to
> |   the translation tables and before the DSB instruction. This ensures that
> |   the updated translation table are visible to a hardware translation
> |   table walk.
> 
> IOW, if ID_MMFR3 is implemented on ARMv7+ and it indicates that coherent
> walks are supported, we don't need to clean the cache entries for
> PUD/PMD/PTE tables.

Yes.

> | ? A write to the translation tables, after it has been cleaned from the
> |   cache if appropriate, is only guaranteed to be seen by a translation
> |   table walk caused by the instruction fetch of an instruction that
> |   follows the write to the translation tables after both a DSB and an ISB.
> 
> So we also need a DSB and ISB if we are going to execute code from the
> new mapping.  This applies to module_alloc() only.

Yes.

> As far as the BTB goes, I wonder if we can postpone that for user TLB
> ops by setting a TIF_ flag and checking that before returning to userspace.
> That would avoid having to needlessly destroy the cached branch information
> for kernel space while looping over the page tables.  The only other place
> that needs to worry about that is module_alloc() and vmap/vmalloc with
> PROT_KERNEL_EXEC, all of which can be done in flush_cache_vmap().

With setting and checking the TIF_ flag we penalise newer hardware
(Cortex-A8 onwards) where the BTB invalidation is a no-op. But I'll
check with the people here if there are any implications with deferring
the BTB invalidation.

-- 
Catalin
