From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 Oct 2011 19:19:23 +0200
Subject: [PATCH 6/8] common: dma-mapping: change alloc/free_coherent method to
	more generic alloc/free_attrs
In-Reply-To: <1318958365-19120-1-git-send-email-m.szyprowski@samsung.com>
References: <1318958365-19120-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1318958365-19120-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new alloc/free/mmap methods that take attributes argument.
alloc/free_coherent can be implemented on top of the new alloc/free
calls with NULL attributes. dma_alloc_non_coherent can be implemented
using DMA_ATTR_NONCOHERENT attribute, dma_alloc_writecombine can also
use separate DMA_ATTR_WRITECOMBINE attribute. This way the drivers will
get more generic, platform independent way of allocating dma memory
buffers with specific parameters.

One more attribute can be usefull: DMA_ATTR_NOKERNELVADDR. Buffers with
such attribute will not have valid kernel virtual address. They might be
usefull for drivers that only exports the DMA buffers to userspace (like
for example V4L2 or ALSA).

mmap method is introduced to let the drivers create a user space mapping
for a DMA buffer in generic, architecture independent way.

TODO: update all dma_map_ops clients for all architectures

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/dma-mapping.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa32fec..b71481d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -8,10 +8,15 @@
 #include <linux/scatterlist.h>
 
 struct dma_map_ops {
-	void* (*alloc_coherent)(struct device *dev, size_t size,
-				dma_addr_t *dma_handle, gfp_t gfp);
-	void (*free_coherent)(struct device *dev, size_t size,
-			      void *vaddr, dma_addr_t dma_handle);
+	void* (*alloc)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t gfp,
+				struct dma_attrs *attrs);
+	void (*free)(struct device *dev, size_t size,
+			      void *vaddr, dma_addr_t dma_handle,
+			      struct dma_attrs *attrs);
+	int (*mmap)(struct device *, struct vm_area_struct *,
+			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
+
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-- 
1.7.1.569.g6f426
