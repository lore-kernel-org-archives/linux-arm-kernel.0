From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 26 Jun 2013 15:40:08 +0200
Subject: [PATCH v3 1/2] drivers: dma-contiguous: clean source code and prepare
 for device tree
In-Reply-To: <1372254009-25307-1-git-send-email-m.szyprowski@samsung.com>
References: <1372254009-25307-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1372254009-25307-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans the initialization of dma contiguous framework. The
all-in-one dma_declare_contiguous() function is now separated into
dma_contiguous_reserve_area() which only steals the the memory from
memblock allocator and dma_contiguous_add_device() function, which
assigns given device to the specified reserved memory area. This improves
the flexibility in defining contiguous memory areas and assigning device
to them, because now it is possible to assign more than one device to
the given contiguous memory area. Such split in initialization procedure
is also required for upcoming device tree support.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/base/dma-contiguous.c        |  211 ++++++++++++++++------------------
 include/asm-generic/dma-contiguous.h |    2 -
 include/linux/dma-contiguous.h       |   32 +++++-
 3 files changed, 129 insertions(+), 116 deletions(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 0ca5442..01fe743 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -39,8 +39,15 @@ struct cma {
 	unsigned long	*bitmap;
 };
 
+static DEFINE_MUTEX(cma_mutex);
+
+static struct cma cma_areas[MAX_CMA_AREAS];
+static unsigned cma_area_count;
+
 struct cma *dma_contiguous_default_area;
 
+/*****************************************************************************/
+
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
 #else
@@ -95,51 +102,20 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
 #endif
 
-/**
- * dma_contiguous_reserve() - reserve area for contiguous memory handling
- * @limit: End address of the reserved memory (optional, 0 for any).
- *
- * This function reserves memory from early allocator. It should be
- * called by arch specific code once the early allocator (memblock or bootmem)
- * has been activated and all other subsystems have already allocated/reserved
- * memory.
- */
-void __init dma_contiguous_reserve(phys_addr_t limit)
-{
-	phys_addr_t selected_size = 0;
-
-	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
-
-	if (size_cmdline != -1) {
-		selected_size = size_cmdline;
-	} else {
-#ifdef CONFIG_CMA_SIZE_SEL_MBYTES
-		selected_size = size_bytes;
-#elif defined(CONFIG_CMA_SIZE_SEL_PERCENTAGE)
-		selected_size = cma_early_percent_memory();
-#elif defined(CONFIG_CMA_SIZE_SEL_MIN)
-		selected_size = min(size_bytes, cma_early_percent_memory());
-#elif defined(CONFIG_CMA_SIZE_SEL_MAX)
-		selected_size = max(size_bytes, cma_early_percent_memory());
-#endif
-	}
-
-	if (selected_size) {
-		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
-			 (unsigned long)selected_size / SZ_1M);
-
-		dma_declare_contiguous(NULL, selected_size, 0, limit);
-	}
-};
-
-static DEFINE_MUTEX(cma_mutex);
+/*************************************************************************/
 
-static __init int cma_activate_area(unsigned long base_pfn, unsigned long count)
+static __init int cma_activate_area(struct cma *cma)
 {
-	unsigned long pfn = base_pfn;
-	unsigned i = count >> pageblock_order;
+	int bitmap_size = BITS_TO_LONGS(cma->count) * sizeof(long);
+	unsigned long base_pfn = cma->base_pfn, pfn = base_pfn;
+	unsigned i = cma->count >> pageblock_order;
 	struct zone *zone;
 
+	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+
+	if (!cma->bitmap)
+		return -ENOMEM;
+
 	WARN_ON_ONCE(!pfn_valid(pfn));
 	zone = page_zone(pfn_to_page(pfn));
 
@@ -153,92 +129,74 @@ static __init int cma_activate_area(unsigned long base_pfn, unsigned long count)
 		}
 		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
 	} while (--i);
+
 	return 0;
 }
 
