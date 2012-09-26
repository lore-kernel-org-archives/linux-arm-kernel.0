From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 26 Sep 2012 23:40:58 +0200
Subject: [PATCH V2 1/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1348695659-27603-1-git-send-email-gmbnomis@gmail.com>
References: <1348695659-27603-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1348695659-27603-2-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f8b63c1 made flush_kernel_dcache_page() a no-op assuming that
the pages it needs to handle are kernel mapped only.  However, for
example when doing direct I/O, pages with user space mappings may
occur.

Thus, do lazy flushing like in flush_dcache_page() if there are no user
space mappings.  Otherwise, flush the kernel cache lines directly.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
---

Changes in v2:
- flush_kernel_dcache_page() follows flush_dcache_page() now, except that it
  does not flush the user mappings

 arch/arm/include/asm/cacheflush.h |    4 ++++
 arch/arm/mm/flush.c               |   39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index e4448e1..eca955f 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -307,6 +307,10 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 static inline void flush_kernel_dcache_page(struct page *page)
 {
+	extern void __flush_kernel_dcache_page(struct page *);
+	/* highmem pages are always flushed upon kunmap already */
+	if (!PageHighMem(page))
+		__flush_kernel_dcache_page(page);
 }
 
 #define flush_dcache_mmap_lock(mapping) \
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 40ca11e..982db2f 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -192,6 +192,45 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 				page->index << PAGE_CACHE_SHIFT);
 }
 
+/*
+ * Ensure cache coherency for the kernel mapping of this page.
+ *
+ * If the page only exists in the page cache and there are no user
+ * space mappings, we can be lazy and remember that we may have dirty
+ * kernel cache lines for later.  Otherwise, we need to flush the
+ * dirty kernel cache lines directly.
+ *
+ * Note that we disable the lazy flush for SMP configurations where
+ * the cache maintenance operations are not automatically broadcasted.
+ *
+ * We can assume that the page is no high mem page, see
+ * flush_kernel_dcache_page.
+ */
+void __flush_kernel_dcache_page(struct page *page)
+{
+	struct address_space *mapping;
+
+	/*
+	 * The zero page is never written to, so never has any dirty
+	 * cache lines, and therefore never needs to be flushed.
+	 */
+	if (page == ZERO_PAGE(0))
+		return;
+
+	mapping = page_mapping(page);
+
+	if (!cache_ops_need_broadcast() &&
+	    mapping && !mapping_mapped(mapping))
+		clear_bit(PG_dcache_clean, &page->flags);
+	else {
+		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+		if (mapping && !cache_is_vivt())
+			__flush_icache_all();
+		set_bit(PG_dcache_clean, &page->flags);
+	}
+}
+EXPORT_SYMBOL(__flush_kernel_dcache_page);
+
 static void __flush_dcache_aliases(struct address_space *mapping, struct page *page)
 {
 	struct mm_struct *mm = current->active_mm;
-- 
1.7.9.5
