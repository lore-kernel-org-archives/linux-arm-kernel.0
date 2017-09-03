From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 4 Sep 2017 00:40:58 +0200
Subject: [PATCH 07/10] dmaengine: sun6i: Retrieve channel count/max request
 from devicetree
In-Reply-To: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170903224100.17893-8-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid introduction of a new compatible for each small SoC/DMA controller
variation, move the definition of the channel count to the devicetree.

The number of vchans is no longer explicit, but limited by the highest
port/DMA request number. The result is a slight overallocation for SoCs
with a sparse port mapping.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index c69dadb853d2..bd4c2e4a759b 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -42,6 +42,9 @@
 
 #define DMA_STAT		0x30
 
+/* Offset between DMA_IRQ_EN and DMA_IRQ_STAT limits number of channels */
+#define DMA_MAX_CHANNELS	(DMA_IRQ_CHAN_NR * 0x10 / 4)
+
 /*
  * sun8i specific registers
  */
@@ -65,7 +68,8 @@
 #define DMA_CHAN_LLI_ADDR	0x08
 
 #define DMA_CHAN_CUR_CFG	0x0c
-#define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & 0x1f)
+#define DMA_CHAN_MAX_DRQ		0x1f
+#define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & DMA_CHAN_MAX_DRQ)
 #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
 #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
 #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
@@ -1173,6 +1177,35 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->num_vchans = sdc->cfg->nr_max_vchans;
 	sdc->max_request = sdc->cfg->nr_max_requests;
 
+	ret = of_property_read_u32(np, "dma-channels", &sdc->num_pchans);
+	if (ret && !sdc->num_pchans) {
+		dev_err(&pdev->dev, "Can't get dma-channels.\n");
+		return ret;
+	}
+
+	if (sdc->num_pchans > DMA_MAX_CHANNELS) {
+		dev_err(&pdev->dev, "Number of dma-channels out of range.\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
+	if (ret && !sdc->max_request) {
+		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
+			 DMA_CHAN_MAX_DRQ);
+	}
+
+	if (sdc->max_request > DMA_CHAN_MAX_DRQ) {
+		dev_err(&pdev->dev, "Value of dma-requests out of range.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * If the number of vchans is not specified, derive it from the
+	 * highest port number, at most one channel per port and direction.
+	 */
+	if (!sdc->num_vchans)
+		sdc->num_vchans = 2 * (sdc->max_request + 1);
+
 	sdc->pchans = devm_kcalloc(&pdev->dev, sdc->num_pchans,
 				   sizeof(struct sun6i_pchan), GFP_KERNEL);
 	if (!sdc->pchans)
-- 
2.14.1
