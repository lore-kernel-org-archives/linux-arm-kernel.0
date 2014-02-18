From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 Feb 2014 14:37:56 +0100
Subject: [PATCH v3 1/6] base: dma-contiguous: add
 dma_contiguous_init_reserved_mem() function
In-Reply-To: <1392730681-14695-1-git-send-email-m.szyprowski@samsung.com>
References: <1392730681-14695-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1392730681-14695-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new dma_contiguous_init_reserved_mem() function, which creates CMA area
from previously reserved memory region.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/dma-contiguous.c  |   70 +++++++++++++++++++++++++++-------------
 include/linux/dma-contiguous.h |    7 ++++
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 165c2c299e57..ece82e8f3a8b 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -182,6 +182,53 @@ static int __init cma_init_reserved_areas(void)
 core_initcall(cma_init_reserved_areas);
 
 /**
+ * dma_contiguous_init_reserved_mem() - reserve custom contiguous area
+ * @size: Size of the reserved area (in bytes),
+ * @base: Base address of the reserved area optional, use 0 for any
+ * @limit: End address of the reserved memory (optional, 0 for any).
+ * @res_cma: Pointer to store the created cma region.
+ *
+ * This function reserves memory from early allocator. It should be
+ * called by arch specific code once the early allocator (memblock or bootmem)
+ * has been activated and all other subsystems have already allocated/reserved
+ * memory. This function allows to create custom reserved areas for specific
+ * devices.
+ */
+int __init dma_contiguous_init_reserved_mem(phys_addr_t size, phys_addr_t base,
+				       struct cma **res_cma)
+{
+	struct cma *cma = &cma_areas[cma_area_count];
+	phys_addr_t alignment;
+
+	/* Sanity checks */
+	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
+		pr_err("Not enough slots for CMA reserved regions!\n");
+		return -ENOSPC;
+	}
+
+	if (!size || !memblock_is_region_reserved(base, size))
+		return -EINVAL;
+
+	/* Sanitise input arguments */
+	alignment = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
+	if (ALIGN(base, alignment) != base || ALIGN(size, alignment) != size)
+		return -EINVAL;
+
+	cma->base_pfn = PFN_DOWN(base);
+	cma->count = size >> PAGE_SHIFT;
+	*res_cma = cma;
+	cma_area_count++;
+
+	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
+		(unsigned long)base);
+
+	/* Architecture specific contiguous memory fixup. */
+	dma_contiguous_early_fixup(base, size);
+	return 0;
+}
+
+
+/**
  * dma_contiguous_reserve_area() - reserve custom contiguous area
  * @size: Size of the reserved area (in bytes),
  * @base: Base address of the reserved area optional, use 0 for any
@@ -197,7 +244,6 @@ core_initcall(cma_init_reserved_areas);
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma)
 {
-	struct cma *cma = &cma_areas[cma_area_count];
 	phys_addr_t alignment;
 	int ret = 0;
 
@@ -205,12 +251,6 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 		 (unsigned long)size, (unsigned long)base,
 		 (unsigned long)limit);
 
-	/* Sanity checks */
-	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
-		pr_err("Not enough slots for CMA reserved regions!\n");
-		return -ENOSPC;
-	}
-
 	if (!size)
 		return -EINVAL;
 
@@ -241,21 +281,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 		}
 	}
 
-	/*
-	 * Each reserved area must be initialised later, when more kernel
-	 * subsystems (like slab allocator) are available.
-	 */
-	cma->base_pfn = PFN_DOWN(base);
-	cma->count = size >> PAGE_SHIFT;
-	*res_cma = cma;
-	cma_area_count++;
-
-	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
-		(unsigned long)base);
-
-	/* Architecture specific contiguous memory fixup. */
-	dma_contiguous_early_fixup(base, size);
-	return 0;
+	return dma_contiguous_init_reserved_mem(size, base, res_cma);
 err:
 	pr_err("CMA: failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
 	return ret;
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 3b28f937d959..550497393ae7 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -90,6 +90,8 @@ void dma_contiguous_reserve(phys_addr_t addr_limit);
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma);
 
+int dma_contiguous_init_reserved_mem(phys_addr_t size, phys_addr_t base,
+				     struct cma **res_cma);
 /**
  * dma_declare_contiguous() - reserve area for contiguous memory handling
  *			      for particular device
@@ -140,6 +142,11 @@ static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base
 	return -ENOSYS;
 }
 
+static inline int dma_contiguous_init_reserved_mem(phys_addr_t size,
+				phys_addr_t base, struct cma **res_cma) {
+	return -ENOSYS;
+}
+
 static inline
 int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 			   phys_addr_t base, phys_addr_t limit)
-- 
1.7.9.5
