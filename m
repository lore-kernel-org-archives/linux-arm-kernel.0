From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 17 Apr 2014 13:02:21 -0700
Subject: [RFC][PATCH] arm64: Add atomic pool for dma mapping
Message-ID: <1397764941-1351-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neither CMA nor noncoherent allocations support atomic allocations.
Add a dedicated atomic pool to support this.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c | 186 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 184 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 0ba347e..c67a3ff 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -38,6 +38,110 @@ static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
 	return prot;
 }
 
+#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
+
+struct dma_pool {
+	size_t size;
+	spinlock_t lock;
+	void *coherent_vaddr;
+	void *noncoherent_vaddr;
+	unsigned long *bitmap;
+	unsigned long nr_pages;
+	struct page **pages;
+};
+
+static struct dma_pool atomic_pool = {
+	.size = DEFAULT_DMA_COHERENT_POOL_SIZE,
+};
+
+static int __init early_coherent_pool(char *p)
+{
+	atomic_pool.size = memparse(p, &p);
+	return 0;
+}
+early_param("coherent_pool", early_coherent_pool);
+
+static void *__alloc_from_pool(size_t size, struct page **ret_page,
+					bool coherent)
+{
+	struct dma_pool *pool = &atomic_pool;
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned int pageno;
+	unsigned long flags;
+	void *ptr = NULL;
+	unsigned long align_mask;
+	void *pool_start = coherent ? pool->coherent_vaddr :
+				      pool->noncoherent_vaddr;
+
+	if (!pool->coherent_vaddr || !pool->noncoherent_vaddr) {
+		WARN(1, "coherent pool not initialised!\n");
+		return NULL;
+	}
+
+	/*
+	 * Align the region allocation - allocations from pool are rather
+	 * small, so align them to their order in pages, minimum is a page
+	 * size. This helps reduce fragmentation of the DMA space.
+	 */
+	align_mask = (1 << get_order(size)) - 1;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	pageno = bitmap_find_next_zero_area(pool->bitmap, pool->nr_pages,
+					    0, count, align_mask);
+	if (pageno < pool->nr_pages) {
+		bitmap_set(pool->bitmap, pageno, count);
+		ptr = pool_start + PAGE_SIZE * pageno;
+		*ret_page = pool->pages[pageno];
+	} else {
+		pr_err_once("ERROR: %u KiB atomic DMA coherent pool is too small!\n"
+			    "Please increase it with coherent_pool= kernel parameter!\n",
+				(unsigned)pool->size / 1024);
+	}
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	return ptr;
+}
+
+static bool __in_atomic_pool(void *start, size_t size, void *pool_start)
+{
+	struct dma_pool *pool = &atomic_pool;
+	void *end = start + size;
+	void *pool_end = pool_start + pool->size;
+
+	if (start < pool_start || start >= pool_end)
+		return false;
+
+	if (end <= pool_end)
+		return true;
+
+	WARN(1, "Wrong coherent size(%p-%p) from atomic pool(%p-%p)\n",
+		start, end - 1, pool_start, pool_end - 1);
+
+	return false;
+}
+
+static int __free_from_pool(void *start, size_t size, bool coherent)
+{
+	struct dma_pool *pool = &atomic_pool;
+	unsigned long pageno, count;
+	unsigned long flags;
+	void *pool_start = coherent ? pool->coherent_vaddr :
+				      pool->noncoherent_vaddr;
+
+	if (!__in_atomic_pool(start, size, pool_start))
+		return 0;
+
+	pageno = (start - pool_start) >> PAGE_SHIFT;
+	count = size >> PAGE_SHIFT;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	bitmap_clear(pool->bitmap, pageno, count);
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	return 1;
+}
+
+
 static void *__dma_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  struct dma_attrs *attrs)
