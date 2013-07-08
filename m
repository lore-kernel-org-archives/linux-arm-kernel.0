From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  8 Jul 2013 16:44:55 -0600
Subject: [PATCH] ARM: mm: restrict early_alloc_aligned to legal area
Message-ID: <1373323495-10087-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

When early_alloc_aligned() is called, it appears that only memory in the
first memory bank is mapped for CPU access. However, memblock_alloc() is
called to allocate the RAM, and that can return RAM that is part of any
valid memory bank, which hence could be inaccessible to the CPU. If this
happens, the subsequent memset() will hang or crash.

Solve this by calling memblock_alloc_base() instead of memblock_alloc().
This function takes an explicit max address. Use the end of the first
memory bank as the address.

As an example, this issue can be triggered as follows:

* Total of 512MB system RAM, so it is all lowmem not highmem. Without this,
  subsequent banks may be ignored by map_lowmem() due to being highmem.
* RAM is split into multiple banks, due to some RAM somewhere in the
  middle having been allocated for purposes other than Linux, e.g. an LCD
  frame-buffer of for a co-processor.
* Some bank is not section-aligned, so that alloc_init_pte() is called
  rather than __map_init_section().

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mm/mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index d7229d2..0849741 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -585,7 +585,10 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
 {
-	void *ptr = __va(memblock_alloc(sz, align));
+	phys_addr_t max_pa = memblock.memory.regions[0].base +
+				memblock.memory.regions[0].size;
+	phys_addr_t pa = memblock_alloc_base(sz, align, max_pa);
+	void *ptr = __va(pa);
 	memset(ptr, 0, sz);
 	return ptr;
 }
-- 
1.8.1.5
