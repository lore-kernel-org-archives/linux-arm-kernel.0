From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 25 Sep 2015 13:15:44 +0100
Subject: [PATCH 2/4] dma-mapping: Tidy up dma_parms default handling
In-Reply-To: <cover.1443178314.git.robin.murphy@arm.com>
References: <cover.1443178314.git.robin.murphy@arm.com>
Message-ID: <003734bc1b15a4dd4f4fc1a32109f448509ed846.1443178314.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many DMA controllers and other devices set max_segment_size to
indicate their scatter-gather capability, but have no interest in
segment_boundary_mask. However, the existence of a dma_parms structure
precludes the use of any default value, leaving them as zeros (assuming
a properly kzalloc'ed structure). If a well-behaved IOMMU (or SWIOTLB)
then tries to respect this by ensuring a mapped segment does not cross
a zero-byte boundary, hilarity ensues.

Since zero is a nonsensical value for either parameter, treat it as an
indicator for "default", as might be expected. In the process, clean up
a bit by replacing the bare constants with slightly more meaningful
macros and removing the superfluous "else" statements.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-mapping.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff0..ac9af22 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -145,7 +145,9 @@ static inline void arch_teardown_dma_ops(struct device *dev) { }
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
-	return dev->dma_parms ? dev->dma_parms->max_segment_size : 65536;
+	if (dev->dma_parms && dev->dma_parms->max_segment_size)
+		return dev->dma_parms->max_segment_size;
+	return SZ_64K;
 }
 
 static inline unsigned int dma_set_max_seg_size(struct device *dev,
@@ -154,14 +156,15 @@ static inline unsigned int dma_set_max_seg_size(struct device *dev,
 	if (dev->dma_parms) {
 		dev->dma_parms->max_segment_size = size;
 		return 0;
-	} else
-		return -EIO;
+	}
+	return -EIO;
 }
 
 static inline unsigned long dma_get_seg_boundary(struct device *dev)
 {
-	return dev->dma_parms ?
-		dev->dma_parms->segment_boundary_mask : 0xffffffff;
+	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
+		return dev->dma_parms->segment_boundary_mask;
+	return DMA_BIT_MASK(32);
 }
 
 static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
@@ -169,8 +172,8 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	if (dev->dma_parms) {
 		dev->dma_parms->segment_boundary_mask = mask;
 		return 0;
-	} else
-		return -EIO;
+	}
+	return -EIO;
 }
 
 #ifndef dma_max_pfn
-- 
1.9.1
