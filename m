From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jun 2010 20:30:03 +0100
Subject: map_vm_area() correct dcache cleaning on ARMv7?
In-Reply-To: <4C167C5B.9070605@l4dev.org>
References: <4C167C5B.9070605@l4dev.org>
Message-ID: <20100614193003.GA17539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 14, 2010 at 10:00:43PM +0300, Bahadir Balban wrote:
> I am looking at the path map_vm_area() takes with regard to cache
> maintenance on ARMv7. It is not how I anticipated. map_vm_area() calls
> vmap_pte_range() which has:
> 
> 1. pte_alloc_one_kernel(), __get_free_page(): allocate pages for 2nd
> level table.
> 
> 2. clean_dcache_area(): clean data cache for pages allocated in (1)
> conditionally if tlb cannot fetch from 1st level dcache.

This is absolutely correct.  We allocate a new page.  This new page can
contain any random garbage, from old PTE entries to invalid PTE entries.
It could even be code.  We do not want the MMU to read that old data.

So, we zero the page, and then call clean_dcache_area() to ensure that
the MMU will see an _initialized_ kernel, not the crappy data that was
in the page before.

> 3. __pmd_populate(): Set 1st level entries to point at 2nd level.
> 
> 4. flush_pmd_entry(): Clean the dcache for 1st to 2nd
> level pointer set in (3), conditionally if TLB needs it.

This pushes the cache line for the L1 table out to memory so that the
MMU can see it.  Without this, the MMU could still see 'zero', in
which case the MMU will fault on the first access to any page covered
by this L2 page table.

> 5. set_pte_ext(): Set each 2nd level entry to pages.
> 
> 6. set_pte_ext(): Unconditionally clean the dcache for 2nd level to
> page pointer set up in (5).

Again, this is to ensure that the MMU can see the data written to the
page tables.
