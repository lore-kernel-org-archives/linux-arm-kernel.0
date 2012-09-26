From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 26 Sep 2012 23:40:59 +0200
Subject: [PATCH 2/2] ARM: remove unnecessary flush of anon pages in
 flush(_kernel)_dcache_page()
In-Reply-To: <1348695659-27603-1-git-send-email-gmbnomis@gmail.com>
References: <1348695659-27603-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1348695659-27603-3-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On non-aliasing VIPT D-caches, there is no need to flush the kernel
mapping of anon pages in flush_kernel_dcache_page() and
flush_dcache_page() directly.  If the page is mapped as executable
later, the necessary D/I-cache flush will be done in
__sync_icache_dcache().

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/flush.c |   60 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 982db2f..077c8fd 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -219,15 +219,18 @@ void __flush_kernel_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
-	if (!cache_ops_need_broadcast() &&
-	    mapping && !mapping_mapped(mapping))
-		clear_bit(PG_dcache_clean, &page->flags);
-	else {
-		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
-		if (mapping && !cache_is_vivt())
-			__flush_icache_all();
-		set_bit(PG_dcache_clean, &page->flags);
+	if (!cache_ops_need_broadcast()) {
+		if ((mapping && !mapping_mapped(mapping)) ||
+		    (!mapping && cache_is_vipt_nonaliasing())) {
+			clear_bit(PG_dcache_clean, &page->flags);
+			return;
+		}
 	}
+
+	__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+	if (mapping && !cache_is_vivt())
+		__flush_icache_all();
+	set_bit(PG_dcache_clean, &page->flags);
 }
 EXPORT_SYMBOL(__flush_kernel_dcache_page);
 
@@ -296,16 +299,20 @@ void __sync_icache_dcache(pte_t pteval)
  * of this page.
  *
  * We have three cases to consider:
- *  - VIPT non-aliasing cache: fully coherent so nothing required.
+ *  - VIPT non-aliasing cache:
+ *          D-cache: fully coherent so nothing required.
+ *          I-cache: Ensure I/D coherency in case of an already mapped page;
+ *                   __sync_icache_dcache() will handle the other cases.
+ *  - VIPT aliasing:
+ *          D-cache: need to handle one alias in our current VM view.
+ *          I-cache: same as VIPT non-aliasing cache
  *  - VIVT: fully aliasing, so we need to handle every alias in our
  *          current VM view.
- *  - VIPT aliasing: need to handle one alias in our current VM view.
  *
- * If we need to handle aliasing:
- *  If the page only exists in the page cache and there are no user
- *  space mappings, we can be lazy and remember that we may have dirty
- *  kernel cache lines for later.  Otherwise, we assume we have
- *  aliasing mappings.
+ * If the page only exists in the page cache and there are no user
+ * space mappings, we can be lazy and remember that we may have dirty
+ * kernel cache lines for later.  Otherwise, we assume we have
+ * aliasing mappings.
  *
  * Note that we disable the lazy flush for SMP configurations where
  * the cache maintenance operations are not automatically broadcasted.
@@ -323,17 +330,20 @@ void flush_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
-	if (!cache_ops_need_broadcast() &&
-	    mapping && !mapping_mapped(mapping))
-		clear_bit(PG_dcache_clean, &page->flags);
-	else {
-		__flush_dcache_page(mapping, page);
-		if (mapping && cache_is_vivt())
-			__flush_dcache_aliases(mapping, page);
-		else if (mapping)
-			__flush_icache_all();
-		set_bit(PG_dcache_clean, &page->flags);
+	if (!cache_ops_need_broadcast()) {
+		if ((mapping && !mapping_mapped(mapping)) ||
+		    (!mapping && cache_is_vipt_nonaliasing())) {
+			clear_bit(PG_dcache_clean, &page->flags);
+			return;
+		}
 	}
+
+	__flush_dcache_page(mapping, page);
+	if (mapping && cache_is_vivt())
+		__flush_dcache_aliases(mapping, page);
+	else if (mapping)
+		__flush_icache_all();
+	set_bit(PG_dcache_clean, &page->flags);
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
-- 
1.7.9.5
