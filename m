From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Mon, 2 Jun 2014 15:49:21 +0530
Subject: [PATCH 2/4] arm: dma-mapping: Refractor attach/detach dev function
 calls
In-Reply-To: <1401704363-31052-2-git-send-email-ritesh.harjani@gmail.com>
References: <1401704363-31052-1-git-send-email-ritesh.harjani@gmail.com>
 <1401704363-31052-2-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1401704363-31052-3-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Refractor following function calls to lib/iommu-helper.c

arm_iommu_attach/detach device function calls.
arm_iommu_init/release_mapping function calls.

Change-Id: Ic69a8b6b7008599a6e98b670b11a61ff6a5bac99
Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm/mm/dma-mapping.c    | 101 +++++--------------------------
 include/linux/iommu-helper.h |  10 ++++
 lib/iommu-helper.c           | 140 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b82561e..38fc146 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1924,7 +1924,8 @@ struct dma_map_ops iommu_coherent_ops = {
  * @base: start address of the valid IO address space
  * @size: maximum size of the valid IO address space
  *
- * Creates a mapping structure which holds information about used/unused
+ * Calls for lib/iommu-helper function which creates a mapping
+ * structure which holds information about used/unused
  * IO address ranges, which is required to perform memory allocation and
  * mapping with IOMMU aware functions.
  *
@@ -1934,71 +1935,10 @@ struct dma_map_ops iommu_coherent_ops = {
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
+	return __iommu_init_mapping(bus, base, size);
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
@@ -2019,8 +1959,7 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
-	if (mapping)
-		kref_put(&mapping->kref, release_iommu_mapping);
+	__iommu_release_mapping(mapping);
 }
 EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
 
@@ -2030,8 +1969,9 @@ EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
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
@@ -2040,13 +1980,12 @@ int arm_iommu_attach_device(struct device *dev,
 {
 	int err;
 
-	err = iommu_attach_device(mapping->domain, dev);
-	if (err)
-		return err;
+	err = __iommu_attach_device(dev, mapping);
 
-	kref_get(&mapping->kref);
-	dev->mapping = mapping;
-	set_dma_ops(dev, &iommu_ops);
+	if (!err)
+		set_dma_ops(dev, &iommu_ops);
+	else
+		return err;
 
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
@@ -2057,24 +1996,14 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
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
+	__iommu_detach_device(dev);
 	set_dma_ops(dev, NULL);
-
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 0c5e4c7..c6a315d 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -19,6 +19,16 @@ struct dma_iommu_mapping {
 	struct kref		kref;
 };
 
+extern void __iommu_detach_device(struct device *dev);
+
+extern void __iommu_release_mapping(struct dma_iommu_mapping *mapping);
+
+extern int __iommu_attach_device(struct device *dev,
+			    struct dma_iommu_mapping *mapping);
+
+extern struct dma_iommu_mapping *
+__iommu_init_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
+
 #define to_dma_iommu_mapping(dev) ((dev)->mapping)
 #else
 #define to_dma_iommu_mapping(dev) NULL
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index c27e269..28daaa5 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -6,6 +6,15 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 
+#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
+#include <linux/iommu.h>
+#include <linux/device.h>
+#include <linux/iommu-helper.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/errno.h>
+#endif
+
 int iommu_is_span_boundary(unsigned int index, unsigned int nr,
 			   unsigned long shift,
 			   unsigned long boundary_size)
@@ -39,3 +48,134 @@ again:
 	return -1;
 }
 EXPORT_SYMBOL(iommu_area_alloc);
+
+#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
+
+/**
+ * __iommu_init_mapping
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
+__iommu_init_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
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
+void __iommu_release_mapping(struct dma_iommu_mapping *mapping)
+{
+	if (mapping)
+		kref_put(&mapping->kref, release_iommu_mapping);
+}
+
+/**
+ * __iommu_detach_device
+ * @dev: valid struct device pointer
+ *
+ * Detaches the provided device from a previously attached map.
+ */
+void __iommu_detach_device(struct device *dev)
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
+ * __iommu_attach_device
+ * @dev: valid struct device pointer
+ * @mapping: io address space mapping structure
+ *
+ * Attaches specified io address space mapping to the provided device.
+ */
+int __iommu_attach_device(struct device *dev,
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
