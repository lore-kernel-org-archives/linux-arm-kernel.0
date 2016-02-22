From: rabin.vincent@axis.com (Rabin Vincent)
Date: Mon, 22 Feb 2016 15:41:30 +0100
Subject: [PATCHv2 2/2] ARM: dma-mapping: refactor to fix coherent+cma+gfp=0
In-Reply-To: <1456152090-18630-1-git-send-email-rabin.vincent@axis.com>
References: <1456152090-18630-1-git-send-email-rabin.vincent@axis.com>
Message-ID: <1456152090-18630-2-git-send-email-rabin.vincent@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given a device which uses arm_coherent_dma_ops and on which
dev_get_cma_area(dev) returns non-NULL, the following usage of the DMA
API with gfp=0 results in memory corruption and a memory leak.

 p = dma_alloc_coherent(dev, sz, &dma, 0);
 if (p)
 	dma_free_coherent(dev, sz, p, dma);

The memory leak is because the alloc allocates using
__alloc_simple_buffer() but the free attempts
dma_release_from_contiguous() which does not do free anything since the
page is not in the CMA area.

The memory corruption is because the free calls __dma_remap() on a page
which is backed by only first level page tables.  The
apply_to_page_range() + __dma_update_pte() loop ends up interpreting the
section mapping as an addresses to a second level page table and writing
the new PTE to memory which is not used by page tables.

We don't have access to the GFP flags used for allocation in the free
function.  Fix this by adding allocator backends and using this
information in the free function so that we always use the correct
release routine.

Fixes: 21caf3a7 ("ARM: 8398/1: arm DMA: Fix allocation from CMA for coherent DMA")
Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 arch/arm/mm/dma-mapping.c | 165 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 128 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d8c6efc..122c9f9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -42,9 +42,33 @@
 #include "dma.h"
 #include "mm.h"
 
+struct arm_dma_alloc_args {
+	struct device *dev;
+	size_t size;
+	gfp_t gfp;
+	pgprot_t prot;
+	const void *caller;
+	bool want_vaddr;
+};
+
+struct arm_dma_free_args {
+	struct device *dev;
+	size_t size;
+	void *cpu_addr;
+	struct page *page;
+	bool want_vaddr;
+};
+
+struct arm_dma_allocator {
+	void *(*alloc)(struct arm_dma_alloc_args *args,
+		       struct page **ret_page);
+	void (*free)(struct arm_dma_free_args *args);
+};
+
 struct arm_dma_buffer {
 	struct list_head list;
 	void *virt;
+	struct arm_dma_allocator *allocator;
 };
 
 static LIST_HEAD(arm_dma_bufs);
@@ -617,7 +641,7 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
 #define __alloc_from_contiguous(dev, size, prot, ret, c, wv)	NULL
-#define __free_from_pool(cpu_addr, size)			0
+#define __free_from_pool(cpu_addr, size)			do { } while (0)
 #define __free_from_contiguous(dev, page, cpu_addr, size, wv)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
 
@@ -635,7 +659,78 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 	return page_address(page);
 }
 
+static void *simple_allocator_alloc(struct arm_dma_alloc_args *args,
+				    struct page **ret_page)
+{
+	return __alloc_simple_buffer(args->dev, args->size, args->gfp,
+				     ret_page);
+}
+
+static void simple_allocator_free(struct arm_dma_free_args *args)
+{
+	__dma_free_buffer(args->page, args->size);
+}
+
+static struct arm_dma_allocator simple_allocator = {
+	.alloc = simple_allocator_alloc,
+	.free = simple_allocator_free,
+};
+
+static void *cma_allocator_alloc(struct arm_dma_alloc_args *args,
+				 struct page **ret_page)
+{
+	return __alloc_from_contiguous(args->dev, args->size, args->prot,
+				       ret_page, args->caller,
+				       args->want_vaddr);
+}
+
+static void cma_allocator_free(struct arm_dma_free_args *args)
+{
+	__free_from_contiguous(args->dev, args->page, args->cpu_addr,
+			       args->size, args->want_vaddr);
+}
+
+static struct arm_dma_allocator cma_allocator = {
+	.alloc = cma_allocator_alloc,
+	.free = cma_allocator_free,
+};
 
