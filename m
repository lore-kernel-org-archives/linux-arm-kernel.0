From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 07 Feb 2013 15:59:24 +0100
Subject: [PATCHv3 1/2] ARM: dma-mapping: add support for CMA regions placed in
 highmem zone
In-Reply-To: <1359984182-6307-1-git-send-email-m.szyprowski@samsung.com>
References: <1359984182-6307-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1360249164-1898-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing pieces to correctly support memory pages served
from CMA regions placed in high memory zones. Please note that the default
global CMA area is still put into lowmem and is limited by optional
architecture specific DMA zone. One can however put device specific CMA
regions in high memory zone to reduce lowmem usage.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Michal Nazarewicz <mina86@mina86.com>
---
Changle log: 
v3: fixed build break for non-MMU builds (thanks to Thierry Reding!)

v2: restructured code and made all himem checks positive 
    ('if (PageHighMem(page))' instead of 'if (!PageHighMem(page))')
---
 arch/arm/mm/dma-mapping.c |   57 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index de93ecd..5f79361 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -186,13 +186,24 @@ static u64 get_coherent_dma_mask(struct device *dev)
 
 static void __dma_clear_buffer(struct page *page, size_t size)
 {
-	void *ptr;
 	/*
 	 * Ensure that the allocated pages are zeroed, and that any data
 	 * lurking in the kernel direct-mapped region is invalidated.
 	 */
-	ptr = page_address(page);
-	if (ptr) {
+	if (PageHighMem(page)) {
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
+	} else {
+		void *ptr = page_address(page);
 		memset(ptr, 0, size);
 		dmac_flush_range(ptr, ptr + size);
 		outer_flush_range(__pa(ptr), __pa(ptr) + size);
@@ -243,7 +254,8 @@ static void __dma_free_buffer(struct page *page, size_t size)
 #endif
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
-				     pgprot_t prot, struct page **ret_page);
+				     pgprot_t prot, struct page **ret_page,
+				     const void *caller);
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
@@ -346,10 +358,11 @@ static int __init atomic_pool_init(void)
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
 
@@ -542,27 +555,41 @@ static int __free_from_pool(void *start, size_t size)
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
 
+	if (PageHighMem(page)) {
+		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
+		if (!ptr) {
+			dma_release_from_contiguous(dev, page, count);
+			return NULL;
+		}
+	} else {
+		__dma_remap(page, size, prot);
+		ptr = page_address(page);
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
+	if (PageHighMem(page))
+		__dma_free_remap(cpu_addr, size);
+	else
+		__dma_remap(page, size, pgprot_kernel);
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
@@ -583,9 +610,9 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 #define __get_dma_pgprot(attrs, prot)	__pgprot(0)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret)		NULL
+#define __alloc_from_contiguous(dev, size, prot, ret, c)	NULL
 #define __free_from_pool(cpu_addr, size)			0
-#define __free_from_contiguous(dev, page, size)			do { } while (0)
+#define __free_from_contiguous(dev, page, cpu_addr, size)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
 
 #endif	/* CONFIG_MMU */
@@ -645,7 +672,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	else if (!IS_ENABLED(CONFIG_CMA))
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
 	else
-		addr = __alloc_from_contiguous(dev, size, prot, &page);
+		addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
 
 	if (addr)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
@@ -739,7 +766,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		 * Non-atomic allocations cannot be freed with IRQs disabled
 		 */
 		WARN_ON(irqs_disabled());
-		__free_from_contiguous(dev, page, size);
+		__free_from_contiguous(dev, page, cpu_addr, size);
 	}
 }
 
-- 
1.7.9.5
