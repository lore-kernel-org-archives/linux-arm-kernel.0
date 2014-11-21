From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 21 Nov 2014 14:44:32 +0100
Subject: [PATCH 2/2] i2c: at91: enable probe deferring on dma channel request
In-Reply-To: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
References: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1416577472-24542-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If dma controller is not probed, defer i2c probe.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Arnd,

It's a combination of the first patch I sent and yours. As you said that my
patch "looks wrong but actually it's ok" I didn't dare to add your
signed-off-by.

 drivers/i2c/busses/i2c-at91.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index b69ea9b..3e56d73 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -635,17 +635,17 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	slave_config.dst_maxburst = 1;
 	slave_config.device_fc = false;
 
-	dma->chan_tx = dma_request_slave_channel(dev->dev, "tx");
-	if (!dma->chan_tx) {
-		dev_err(dev->dev, "can't get a DMA channel for tx\n");
-		ret = -EBUSY;
+	dma->chan_tx = dma_request_slave_channel_reason(dev->dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
+		ret = PTR_ERR(dma->chan_tx);
+		dma->chan_tx = NULL;
 		goto error;
 	}
 
-	dma->chan_rx = dma_request_slave_channel(dev->dev, "rx");
-	if (!dma->chan_rx) {
-		dev_err(dev->dev, "can't get a DMA channel for rx\n");
-		ret = -EBUSY;
+	dma->chan_rx = dma_request_slave_channel_reason(dev->dev, "rx");
+	if (IS_ERR(dma->chan_rx)) {
+		ret = PTR_ERR(dma->chan_rx);
+		dma->chan_rx = NULL;
 		goto error;
 	}
 
@@ -666,6 +666,7 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	sg_init_table(&dma->sg, 1);
 	dma->buf_mapped = false;
 	dma->xfer_in_progress = false;
+	dev->use_dma = true;
 
 	dev_info(dev->dev, "using %s (tx) and %s (rx) for DMA transfers\n",
 		 dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
@@ -673,7 +674,8 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	return ret;
 
 error:
-	dev_info(dev->dev, "can't use DMA\n");
+	if (ret != -EPROBE_DEFER)
+		dev_info(dev->dev, "can't use DMA, error %d\n", ret);
 	if (dma->chan_rx)
 		dma_release_channel(dma->chan_rx);
 	if (dma->chan_tx)
@@ -742,8 +744,9 @@ static int at91_twi_probe(struct platform_device *pdev)
 	clk_prepare_enable(dev->clk);
 
 	if (dev->dev->of_node) {
-		if (at91_twi_configure_dma(dev, phy_addr) == 0)
-			dev->use_dma = true;
+		rc = at91_twi_configure_dma(dev, phy_addr);
+		if (rc == -EPROBE_DEFER)
+			return rc;
 	}
 
 	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
-- 
2.0.3
