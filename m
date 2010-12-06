From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  6 Dec 2010 11:09:58 +0100
Subject: [PATCH 2/2] dmaengine i.MX SDMA: protect channel0
In-Reply-To: <1291630198-9690-1-git-send-email-s.hauer@pengutronix.de>
References: <1291630198-9690-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1291630198-9690-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Channel 0 of the SDMA engine is a shared resource used by the
other channels, thus we have to protect it with a mutex.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 01c4a5f..b1f5947 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -355,6 +355,7 @@ struct sdma_engine {
 	struct dma_device		dma_device;
 	struct clk			*clk;
 	struct sdma_script_start_addrs	*script_addrs;
+	struct mutex			channel0_mutex;
 };
 
 #define SDMA_H_CONFIG_DSPDMA	(1 << 12) /* indicates if the DSPDMA is used */
@@ -437,6 +438,8 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	if (!buf_virt)
 		return -ENOMEM;
 
+	mutex_lock(&sdma->channel0_mutex);
+
 	bd0->mode.command = C0_SETPM;
 	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
 	bd0->mode.count = size / 2;
@@ -447,6 +450,8 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 
 	ret = sdma_run_channel(&sdma->channel[0]);
 
+	mutex_unlock(&sdma->channel0_mutex);
+
 	dma_free_coherent(NULL, size, buf_virt, buf_phys);
 
 	return ret;
@@ -684,6 +689,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	context->gReg[6] = sdmac->shp_addr;
 	context->gReg[7] = sdmac->watermark_level;
 
+	mutex_lock(&sdma->channel0_mutex);
+
 	bd0->mode.command = C0_SETDM;
 	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
 	bd0->mode.count = sizeof(*context) / 4;
@@ -692,6 +699,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	ret = sdma_run_channel(&sdma->channel[0]);
 
+	mutex_unlock(&sdma->channel0_mutex);
+
 	return ret;
 }
 
@@ -1297,6 +1306,8 @@ static int __init sdma_probe(struct platform_device *pdev)
 
 	sdma->version = pdata->sdma_version;
 
+	mutex_init(&sdma->channel0_mutex);
+
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
-- 
1.7.2.3
