From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Wed, 4 Jun 2014 18:24:48 +0530
Subject: [PATCHv2 1/2] arm: dma-mapping: Refactor attach/detach,
 alloc/free func
In-Reply-To: <1401886489-25498-1-git-send-email-ritesh.harjani@gmail.com>
References: <1401886489-25498-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1401886489-25498-2-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Refactor following function calls to lib/iommu-helper.c

1.
arm_iommu_attach/detach device function calls.
arm_iommu_init/release_mapping function calls.

2. iommu_alloc/free_buffer can be moved out from
arm/dma-mapping.c to lib/iommu_helper.c

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm/mm/dma-mapping.c    | 200 ++++--------------------------------
 include/linux/iommu-helper.h |  18 ++++
 lib/iommu-helper.c           | 235 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+), 181 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b82561e..66cf96b 100644
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
+	pages = iommu_helper_alloc_buffer(dev, size, gfp, attrs,
+					__dma_clear_buffer);
 	if (!pages)
 		return NULL;
 
@@ -1438,7 +1347,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 err_mapping:
 	__iommu_remove_mapping(dev, *handle, size);
 err_buffer:
-	__iommu_free_buffer(dev, pages, size, attrs);
+	iommu_helper_free_buffer(dev, pages, size, attrs);
 	return NULL;
 }
 
@@ -1495,7 +1404,7 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	}
 
 	__iommu_remove_mapping(dev, handle, size);
-	__iommu_free_buffer(dev, pages, size, attrs);
+	iommu_helper_free_buffer(dev, pages, size, attrs);
 }
 
 static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
