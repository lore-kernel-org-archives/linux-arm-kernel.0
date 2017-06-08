From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:26:02 +0200
Subject: [PATCH 37/44] mips/loongson64: implement ->dma_supported instead of
 ->set_dma_mask
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170608132609.32662-38-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Same behavior, less code duplication.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/loongson64/common/dma-swiotlb.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 178ca17a5667..34486c138206 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -75,19 +75,11 @@ static void loongson_dma_sync_sg_for_device(struct device *dev,
 	mb();
 }
 
-static int loongson_dma_set_mask(struct device *dev, u64 mask)
+static int loongson_dma_supported(struct device *dev, u64 mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits)) {
-		*dev->dma_mask = DMA_BIT_MASK(loongson_sysconf.dma_mask_bits);
-		return -EIO;
-	}
-
-	*dev->dma_mask = mask;
-
-	return 0;
+	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits))
+		return 0;
+	return swiotlb_dma_supported(dev, mask);
 }
 
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
@@ -126,8 +118,7 @@ static const struct dma_map_ops loongson_dma_map_ops = {
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = swiotlb_dma_supported,
-	.set_dma_mask = loongson_dma_set_mask
+	.dma_supported = loongson_dma_supported,
 };
 
 void __init plat_swiotlb_setup(void)
-- 
2.11.0
