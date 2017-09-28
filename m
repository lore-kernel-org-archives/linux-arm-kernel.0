From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 28 Sep 2017 03:49:24 +0200
Subject: [PATCH v4 07/11] dmaengine: sun6i: Retrieve channel count/max request
 from devicetree
In-Reply-To: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
Message-ID: <6277478a-601a-48b0-8e1f-1d309049d4f4@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid introduction of a new compatible for each small SoC/DMA controller
variation, move the definition of the channel count to the devicetree.

The number of vchans is no longer explicit, but limited by the highest
port/DMA request number. The result is a slight overallocation for SoCs
with a sparse port mapping.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

---

Changes in v4:
- remove range checks for dma-channels/dma-requests DT properties

Changes in v3: None
Changes in v2:
- Set default number of dma-request if not provided in config or devicetree

 drivers/dma/sun6i-dma.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 7fce976a13d8..b5906da2a975 100644
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
@@ -1155,6 +1159,7 @@ MODULE_DEVICE_TABLE(of, sun6i_dma_match);
 static int sun6i_dma_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *device;
+	struct device_node *np = pdev->dev.of_node;
 	struct sun6i_dma_dev *sdc;
 	struct resource *res;
 	int ret, i;
@@ -1230,6 +1235,26 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->num_vchans = sdc->cfg->nr_max_vchans;
 	sdc->max_request = sdc->cfg->nr_max_requests;
 
+	ret = of_property_read_u32(np, "dma-channels", &sdc->num_pchans);
+	if (ret && !sdc->num_pchans) {
+		dev_err(&pdev->dev, "Can't get dma-channels.\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
+	if (ret && !sdc->max_request) {
+		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
+			 DMA_CHAN_MAX_DRQ);
+		sdc->max_request = DMA_CHAN_MAX_DRQ;
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
