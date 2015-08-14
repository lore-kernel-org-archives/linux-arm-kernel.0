From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 14 Aug 2015 18:12:55 +0200
Subject: [PATCH v2 1/2] ARM: dma-mapping: Don't use outer_flush_range when the
 L2C is coherent
In-Reply-To: <1439568776-17864-1-git-send-email-gregory.clement@free-electrons.com>
References: <1439568776-17864-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1439568776-17864-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a L2 cache controller is used in a system that provides hardware
coherency, the entire outer cache operations are useless, and can be
skipped.  Moreover, on some systems, it is harmful as it causes
deadlocks between the Marvell coherency mechanism, the Marvell PCIe
controller and the Cortex-A9.

In the current kernel implementation, the outer cache flush range
operation is triggered by the dma_alloc function.
This operation can be take place during runtime and in some
circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
SoCs.

This patch extends the __dma_clear_buffer() function to receive a
boolean argument related to the coherency of the system. The same
things is done for the calling functions.

Reported-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.16+
---
 arch/arm/mm/dma-mapping.c | 55 +++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1ced8a0f7a52..96d1b0572602 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -224,7 +224,7 @@ static u64 get_coherent_dma_mask(struct device *dev)
 	return mask;
 }
 
-static void __dma_clear_buffer(struct page *page, size_t size)
+static void __dma_clear_buffer(struct page *page, size_t size, bool is_coherent)
 {
 	/*
 	 * Ensure that the allocated pages are zeroed, and that any data
@@ -236,17 +236,21 @@ static void __dma_clear_buffer(struct page *page, size_t size)
 		while (size > 0) {
 			void *ptr = kmap_atomic(page);
 			memset(ptr, 0, PAGE_SIZE);
-			dmac_flush_range(ptr, ptr + PAGE_SIZE);
+			if (!is_coherent)
+				dmac_flush_range(ptr, ptr + PAGE_SIZE);
 			kunmap_atomic(ptr);
 			page++;
 			size -= PAGE_SIZE;
 		}
-		outer_flush_range(base, end);
+		if (!is_coherent)
+			outer_flush_range(base, end);
 	} else {
 		void *ptr = page_address(page);
 		memset(ptr, 0, size);
-		dmac_flush_range(ptr, ptr + size);
-		outer_flush_range(__pa(ptr), __pa(ptr) + size);
+		if (!is_coherent) {
+			dmac_flush_range(ptr, ptr + size);
+			outer_flush_range(__pa(ptr), __pa(ptr) + size);
+		}
 	}
 }
 
@@ -254,7 +258,8 @@ static void __dma_clear_buffer(struct page *page, size_t size)
  * Allocate a DMA buffer for 'dev' of size 'size' using the
  * specified gfp mask.  Note that 'size' must be page aligned.
  */
-static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
+static struct page *__dma_alloc_buffer(struct device *dev, size_t size,
+				gfp_t gfp, bool is_coherent)
 {
 	unsigned long order = get_order(size);
 	struct page *page, *p, *e;
@@ -270,7 +275,7 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
 	for (p = page + (size >> PAGE_SHIFT), e = page + (1 << order); p < e; p++)
 		__free_page(p);
 
-	__dma_clear_buffer(page, size);
+	__dma_clear_buffer(page, size, is_coherent);
 
 	return page;
 }
@@ -292,7 +297,8 @@ static void __dma_free_buffer(struct page *page, size_t size)
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-				     const void *caller, bool want_vaddr);
+				     const void *caller, bool want_vaddr,
+				     bool is_coherent);
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
@@ -358,9 +364,14 @@ static int __init atomic_pool_init(void)
 	if (!atomic_pool)
 		goto out;
 
+	/*
+	 * Here we don't know if the system is coherent, but it is
+	 * harmless to use the non-coherent case in the
+	 * __alloc_from_contiguous() call.
+	 */
 	if (dev_get_cma_area(NULL))
 		ptr = __alloc_from_contiguous(NULL, atomic_pool_size, prot,
-					      &page, atomic_pool_init, true);
+					&page, atomic_pool_init, true, false);
 	else
 		ptr = __alloc_remap_buffer(NULL, atomic_pool_size, gfp, prot,
 					   &page, atomic_pool_init, true);
@@ -474,7 +485,8 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 {
 	struct page *page;
 	void *ptr = NULL;
-	page = __dma_alloc_buffer(dev, size, gfp);
+	/* This function is only called when the arch is non-coherent */
+	page = __dma_alloc_buffer(dev, size, gfp, false);
 	if (!page)
 		return NULL;
 	if (!want_vaddr)
@@ -529,7 +541,8 @@ static int __free_from_pool(void *start, size_t size)
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-				     const void *caller, bool want_vaddr)
+				     const void *caller, bool want_vaddr,
+				     bool is_coherent)
 {
 	unsigned long order = get_order(size);
 	size_t count = size >> PAGE_SHIFT;
@@ -540,7 +553,7 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	__dma_clear_buffer(page, size);
+	__dma_clear_buffer(page, size, is_coherent);
 
 	if (!want_vaddr)
 		goto out;
@@ -590,7 +603,7 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 #define __get_dma_pgprot(attrs, prot)				__pgprot(0)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret, c, wv)	NULL
+#define __alloc_from_contiguous(dev, size, prot, ret, c, wv, is_coherent)   NULL
 #define __free_from_pool(cpu_addr, size)			0
 #define __free_from_contiguous(dev, page, cpu_addr, size, wv)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
@@ -601,7 +614,8 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 				   struct page **ret_page)
 {
 	struct page *page;
-	page = __dma_alloc_buffer(dev, size, gfp);
+	/* This function is only called when the arch is coherent */
+	page = __dma_alloc_buffer(dev, size, gfp, true);
 	if (!page)
 		return NULL;
 
@@ -655,7 +669,8 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	else if (!dev_get_cma_area(dev))
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller, want_vaddr);
 	else
-		addr = __alloc_from_contiguous(dev, size, prot, &page, caller, want_vaddr);
+		addr = __alloc_from_contiguous(dev, size, prot, &page, caller,
+					want_vaddr, is_coherent);
 
 	if (page)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
@@ -1131,7 +1146,8 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 }
 
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
+					gfp_t gfp, struct dma_attrs *attrs,
+					bool is_coherent)
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
@@ -1154,7 +1170,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		if (!page)
 			goto error;
 
-		__dma_clear_buffer(page, size);
+		__dma_clear_buffer(page, size, is_coherent);
 
 		for (i = 0; i < count; i++)
 			pages[i] = page + i;
@@ -1198,7 +1214,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 				pages[i + j] = pages[i] + j;
 		}
 
-		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
+		__dma_clear_buffer(pages[i], PAGE_SIZE << order, is_coherent);
 		i += 1 << order;
 		count -= 1 << order;
 	}
@@ -1381,7 +1397,8 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp &= ~(__GFP_COMP);
 
-	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
+	/* For now always consider we are in a non-coherent case */
+	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, false);
 	if (!pages)
 		return NULL;
 
-- 
2.1.0
