From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 10:31:27 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20110215103127.GC4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 05:39:58PM +0000, Catalin Marinas wrote:
> Newer processors like Cortex-A15 may cache entries in the higher page
> table levels. These cached entries are ASID-tagged and are invalidated
> during normal TLB operations.
> 
> When a level 2 (pte) page table is removed, the current code sequence
> first clears the level 1 (pmd) entry, flushes the cache, frees the level
> 2 table and then invalidates the TLB. Because of the caching of the
> higher page table entries, the processor may speculatively create a TLB
> entry after the level 2 page table has been freed but before the TLB
> invalidation. If such speculative PTW accesses random data, it could
> create a global TLB entry that gets used for subsequent user space
> accesses.
> 
> The patch ensures that the TLB is invalidated before the page table is
> freed (pte_free_tlb). Since pte_free_tlb() does not get a vma structure,
> the patch also introduces flush_tlb_user_page() which takes an mm_struct
> rather than vma_struct. The original flush_tlb_page() is implemented as
> a call to flush_tlb_user_page().

We already have support for doing this, and Peter Zijlstra posted patches
to convert ARM to use a generic implementation of the TLB shootdown code.

http://marc.info/?l=linux-kernel&m=129604765010347&w=2

Does this patch solve your problem?
