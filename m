From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon,  5 Mar 2018 10:35:28 +0100
Subject: [PATCH 1/7] media: sun6i: Fill dma_pfn_offset to accomodate for the
 RAM offset
In-Reply-To: <20180305093535.11801-1-maxime.ripard@bootlin.com>
References: <1519697113-32202-1-git-send-email-yong.deng@magewell.com>
 <20180305093535.11801-1-maxime.ripard@bootlin.com>
Message-ID: <20180305093535.11801-2-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CSI controller does its DMA accesses through a DMA bus that has the RAM
mapped at the address 0.

The current code removes from the dma_addr_t PHYS_OFFSET, and while it
works, this is an abuse of the DMA API.

Instead, fill the dma_pfn_offset field in the struct device that should be
used to express such an offset, and the use the dma_addr_t directly as we
should.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 1aaaae238d57..2ec33fb04632 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -563,20 +563,15 @@ int sun6i_csi_update_config(struct sun6i_csi *csi,
 void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr)
 {
 	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
-	/* transform physical address to bus address */
-#if defined(CONFIG_COMPILE_TEST) && !defined(PHYS_OFFSET)
-#define PHYS_OFFSET 0
-#endif
-	dma_addr_t bus_addr = addr - PHYS_OFFSET;
 
 	regmap_write(sdev->regmap, CSI_CH_F0_BUFA_REG,
-		     (bus_addr + sdev->planar_offset[0]) >> 2);
+		     (addr + sdev->planar_offset[0]) >> 2);
 	if (sdev->planar_offset[1] != -1)
 		regmap_write(sdev->regmap, CSI_CH_F1_BUFA_REG,
-			     (bus_addr + sdev->planar_offset[1]) >> 2);
+			     (addr + sdev->planar_offset[1]) >> 2);
 	if (sdev->planar_offset[2] != -1)
 		regmap_write(sdev->regmap, CSI_CH_F2_BUFA_REG,
-			     (bus_addr + sdev->planar_offset[2]) >> 2);
+			     (addr + sdev->planar_offset[2]) >> 2);
 }
 
 void sun6i_csi_set_stream(struct sun6i_csi *csi, bool enable)
@@ -856,6 +851,14 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 	return 0;
 }
 
+/*
+ * PHYS_OFFSET isn't available on all architectures. In order to
+ * accomodate for COMPILE_TEST, let's define it to something dumb.
+ */
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET 0
+#endif
+
 static int sun6i_csi_probe(struct platform_device *pdev)
 {
 	struct sun6i_csi_dev *sdev;
@@ -866,6 +869,8 @@ static int sun6i_csi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sdev->dev = &pdev->dev;
+	/* The DMA bus has the memory mapped at 0 */
+	sdev->dev->dma_pfn_offset = PHYS_OFFSET >> PAGE_SHIFT;
 
 	ret = sun6i_csi_resource_request(sdev, pdev);
 	if (ret)
-- 
2.14.3
