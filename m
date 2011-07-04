From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:49:16 +0100
Subject: [PATCH 05/10] ARM: dmabounce: move decision for bouncing into
	__dma_map_page()
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1QdeqC-0000ZM-LK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the decision whether to bounce into __dma_map_page(), before
the check for high pages.  This avoids triggering the high page
check for devices which aren't using dmabounce.  Fix the unmap path
to cope too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c |  124 ++++++++++++++++++++-----------------------
 1 files changed, 58 insertions(+), 66 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 643e1d6..6ae292c 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -246,88 +246,58 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		enum dma_data_direction dir)
 {
 	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
-	dma_addr_t dma_addr;
-	int ret;
+	struct safe_buffer *buf;
 
 	if (device_info)
 		DO_STATS ( device_info->map_op_count++ );
 
-	dma_addr = virt_to_dma(dev, ptr);
-
-	ret = needs_bounce(dev, dma_addr, size);
-	if (ret < 0)
+	buf = alloc_safe_buffer(device_info, ptr, size, dir);
+	if (buf == 0) {
+		dev_err(dev, "%s: unable to map unsafe buffer %p!\n",
+		       __func__, ptr);
 		return ~0;
+	}
 
-	if (ret > 0) {
-		struct safe_buffer *buf;
-
-		buf = alloc_safe_buffer(device_info, ptr, size, dir);
-		if (buf == 0) {
-			dev_err(dev, "%s: unable to map unsafe buffer %p!\n",
-			       __func__, ptr);
-			return ~0;
-		}
-
-		dev_dbg(dev,
-			"%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-			__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
-			buf->safe, buf->safe_dma_addr);
-
-		if ((dir == DMA_TO_DEVICE) ||
-		    (dir == DMA_BIDIRECTIONAL)) {
-			dev_dbg(dev, "%s: copy unsafe %p to safe %p, size %d\n",
-				__func__, ptr, buf->safe, size);
-			memcpy(buf->safe, ptr, size);
-		}
-		ptr = buf->safe;
+	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
+		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
+		buf->safe, buf->safe_dma_addr);
 
-		dma_addr = buf->safe_dma_addr;
-	} else {
-		/*
-		 * We don't need to sync the DMA buffer since
-		 * it was allocated via the coherent allocators.
-		 */
-		__dma_single_cpu_to_dev(ptr, size, dir);
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL) {
+		dev_dbg(dev, "%s: copy unsafe %p to safe %p, size %d\n",
+			__func__, ptr, buf->safe, size);
+		memcpy(buf->safe, ptr, size);
 	}
 
-	return dma_addr;
+	return buf->safe_dma_addr;
 }
 
-static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
+static inline void unmap_single(struct device *dev, struct safe_buffer *buf,
 		size_t size, enum dma_data_direction dir)
 {
-	struct safe_buffer *buf = find_safe_buffer_dev(dev, dma_addr, "unmap");
-
-	if (buf) {
-		BUG_ON(buf->size != size);
-		BUG_ON(buf->direction != dir);
+	BUG_ON(buf->size != size);
+	BUG_ON(buf->direction != dir);
 
-		dev_dbg(dev,
-			"%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-			__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
-			buf->safe, buf->safe_dma_addr);
+	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
+		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
+		buf->safe, buf->safe_dma_addr);
 
-		DO_STATS(dev->archdata.dmabounce->bounce_count++);
+	DO_STATS(dev->archdata.dmabounce->bounce_count++);
 
-		if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
-			void *ptr = buf->ptr;
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
+		void *ptr = buf->ptr;
 
-			dev_dbg(dev,
-				"%s: copy back safe %p to unsafe %p size %d\n",
-				__func__, buf->safe, ptr, size);
-			memcpy(ptr, buf->safe, size);
+		dev_dbg(dev, "%s: copy back safe %p to unsafe %p size %d\n",
+			__func__, buf->safe, ptr, size);
+		memcpy(ptr, buf->safe, size);
 
-			/*
-			 * Since we may have written to a page cache page,
-			 * we need to ensure that the data will be coherent
-			 * with user mappings.
-			 */
-			__cpuc_flush_dcache_area(ptr, size);
-		}
-		free_safe_buffer(dev->archdata.dmabounce, buf);
-	} else {
-		__dma_single_dev_to_cpu(dma_to_virt(dev, dma_addr), size, dir);
+		/*
+		 * Since we may have written to a page cache page,
+		 * we need to ensure that the data will be coherent
+		 * with user mappings.
+		 */
+		__cpuc_flush_dcache_area(ptr, size);
 	}
+	free_safe_buffer(dev->archdata.dmabounce, buf);
 }
 
 /* ************************************************** */
@@ -341,12 +311,25 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 dma_addr_t __dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir)
 {
+	dma_addr_t dma_addr;
+	int ret;
+
 	dev_dbg(dev, "%s(page=%p,off=%#lx,size=%zx,dir=%x)\n",
 		__func__, page, offset, size, dir);
 
+	dma_addr = pfn_to_dma(dev, page_to_pfn(page)) + offset;
+
+	ret = needs_bounce(dev, dma_addr, size);
+	if (ret < 0)
+		return ~0;
+
+	if (ret == 0) {
+		__dma_page_cpu_to_dev(page, offset, size, dir);
+		return dma_addr;
+	}
+
 	if (PageHighMem(page)) {
-		dev_err(dev, "DMA buffer bouncing of HIGHMEM pages "
-			     "is not supported\n");
+		dev_err(dev, "DMA buffer bouncing of HIGHMEM pages is not supported\n");
 		return ~0;
 	}
 
@@ -363,10 +346,19 @@ EXPORT_SYMBOL(__dma_map_page);
 void __dma_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		enum dma_data_direction dir)
 {
+	struct safe_buffer *buf;
+
 	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
 		__func__, (void *) dma_addr, size, dir);
 
-	unmap_single(dev, dma_addr, size, dir);
+	buf = find_safe_buffer_dev(dev, dma_addr, __func__);
+	if (!buf) {
+		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, dma_addr)),
+			dma_addr & ~PAGE_MASK, size, dir);
+		return;
+	}
+
+	unmap_single(dev, buf, size, dir);
 }
 EXPORT_SYMBOL(__dma_unmap_page);
 
-- 
1.7.4.4
