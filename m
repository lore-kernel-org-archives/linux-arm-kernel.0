From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 19 Aug 2010 16:40:22 +0200 (CEST)
Subject: [PATCH 4/5] DMA: Add functions to preallocate DMA memory dor devices
In-Reply-To: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
Message-ID: <Pine.LNX.4.64.1008191636590.26145@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently dma_declare_coherent_memory() and dma_release_declared_memory() are
provided to assign DMA memory to a device and to release it. These functions
can be use with device local memory, like on-chip SRAM. However, they are
unsuitable for assigning of generic system RAM to devices, because such system
memory should not be ioremapped, and ioremap() is used internally in the former
of these functions to map the memory.

This patch solves this problem by adding two more functions:
dma_preallocate_coherent_memory() and dma_release_preallocated_memory(), which
allocate DMA coherent memory and assign it to the device, and release it back
respectively.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/base/dma-coherent.c        |   50 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/dma-coherent.h |    2 +
 include/linux/dma-mapping.h        |   12 ++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 8efdfd4..9eb2856 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -170,3 +170,53 @@ int dma_release_from_coherent(struct device *dev, int order, void *vaddr)
 	return 0;
 }
 EXPORT_SYMBOL(dma_release_from_coherent);
+
+int dma_preallocate_coherent_memory(struct device *dev, size_t size, gfp_t gfp,
+				    int flags)
+{
+	int pages = size >> PAGE_SHIFT;
+	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
+	dma_addr_t dma_handle;
+	void *buf;
+
+	if (!(flags & (DMA_MEMORY_MAP | DMA_MEMORY_IO)) || !dev)
+		return -EINVAL;
+
+	if (!size)
+		return 0;
+
+	buf = dma_alloc_coherent(NULL, size, &dma_handle, gfp);
+	if (!buf)
+		return -ENOMEM;
+
+	dev->dma_mem = kzalloc(sizeof(struct dma_coherent_mem) + bitmap_size, gfp);
+	if (!dev->dma_mem)
+		goto ealloc;
+
+	dev->dma_mem->virt_base = buf;
+	dev->dma_mem->device_base = dma_handle;
+	dev->dma_mem->size = pages;
+	dev->dma_mem->flags = flags;
+
+	return 0;
+
+ealloc:
+	dma_free_coherent(dev, size, buf, dma_handle);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(dma_preallocate_coherent_memory);
+
+void dma_release_preallocated_memory(struct device *dev)
+{
+	struct dma_coherent_mem *mem = dev->dma_mem;
+
+	if (!mem)
+		return;
+
+	dev->dma_mem = NULL;
+	dma_free_coherent(dev, mem->size << PAGE_SHIFT, mem->virt_base,
+			  mem->device_base);
+	kfree(mem);
+}
+EXPORT_SYMBOL(dma_release_preallocated_memory);
diff --git a/include/asm-generic/dma-coherent.h b/include/asm-generic/dma-coherent.h
index a92bc09..08a66a1 100644
--- a/include/asm-generic/dma-coherent.h
+++ b/include/asm-generic/dma-coherent.h
@@ -21,6 +21,8 @@ void dma_release_declared_memory(struct device *dev);
 
 void *dma_mark_declared_memory_occupied(struct device *dev,
 				  dma_addr_t device_addr, size_t size);
+int dma_preallocate_coherent_memory(struct device *dev, size_t size, gfp_t gfp, int flags);
+void dma_release_preallocated_memory(struct device *dev);
 #else
 #define dma_alloc_from_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_coherent(dev, order, vaddr) (0)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 77ce97f..0912abf 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -177,6 +177,18 @@ dma_mark_declared_memory_occupied(struct device *dev,
 {
 	return ERR_PTR(-EBUSY);
 }
+
+static inline int
+dma_preallocate_coherent_memory(struct device *dev, size_t size, gfp_t gfp, int flags)
+{
+	return -EINVAL;
+}
+
+static inline void
+dma_release_preallocated_memory(struct device *dev)
+{
+}
+
 #endif
 
 /*
-- 
1.7.2
