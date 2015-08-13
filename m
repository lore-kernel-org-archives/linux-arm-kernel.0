From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 13 Aug 2015 15:59:25 +0200
Subject: [PATCH] ARM: dma-mapping: Don't use outer_flush_range when the L2C is
 coherent
Message-ID: <1439474365-12058-1-git-send-email-gregory.clement@free-electrons.com>
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
things is done for the calling functions. In order to be consistent
the iommu variant of dma_alloc are also updated.

Reported-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.16+
---
 arch/arm/mm/dma-mapping.c | 58 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1ced8a0f7a52..ccd792af2c51 100644
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
@@ -241,12 +241,15 @@ static void __dma_clear_buffer(struct page *page, size_t size)
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
 
@@ -254,7 +257,8 @@ static void __dma_clear_buffer(struct page *page, size_t size)
  * Allocate a DMA buffer for 'dev' of size 'size' using the
  * specified gfp mask.  Note that 'size' must be page aligned.
  */
-static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
+static struct page *__dma_alloc_buffer(struct device *dev, size_t size,
+				gfp_t gfp, bool is_coherent)
 {
 	unsigned long order = get_order(size);
 	struct page *page, *p, *e;
@@ -270,7 +274,7 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
 	for (p = page + (size >> PAGE_SHIFT), e = page + (1 << order); p < e; p++)
 		__free_page(p);
 
-	__dma_clear_buffer(page, size);
+	__dma_clear_buffer(page, size, is_coherent);
 
 	return page;
 }
@@ -474,7 +478,8 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 {
 	struct page *page;
 	void *ptr = NULL;
-	page = __dma_alloc_buffer(dev, size, gfp);
+	/* This function is only called when the arch is non-coherent */
+	page = __dma_alloc_buffer(dev, size, gfp, false);
 	if (!page)
 		return NULL;
 	if (!want_vaddr)
@@ -540,7 +545,13 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	__dma_clear_buffer(page, size);
+	/*
+	 * We are either called from __dma_alloc on the non-coherent
+	 * case or only once from atomic_pool_init. It is called
+	 * during boot time so it is harmless to use the non-coherent
+	 * case even if the L2C is coherent.
+	 */
+	__dma_clear_buffer(page, size, false);
 
 	if (!want_vaddr)
 		goto out;
@@ -601,7 +612,8 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 				   struct page **ret_page)
 {
 	struct page *page;
-	page = __dma_alloc_buffer(dev, size, gfp);
+	/* This function is only called when the arch is coherent */
+	page = __dma_alloc_buffer(dev, size, gfp, true);
 	if (!page)
 		return NULL;
 
@@ -1131,7 +1143,8 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 }
 
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
+					gfp_t gfp, struct dma_attrs *attrs,
+					bool is_coherent)
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
@@ -1154,7 +1167,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		if (!page)
 			goto error;
 
-		__dma_clear_buffer(page, size);
+		__dma_clear_buffer(page, size, is_coherent);
 
 		for (i = 0; i < count; i++)
 			pages[i] = page + i;
@@ -1198,7 +1211,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 				pages[i + j] = pages[i] + j;
 		}
 
-		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
+		__dma_clear_buffer(pages[i], PAGE_SIZE << order, is_coherent);
 		i += 1 << order;
 		count -= 1 << order;
 	}
@@ -1359,8 +1372,9 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 	__free_from_pool(cpu_addr, size);
 }
 
-static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs,
+	    bool is_coherent)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
@@ -1381,7 +1395,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp &= ~(__GFP_COMP);
 
-	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
+	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, is_coherent);
 	if (!pages)
 		return NULL;
 
@@ -1406,6 +1420,18 @@ err_buffer:
 	return NULL;
 }
 
+static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	__arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, false);
+}
+
+static void *arm_coherent_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	__arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, true);
+}
+
 static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    struct dma_attrs *attrs)
@@ -1868,7 +1894,7 @@ struct dma_map_ops iommu_ops = {
 };
 
 struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
+	.alloc		= arm_coherent_iommu_alloc_attrs,
 	.free		= arm_iommu_free_attrs,
 	.mmap		= arm_iommu_mmap_attrs,
 	.get_sgtable	= arm_iommu_get_sgtable,
-- 
2.1.0
