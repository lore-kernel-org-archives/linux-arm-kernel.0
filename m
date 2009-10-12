From: ngupta@vflare.org (Nitin Gupta)
Date: Mon, 12 Oct 2009 14:20:23 +0530
Subject: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
Message-ID: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, update_mmu_cache() does dcache flush for a page only if
it has a kernel mapping (page_mapping(page) != NULL). The correct
behavior would be to force the flush based on dcache_dirty bit only.

One of the cases where present logic would be a problem is when
a RAM based block device[1] is used as a swap disk. In this case,
we would have in-memory data corruption as shown in steps below:

do_swap_page()
{
    - Allocate a new page (if not already in swap cache)
    - Issue read from swap disk
        - Block driver issues flush_dcache_page()
        - flush_dcache_page() simply sets PG_dcache_dirty bit and does not
          actually issue a flush since this page has no user space mapping yet.
    - Now, if swap disk is almost full, this newly read page is removed
      from swap cache and corrsponding swap slot is freed.
    - Map this page anonymously in user space.
    - update_mmu_cache()
        - Since this page does not have kernel mapping (its not in page/swap
          cache and is mapped anonymously), it does not issue dcache flush
          even if dcache_dirty bit is set by flush_dcache_page() above.

    <user now gets stale data since dcache was never flushed>
}

Same problem exists on mips too.

[1] example:
 - brd (RAM based block device)
 - ramzswap (RAM based compressed swap device)

Signed-off-by: Nitin Gupta <ngupta@vflare.org>
---
 arch/arm/mm/fault-armv.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index bc0099d..d0d17b6 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -153,14 +153,11 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 
 	page = pfn_to_page(pfn);
 	mapping = page_mapping(page);
-	if (mapping) {
 #ifndef CONFIG_SMP
-		int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
-
-		if (dirty)
-			__flush_dcache_page(mapping, page);
+	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
+		__flush_dcache_page(mapping, page);
 #endif
-
+	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, pfn);
 		else if (vma->vm_flags & VM_EXEC)
-- 
1.6.2.5
