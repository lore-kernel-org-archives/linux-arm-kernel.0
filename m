From: albuer@gmail.com (albuer)
Date: Thu, 15 May 2014 15:19:28 +0800
Subject: [review]  ARM: dma-mapping: Add support DMA allocate memory without
 mapping
Message-ID: <53746A80.8070900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all:

ARM: dma-mapping: Add support DMA allocate memory without mapping

reserved DMA(CMA) regions may be large than 512MB for devices, placed it
in the highmem zone is appropriate, but according to the existing
mechanism, memory allocation with mapping will cause vmalloc area not
enough.

Now we don't do mapping if the DMA_ATTR_NO_KERNEL_MAPPING is set.

the DMA(CMA) region used for VPU/VOP/Camera/RGA etc, my screen
resolution: 2560*1600, we need CMA memory large than 768MB.

-------------- next part --------------
commit 89e0808306853052a685125a58b6e2f074d16fb6
Author: CMY <cmy@rock-chips.com>
Date:   Thu May 15 14:59:41 2014 +0800

    ARM: dma-mapping: Add support DMA allocate memory without mapping
    
    reserved DMA(CMA) regions may be large than 512MB for devices, placed it
    in the highmem zone is appropriate, but according to the existing
    mechanism, memory allocation with mapping will cause vmalloc area not
    enough.
    
    Now we don't do mapping if the DMA_ATTR_NO_KERNEL_MAPPING is set.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b00be1..7e04452 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -286,13 +286,15 @@ static void __dma_free_buffer(struct page *page, size_t size)
 #ifdef CONFIG_MMU
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
-				     pgprot_t prot, struct page **ret_page,
+				     struct dma_attrs *attrs, struct page **ret_page,
 				     const void *caller);
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
-				 pgprot_t prot, struct page **ret_page,
+				 struct dma_attrs *attrs, struct page **ret_page,
 				 const void *caller);
 
+static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot);
+
 static void *
 __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
 	const void *caller)
@@ -373,7 +375,6 @@ void __init init_dma_coherent_pool_size(unsigned long size)
 static int __init atomic_pool_init(void)
 {
 	struct dma_pool *pool = &atomic_pool;
-	pgprot_t prot = pgprot_dmacoherent(PAGE_KERNEL);
 	gfp_t gfp = GFP_KERNEL | GFP_DMA;
 	unsigned long nr_pages = pool->size >> PAGE_SHIFT;
 	unsigned long *bitmap;
@@ -391,10 +392,10 @@ static int __init atomic_pool_init(void)
 		goto no_pages;
 
 	if (IS_ENABLED(CONFIG_DMA_CMA))
-		ptr = __alloc_from_contiguous(NULL, pool->size, prot, &page,
+		ptr = __alloc_from_contiguous(NULL, pool->size, NULL, &page,
 					      atomic_pool_init);
 	else
-		ptr = __alloc_remap_buffer(NULL, pool->size, gfp, prot, &page,
+		ptr = __alloc_remap_buffer(NULL, pool->size, gfp, NULL, &page,
 					   atomic_pool_init);
 	if (ptr) {
 		int i;
@@ -491,15 +492,19 @@ static void __dma_remap(struct page *page, size_t size, pgprot_t prot)
 }
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
-				 pgprot_t prot, struct page **ret_page,
+				 struct dma_attrs *attrs, struct page **ret_page,
 				 const void *caller)
 {
 	struct page *page;
 	void *ptr;
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	page = __dma_alloc_buffer(dev, size, gfp);
 	if (!page)
 		return NULL;
 
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+		return (*ret_page=page);
+
 	ptr = __dma_alloc_remap(page, size, gfp, prot, caller);
 	if (!ptr) {
 		__dma_free_buffer(page, size);
@@ -587,13 +592,14 @@ static int __free_from_pool(void *start, size_t size)
 }
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
-				     pgprot_t prot, struct page **ret_page,
+				     struct dma_attrs *attrs, struct page **ret_page,
 				     const void *caller)
 {
 	unsigned long order = get_order(size);
 	size_t count = size >> PAGE_SHIFT;
 	struct page *page;
 	void *ptr;
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 
 	page = dma_alloc_from_contiguous(dev, count, order);
 	if (!page)
@@ -601,6 +607,9 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 
 	__dma_clear_buffer(page, size);
 
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+		return (*ret_page=page);
+
 	if (PageHighMem(page)) {
 		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
 		if (!ptr) {
@@ -616,12 +625,14 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 }
 
 static void __free_from_contiguous(struct device *dev, struct page *page,
-				   void *cpu_addr, size_t size)
+				   void *cpu_addr, size_t size, struct dma_attrs *attrs)
 {
-	if (PageHighMem(page))
-		__dma_free_remap(cpu_addr, size);
-	else
-		__dma_remap(page, size, PAGE_KERNEL);
+	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+		if (PageHighMem(page))
+			__dma_free_remap(cpu_addr, size);
+		else
+			__dma_remap(page, size, PAGE_KERNEL);
+	}
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
@@ -640,11 +651,11 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 #define nommu() 1
 
 #define __get_dma_pgprot(attrs, prot)	__pgprot(0)
-#define __alloc_remap_buffer(dev, size, gfp, prot, ret, c)	NULL
+#define __alloc_remap_buffer(dev, size, gfp, attrs, ret, c)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret, c)	NULL
+#define __alloc_from_contiguous(dev, size, attrs, ret, c)	NULL
 #define __free_from_pool(cpu_addr, size)			0
-#define __free_from_contiguous(dev, page, cpu_addr, size)	do { } while (0)
+#define __free_from_contiguous(dev, page, cpu_addr, size, attrs)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
 
 #endif	/* CONFIG_MMU */
@@ -664,7 +675,8 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			 gfp_t gfp, pgprot_t prot, bool is_coherent, const void *caller)
+			 gfp_t gfp, struct dma_attrs *attrs, bool is_coherent,
+			 const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
@@ -702,9 +714,9 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	else if (!(gfp & __GFP_WAIT))
 		addr = __alloc_from_pool(size, &page);
 	else if (!IS_ENABLED(CONFIG_DMA_CMA))
-		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
+		addr = __alloc_remap_buffer(dev, size, gfp, attrs, &page, caller);
 	else
-		addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
+		addr = __alloc_from_contiguous(dev, size, attrs, &page, caller);
 
 	if (addr)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
@@ -715,30 +727,30 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 /*
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
+ * If the DMA_ATTR_NO_KERNEL_MAPPING is set within attrs, return both
+ * the 'struct page*' and bus address.
  */
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		    gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	return __dma_alloc(dev, size, handle, gfp, prot, false,
+	return __dma_alloc(dev, size, handle, gfp, attrs, false,
 			   __builtin_return_address(0));
 }
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	return __dma_alloc(dev, size, handle, gfp, prot, true,
+	return __dma_alloc(dev, size, handle, gfp, attrs, true,
 			   __builtin_return_address(0));
 }
 
@@ -791,14 +803,16 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	} else if (__free_from_pool(cpu_addr, size)) {
 		return;
 	} else if (!IS_ENABLED(CONFIG_DMA_CMA)) {
-		__dma_free_remap(cpu_addr, size);
+		if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+			__dma_free_remap(cpu_addr, size);
+
 		__dma_free_buffer(page, size);
 	} else {
 		/*
 		 * Non-atomic allocations cannot be freed with IRQs disabled
 		 */
 		WARN_ON(irqs_disabled());
-		__free_from_contiguous(dev, page, cpu_addr, size);
+		__free_from_contiguous(dev, page, cpu_addr, size, attrs);
 	}
 }
 
