From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 28 May 2012 01:11:58 +0200
Subject: [RFC/PATCH 1/1] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1338160318-20712-1-git-send-email-gmbnomis@gmail.com>
References: <1338160318-20712-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1338160318-20712-2-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
it needs to handle are kernel mapped only.  However, for example when doing
direct I/O, pages with user space mappings may occur.

Thus, continue to do lazy flushing if there are no user space mappings.
Otherwise, flush the kernel cache lines directly.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/include/asm/cacheflush.h |    4 ++++
 arch/arm/mm/flush.c               |   22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5d8d5c..c6c81d5 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -303,6 +303,10 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 static inline void flush_kernel_dcache_page(struct page *page)
 {
+	extern void __flush_kernel_dcache_page(struct page *);
+	/* highmem pages are always flushed upon kunmap already */
+	if ((cache_is_vivt() || cache_is_vipt_aliasing()) && !PageHighMem(page))
+		__flush_kernel_dcache_page(page);
 }
 
 #define flush_dcache_mmap_lock(mapping) \
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7745854..bcba3a9 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -192,6 +192,28 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 				page->index << PAGE_CACHE_SHIFT);
 }
 
+/*
+ * Ensure cache coherency for kernel mapping of this page.
+ *
+ * If the page only exists in the page cache and there are no user
+ * space mappings, this is a no-op since the page was already marked
+ * dirty@creation.  Otherwise, we need to flush the dirty kernel
+ * cache lines directly.
+ *
+ * We can assume that the page is no high mem page, see
+ * flush_kernel_dcache_page.
+ */
+void __flush_kernel_dcache_page(struct page *page)
+{
+	struct address_space *mapping;
+
+	mapping = page_mapping(page);
+
+	if (!mapping || mapping_mapped(mapping))
+		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+}
+EXPORT_SYMBOL(__flush_kernel_dcache_page);
+
 static void __flush_dcache_aliases(struct address_space *mapping, struct page *page)
 {
 	struct mm_struct *mm = current->active_mm;
-- 
1.7.9.5
