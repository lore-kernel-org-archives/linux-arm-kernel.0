From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Apr 2016 17:31:09 +0200
Subject: [PATCH v8 1/2] ARM: dma-mapping: Don't use outer_flush_range when the
 L2C is coherent
In-Reply-To: <1460475070-29058-1-git-send-email-gregory.clement@free-electrons.com>
References: <1460475070-29058-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1460475070-29058-2-git-send-email-gregory.clement@free-electrons.com>
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
 arch/arm/mm/dma-mapping.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index deac58d5f1f7..97beffb8a687 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -49,6 +49,7 @@ struct arm_dma_alloc_args {
 	pgprot_t prot;
 	const void *caller;
 	bool want_vaddr;
+	int coherent_flag;
 };
 
 struct arm_dma_free_args {
@@ -59,6 +60,9 @@ struct arm_dma_free_args {
 	bool want_vaddr;
 };
 
+#define NORMAL	    0
+#define COHERENT    1
+
 struct arm_dma_allocator {
 	void *(*alloc)(struct arm_dma_alloc_args *args,
 		       struct page **ret_page);
@@ -274,7 +278,7 @@ static u64 get_coherent_dma_mask(struct device *dev)
 	return mask;
 }
 
-static void __dma_clear_buffer(struct page *page, size_t size)
+static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
 {
 	/*
 	 * Ensure that the allocated pages are zeroed, and that any data
@@ -286,17 +290,21 @@ static void __dma_clear_buffer(struct page *page, size_t size)
 		while (size > 0) {
 			void *ptr = kmap_atomic(page);
 			memset(ptr, 0, PAGE_SIZE);
-			dmac_flush_range(ptr, ptr + PAGE_SIZE);
+			if (coherent_flag != COHERENT)
+				dmac_flush_range(ptr, ptr + PAGE_SIZE);
 			kunmap_atomic(ptr);
 			page++;
 			size -= PAGE_SIZE;
 		}
-		outer_flush_range(base, end);
+		if (coherent_flag != COHERENT)
+			outer_flush_range(base, end);
 	} else {
 		void *ptr = page_address(page);
 		memset(ptr, 0, size);
-		dmac_flush_range(ptr, ptr + size);
-		outer_flush_range(__pa(ptr), __pa(ptr) + size);
+		if (coherent_flag != COHERENT) {
+			dmac_flush_range(ptr, ptr + size);
+			outer_flush_range(__pa(ptr), __pa(ptr) + size);
+		}
 	}
 }
 
@@ -304,7 +312,8 @@ static void __dma_clear_buffer(struct page *page, size_t size)
  * Allocate a DMA buffer for 'dev' of size 'size' using the
  * specified gfp mask.  Note that 'size' must be page aligned.
  */
-static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
+static struct page *__dma_alloc_buffer(struct device *dev, size_t size,
+				       gfp_t gfp, int coherent_flag)
 {
 	unsigned long order = get_order(size);
 	struct page *page, *p, *e;
@@ -320,7 +329,7 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
 	for (p = page + (size >> PAGE_SHIFT), e = page + (1 << order); p < e; p++)
 		__free_page(p);
 
-	__dma_clear_buffer(page, size);
+	__dma_clear_buffer(page, size, coherent_flag);
 
 	return page;
 }
@@ -342,7 +351,8 @@ static void __dma_free_buffer(struct page *page, size_t size)
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-				     const void *caller, bool want_vaddr);
+				     const void *caller, bool want_vaddr,
+				     int coherent_flag);
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
@@ -407,10 +417,13 @@ static int __init atomic_pool_init(void)
 	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
 	if (!atomic_pool)
 		goto out;
-
+	/*
+	 * The atomic pool is only used for non-coherent allocations
+	 * so we must pass NORMAL for coherent_flag.
+	 */
 	if (dev_get_cma_area(NULL))
 		ptr = __alloc_from_contiguous(NULL, atomic_pool_size, prot,
-					      &page, atomic_pool_init, true);
+				      &page, atomic_pool_init, true, NORMAL);
 	else
 		ptr = __alloc_remap_buffer(NULL, atomic_pool_size, gfp, prot,
 					   &page, atomic_pool_init, true);
@@ -524,7 +537,11 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 {
 	struct page *page;
 	void *ptr = NULL;
-	page = __dma_alloc_buffer(dev, size, gfp);
+	/*
+	 * __alloc_remap_buffer is only called when the device is
+	 * non-coherent
+	 */
+	page = __dma_alloc_buffer(dev, size, gfp, NORMAL);
 	if (!page)
 		return NULL;
 	if (!want_vaddr)
@@ -579,7 +596,8 @@ static int __free_from_pool(void *start, size_t size)
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-				     const void *caller, bool want_vaddr)
+				     const void *caller, bool want_vaddr,
+				     int coherent_flag)
 {
 	unsigned long order = get_order(size);
 	size_t count = size >> PAGE_SHIFT;
@@ -590,7 +608,7 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	__dma_clear_buffer(page, size);
+	__dma_clear_buffer(page, size, coherent_flag);
 
 	if (!want_vaddr)
 		goto out;
@@ -640,7 +658,7 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 #define __get_dma_pgprot(attrs, prot)				__pgprot(0)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret, c, wv)	NULL
+#define __alloc_from_contiguous(dev, size, prot, ret, c, wv, coherent_flag)	NULL
 #define __free_from_pool(cpu_addr, size)			do { } while (0)
 #define __free_from_contiguous(dev, page, cpu_addr, size, wv)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
@@ -651,7 +669,8 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 				   struct page **ret_page)
 {
 	struct page *page;
-	page = __dma_alloc_buffer(dev, size, gfp);
+	/* __alloc_simple_buffer is only called when the device is coherent */
+	page = __dma_alloc_buffer(dev, size, gfp, COHERENT);
 	if (!page)
 		return NULL;
 
@@ -681,7 +700,7 @@ static void *cma_allocator_alloc(struct arm_dma_alloc_args *args,
 {
 	return __alloc_from_contiguous(args->dev, args->size, args->prot,
 				       ret_page, args->caller,
-				       args->want_vaddr);
+				       args->want_vaddr, args->coherent_flag);
 }
 
 static void cma_allocator_free(struct arm_dma_free_args *args)
@@ -748,6 +767,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		.prot = prot,
 		.caller = caller,
 		.want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs),
+		.coherent_flag = is_coherent ? COHERENT : NORMAL,
 	};
 
 #ifdef CONFIG_DMA_API_DEBUG
@@ -1264,7 +1284,8 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 static const int iommu_order_array[] = { 9, 8, 4, 0 };
 
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
+					  gfp_t gfp, struct dma_attrs *attrs,
+					  int coherent_flag)
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
@@ -1288,7 +1309,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		if (!page)
 			goto error;
 
-		__dma_clear_buffer(page, size);
+		__dma_clear_buffer(page, size, coherent_flag);
 
 		for (i = 0; i < count; i++)
 			pages[i] = page + i;
@@ -1338,7 +1359,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 				pages[i + j] = pages[i] + j;
 		}
 
-		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
+		__dma_clear_buffer(pages[i], PAGE_SIZE << order, coherent_flag);
 		i += 1 << order;
 		count -= 1 << order;
 	}
@@ -1516,7 +1537,8 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp &= ~(__GFP_COMP);
 
-	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
+	/* For now always consider we are in a non-coherent case */
+	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, NORMAL);
 	if (!pages)
 		return NULL;
 
-- 
2.5.0