-static __init struct cma *cma_create_area(unsigned long base_pfn,
-				     unsigned long count)
+/**
+ * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
+ * @limit: End address of the reserved memory (optional, 0 for any).
+ *
+ * This function reserves memory from early allocator. It should be
+ * called by arch specific code once the early allocator (memblock or bootmem)
+ * has been activated and all other subsystems have already allocated/reserved
+ * memory. It reserves contiguous areas for global, device independent
+ * allocations and (optionally) all areas defined in device tree structures.
+ */
+void __init dma_contiguous_reserve(phys_addr_t limit)
 {
-	int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
-	struct cma *cma;
-	int ret = -ENOMEM;
-
-	pr_debug("%s(base %08lx, count %lx)\n", __func__, base_pfn, count);
-
-	cma = kmalloc(sizeof *cma, GFP_KERNEL);
-	if (!cma)
-		return ERR_PTR(-ENOMEM);
+	phys_addr_t sel_size = 0;
 
-	cma->base_pfn = base_pfn;
-	cma->count = count;
-	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-
-	if (!cma->bitmap)
-		goto no_mem;
-
-	ret = cma_activate_area(base_pfn, count);
-	if (ret)
-		goto error;
-
-	pr_debug("%s: returned %p\n", __func__, (void *)cma);
-	return cma;
-
-error:
-	kfree(cma->bitmap);
-no_mem:
-	kfree(cma);
-	return ERR_PTR(ret);
-}
-
-static struct cma_reserved {
-	phys_addr_t start;
-	unsigned long size;
-	struct device *dev;
-} cma_reserved[MAX_CMA_AREAS] __initdata;
-static unsigned cma_reserved_count __initdata;
+	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
-static int __init cma_init_reserved_areas(void)
-{
-	struct cma_reserved *r = cma_reserved;
-	unsigned i = cma_reserved_count;
+	if (size_cmdline != -1) {
+		sel_size = size_cmdline;
+	} else {
+#ifdef CONFIG_CMA_SIZE_SEL_MBYTES
+		sel_size = size_bytes;
+#elif defined(CONFIG_CMA_SIZE_SEL_PERCENTAGE)
+		sel_size = cma_early_percent_memory();
+#elif defined(CONFIG_CMA_SIZE_SEL_MIN)
+		sel_size = min(size_bytes, cma_early_percent_memory());
+#elif defined(CONFIG_CMA_SIZE_SEL_MAX)
+		sel_size = max(size_bytes, cma_early_percent_memory());
+#endif
+	}
 
-	pr_debug("%s()\n", __func__);
+	if (sel_size && !dma_contiguous_default_area) {
+		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
+			 (unsigned long)sel_size / SZ_1M);
 
-	for (; i; --i, ++r) {
-		struct cma *cma;
-		cma = cma_create_area(PFN_DOWN(r->start),
-				      r->size >> PAGE_SHIFT);
-		if (!IS_ERR(cma))
-			dev_set_cma_area(r->dev, cma);
+		dma_contiguous_reserve_area(sel_size, 0, limit,
+					    &dma_contiguous_default_area);
 	}
-	return 0;
-}
-core_initcall(cma_init_reserved_areas);
+};
 
 /**
- * dma_declare_contiguous() - reserve area for contiguous memory handling
- *			      for particular device
- * @dev:   Pointer to device structure.
- * @size:  Size of the reserved memory.
- * @base:  Start address of the reserved memory (optional, 0 for any).
+ * dma_contiguous_reserve_area() - reserve custom contiguous area
+ * @size: Size of the reserved area (in bytes),
+ * @base: Base address of the reserved area optional, use 0 for any
  * @limit: End address of the reserved memory (optional, 0 for any).
+ * @res_cma: Pointer to store the created cma region.
  *
- * This function reserves memory for specified device. It should be
- * called by board specific code when early allocator (memblock or bootmem)
- * is still activate.
+ * This function reserves memory from early allocator. It should be
+ * called by arch specific code once the early allocator (memblock or bootmem)
+ * has been activated and all other subsystems have already allocated/reserved
+ * memory. This function allows to create custom reserved areas for specific
+ * devices.
  */
