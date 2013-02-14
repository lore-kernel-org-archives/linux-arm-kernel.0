From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Feb 2013 13:45:27 +0100
Subject: [PATCH 1/2] drivers: dma-contiguous: clean source code and prepare for
 device tree
In-Reply-To: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1360845928-8107-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans the initialization of dma contiguous framework. The
all-in-one dma_declare_contiguous() function is now separated into
dma_contiguous_reserve_area() which only steals the the memory from
memblock allocator and dma_contiguous_add_device() function, which
assigns given device to the specified reserved memory area. This improves
the flexibility in defining contiguous memory areas and assigning device
to them, because now it is possible to assign more than one device to
the given contiguous memory area. This split in initialization is also
required for upcoming device tree support.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/base/dma-contiguous.c        |  210 +++++++++++++++++++++-------------
 include/asm-generic/dma-contiguous.h |    4 +-
 include/linux/dma-contiguous.h       |   32 +++++-
 3 files changed, 161 insertions(+), 85 deletions(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 0ca5442..085389c 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -39,7 +39,33 @@ struct cma {
 	unsigned long	*bitmap;
 };
 
-struct cma *dma_contiguous_default_area;
+static DEFINE_MUTEX(cma_mutex);
+
+struct cma *dma_contiguous_def_area;
+phys_addr_t dma_contiguous_def_base;
+
+static struct cma_area {
+	phys_addr_t base;
+	unsigned long size;
+	struct cma *cma;
+} cma_areas[MAX_CMA_AREAS] __initdata;
+static unsigned cma_area_count __initdata;
+
+
+static struct cma_map {
+	phys_addr_t base;
+	struct device *dev;
+} cma_maps[MAX_CMA_AREAS] __initdata;
+static unsigned cma_map_count __initdata;
+
+static struct cma *cma_get_area(phys_addr_t base)
+{
+	int i;
+	for (i = 0; i < cma_area_count; i++)
+		if (cma_areas[i].base == base)
+			return cma_areas[i].cma;
+	return NULL;
+}
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -95,45 +121,6 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
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
-
 static __init int cma_activate_area(unsigned long base_pfn, unsigned long count)
 {
 	unsigned long pfn = base_pfn;
@@ -190,55 +177,73 @@ no_mem:
 	return ERR_PTR(ret);
 }
 
-static struct cma_reserved {
-	phys_addr_t start;
-	unsigned long size;
-	struct device *dev;
-} cma_reserved[MAX_CMA_AREAS] __initdata;
-static unsigned cma_reserved_count __initdata;
-
-static int __init cma_init_reserved_areas(void)
+/**
+ * dma_contiguous_reserve() - reserve area for contiguous memory handling
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
-	struct cma_reserved *r = cma_reserved;
-	unsigned i = cma_reserved_count;
+	phys_addr_t sel_size = 0;
 
-	pr_debug("%s()\n", __func__);
+	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
-	for (; i; --i, ++r) {
-		struct cma *cma;
-		cma = cma_create_area(PFN_DOWN(r->start),
-				      r->size >> PAGE_SHIFT);
-		if (!IS_ERR(cma))
-			dev_set_cma_area(r->dev, cma);
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
 	}
-	return 0;
-}
-core_initcall(cma_init_reserved_areas);
+
+	if (sel_size) {
+		phys_addr_t base = 0;
+		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
+			 (unsigned long)sel_size / SZ_1M);
+
+		if (dma_contiguous_reserve_area(sel_size, &base, limit) == 0)
+			dma_contiguous_def_base = base;
+	}
+};
 
 /**
- * dma_declare_contiguous() - reserve area for contiguous memory handling
- *			      for particular device
- * @dev:   Pointer to device structure.
- * @size:  Size of the reserved memory.
- * @base:  Start address of the reserved memory (optional, 0 for any).
+ * dma_contiguous_reserve_area() - reserve custom contiguous area
+ * @size: Size of the reserved area (in bytes),
+ * @base: Pointer to the base address of the reserved area, also used to return
+ * 	  base address of the actually reserved area, optional, use pointer to
+ *	  0 for any
  * @limit: End address of the reserved memory (optional, 0 for any).
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
+int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t *res_base,
+				       phys_addr_t limit)
 {
-	struct cma_reserved *r = &cma_reserved[cma_reserved_count];
+	phys_addr_t base = *res_base;
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
@@ -256,7 +261,7 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 	if (base) {
 		if (memblock_is_region_reserved(base, size) ||
 		    memblock_reserve(base, size) < 0) {
-			base = -EBUSY;
+			ret = -EBUSY;
 			goto err;
 		}
 	} else {
@@ -266,7 +271,7 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 		 */
 		phys_addr_t addr = __memblock_alloc_base(size, alignment, limit);
 		if (!addr) {
-			base = -ENOMEM;
+			ret = -ENOMEM;
 			goto err;
 		} else {
 			base = addr;
@@ -277,10 +282,11 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 	 * Each reserved area must be initialised later, when more kernel
 	 * subsystems (like slab allocator) are available.
 	 */
-	r->start = base;
-	r->size = size;
-	r->dev = dev;
-	cma_reserved_count++;
+	cma_areas[cma_area_count].base = base;
+	cma_areas[cma_area_count].size = size;
+	cma_area_count++;
+	*res_base = base;
+
 	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
 		(unsigned long)base);
 
@@ -289,9 +295,55 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
 	return 0;
 err:
 	pr_err("CMA: failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
-	return base;
+	return ret;
+}
+
+/**
+ * dma_contiguous_add_device() - add device to custom contiguous reserved area
+ * @dev:   Pointer to device structure.
+ * @base: Pointer to the base address of the reserved area returned by
+ *        dma_contiguous_reserve_area() function, also used to return
+ *
+ * This function assigns the given device to the contiguous memory area
+ * reserved earlier by dma_contiguous_reserve_area() function.
+ */
+int __init dma_contiguous_add_device(struct device *dev, phys_addr_t base)
+{
+	if (cma_map_count == ARRAY_SIZE(cma_maps)) {
+		pr_err("Not enough slots for CMA reserved regions!\n");
+		return -ENOSPC;
+	}
+	cma_maps[cma_map_count].dev = dev;
+	cma_maps[cma_map_count].base = base;
+	cma_map_count++;
+	return 0;
 }
 
+static int __init cma_init_reserved_areas(void)
+{
+	struct cma *cma;
+	int i;
+
+	for (i = 0; i < cma_area_count; i++) {
+		phys_addr_t base = PFN_DOWN(cma_areas[i].base);
+		unsigned int count = cma_areas[i].size >> PAGE_SHIFT;
+
+		cma = cma_create_area(base, count);
+		if (!IS_ERR(cma))
+			cma_areas[i].cma = cma;
+	}
+
+	dma_contiguous_def_area = cma_get_area(dma_contiguous_def_base);
+
+	for (i = 0; i < cma_map_count; i++) {
+		cma = cma_get_area(cma_maps[i].base);
+		dev_set_cma_area(cma_maps[i].dev, cma);
+	}
+
+	return 0;
+}
+core_initcall(cma_init_reserved_areas);
+
 /**
  * dma_alloc_from_contiguous() - allocate pages from contiguous area
  * @dev:   Pointer to device for which the allocation is performed.
diff --git a/include/asm-generic/dma-contiguous.h b/include/asm-generic/dma-contiguous.h
index 294b1e7..9071ef1 100644
--- a/include/asm-generic/dma-contiguous.h
+++ b/include/asm-generic/dma-contiguous.h
@@ -11,15 +11,13 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 {
 	if (dev && dev->cma_area)
 		return dev->cma_area;
-	return dma_contiguous_default_area;
+	return dma_contiguous_def_area;
 }
 
 static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
 {
 	if (dev)
 		dev->cma_area = cma;
-	if (!dev && !dma_contiguous_default_area)
-		dma_contiguous_default_area = cma;
 }
 
 #endif
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 01b5c84..285b593 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -65,11 +65,37 @@ struct device;
  */
 #define MAX_CMA_AREAS	(1 + CONFIG_CMA_AREAS)
 
-extern struct cma *dma_contiguous_default_area;
+extern struct cma *dma_contiguous_def_area;
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
-int dma_declare_contiguous(struct device *dev, phys_addr_t size,
-			   phys_addr_t base, phys_addr_t limit);
+
+int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t *res_base,
+				  phys_addr_t limit);
+
+int dma_contiguous_add_device(struct device *dev, phys_addr_t base);
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
+	int ret;
+	ret = dma_contiguous_reserve_area(size, &base, limit);
+	if (ret == 0)
+		ret = dma_contiguous_add_device(dev, base);
+	return ret;
+}
 
 struct page *dma_alloc_from_contiguous(struct device *dev, int count,
 				       unsigned int order);
-- 
1.7.9.5
