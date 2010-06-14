From: bahadir@l4dev.org (Bahadir Balban)
Date: Mon, 14 Jun 2010 22:00:43 +0300
Subject: map_vm_area() correct dcache cleaning on ARMv7?
Message-ID: <4C167C5B.9070605@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am looking at the path map_vm_area() takes with regard to cache
maintenance on ARMv7. It is not how I anticipated. map_vm_area() calls
vmap_pte_range() which has:

1. pte_alloc_one_kernel(), __get_free_page(): allocate pages for 2nd
level table.

2. clean_dcache_area(): clean data cache for pages allocated in (1)
conditionally if tlb cannot fetch from 1st level dcache.

3. __pmd_populate(): Set 1st level entries to point at 2nd level.

4. flush_pmd_entry(): Clean the dcache for 1st to 2nd
level pointer set in (3), conditionally if TLB needs it.

5. set_pte_ext(): Set each 2nd level entry to pages.

6. set_pte_ext(): Unconditionally clean the dcache for 2nd level to
page pointer set up in (5).

My remarks:
I would expect (2) to not exist at all, since we don't know if there is
any page table data in those newly allocated pages. How is this useful?

I would expect (6) to be doing what (2) and (4) is doing, e.g. only
conditionally clean the dcache in case tlb cannot fetch from L1. Am I
missing something?

-- 
Bahadir