@@ -1924,7 +1833,8 @@ struct dma_map_ops iommu_coherent_ops = {
  * @base: start address of the valid IO address space
  * @size: maximum size of the valid IO address space
  *
- * Creates a mapping structure which holds information about used/unused
+ * Calls for lib/iommu-helper function which creates a mapping
+ * structure which holds information about used/unused
  * IO address ranges, which is required to perform memory allocation and
  * mapping with IOMMU aware functions.
  *
@@ -1934,71 +1844,10 @@ struct dma_map_ops iommu_coherent_ops = {
 struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 {
-	unsigned int bits = size >> PAGE_SHIFT;
-	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
-	struct dma_iommu_mapping *mapping;
-	int extensions = 1;
-	int err = -ENOMEM;
-
-	if (!bitmap_size)
-		return ERR_PTR(-EINVAL);
-
-	if (bitmap_size > PAGE_SIZE) {
-		extensions = bitmap_size / PAGE_SIZE;
-		bitmap_size = PAGE_SIZE;
-	}
-
-	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
-	if (!mapping)
-		goto err;
-
-	mapping->bitmap_size = bitmap_size;
-	mapping->bitmaps = kzalloc(extensions * sizeof(unsigned long *),
-				GFP_KERNEL);
-	if (!mapping->bitmaps)
-		goto err2;
-
-	mapping->bitmaps[0] = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!mapping->bitmaps[0])
-		goto err3;
-
-	mapping->nr_bitmaps = 1;
-	mapping->extensions = extensions;
-	mapping->base = base;
-	mapping->bits = BITS_PER_BYTE * bitmap_size;
-
-	spin_lock_init(&mapping->lock);
-
-	mapping->domain = iommu_domain_alloc(bus);
-	if (!mapping->domain)
-		goto err4;
-
-	kref_init(&mapping->kref);
-	return mapping;
-err4:
-	kfree(mapping->bitmaps[0]);
-err3:
-	kfree(mapping->bitmaps);
-err2:
-	kfree(mapping);
-err:
-	return ERR_PTR(err);
+	return iommu_helper_init_mapping(bus, base, size);
 }
 EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
-static void release_iommu_mapping(struct kref *kref)
-{
-	int i;
-	struct dma_iommu_mapping *mapping =
-		container_of(kref, struct dma_iommu_mapping, kref);
-
-	iommu_domain_free(mapping->domain);
-	for (i = 0; i < mapping->nr_bitmaps; i++)
-		kfree(mapping->bitmaps[i]);
-	kfree(mapping->bitmaps);
-	kfree(mapping);
-}
-
 static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 {
 	int next_bitmap;
@@ -2019,8 +1868,7 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
-	if (mapping)
-		kref_put(&mapping->kref, release_iommu_mapping);
+	iommu_helper_release_mapping(mapping);
 }
 EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
 
@@ -2030,8 +1878,9 @@ EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
  * @mapping: io address space mapping structure (returned from
  *	arm_iommu_create_mapping)
  *
- * Attaches specified io address space mapping to the provided device,
- * this replaces the dma operations (dma_map_ops pointer) with the
+ * Calls for lib/iommu-helper which attaches specified io
+ * address space mapping to the provided device, this
+ * replaces the dma operations (dma_map_ops pointer) with the
  * IOMMU aware version. More than one client might be attached to
  * the same io address space mapping.
  */
@@ -2040,13 +1889,12 @@ int arm_iommu_attach_device(struct device *dev,
 {
 	int err;
 
-	err = iommu_attach_device(mapping->domain, dev);
-	if (err)
-		return err;
+	err = iommu_helper_attach_device(dev, mapping);
 
-	kref_get(&mapping->kref);
-	dev->mapping = mapping;
-	set_dma_ops(dev, &iommu_ops);
+	if (!err)
+		set_dma_ops(dev, &iommu_ops);
+	else
+		return err;
 
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
@@ -2057,24 +1905,14 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
  * arm_iommu_detach_device
  * @dev: valid struct device pointer
  *
- * Detaches the provided device from a previously attached map.
+ * Calls for lib/iommu-helper which detaches the provided
+ * device from a previously attached map.
  * This voids the dma operations (dma_map_ops pointer)
  */
 void arm_iommu_detach_device(struct device *dev)
 {
-	struct dma_iommu_mapping *mapping;
-
-	mapping = to_dma_iommu_mapping(dev);
-	if (!mapping) {
-		dev_warn(dev, "Not attached\n");
-		return;
-	}
-
-	iommu_detach_device(mapping->domain, dev);
-	kref_put(&mapping->kref, release_iommu_mapping);
-	dev->mapping = NULL;
+	iommu_helper_detach_device(dev);
 	set_dma_ops(dev, NULL);
-
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 0c5e4c7..9c4c2ae 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -2,6 +2,7 @@
 #define _LINUX_IOMMU_HELPER_H
 
 #include <linux/kernel.h>
+#include <linux/dma-attrs.h>
 
 #ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
 struct dma_iommu_mapping {
@@ -19,6 +20,23 @@ struct dma_iommu_mapping {
 	struct kref		kref;
 };
 
+extern struct page **iommu_helper_alloc_buffer(struct device *dev, size_t size,
+					  gfp_t gfp, struct dma_attrs *attrs,
+			void (*arch_clear_buffer_cb)(struct page*, size_t));
+
+extern int iommu_helper_free_buffer(struct device *dev, struct page **pages,
+			       size_t size, struct dma_attrs *attrs);
+
+extern void iommu_helper_detach_device(struct device *dev);
+
+extern void iommu_helper_release_mapping(struct dma_iommu_mapping *mapping);
+
+extern int iommu_helper_attach_device(struct device *dev,
+			    struct dma_iommu_mapping *mapping);
+
+extern struct dma_iommu_mapping *
+iommu_helper_init_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
+
 #define to_dma_iommu_mapping(dev) ((dev)->mapping)
 #else
 #define to_dma_iommu_mapping(dev) NULL
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index c27e269..3664709 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -6,6 +6,17 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 
+#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
+#include <linux/iommu.h>
+#include <linux/device.h>
+#include <linux/iommu-helper.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/errno.h>
+#include <linux/dma-contiguous.h>
+#include <linux/mm.h>
+#endif
+
 int iommu_is_span_boundary(unsigned int index, unsigned int nr,
 			   unsigned long shift,
 			   unsigned long boundary_size)
@@ -39,3 +50,227 @@ again:
 	return -1;
 }
 EXPORT_SYMBOL(iommu_area_alloc);
+
+#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
+
+struct page **iommu_helper_alloc_buffer(struct device *dev, size_t size,
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
+int iommu_helper_free_buffer(struct device *dev, struct page **pages,
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
+/**
+ * iommu_helper_init_mapping
+ * @bus: pointer to the bus holding the client device (for IOMMU calls)
+ * @base: start address of the valid IO address space
+ * @size: maximum size of the valid IO address space
+ *
+ * Creates a mapping structure which holds information about used/unused
+ * IO address ranges, which is required to perform memory allocation and
+ * mapping with IOMMU aware functions.
+ *
+ */
+
+struct dma_iommu_mapping *
+iommu_helper_init_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
+{
+	unsigned int bits = size >> PAGE_SHIFT;
+	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
+	struct dma_iommu_mapping *mapping;
+	int extensions = 1;
+	int err = -ENOMEM;
+
+	if (!bitmap_size)
+		return ERR_PTR(-EINVAL);
+
+	if (bitmap_size > PAGE_SIZE) {
+		extensions = bitmap_size / PAGE_SIZE;
+		bitmap_size = PAGE_SIZE;
+	}
+
+	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
+	if (!mapping)
+		goto err;
+
+	mapping->bitmap_size = bitmap_size;
+	mapping->bitmaps = kzalloc(extensions * sizeof(unsigned long *),
+				GFP_KERNEL);
+	if (!mapping->bitmaps)
+		goto err2;
+
+	mapping->bitmaps[0] = kzalloc(bitmap_size, GFP_KERNEL);
+	if (!mapping->bitmaps[0])
+		goto err3;
+
+	mapping->nr_bitmaps = 1;
+	mapping->extensions = extensions;
+	mapping->base = base;
+	mapping->bits = BITS_PER_BYTE * bitmap_size;
+
+	spin_lock_init(&mapping->lock);
+
+	mapping->domain = iommu_domain_alloc(bus);
+	if (!mapping->domain)
+		goto err4;
+
+	kref_init(&mapping->kref);
+	return mapping;
+err4:
+	kfree(mapping->bitmaps[0]);
+err3:
+	kfree(mapping->bitmaps);
+err2:
+	kfree(mapping);
+err:
+	return ERR_PTR(err);
+}
+
+static void release_iommu_mapping(struct kref *kref)
+{
+	int i;
+	struct dma_iommu_mapping *mapping =
+		container_of(kref, struct dma_iommu_mapping, kref);
+
+	iommu_domain_free(mapping->domain);
+	for (i = 0; i < mapping->nr_bitmaps; i++)
+		kfree(mapping->bitmaps[i]);
+	kfree(mapping->bitmaps);
+	kfree(mapping);
+}
+
+
+void iommu_helper_release_mapping(struct dma_iommu_mapping *mapping)
+{
+	if (mapping)
+		kref_put(&mapping->kref, release_iommu_mapping);
+}
+
+/**
+ * iommu_helper_detach_device
+ * @dev: valid struct device pointer
+ *
+ * Detaches the provided device from a previously attached map.
+ */
+void iommu_helper_detach_device(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping;
+
+	mapping = to_dma_iommu_mapping(dev);
+	if (!mapping) {
+		dev_warn(dev, "Not attached\n");
+		return;
+	}
+
+	iommu_detach_device(mapping->domain, dev);
+	kref_put(&mapping->kref, release_iommu_mapping);
+	dev->mapping = NULL;
+}
+
+/**
+ * iommu_helper_attach_device
+ * @dev: valid struct device pointer
+ * @mapping: io address space mapping structure
+ *
+ * Attaches specified io address space mapping to the provided device.
+ */
+int iommu_helper_attach_device(struct device *dev,
+			    struct dma_iommu_mapping *mapping)
+{
+	int err;
+
+	err = iommu_attach_device(mapping->domain, dev);
+	if (err)
+		return err;
+
+	kref_get(&mapping->kref);
+	dev->mapping = mapping;
+	return 0;
+}
+#endif
-- 
1.8.1.3