+static void *pool_allocator_alloc(struct arm_dma_alloc_args *args,
+				  struct page **ret_page)
+{
+	return __alloc_from_pool(args->size, ret_page);
+}
+
+static void pool_allocator_free(struct arm_dma_free_args *args)
+{
+	__free_from_pool(args->cpu_addr, args->size);
+}
+
+static struct arm_dma_allocator pool_allocator = {
+	.alloc = pool_allocator_alloc,
+	.free = pool_allocator_free,
+};
+
+static void *remap_allocator_alloc(struct arm_dma_alloc_args *args,
+				   struct page **ret_page)
+{
+	return __alloc_remap_buffer(args->dev, args->size, args->gfp,
+				    args->prot, ret_page, args->caller,
+				    args->want_vaddr);
+}
+
+static void remap_allocator_free(struct arm_dma_free_args *args)
+{
+	if (args->want_vaddr)
+		__dma_free_remap(args->cpu_addr, args->size);
+
+	__dma_free_buffer(args->page, args->size);
+}
+
+static struct arm_dma_allocator remap_allocator = {
+	.alloc = remap_allocator_alloc,
+	.free = remap_allocator_free,
+};
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent,
@@ -644,8 +739,16 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
 	void *addr;
-	bool want_vaddr;
+	bool allowblock, cma;
 	struct arm_dma_buffer *buf;
+	struct arm_dma_alloc_args args = {
+		.dev = dev,
+		.size = PAGE_ALIGN(size),
+		.gfp = gfp,
+		.prot = prot,
+		.caller = caller,
+		.want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs),
+	};
 
 #ifdef CONFIG_DMA_API_DEBUG
 	u64 limit = (mask + 1) & ~mask;
@@ -674,29 +777,28 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	 * platform; see CONFIG_HUGETLBFS.
 	 */
 	gfp &= ~(__GFP_COMP);
+	args.gfp = gfp;
 
 	*handle = DMA_ERROR_CODE;
-	size = PAGE_ALIGN(size);
-	want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
-
-	if (nommu())
-		addr = __alloc_simple_buffer(dev, size, gfp, &page);
-	else if (dev_get_cma_area(dev) && (gfp & __GFP_DIRECT_RECLAIM))
-		addr = __alloc_from_contiguous(dev, size, prot, &page,
-					       caller, want_vaddr);
-	else if (is_coherent)
-		addr = __alloc_simple_buffer(dev, size, gfp, &page);
-	else if (!gfpflags_allow_blocking(gfp))
-		addr = __alloc_from_pool(size, &page);
+	allowblock = gfpflags_allow_blocking(gfp);
+	cma = allowblock ? dev_get_cma_area(dev) : false;
+
+	if (cma)
+		buf->allocator = &cma_allocator;
+	else if (nommu() || is_coherent)
+		buf->allocator = &simple_allocator;
+	else if (allowblock)
+		buf->allocator = &remap_allocator;
 	else
-		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page,
-					    caller, want_vaddr);
+		buf->allocator = &pool_allocator;
+
+	addr = buf->allocator->alloc(&args, &page);
 
 	if (page) {
 		unsigned long flags;
 
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
-		buf->virt = want_vaddr ? addr : page;
+		buf->virt = args.want_vaddr ? addr : page;
 
 		spin_lock_irqsave(&arm_dma_bufs_lock, flags);
 		list_add(&buf->list, &arm_dma_bufs);
@@ -705,7 +807,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		kfree(buf);
 	}
 
-	return want_vaddr ? addr : page;
+	return args.want_vaddr ? addr : page;
 }
 
 /*
@@ -781,31 +883,20 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 			   bool is_coherent)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
-	bool want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
 	struct arm_dma_buffer *buf;
+	struct arm_dma_free_args args = {
+		.dev = dev,
+		.size = PAGE_ALIGN(size),
+		.cpu_addr = cpu_addr,
+		.page = page,
+		.want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs),
+	};
 
 	buf = arm_dma_buffer_find(cpu_addr);
 	if (WARN(!buf, "Freeing invalid buffer %p\n", cpu_addr))
 		return;
 
-	size = PAGE_ALIGN(size);
-
-	if (nommu()) {
-		__dma_free_buffer(page, size);
-	} else if (!is_coherent && __free_from_pool(cpu_addr, size)) {
-		return;
-	} else if (!dev_get_cma_area(dev)) {
-		if (want_vaddr && !is_coherent)
-			__dma_free_remap(cpu_addr, size);
-		__dma_free_buffer(page, size);
-	} else {
-		/*
-		 * Non-atomic allocations cannot be freed with IRQs disabled
-		 */
-		WARN_ON(irqs_disabled());
-		__free_from_contiguous(dev, page, cpu_addr, size, want_vaddr);
-	}
-
+	buf->allocator->free(&args);
 	kfree(buf);
 }
 
-- 
2.7.0
