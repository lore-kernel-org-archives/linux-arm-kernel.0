From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 12:13:38 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704104329.GD19117@e102109-lin.cambridge.arm.com>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
Message-ID: <20110704111338.GD8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 11:43:29AM +0100, Catalin Marinas wrote:
> According to the ARM ARM, the TLB invalidation sequence should be:
> 
> STR rx, [Translation table entry]          ; write new entry to the translation table
> Clean cache line [Translation table entry] ; This operation is not required with the
>                                            ; Multiprocessing Extensions.
> DSB            ; ensures visibility of the data cleaned from the D Cache
> Invalidate TLB entry by MVA (and ASID if non-global) [page address]
> Invalidate BTC
> DSB            ; ensure completion of the Invalidate TLB operation
> ISB            ; ensure table changes visible to instruction fetch
> 
> So we have a DSB and ISB (when we don't return to user) unconditionally.

That is the "cover all cases of following code" example sequence - it
is intended that at the end of the sequence, the CPU will be able to
execute whatever code irrespective of what it is.

The clarity of that comes from reading the actual rules given before
the example code:

| For TLB maintenance, the translation table walk is treated as a separate
| observer:
| ? A write to the translation tables, after it has been cleaned from the
|   cache if appropriate, is only guaranteed to be seen by a translation
|   table walk caused by an explicit load or store after the execution of
|   both a DSB and an ISB.
|
|   However, it is guaranteed that any writes to the translation tables are
|   not seen by any explicit memory access that occurs in program order
|   before the write to the translation tables.

In other words, if we write to the translation tables to setup a new
mapping where one did not previously exist, we only need an intervening
DSB and ISB when we want to access data through that that mapping.  So,
ioremap(), vmalloc(), vmap(), module allocation, etc would require this.

If we are tearing down a mapping, then we don't need any barrier for
individual PTE entries, but we do if we remove a higher-level (PMD/PUD)
table.

Note that it is irrelevant whether or not we had to clean the cache.

That "However" clause is an interesting one though - it seems to imply
that no barrier is required when we zero out a new page table, before
we link the new page table into the higher order table.  The memory we
allocated for the page table doesn't become a page table until it is
linked into the page table tree.  It also raises the question about how
the system knows that a particular store is to something that's a page
table and something that isn't...  Given that normal memory accesses are
unordered, I think this paragraph is misleading and wrong.

So, I think we need a DSB+ISB in clean_pte_table() to ensure that the
zeroing of that page will be visible to everyone coincidentally or before
the table is linked into the page table tree.  Maybe the arch people can
clarify that?

| ? For the base ARMv7 architecture and versions of the architecture before
|   ARMv7, if the translation tables are held in Write-Back Cacheable memory,
|   the caches must be cleaned to the point of unification after writing to
|   the translation tables and before the DSB instruction. This ensures that
|   the updated translation table are visible to a hardware translation
|   table walk.

IOW, if ID_MMFR3 is implemented on ARMv7+ and it indicates that coherent
walks are supported, we don't need to clean the cache entries for
PUD/PMD/PTE tables.

| ? A write to the translation tables, after it has been cleaned from the
|   cache if appropriate, is only guaranteed to be seen by a translation
|   table walk caused by the instruction fetch of an instruction that
|   follows the write to the translation tables after both a DSB and an ISB.

So we also need a DSB and ISB if we are going to execute code from the
new mapping.  This applies to module_alloc() only.

As far as the BTB goes, I wonder if we can postpone that for user TLB
ops by setting a TIF_ flag and checking that before returning to userspace.
That would avoid having to needlessly destroy the cached branch information
for kernel space while looping over the page tables.  The only other place
that needs to worry about that is module_alloc() and vmap/vmalloc with
PROT_KERNEL_EXEC, all of which can be done in flush_cache_vmap().
Thoughts?
