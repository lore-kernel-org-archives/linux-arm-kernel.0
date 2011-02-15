From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 11:02:28 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <20110215103127.GC4152@n2100.arm.linux.org.uk>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
Message-ID: <1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-02-15 at 10:31 +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 14, 2011 at 05:39:58PM +0000, Catalin Marinas wrote:
> > Newer processors like Cortex-A15 may cache entries in the higher page
> > table levels. These cached entries are ASID-tagged and are invalidated
> > during normal TLB operations.
> >
> > When a level 2 (pte) page table is removed, the current code sequence
> > first clears the level 1 (pmd) entry, flushes the cache, frees the level
> > 2 table and then invalidates the TLB. Because of the caching of the
> > higher page table entries, the processor may speculatively create a TLB
> > entry after the level 2 page table has been freed but before the TLB
> > invalidation. If such speculative PTW accesses random data, it could
> > create a global TLB entry that gets used for subsequent user space
> > accesses.
> >
> > The patch ensures that the TLB is invalidated before the page table is
> > freed (pte_free_tlb). Since pte_free_tlb() does not get a vma structure,
> > the patch also introduces flush_tlb_user_page() which takes an mm_struct
> > rather than vma_struct. The original flush_tlb_page() is implemented as
> > a call to flush_tlb_user_page().
> 
> We already have support for doing this, and Peter Zijlstra posted patches
> to convert ARM to use a generic implementation of the TLB shootdown code.
> 
> http://marc.info/?l=linux-kernel&m=129604765010347&w=2
> 
> Does this patch solve your problem?

I don't think it does. Peter's patch moves the ARM TLB support to the
generic one which is a good clean-up, however it doesn't look like
anything is invalidating the TLB entry between pmd_clear() and
pte_free(), only after. This is too late because we may speculatively
get a global TLB entry (which isn't invalidated by the ASID TLB
operations). So with Peter's patch we still have to implement
__pte_free_tlb().

An alternative would be that flush_tlb_page() flushes all the ASIDs for
the corresponding user address and this would include any speculatively
fetched global TLB entries.

-- 
Catalin