-int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
-				  phys_addr_t base, phys_addr_t limit)
+int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
+				       phys_addr_t limit, struct cma **res_cma)
 {
-	struct cma_reserved *r = &cma_reserved[cma_reserved_count];
 	phys_addr_t alignment;
+	int ret = 0;
 
 	pr_debug("%s(size %lx, base %08lx, limit %08lx)\n", __func__,
 		 (unsigned long)size, (unsigned long)base,
 		 (unsigned long)limit);
 
 	/* Sanity checks */
-	if (cma_reserved_count == ARRAY_SIZE(cma_reserved)) {
+	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
 		pr_err("Not enough slots for CMA reserved regions!\n");
 		return -ENOSPC;
 	}
@@ -256,7 +214,7 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 	if (base) {
 		if (memblock_is_region_reserved(base, size) ||
 		    memblock_reserve(base, size) < 0) {
-			base = -EBUSY;
+			ret = -EBUSY;
 			goto err;
 		}
 	} else {
@@ -266,7 +224,7 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 		 */
 		phys_addr_t addr = __memblock_alloc_base(size, alignment, limit);
 		if (!addr) {
-			base = -ENOMEM;
+			ret = -ENOMEM;
 			goto err;
 		} else {
 			base = addr;
@@ -277,10 +235,11 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 	 * Each reserved area must be initialised later, when more kernel
 	 * subsystems (like slab allocator) are available.
 	 */
-	r->start = base;
-	r->size = size;
-	r->dev = dev;
-	cma_reserved_count++;
+	cma_areas[cma_area_count].base_pfn = PFN_DOWN(base);
+	cma_areas[cma_area_count].count = size >> PAGE_SHIFT;
+	*res_cma = &cma_areas[cma_area_count];
+	cma_area_count++;
+
 	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
 		(unsigned long)base);
 
@@ -289,10 +248,38 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 	return 0;
 err:
 	pr_err("CMA: failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
-	return base;
+	return ret;
 }
 
 /**
+ * dma_contiguous_add_device() - add device to custom contiguous reserved area
+ * @dev:   Pointer to device structure.
+ * @cma:   Pointer to the cma structure for the reserved area
+ *
+ * This function assigns the given device to the contiguous memory area
+ * reserved earlier by dma_contiguous_reserve_area() function.
+ */
+int __init dma_contiguous_add_device(struct device *dev, struct cma *cma)
+{
+	dev_set_cma_area(dev, cma);
+	return 0;
+}
+
+static int __init cma_init_reserved_areas(void)
+{
+	int i;
+
+	for (i = 0; i < cma_area_count; i++) {
+		int ret = cma_activate_area(&cma_areas[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+core_initcall(cma_init_reserved_areas);
+
+/**
  * dma_alloc_from_contiguous() - allocate pages from contiguous area
  * @dev:   Pointer to device for which the allocation is performed.
  * @count: Requested number of pages.
diff --git a/include/asm-generic/dma-contiguous.h b/include/asm-generic/dma-contiguous.h
index 294b1e7..8979f86 100644
--- a/include/asm-generic/dma-contiguous.h
+++ b/include/asm-generic/dma-contiguous.h
@@ -18,8 +18,6 @@ static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
 {
 	if (dev)
 		dev->cma_area = cma;
-	if (!dev && !dma_contiguous_default_area)
-		dma_contiguous_default_area = cma;
 }
 
 #endif
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 01b5c84..28c31fe 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -68,8 +68,36 @@ struct device;
 extern struct cma *dma_contiguous_default_area;
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
-int dma_declare_contiguous(struct device *dev, phys_addr_t size,
-			   phys_addr_t base, phys_addr_t limit);
+
+int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
+				       phys_addr_t limit, struct cma **res_cma);
+
+int dma_contiguous_add_device(struct device *dev, struct cma *cma);
+
+/**
+ * dma_declare_contiguous() - reserve area for contiguous memory handling
+ *			      for particular device
+ * @dev:   Pointer to device structure.
+ * @size:  Size of the reserved memory.
+ * @base:  Start address of the reserved memory (optional, 0 for any).
+ * @limit: End address of the reserved memory (optional, 0 for any).
+ *
+ * This function reserves memory for specified device. It should be
+ * called by board specific code when early allocator (memblock or bootmem)
+ * is still activate.
+ */
+
+static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
+					 phys_addr_t base, phys_addr_t limit)
+{
+	struct cma *cma;
+	int ret;
+	ret = dma_contiguous_reserve_area(size, base, limit, &cma);
+	if (ret == 0)
+		dma_contiguous_add_device(dev, cma);
+
+	return ret;
+}
 
 struct page *dma_alloc_from_contiguous(struct device *dev, int count,
 				       unsigned int order);
-- 
1.7.9.5
