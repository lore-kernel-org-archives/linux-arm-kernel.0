From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Mon, 2 Jun 2014 15:49:22 +0530
Subject: [PATCH 3/4] arm: dma-mapping: Refractor iommu_alloc/free funcs
In-Reply-To: <1401704363-31052-3-git-send-email-ritesh.harjani@gmail.com>
References: <1401704363-31052-1-git-send-email-ritesh.harjani@gmail.com>
 <1401704363-31052-2-git-send-email-ritesh.harjani@gmail.com>
 <1401704363-31052-3-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1401704363-31052-4-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

iommu_alloc/free_buffer can be moved out to
lib/iommu_helper.c as a part of refactoring
arm iommu dma-mapping code.

Change-Id: I5fba02f64cb4913f6d0200189267826df47df8d6
Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm/mm/dma-mapping.c    | 95 +-------------------------------------------
 include/linux/iommu-helper.h |  8 ++++
 lib/iommu-helper.c           | 95 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 38fc146..268004c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1161,98 +1161,6 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
-static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
-{
-	struct page **pages;
-	int count = size >> PAGE_SHIFT;
-	int array_size = count * sizeof(struct page *);
-	int i = 0;
-
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, gfp);
-	else
-		pages = vzalloc(array_size);
-	if (!pages)
-		return NULL;
-
-	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs))
-	{
-		unsigned long order = get_order(size);
-		struct page *page;
-
-		page = dma_alloc_from_contiguous(dev, count, order);
-		if (!page)
-			goto error;
-
-		__dma_clear_buffer(page, size);
-
-		for (i = 0; i < count; i++)
-			pages[i] = page + i;
-
-		return pages;
-	}
-
-	/*
-	 * IOMMU can map any pages, so himem can also be used here
-	 */
-	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
-
-	while (count) {
-		int j, order = __fls(count);
-
-		pages[i] = alloc_pages(gfp, order);
-		while (!pages[i] && order)
-			pages[i] = alloc_pages(gfp, --order);
-		if (!pages[i])
-			goto error;
-
-		if (order) {
-			split_page(pages[i], order);
-			j = 1 << order;
-			while (--j)
-				pages[i + j] = pages[i] + j;
-		}
-
-		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
-		i += 1 << order;
-		count -= 1 << order;
-	}
-
-	return pages;
-error:
-	while (i--)
-		if (pages[i])
-			__free_pages(pages[i], 0);
-	if (array_size <= PAGE_SIZE)
-		kfree(pages);
-	else
-		vfree(pages);
-	return NULL;
-}
-
-static int __iommu_free_buffer(struct device *dev, struct page **pages,
-			       size_t size, struct dma_attrs *attrs)
-{
-	int count = size >> PAGE_SHIFT;
-	int array_size = count * sizeof(struct page *);
-	int i;
-
-	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
-		dma_release_from_contiguous(dev, pages[0], count);
-	} else {
-		for (i = 0; i < count; i++)
-			if (pages[i])
-				__free_pages(pages[i], 0);
-	}
-
-	if (array_size <= PAGE_SIZE)
-		kfree(pages);
-	else
-		vfree(pages);
-	return 0;
-}
-
 /*
  * Create a CPU mapping for a specified pages
  */
@@ -1417,7 +1325,8 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp &= ~(__GFP_COMP);
 
-	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
+	pages = __iommu_alloc_buffer(dev, size, gfp, attrs,
+					__dma_clear_buffer);
 	if (!pages)
 		return NULL;
 
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index c6a315d..b27b7cb8 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -2,6 +2,7 @@
 #define _LINUX_IOMMU_HELPER_H
 
 #include <linux/kernel.h>
+#include <linux/dma-attrs.h>
 
 #ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
 struct dma_iommu_mapping {
@@ -19,6 +20,13 @@ struct dma_iommu_mapping {
 	struct kref		kref;
 };
 
+extern struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
+					  gfp_t gfp, struct dma_attrs *attrs,
+			void (*arch_clear_buffer_cb)(struct page*, size_t));
+
+extern int __iommu_free_buffer(struct device *dev, struct page **pages,
+			       size_t size, struct dma_attrs *attrs);
+
 extern void __iommu_detach_device(struct device *dev);
 
 extern void __iommu_release_mapping(struct dma_iommu_mapping *mapping);
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index 28daaa5..e0f643a 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
+#include <linux/dma-contiguous.h>
+#include <linux/mm.h>
 #endif
 
 int iommu_is_span_boundary(unsigned int index, unsigned int nr,
@@ -51,6 +53,99 @@ EXPORT_SYMBOL(iommu_area_alloc);
 
 #ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
 
+struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
+					  gfp_t gfp, struct dma_attrs *attrs,
+			void (*arch_clear_buffer_cb)(struct page*, size_t))
+{
+	struct page **pages;
+	int count = size >> PAGE_SHIFT;
+	int array_size = count * sizeof(struct page *);
+	int i = 0;
+
+	if (array_size <= PAGE_SIZE)
+		pages = kzalloc(array_size, gfp);
+	else
+		pages = vzalloc(array_size);
+	if (!pages)
+		return NULL;
+
+	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
+		unsigned long order = get_order(size);
+		struct page *page;
+
+		page = dma_alloc_from_contiguous(dev, count, order);
+		if (!page)
+			goto error;
+
+		if (arch_clear_buffer_cb)
+			arch_clear_buffer_cb(page, size);
+
+		for (i = 0; i < count; i++)
+			pages[i] = page + i;
+
+		return pages;
+	}
+
+	/*
+	 * IOMMU can map any pages, so himem can also be used here
+	 */
+	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+
+	while (count) {
+		int j, order = __fls(count);
+
+		pages[i] = alloc_pages(gfp, order);
+		while (!pages[i] && order)
+			pages[i] = alloc_pages(gfp, --order);
+		if (!pages[i])
+			goto error;
+
+		if (order) {
+			split_page(pages[i], order);
+			j = 1 << order;
+			while (--j)
+				pages[i + j] = pages[i] + j;
+		}
+		if (arch_clear_buffer_cb)
+			arch_clear_buffer_cb(pages[i], PAGE_SIZE << order);
+		i += 1 << order;
+		count -= 1 << order;
+	}
+
+	return pages;
+error:
+	while (i--)
+		if (pages[i])
+			__free_pages(pages[i], 0);
+	if (array_size <= PAGE_SIZE)
+		kfree(pages);
+	else
+		vfree(pages);
+	return NULL;
+}
+
+int __iommu_free_buffer(struct device *dev, struct page **pages,
+			       size_t size, struct dma_attrs *attrs)
+{
+	int count = size >> PAGE_SHIFT;
+	int array_size = count * sizeof(struct page *);
+	int i;
+
+	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
+		dma_release_from_contiguous(dev, pages[0], count);
+	} else {
+		for (i = 0; i < count; i++)
+			if (pages[i])
+				__free_pages(pages[i], 0);
+	}
+
+	if (array_size <= PAGE_SIZE)
+		kfree(pages);
+	else
+		vfree(pages);
+	return 0;
+}
+
 /**
  * __iommu_init_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
-- 
1.8.1.3
