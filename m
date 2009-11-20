From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Nov 2009 18:05:00 +0000
Subject: [PATCH 5/7] ARM: dma-mapping: use the idea of buffer ownership
In-Reply-To: <20091120182539.GG16920@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
Message-ID: <E1NBYED-0005l4-2A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA API has the notion of buffer ownership; make it explicit in the
ARM implementation of this API.  This gives us a set of hooks to allow
us to deal with CPU cache issues arising from non-cache coherent DMA.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c        |    9 ++---
 arch/arm/include/asm/dma-mapping.h |   64 ++++++++++++++++++++++++++---------
 arch/arm/mm/dma-mapping.c          |   13 ++++---
 3 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 5a375e5..bc3e269 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -277,7 +277,7 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		 * We don't need to sync the DMA buffer since
 		 * it was allocated via the coherent allocators.
 		 */
-		dma_cache_maint(ptr, size, dir);
+		__dma_single_cpu_to_dev(ptr, size, dir);
 	}
 
 	return dma_addr;
@@ -310,15 +310,14 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 			/*
 			 * DMA buffers must have the same cache properties
 			 * as if they were really used for DMA - which means
-			 * data must be written back to RAM.  Note that
-			 * we don't use dmac_flush_range() here for the
-			 * bidirectional case because we know the cache
-			 * lines will be coherent with the data written.
+			 * data must be written back to RAM.
 			 */
 			dmac_clean_range(ptr, ptr + size);
 			outer_clean_range(__pa(ptr), __pa(ptr) + size);
 		}
 		free_safe_buffer(dev->archdata.dmabounce, buf);
+	} else {
+		__dma_single_dev_to_cpu(dma_to_virt(dev, dma_addr), size, dir);
 	}
 }
 
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a96300b..e850f5c 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -57,20 +57,49 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 #endif
 
 /*
- * DMA-consistent mapping functions.  These allocate/free a region of
- * uncached, unwrite-buffered mapped memory space for use with DMA
- * devices.  This is the "generic" version.  The PCI specific version
- * is in pci.h
- *
- * Note: Drivers should NOT use this function directly, as it will break
- * platforms with CONFIG_DMABOUNCE.
- * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
+ * Private support functions: these are not part of the API and are
+ * liable to change.  Drivers must not use these.
  */
 extern void dma_cache_maint(const void *kaddr, size_t size, int rw);
 extern void dma_cache_maint_page(struct page *page, unsigned long offset,
 				 size_t size, int rw);
 
 /*
+ * The DMA API is built upon the notion of "buffer ownership".  A buffer
+ * is either exclusively owned by the CPU (and therefore may be accessed
+ * by it) or exclusively owned by the DMA device.  These helper functions
+ * represent the transitions between these two ownership states.
+ *
+ * As above, these are private support functions and not part of the API.
+ * Drivers must not use these.
+ */
+static inline void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
+	enum dma_data_direction dir)
+{
+	if (!arch_is_coherent())
+		dma_cache_maint(kaddr, size, dir);
+}
+
+static inline void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
+	enum dma_data_direction dir)
+{
+	/* nothing to do */
+}
+
+static inline void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir)
+{
+	if (!arch_is_coherent())
+		dma_cache_maint_page(page, off, size, dir);
+}
+
+static inline void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir)
+{
+	/* nothing to do */
+}
+
+/*
  * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
  * during bus mastering, then you would pass 0x00ffffff as the mask
@@ -304,8 +333,7 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
 {
 	BUG_ON(!valid_dma_direction(dir));
 
-	if (!arch_is_coherent())
-		dma_cache_maint(cpu_addr, size, dir);
+	__dma_single_cpu_to_dev(cpu_addr, size, dir);
 
 	return virt_to_dma(dev, cpu_addr);
 }
@@ -329,8 +357,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 {
 	BUG_ON(!valid_dma_direction(dir));
 
-	if (!arch_is_coherent())
-		dma_cache_maint_page(page, offset, size, dir);
+	__dma_page_cpu_to_dev(page, offset, size, dir);
 
 	return page_to_dma(dev, page) + offset;
 }
@@ -352,7 +379,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	/* nothing to do */
+	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
 }
 
 /**
@@ -372,7 +399,8 @@ static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	/* nothing to do */
+	__dma_page_dev_to_cpu(dma_to_page(dev, handle), handle & ~PAGE_MASK,
+		size, dir);
 }
 #endif /* CONFIG_DMABOUNCE */
 
@@ -400,7 +428,10 @@ static inline void dma_sync_single_range_for_cpu(struct device *dev,
 {
 	BUG_ON(!valid_dma_direction(dir));
 
-	dmabounce_sync_for_cpu(dev, handle, offset, size, dir);
+	if (!dmabounce_sync_for_cpu(dev, handle, offset, size, dir))
+		return;
+
+	__dma_single_dev_to_cpu(dma_to_virt(dev, handle) + offset, size, dir);
 }
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
@@ -412,8 +443,7 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 	if (!dmabounce_sync_for_device(dev, handle, offset, size, dir))
 		return;
 
-	if (!arch_is_coherent())
-		dma_cache_maint(dma_to_virt(dev, handle) + offset, size, dir);
+	__dma_single_cpu_to_dev(dma_to_virt(dev, handle) + offset, size, dir);
 }
 
 static inline void dma_sync_single_for_cpu(struct device *dev,
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b9590a7..5bd2e0d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -708,8 +708,12 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		dmabounce_sync_for_cpu(dev, sg_dma_address(s), 0,
-					sg_dma_len(s), dir);
+		if (!dmabounce_sync_for_cpu(dev, sg_dma_address(s), 0,
+					    sg_dma_len(s), dir))
+			continue;
+
+		__dma_page_dev_to_cpu(sg_page(s), s->offset,
+				      s->length, dir);
 	}
 }
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
@@ -732,9 +736,8 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 					sg_dma_len(s), dir))
 			continue;
 
-		if (!arch_is_coherent())
-			dma_cache_maint_page(sg_page(s), s->offset,
-					     s->length, dir);
+		__dma_page_cpu_to_dev(sg_page(s), s->offset,
+				      s->length, dir);
 	}
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
-- 
1.6.2.5
