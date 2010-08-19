From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 19 Aug 2010 16:40:15 +0200 (CEST)
Subject: [PATCH 3/5] DMA: reduce the number of memory allocations
In-Reply-To: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
Message-ID: <Pine.LNX.4.64.1008191634160.26145@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate the bitmap in dma_declare_coherent_memory() together with the struct
dma_coherent_mem object.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/base/dma-coherent.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index f369e27..8efdfd4 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -11,7 +11,7 @@ struct dma_coherent_mem {
 	dma_addr_t	device_base;
 	int		size;
 	int		flags;
-	unsigned long	*bitmap;
+	unsigned long	bitmap[0];
 };
 
 int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
@@ -34,12 +34,10 @@ int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 	if (!mem_base)
 		goto out;
 
-	dev->dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
+	dev->dma_mem = kzalloc(sizeof(struct dma_coherent_mem) + bitmap_size,
+			       GFP_KERNEL);
 	if (!dev->dma_mem)
 		goto out;
-	dev->dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!dev->dma_mem->bitmap)
-		goto free1_out;
 
 	dev->dma_mem->virt_base = mem_base;
 	dev->dma_mem->device_base = device_addr;
@@ -51,8 +49,6 @@ int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 
 	return DMA_MEMORY_IO;
 
- free1_out:
-	kfree(dev->dma_mem);
  out:
 	if (mem_base)
 		iounmap(mem_base);
@@ -68,7 +64,6 @@ void dma_release_declared_memory(struct device *dev)
 		return;
 	dev->dma_mem = NULL;
 	iounmap(mem->virt_base);
-	kfree(mem->bitmap);
 	kfree(mem);
 }
 EXPORT_SYMBOL(dma_release_declared_memory);
-- 
1.7.2
