From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:35 +0200
Subject: [PATCH 07/29] ARM: dma-mapping: arm_iommu_attach_device: automatically
 set max_seg_size
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If device has no max_seg_size set, we assume that there is no limit and
force it to DMA_BIT_MASK(32) to always use contiguous mappings in DMA
address space.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7a996aa..8161102 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2051,6 +2051,22 @@ int arm_iommu_attach_device(struct device *dev,
 {
 	int err;
 
+	/*
+	 * if device has no max_seg_size set, we assume that there is no limit
+	 * and force it to DMA_BIT_MASK(32) to always use contiguous mappings
+	 * in DMA address space
+	 */
+	if (!dev->dma_parms) {
+		dev->dma_parms = kzalloc(sizeof(*dev->dma_parms), GFP_KERNEL);
+		if (!dev->dma_parms)
+			return -ENOMEM;
+	}
+	if (!dev->dma_parms->max_segment_size) {
+		err = dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+		if (err)
+			return err;
+	}
+
 	err = iommu_attach_device(mapping->domain, dev);
 	if (err)
 		return err;
-- 
1.9.2
