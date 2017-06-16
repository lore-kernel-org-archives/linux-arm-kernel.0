From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:58 +0200
Subject: [PATCH 43/44] dma-mapping: remove the set_dma_mask method
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-44-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma.c   | 4 ----
 include/linux/dma-mapping.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 41c749586bd2..466c9f07b288 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -316,10 +316,6 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
 
 int __dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	const struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	if ((dma_ops != NULL) && (dma_ops->set_dma_mask != NULL))
-		return dma_ops->set_dma_mask(dev, dma_mask);
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 	*dev->dma_mask = dma_mask;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 3e5908656226..527f2ed8c645 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -127,7 +127,6 @@ struct dma_map_ops {
 				   enum dma_data_direction dir);
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
-	int (*set_dma_mask)(struct device *dev, u64 mask);
 #ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	u64 (*get_required_mask)(struct device *dev);
 #endif
@@ -563,11 +562,6 @@ static inline int dma_supported(struct device *dev, u64 mask)
 #ifndef HAVE_ARCH_DMA_SET_MASK
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (ops->set_dma_mask)
-		return ops->set_dma_mask(dev, mask);
-
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
 	*dev->dma_mask = mask;
-- 
2.11.0
