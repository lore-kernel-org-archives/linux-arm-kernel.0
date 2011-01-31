From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 12:59:31 +0100
Subject: [PATCH 4/5] dmaengine i.MX SDMA: initialize dma capabilities outside
	channel loop
In-Reply-To: <1296475172-23900-1-git-send-email-s.hauer@pengutronix.de>
References: <1296475172-23900-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296475172-23900-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The capabilities are device specific fields, not channel specific fields.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3e848ee..eb25068 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1295,6 +1295,9 @@ static int __init sdma_probe(struct platform_device *pdev)
 
 	sdma->version = pdata->sdma_version;
 
+	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
+
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
@@ -1303,9 +1306,6 @@ static int __init sdma_probe(struct platform_device *pdev)
 		sdmac->sdma = sdma;
 		spin_lock_init(&sdmac->lock);
 
-		dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
-		dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
-
 		sdmac->chan.device = &sdma->dma_device;
 		sdmac->channel = i;
 
-- 
1.7.2.3
