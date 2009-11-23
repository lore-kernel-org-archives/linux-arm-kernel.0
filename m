From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 13:38:41 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
Message-ID: <E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
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
Tested-By: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/include/asm/dma-mapping.h |   32 ++++++++--
 arch/arm/mm/dma-mapping.c          |  115 +++++++++++++++++++-----------------
 2 files changed, 86 insertions(+), 61 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index e850f5c..ef9a11d 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -60,9 +60,8 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
  * Private support functions: these are not part of the API and are
  * liable to change.  Drivers must not use these.
  */
-extern void dma_cache_maint(const void *kaddr, size_t size, int rw);
-extern void dma_cache_maint_page(struct page *page, unsigned long offset,
-				 size_t size, int rw);
+extern void __dma_cache_maint_page(struct page *page, unsigned long offset,
+				   size_t size, int map);
 
 /*
  * The DMA API is built upon the notion of "buffer ownership".  A buffer
@@ -70,33 +69,52 @@ extern void dma_cache_maint_page(struct page *page, unsigned long offset,
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
 static inline void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
 	enum dma_data_direction dir)
 {
+	extern void ___dma_single_cpu_to_dev(const void *, size_t,
+		enum dma_data_direction);
+
 	if (!arch_is_coherent())
-		dma_cache_maint(kaddr, size, dir);
+		___dma_single_cpu_to_dev(kaddr, size, dir);
 }
 
 static inline void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
 	enum dma_data_direction dir)
 {
-	/* nothing to do */
+	extern void ___dma_single_dev_to_cpu(const void *, size_t,
+		enum dma_data_direction);
+
+	if (!arch_is_coherent())
+		___dma_single_dev_to_cpu(kaddr, size, dir);
 }
 
 static inline void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
+	extern void ___dma_page_cpu_to_dev(struct page *, unsigned long,
+		size_t, enum dma_data_direction);
+
 	if (!arch_is_coherent())
-		dma_cache_maint_page(page, off, size, dir);
+		___dma_page_cpu_to_dev(page, off, size, dir);
 }
 
 static inline void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
-	/* nothing to do */
+	extern void ___dma_page_dev_to_cpu(struct page *, unsigned long,
+		size_t, enum dma_data_direction);
+
+	if (!arch_is_coherent())
+		___dma_page_dev_to_cpu(page, off, size, dir);
 }
 
 /*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5bd2e0d..80a4a57 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -539,78 +539,58 @@ core_initcall(consistent_init);
  * platforms with CONFIG_DMABOUNCE.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
-void dma_cache_maint(const void *start, size_t size, int direction)
+void ___dma_single_cpu_to_dev(const void *kaddr, size_t size,
+	enum dma_data_direction dir)
 {
-	void (*inner_op)(const void *, const void *);
-	void (*outer_op)(unsigned long, unsigned long);
-
-	BUG_ON(!virt_addr_valid(start) || !virt_addr_valid(start + size - 1));
-
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
-		outer_op = outer_inv_range;
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		inner_op = dmac_clean_range;
-		outer_op = outer_clean_range;
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
-		outer_op = outer_flush_range;
-		break;
-	default:
-		BUG();
+	unsigned long paddr;
+
+	BUG_ON(!virt_addr_valid(kaddr) || !virt_addr_valid(kaddr + size - 1));
+
+	paddr = __pa(kaddr);
+	if (dir == DMA_FROM_DEVICE) {
+		outer_inv_range(paddr, paddr + size);
+		dmac_inv_range(kaddr, kaddr + size);
+	} else {
+		dmac_clean_range(kaddr, kaddr + size);
+		outer_clean_range(paddr, paddr + size);
 	}
+}
+EXPORT_SYMBOL(___dma_single_cpu_to_dev);
 
-	inner_op(start, start + size);
-	outer_op(__pa(start), __pa(start) + size);
+void ___dma_single_dev_to_cpu(const void *kaddr, size_t size,
+	enum dma_data_direction dir)
+{
+	BUG_ON(!virt_addr_valid(kaddr) || !virt_addr_valid(kaddr + size - 1));
+
+	/* don't bother invalidating if DMA to device */
+	if (dir != DMA_TO_DEVICE) {
+		unsigned long paddr = __pa(kaddr);
+		outer_inv_range(paddr, paddr + size);
+		dmac_inv_range(kaddr, kaddr + size);
+	}
 }
-EXPORT_SYMBOL(dma_cache_maint);
+EXPORT_SYMBOL(___dma_single_dev_to_cpu);
 
 static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
-				       size_t size, int direction)
+		       size_t size, void (*op)(const void *, const void *))
 {
 	void *vaddr;
-	unsigned long paddr;
-	void (*inner_op)(const void *, const void *);
-	void (*outer_op)(unsigned long, unsigned long);
-
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
-		outer_op = outer_inv_range;
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		inner_op = dmac_clean_range;
-		outer_op = outer_clean_range;
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
-		outer_op = outer_flush_range;
-		break;
-	default:
-		BUG();
-	}
 
 	if (!PageHighMem(page)) {
 		vaddr = page_address(page) + offset;
-		inner_op(vaddr, vaddr + size);
+		op(vaddr, vaddr + size);
 	} else {
 		vaddr = kmap_high_get(page);
 		if (vaddr) {
 			vaddr += offset;
-			inner_op(vaddr, vaddr + size);
+			op(vaddr, vaddr + size);
 			kunmap_high(page);
 		}
 	}
-
-	paddr = page_to_phys(page) + offset;
-	outer_op(paddr, paddr + size);
 }
 
-void dma_cache_maint_page(struct page *page, unsigned long offset,
-			  size_t size, int dir)
+void __dma_cache_maint_page(struct page *page, unsigned long offset,
+	size_t size, void (*op)(const void *, const void *))
 {
 	/*
 	 * A single sg entry may refer to multiple physically contiguous
@@ -628,13 +608,40 @@ void dma_cache_maint_page(struct page *page, unsigned long offset,
 			}
 			len = PAGE_SIZE - offset;
 		}
-		dma_cache_maint_contiguous(page, offset, len, dir);
+		dma_cache_maint_contiguous(page, offset, len, op);
 		offset = 0;
 		page++;
 		left -= len;
 	} while (left);
 }
-EXPORT_SYMBOL(dma_cache_maint_page);
+
+void ___dma_page_cpu_to_dev(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir)
+{
+	unsigned long paddr = page_to_phys(page) + offset;
+
+	if (dir == DMA_FROM_DEVICE) {
+		outer_inv_range(paddr, paddr + size);
+		__dma_cache_maint_page(page, off, size, dmac_inv_range);
+	} else {
+		__dma_cache_maint_page(page, off, size, dmac_clean_range);
+		outer_clean_range(paddr, paddr + size);
+	}
+}
+EXPORT_SYMBOL(___dma_page_cpu_to_dev);
+
+void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir)
+{
+	unsigned long paddr = page_to_phys(page) + offset;
+
+	/* don't bother invalidating if DMA to device */
+	if (dir != DMA_TO_DEVICE) {
+		outer_inv_range(paddr, paddr + size);
+		__dma_cache_maint_page(page, off, size, dmac_inv_range);
+	}
+}
+EXPORT_SYMBOL(___dma_page_dev_to_cpu);
 
 /**
  * dma_map_sg - map a set of SG buffers for streaming mode DMA
-- 
1.6.2.5