@@ -50,7 +154,16 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 	if (IS_ENABLED(CONFIG_ZONE_DMA) &&
 	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
 		flags |= GFP_DMA;
-	if (IS_ENABLED(CONFIG_DMA_CMA)) {
+
+	if (!(flags & __GFP_WAIT)) {
+		struct page *page = NULL;
+		void *addr = __alloc_from_pool(size, &page, true);
+
+		if (addr)
+			*dma_handle = phys_to_dma(dev, page_to_phys(page));
+
+		return addr;
+	} else if (IS_ENABLED(CONFIG_DMA_CMA)) {
 		struct page *page;
 
 		size = PAGE_ALIGN(size);
@@ -75,7 +188,9 @@ static void __dma_free_coherent(struct device *dev, size_t size,
 		return;
 	}
 
-	if (IS_ENABLED(CONFIG_DMA_CMA)) {
+	if (__free_from_pool(vaddr, size, true)) {
+		return;
+	} else if (IS_ENABLED(CONFIG_DMA_CMA)) {
 		phys_addr_t paddr = dma_to_phys(dev, dma_handle);
 
 		dma_release_from_contiguous(dev,
@@ -97,9 +212,21 @@ static void *__dma_alloc_noncoherent(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
+	if (!(flags & __GFP_WAIT)) {
+		struct page *page = NULL;
+		void *addr = __alloc_from_pool(size, &page, false);
+
+		if (addr)
+			*dma_handle = phys_to_dma(dev, page_to_phys(page));
+
+		return addr;
+
+	}
+
 	ptr = __dma_alloc_coherent(dev, size, dma_handle, flags, attrs);
 	if (!ptr)
 		goto no_mem;
+
 	map = kmalloc(sizeof(struct page *) << order, flags & ~GFP_DMA);
 	if (!map)
 		goto no_map;
@@ -132,6 +259,8 @@ static void __dma_free_noncoherent(struct device *dev, size_t size,
 {
 	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 
+	if (__free_from_pool(vaddr, size, false))
+		return;
 	vunmap(vaddr);
 	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
 }
@@ -307,6 +436,59 @@ EXPORT_SYMBOL(coherent_swiotlb_dma_ops);
 
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 
+static int __init atomic_pool_init(void)
+{
+	struct dma_pool *pool = &atomic_pool;
+	pgprot_t prot = pgprot_writecombine(pgprot_default);
+	unsigned long nr_pages = pool->size >> PAGE_SHIFT;
+	unsigned long *bitmap;
+	struct page *page;
+	struct page **pages;
+	int bitmap_size = BITS_TO_LONGS(nr_pages) * sizeof(long);
+
+
+	if (!IS_ENABLED(CONFIG_CMA))
+		return 0;
+
+	bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+	if (!bitmap)
+		goto no_bitmap;
+
+	pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		goto no_pages;
+
+	if (IS_ENABLED(CONFIG_CMA))
+		page = dma_alloc_from_contiguous(NULL, nr_pages,
+					get_order(pool->size));
+
+	if (page) {
+		int i;
+
+		for (i = 0; i < nr_pages; i++)
+			pages[i] = page + i;
+
+		spin_lock_init(&pool->lock);
+		pool->pages = pages;
+		pool->coherent_vaddr = vmap(pages, nr_pages, VM_MAP, prot);
+		pool->noncoherent_vaddr = page_address(page);
+		pool->bitmap = bitmap;
+		pool->nr_pages = nr_pages;
+		pr_info("DMA: preallocated %u KiB pool for atomic allocations\n",
+			(unsigned)pool->size / 1024);
+		return 0;
+	}
+
+	kfree(pages);
+no_pages:
+	kfree(bitmap);
+no_bitmap:
+	pr_err("DMA: failed to allocate %u KiB pool for atomic coherent allocation\n",
+		(unsigned)pool->size / 1024);
+	return -ENOMEM;
+}
+postcore_initcall(atomic_pool_init);
+
 static int __init swiotlb_late_init(void)
 {
 	size_t swiotlb_size = min(SZ_64M, MAX_ORDER_NR_PAGES << PAGE_SHIFT);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
