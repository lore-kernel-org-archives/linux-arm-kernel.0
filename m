From: rabin.vincent@axis.com (Rabin Vincent)
Date: Fri, 19 Feb 2016 09:12:03 +0100
Subject: [PATCH 1/2] mm: cma: split out in_cma check to separate function
Message-ID: <1455869524-13874-1-git-send-email-rabin.vincent@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split out the logic in cma_release() which checks if the page is in the
contiguous area to a new function which can be called separately.  ARM
will use this.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 include/linux/cma.h | 12 ++++++++++++
 mm/cma.c            | 27 +++++++++++++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 29f9e77..6e7fd2d 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -27,5 +27,17 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align);
+
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
+#ifdef CONFIG_CMA
+extern bool in_cma(struct cma *cma, const struct page *pages,
+		   unsigned int count);
+#else
+static inline bool in_cma(struct cma *cma, const struct page *pages,
+			  unsigned int count)
+{
+	return false;
+}
+#endif
+
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index ea506eb..55cda16 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -426,6 +426,23 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align)
 	return page;
 }
 
+bool in_cma(struct cma *cma, const struct page *pages, unsigned int count)
+{
+	unsigned long pfn;
+
+	if (!cma || !pages)
+		return false;
+
+	pfn = page_to_pfn(pages);
+
+	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
+		return false;
+
+	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
+
+	return true;
+}
+
 /**
  * cma_release() - release allocated pages
  * @cma:   Contiguous memory region for which the allocation is performed.
@@ -440,18 +457,12 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 {
 	unsigned long pfn;
 
-	if (!cma || !pages)
-		return false;
-
 	pr_debug("%s(page %p)\n", __func__, (void *)pages);
 
-	pfn = page_to_pfn(pages);
-
-	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
+	if (!in_cma(cma, pages, count))
 		return false;
 
-	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
-
+	pfn = page_to_pfn(pages);
 	free_contig_range(pfn, count);
 	cma_clear_bitmap(cma, pfn, count);
 	trace_cma_release(pfn, pages, count);
-- 
2.7.0
