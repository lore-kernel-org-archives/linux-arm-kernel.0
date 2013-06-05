From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed,  5 Jun 2013 21:59:04 +0200
Subject: [PATCH V5] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
Message-ID: <1370462344-7128-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
it needs to handle are kernel mapped only.  However, for example when doing
direct I/O, pages with user space mappings may occur.

Thus, continue to do lazy flushing if there are no user space mappings.
Otherwise, flush the kernel cache lines directly.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
Cc: <stable@vger.kernel.org> # 3.2+
CC: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
---

Changes:

in V5:
- simplified highmem case; we can assume kmapped pages

in V4:
- get back to simpler version of flush_kernel_dcache_page() and use the
logic from __flush_dcache_page() to flush the kernel mapping (which
also takes care of highmem pages)

in V3:
- Followed Catalin's suggestion to reverse the order of the patches

in V2:
- flush_kernel_dcache_page() follows flush_dcache_page() now, except that it
does not flush the user mappings


 arch/arm/include/asm/cacheflush.h |    4 +---
 arch/arm/mm/flush.c               |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index bff7138..17d0ae8 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -320,9 +320,7 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 }
 
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
-static inline void flush_kernel_dcache_page(struct page *page)
-{
-}
+extern void flush_kernel_dcache_page(struct page *);
 
 #define flush_dcache_mmap_lock(mapping) \
 	spin_lock_irq(&(mapping)->tree_lock)
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 0d473cc..32aa586 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -301,6 +301,39 @@ void flush_dcache_page(struct page *page)
 EXPORT_SYMBOL(flush_dcache_page);
 
 /*
+ * Ensure cache coherency for the kernel mapping of this page. We can
+ * assume that the page is pinned via kmap.
+ *
+ * If the page only exists in the page cache and there are no user
+ * space mappings, this is a no-op since the page was already marked
+ * dirty at creation.  Otherwise, we need to flush the dirty kernel
+ * cache lines directly.
+ */
+void flush_kernel_dcache_page(struct page *page)
+{
+	if (cache_is_vivt() || cache_is_vipt_aliasing()) {
+		struct address_space *mapping;
+
+		mapping = page_mapping(page);
+
+		if (!mapping || mapping_mapped(mapping)) {
+			void *addr;
+
+			addr = page_address(page);
+			/*
+			 * kmap_atomic() doesn't set the page virtual
+			 * address for highmem pages, and
+			 * kunmap_atomic() takes care of cache
+			 * flushing already.
+			 */
+			if (!IS_ENABLED(CONFIG_HIGHMEM) || addr)
+				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+		}
+	}
+}
+EXPORT_SYMBOL(flush_kernel_dcache_page);
+
+/*
  * Flush an anonymous page so that users of get_user_pages()
  * can safely access the data.  The expected sequence is:
  *
-- 
1.7.9.5
