From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 13:00:48 +0100
Subject: [PATCH 4/4] dmaengine i.MX dma: initialize dma capabilities outside
	channel loop
In-Reply-To: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
References: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296475248-29095-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The capabilities are device specific fields, not channel specific fields.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-dma.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 8262708..e18eaab 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -345,6 +345,9 @@ static int __init imxdma_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&imxdma->dma_device.channels);
 
+	dma_cap_set(DMA_SLAVE, imxdma->dma_device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, imxdma->dma_device.cap_mask);
+
 	/* Initialize channel parameters */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct imxdma_channel *imxdmac = &imxdma->channel[i];
@@ -362,9 +365,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		imxdmac->imxdma = imxdma;
 		spin_lock_init(&imxdmac->lock);
 
-		dma_cap_set(DMA_SLAVE, imxdma->dma_device.cap_mask);
-		dma_cap_set(DMA_CYCLIC, imxdma->dma_device.cap_mask);
-
 		imxdmac->chan.device = &imxdma->dma_device;
 		imxdmac->channel = i;
 
-- 
1.7.2.3
