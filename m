From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Nov 2009 18:06:00 +0000
Subject: [PATCH 6/7] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091120182539.GG16920@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
Message-ID: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than handing all cache maintainence before DMA begins, we
also need to handle cache maintainence upon completion when we
have CPUs which prefetch speculatively.

This renames the dma_cache_maint*() functions, and changes their
parameters to indicate whether we are mapping a DMA buffer.  We
always clean DMA buffers when we map them, but avoid invalidating
them if we are DMA'ing to the device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/dma-mapping.h |   25 +++++++++++++-----
 arch/arm/mm/dma-mapping.c          |   48 +++++++++++------------------------
 2 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index e850f5c..5a86105 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -60,9 +60,9 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
  * Private support functions: these are not part of the API and are
  * liable to change.  Drivers must not use these.
  */
-extern void dma_cache_maint(const void *kaddr, size_t size, int rw);
-extern void dma_cache_maint_page(struct page *page, unsigned long offset,
-				 size_t size, int rw);
+extern void __dma_cache_maint(const void *kaddr, size_t size, int map);
+extern void __dma_cache_maint_page(struct page *page, unsigned long offset,
+				   size_t size, int map);
 
 /*
  * The DMA API is built upon the notion of "buffer ownership".  A buffer
@@ -70,6 +70,11 @@ extern void dma_cache_maint_page(struct page *page, unsigned long offset,
  * by it) or exclusively owned by the DMA device.  These helper functions
  * represent the transitions between these two ownership states.
  *
+ * Note, however, that on later ARMs, this notion does not work due to
+ * speculative prefetches.  We model our approach on the assumption that
+ * the CPU does do speculative prefetches, which means we clean caches
+ * before transfers and delay cache invalidation until transfer completion.
+ *
  * As above, these are private support functions and not part of the API.
  * Drivers must not use these.
  */
@@ -77,26 +82,32 @@ static inline void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
 	enum dma_data_direction dir)
 {
 	if (!arch_is_coherent())
-		dma_cache_maint(kaddr, size, dir);
+		__dma_cache_maint(kaddr, size, 1);
 }
 
 static inline void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
 	enum dma_data_direction dir)
 {
-	/* nothing to do */
+	if (!arch_is_coherent())
+		/* don't bother invalidating if DMA to device */
+		if (dir != DMA_TO_DEVICE)
+			__dma_cache_maint(kaddr, size, 0);
 }
 
 static inline void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
 	if (!arch_is_coherent())
-		dma_cache_maint_page(page, off, size, dir);
+		__dma_cache_maint_page(page, off, size, 1);
 }
 
 static inline void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
-	/* nothing to do */
+	if (!arch_is_coherent())
+		/* don't bother invalidating if DMA to device */
+		if (dir != DMA_TO_DEVICE)
+			__dma_cache_maint_page(page, off, size, 0);
 }
 
 /*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5bd2e0d..4193904 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -539,58 +539,40 @@ core_initcall(consistent_init);
  * platforms with CONFIG_DMABOUNCE.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
-void dma_cache_maint(const void *start, size_t size, int direction)
+void __dma_cache_maint(const void *start, size_t size, int map)
 {
 	void (*inner_op)(const void *, const void *);
 	void (*outer_op)(unsigned long, unsigned long);
 
 	BUG_ON(!virt_addr_valid(start) || !virt_addr_valid(start + size - 1));
 
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
-		outer_op = outer_inv_range;
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
+	if (map) {		/* writeback only */
 		inner_op = dmac_clean_range;
 		outer_op = outer_clean_range;
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
-		outer_op = outer_flush_range;
-		break;
-	default:
-		BUG();
+	} else {		/* invalidate only */
+		inner_op = dmac_inv_range;
+		outer_op = outer_inv_range;
 	}
 
 	inner_op(start, start + size);
 	outer_op(__pa(start), __pa(start) + size);
 }
-EXPORT_SYMBOL(dma_cache_maint);
+EXPORT_SYMBOL(__dma_cache_maint);
 
 static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
-				       size_t size, int direction)
+				       size_t size, int map)
 {
 	void *vaddr;
 	unsigned long paddr;
 	void (*inner_op)(const void *, const void *);
 	void (*outer_op)(unsigned long, unsigned long);
 
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
-		outer_op = outer_inv_range;
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
+	if (map) {		/* writeback only */
 		inner_op = dmac_clean_range;
 		outer_op = outer_clean_range;
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
-		outer_op = outer_flush_range;
-		break;
-	default:
-		BUG();
+	} else {		/* invalidate only */
+		inner_op = dmac_inv_range;
+		outer_op = outer_inv_range;
 	}
 
 	if (!PageHighMem(page)) {
@@ -609,8 +591,8 @@ static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
 	outer_op(paddr, paddr + size);
 }
 
-void dma_cache_maint_page(struct page *page, unsigned long offset,
-			  size_t size, int dir)
+void __dma_cache_maint_page(struct page *page, unsigned long offset,
+	size_t size, int map)
 {
 	/*
 	 * A single sg entry may refer to multiple physically contiguous
@@ -628,13 +610,13 @@ void dma_cache_maint_page(struct page *page, unsigned long offset,
 			}
 			len = PAGE_SIZE - offset;
 		}
-		dma_cache_maint_contiguous(page, offset, len, dir);
+		dma_cache_maint_contiguous(page, offset, len, map);
 		offset = 0;
 		page++;
 		left -= len;
 	} while (left);
 }
-EXPORT_SYMBOL(dma_cache_maint_page);
+EXPORT_SYMBOL(__dma_cache_maint_page);
 
 /**
  * dma_map_sg - map a set of SG buffers for streaming mode DMA
-- 
1.6.2.5
