From: gking@nvidia.com (gking at nvidia.com)
Date: Wed, 28 Jul 2010 17:57:47 -0700
Subject: [PATCH 2/2] [ARM] dma-mapping: add highmem support to dma bounce
In-Reply-To: <1280365067-21102-1-git-send-email-gking@nvidia.com>
References: <1280365067-21102-1-git-send-email-gking@nvidia.com>
Message-ID: <1280365067-21102-3-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gary King <gking@nvidia.com>

extend map_single and safe_buffer to support mapping pages or kernel
buffers; call kmap_atomic and kunmap_atomic if the safe_buffer is
bouncing a page, so that it may be copied into the safe DMA buffer

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/common/dmabounce.c |   91 +++++++++++++++++++++++++++++++++---------
 1 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index e31a333..0712f7f 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -31,6 +31,7 @@
 #include <linux/dmapool.h>
 #include <linux/list.h>
 #include <linux/scatterlist.h>
+#include <linux/highmem.h>
 
 #include <asm/cacheflush.h>
 
@@ -49,6 +50,8 @@ struct safe_buffer {
 
 	/* original request */
 	void		*ptr;
+	struct page	*page;
+	unsigned long	offset;
 	size_t		size;
 	int		direction;
 
@@ -103,7 +106,8 @@ static DEVICE_ATTR(dmabounce_stats, 0400, dmabounce_show, NULL);
 /* allocate a 'safe' buffer and keep track of it */
 static inline struct safe_buffer *
 alloc_safe_buffer(struct dmabounce_device_info *device_info, void *ptr,
-		  size_t size, enum dma_data_direction dir)
+		  struct page *page, unsigned long offset, size_t size,
+		  enum dma_data_direction dir)
 {
 	struct safe_buffer *buf;
 	struct dmabounce_pool *pool;
@@ -128,6 +132,8 @@ alloc_safe_buffer(struct dmabounce_device_info *device_info, void *ptr,
 	}
 
 	buf->ptr = ptr;
+	buf->page = page;
+	buf->offset = offset;
 	buf->size = size;
 	buf->direction = dir;
 	buf->pool = pool;
@@ -219,7 +225,8 @@ static struct safe_buffer *find_safe_buffer_dev(struct device *dev,
 	return find_safe_buffer(dev->archdata.dmabounce, dma_addr);
 }
 
-static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
+static inline dma_addr_t map_single_or_page(struct device *dev, void *ptr,
+		struct page *page, unsigned long offset,  size_t size,
 		enum dma_data_direction dir)
 {
 	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
@@ -229,7 +236,10 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 	if (device_info)
 		DO_STATS ( device_info->map_op_count++ );
 
-	dma_addr = virt_to_dma(dev, ptr);
+	if (page)
+		dma_addr = page_to_dma(dev, page) + offset;
+	else
+		dma_addr = virt_to_dma(dev, ptr);
 
 	if (dev->dma_mask) {
 		unsigned long mask = *dev->dma_mask;
@@ -253,38 +263,83 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 	if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
 		struct safe_buffer *buf;
 
-		buf = alloc_safe_buffer(device_info, ptr, size, dir);
+		buf = alloc_safe_buffer(device_info, ptr, page, offset, size, dir);
 		if (buf == 0) {
 			dev_err(dev, "%s: unable to map unsafe buffer %p!\n",
 			       __func__, ptr);
 			return 0;
 		}
 
-		dev_dbg(dev,
-			"%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-			__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
-			buf->safe, buf->safe_dma_addr);
+                if (buf->page)
+			dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped "
+				"to %p (dma=%#x)\n", __func__,
+				page_address(buf->page),
+				page_to_dma(dev, buf->page),
+				buf->safe, buf->safe_dma_addr);
+		else
+			dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped "
+				"to %p (dma=%#x)\n", __func__,
+				buf->ptr, virt_to_dma(dev, buf->ptr),
+				buf->safe, buf->safe_dma_addr);
 
 		if ((dir == DMA_TO_DEVICE) ||
 		    (dir == DMA_BIDIRECTIONAL)) {
+			if (page)
+				ptr = kmap_atomic(page, KM_BOUNCE_READ) + offset;
 			dev_dbg(dev, "%s: copy unsafe %p to safe %p, size %d\n",
 				__func__, ptr, buf->safe, size);
 			memcpy(buf->safe, ptr, size);
+			wmb();
+			if (page)
+				kunmap_atomic(ptr - offset, KM_BOUNCE_READ);
 		}
-		ptr = buf->safe;
-
 		dma_addr = buf->safe_dma_addr;
 	} else {
 		/*
 		 * We don't need to sync the DMA buffer since
 		 * it was allocated via the coherent allocators.
 		 */
-		__dma_single_cpu_to_dev(ptr, size, dir);
+		if (page)
+			__dma_page_cpu_to_dev(page, offset, size, dir);
+		else
+			__dma_single_cpu_to_dev(ptr, size, dir);
 	}
 
 	return dma_addr;
 }
 
+static inline void unmap_page(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir)
+{
+	struct safe_buffer *buf = find_safe_buffer_dev(dev, dma_addr, "unmap");
+
+	if (buf) {
+		BUG_ON(buf->size != size);
+		BUG_ON(buf->direction != dir);
+		BUG_ON(!buf->page);
+		BUG_ON(buf->ptr);
+
+		dev_dbg(dev,
+			"%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
+			__func__, page_address(buf->page),
+			page_to_dma(dev, buf->page),
+			buf->safe, buf->safe_dma_addr);
+
+		DO_STATS(dev->archdata.dmabounce->bounce_count++);
+		if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
+			void *ptr;
+			ptr = kmap_atomic(buf->page, KM_BOUNCE_READ) + buf->offset;
+			memcpy(ptr, buf->safe, size);
+			__cpuc_flush_dcache_area(ptr, size);
+			kunmap_atomic(ptr - buf->offset, KM_BOUNCE_READ);
+		}
+		free_safe_buffer(dev->archdata.dmabounce, buf);
+	} else {
+		__dma_page_dev_to_cpu(dma_to_page(dev, dma_addr),
+			      dma_addr & ~PAGE_MASK, size, dir);
+	}
+}
+
 static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
@@ -293,6 +348,8 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 	if (buf) {
 		BUG_ON(buf->size != size);
 		BUG_ON(buf->direction != dir);
+		BUG_ON(buf->page);
+		BUG_ON(!buf->ptr);
 
 		dev_dbg(dev,
 			"%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
@@ -338,7 +395,7 @@ dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
 
 	BUG_ON(!valid_dma_direction(dir));
 
-	return map_single(dev, ptr, size, dir);
+	return map_single_or_page(dev, ptr, NULL, 0, size, dir);
 }
 EXPORT_SYMBOL(dma_map_single);
 
@@ -366,13 +423,7 @@ dma_addr_t dma_map_page(struct device *dev, struct page *page,
 
 	BUG_ON(!valid_dma_direction(dir));
 
-	if (PageHighMem(page)) {
-		dev_err(dev, "DMA buffer bouncing of HIGHMEM pages "
-			     "is not supported\n");
-		return ~0;
-	}
-
-	return map_single(dev, page_address(page) + offset, size, dir);
+	return map_single_or_page(dev, NULL, page, offset, size, dir);
 }
 EXPORT_SYMBOL(dma_map_page);
 
@@ -388,7 +439,7 @@ void dma_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
 		__func__, (void *) dma_addr, size, dir);
 
-	unmap_single(dev, dma_addr, size, dir);
+	unmap_page(dev, dma_addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_page);
 
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
