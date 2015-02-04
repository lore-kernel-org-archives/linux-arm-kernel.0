From: carlo@caione.org (Carlo Caione)
Date: Wed,  4 Feb 2015 10:23:20 +0100
Subject: [PATCH v2 2/2] arm/dma-mapping: Respect NO_KERNEL_MAPPING when we
 don't have an IOMMU
In-Reply-To: <1423041800-27859-1-git-send-email-carlo@caione.org>
References: <1423041800-27859-1-git-send-email-carlo@caione.org>
Message-ID: <1423041800-27859-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jasper St. Pierre" <jstpierre@mecheye.net>

Even without an iommu, NO_KERNEL_MAPPING is still convenient to save on
kernel address space in places where we don't need a kernel mapping.
Implement support for it in the two places where we're creating an
expensive mapping.

__alloc_from_pool uses an internal pool from which we already have
virtual addresses, so it's not relevant, and __alloc_simple_buffer uses
alloc_pages, which will always return a lowmem page, which is already
mapped into kernel space, so we can't prevent a mapping for it in that
case.

Signed-off-by: Jasper St. Pierre <jstpierre@mecheye.net>
Signed-off-by: Carlo Caione <carlo@caione.org>
Reviewed-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Daniel Drake <dsd@endlessm.com>
---
 arch/arm/mm/dma-mapping.c | 67 +++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index a673c7f..d767bba 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -289,11 +289,11 @@ static void __dma_free_buffer(struct page *page, size_t size)
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-				     const void *caller);
+				     const void *caller, bool want_vaddr);
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
-				 const void *caller);
+				 const void *caller, bool want_vaddr);
 
 static void *
 __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
@@ -357,10 +357,10 @@ static int __init atomic_pool_init(void)
 
 	if (dev_get_cma_area(NULL))
 		ptr = __alloc_from_contiguous(NULL, atomic_pool_size, prot,
-					      &page, atomic_pool_init);
+					      &page, atomic_pool_init, true);
 	else
 		ptr = __alloc_remap_buffer(NULL, atomic_pool_size, gfp, prot,
-					   &page, atomic_pool_init);
+					   &page, atomic_pool_init, true);
 	if (ptr) {
 		int ret;
 
@@ -467,13 +467,15 @@ static void __dma_remap(struct page *page, size_t size, pgprot_t prot)
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
-				 const void *caller)
+				 const void *caller, bool want_vaddr)
 {
 	struct page *page;
-	void *ptr;
+	void *ptr = NULL;
 	page = __dma_alloc_buffer(dev, size, gfp);
 	if (!page)
 		return NULL;
+	if (!want_vaddr)
+		goto out;
 
 	ptr = __dma_alloc_remap(page, size, gfp, prot, caller);
 	if (!ptr) {
@@ -481,6 +483,7 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 		return NULL;
 	}
 
+ out:
 	*ret_page = page;
 	return ptr;
 }
@@ -523,12 +526,12 @@ static int __free_from_pool(void *start, size_t size)
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-				     const void *caller)
+				     const void *caller, bool want_vaddr)
 {
 	unsigned long order = get_order(size);
 	size_t count = size >> PAGE_SHIFT;
 	struct page *page;
-	void *ptr;
+	void *ptr = NULL;
 
 	page = dma_alloc_from_contiguous(dev, count, order);
 	if (!page)
@@ -536,6 +539,9 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 
 	__dma_clear_buffer(page, size);
 
+	if (!want_vaddr)
+		goto out;
+
 	if (PageHighMem(page)) {
 		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
 		if (!ptr) {
@@ -546,17 +552,21 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 		__dma_remap(page, size, prot);
 		ptr = page_address(page);
 	}
+
+ out:
 	*ret_page = page;
 	return ptr;
 }
 
 static void __free_from_contiguous(struct device *dev, struct page *page,
-				   void *cpu_addr, size_t size)
+				   void *cpu_addr, size_t size, bool want_vaddr)
 {
-	if (PageHighMem(page))
-		__dma_free_remap(cpu_addr, size);
-	else
-		__dma_remap(page, size, PAGE_KERNEL);
+	if (want_vaddr) {
+		if (PageHighMem(page))
+			__dma_free_remap(cpu_addr, size);
+		else
+			__dma_remap(page, size, PAGE_KERNEL);
+	}
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
@@ -574,12 +584,12 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 
 #define nommu() 1
 
-#define __get_dma_pgprot(attrs, prot)	__pgprot(0)
-#define __alloc_remap_buffer(dev, size, gfp, prot, ret, c)	NULL
+#define __get_dma_pgprot(attrs, prot)				__pgprot(0)
+#define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret, c)	NULL
+#define __alloc_from_contiguous(dev, size, prot, ret, c, wv)	NULL
 #define __free_from_pool(cpu_addr, size)			0
-#define __free_from_contiguous(dev, page, cpu_addr, size)	do { } while (0)
+#define __free_from_contiguous(dev, page, cpu_addr, size, wv)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
 
 #endif	/* CONFIG_MMU */
@@ -599,11 +609,13 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			 gfp_t gfp, pgprot_t prot, bool is_coherent, const void *caller)
+			 gfp_t gfp, pgprot_t prot, bool is_coherent,
+			 struct dma_attrs *attrs, const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
 	void *addr;
+	bool want_vaddr;
 
 #ifdef CONFIG_DMA_API_DEBUG
 	u64 limit = (mask + 1) & ~mask;
@@ -631,20 +643,21 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
+	want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
 
 	if (is_coherent || nommu())
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
 	else if (!(gfp & __GFP_WAIT))
 		addr = __alloc_from_pool(size, &page);
 	else if (!dev_get_cma_area(dev))
-		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
+		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller, want_vaddr);
 	else
-		addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
+		addr = __alloc_from_contiguous(dev, size, prot, &page, caller, want_vaddr);
 
-	if (addr)
+	if (page)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
 
-	return addr;
+	return want_vaddr ? addr : page;
 }
 
 /*
@@ -661,7 +674,7 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		return memory;
 
 	return __dma_alloc(dev, size, handle, gfp, prot, false,
-			   __builtin_return_address(0));
+			   attrs, __builtin_return_address(0));
 }
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
@@ -674,7 +687,7 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 		return memory;
 
 	return __dma_alloc(dev, size, handle, gfp, prot, true,
-			   __builtin_return_address(0));
+			   attrs, __builtin_return_address(0));
 }
 
 /*
@@ -715,6 +728,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 			   bool is_coherent)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
+	bool want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
 
 	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
 		return;
@@ -726,14 +740,15 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	} else if (__free_from_pool(cpu_addr, size)) {
 		return;
 	} else if (!dev_get_cma_area(dev)) {
-		__dma_free_remap(cpu_addr, size);
+		if (want_vaddr)
+			__dma_free_remap(cpu_addr, size);
 		__dma_free_buffer(page, size);
 	} else {
 		/*
 		 * Non-atomic allocations cannot be freed with IRQs disabled
 		 */
 		WARN_ON(irqs_disabled());
-		__free_from_contiguous(dev, page, cpu_addr, size);
+		__free_from_contiguous(dev, page, cpu_addr, size, want_vaddr);
 	}
 }
 
-- 
2.2.2
