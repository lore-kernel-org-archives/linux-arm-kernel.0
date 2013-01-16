From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 16 Jan 2013 16:31:22 +0100
Subject: [PATCH 1/2] ARM: dma-mapping: add support for CMA regions placed in
 highmem zone
In-Reply-To: <1358350284-6972-1-git-send-email-m.szyprowski@samsung.com>
References: <1358350284-6972-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1358350284-6972-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing pieces to correctly support memory pages served
from CMA regions placed in high memory zones. Please note that the default
global CMA area is still put into lowmem and is limited by optional
architecture specific DMA zone. One can however put device specific CMA
regions in high memory zone to reduce lowmem usage.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   61 +++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b2fb87..4080c37 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -186,16 +186,29 @@ static u64 get_coherent_dma_mask(struct device *dev)
 
 static void __dma_clear_buffer(struct page *page, size_t size)
 {
-	void *ptr;
 	/*
 	 * Ensure that the allocated pages are zeroed, and that any data
 	 * lurking in the kernel direct-mapped region is invalidated.
 	 */
-	ptr = page_address(page);
-	if (ptr) {
-		memset(ptr, 0, size);
-		dmac_flush_range(ptr, ptr + size);
-		outer_flush_range(__pa(ptr), __pa(ptr) + size);
+	if (!PageHighMem(page)) {
+		void *ptr = page_address(page);
+		if (ptr) {
+			memset(ptr, 0, size);
+			dmac_flush_range(ptr, ptr + size);
+			outer_flush_range(__pa(ptr), __pa(ptr) + size);
+		}
+	} else {
+		phys_addr_t base = __pfn_to_phys(page_to_pfn(page));
+		phys_addr_t end = base + size;
+		while (size > 0) {
+			void *ptr = kmap_atomic(page);
+			memset(ptr, 0, PAGE_SIZE);
+			dmac_flush_range(ptr, ptr + PAGE_SIZE);
+			kunmap_atomic(ptr);
+			page++;
+			size -= PAGE_SIZE;
+		}
+		outer_flush_range(base, end);
 	}
 }
 
@@ -243,7 +256,8 @@ static void __dma_free_buffer(struct page *page, size_t size)
 #endif
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
-				     pgprot_t prot, struct page **ret_page);
+				     pgprot_t prot, struct page **ret_page,
+				     const void *caller);
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
@@ -346,10 +360,11 @@ static int __init atomic_pool_init(void)
 		goto no_pages;
 
 	if (IS_ENABLED(CONFIG_CMA))
-		ptr = __alloc_from_contiguous(NULL, pool->size, prot, &page);
+		ptr = __alloc_from_contiguous(NULL, pool->size, prot, &page,
+					      atomic_pool_init);
 	else
 		ptr = __alloc_remap_buffer(NULL, pool->size, GFP_KERNEL, prot,
-					   &page, NULL);
+					   &page, atomic_pool_init);
 	if (ptr) {
 		int i;
 
@@ -542,27 +557,41 @@ static int __free_from_pool(void *start, size_t size)
 }
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
-				     pgprot_t prot, struct page **ret_page)
+				     pgprot_t prot, struct page **ret_page,
+				     const void *caller)
 {
 	unsigned long order = get_order(size);
 	size_t count = size >> PAGE_SHIFT;
 	struct page *page;
+	void *ptr;
 
 	page = dma_alloc_from_contiguous(dev, count, order);
 	if (!page)
 		return NULL;
 
 	__dma_clear_buffer(page, size);
-	__dma_remap(page, size, prot);
 
+	if (!PageHighMem(page)) {
+		__dma_remap(page, size, prot);
+		ptr = page_address(page);
+	} else {
+		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
+		if (!ptr) {
+			dma_release_from_contiguous(dev, page, count);
+			return NULL;
+		}
+	}
 	*ret_page = page;
-	return page_address(page);
+	return ptr;
 }
 
 static void __free_from_contiguous(struct device *dev, struct page *page,
-				   size_t size)
+				   void *cpu_addr, size_t size)
 {
-	__dma_remap(page, size, pgprot_kernel);
+	if (!PageHighMem(page))
+		__dma_remap(page, size, pgprot_kernel);
+	else
+		__dma_free_remap(cpu_addr, size);
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
@@ -645,7 +674,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	else if (!IS_ENABLED(CONFIG_CMA))
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
 	else
-		addr = __alloc_from_contiguous(dev, size, prot, &page);
+		addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
 
 	if (addr)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
@@ -739,7 +768,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		 * Non-atomic allocations cannot be freed with IRQs disabled
 		 */
 		WARN_ON(irqs_disabled());
-		__free_from_contiguous(dev, page, size);
+		__free_from_contiguous(dev, page, cpu_addr, size);
 	}
 }
 
-- 
1.7.9.5
