From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 14 Nov 2014 14:47:59 +0100
Subject: [PATCH] i2c: at91: introduce probe deferring
Message-ID: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return probe defer if requesting a dma channel without a dma controller probed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 77fb647..df3f4c4 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -679,14 +679,21 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
-							dev->dev, "tx");
-	if (!dma->chan_tx) {
+	dma->chan_tx = dma_request_slave_channel_reason(dev->dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
+		ret = PTR_ERR(dma->chan_tx);
+		if (ret == -EPROBE_DEFER) {
+			dev_warn(dev->dev, "no DMA channel available at the moment\n");
+			return ret;
+		}
 		dev_err(dev->dev, "can't get a DMA channel for tx\n");
-		ret = -EBUSY;
 		goto error;
 	}
 
+	/*
+	 * No reason to check EPROBE_DEFER here since we have already request
+	 * tx channel. If it fails here, it's for another reason.
+	 */
 	dma->chan_rx = dma_request_slave_channel_compat(mask, filter, pdata,
 							dev->dev, "rx");
 	if (!dma->chan_rx) {
@@ -722,7 +729,7 @@ error:
 	dev_info(dev->dev, "can't use DMA\n");
 	if (dma->chan_rx)
 		dma_release_channel(dma->chan_rx);
-	if (dma->chan_tx)
+	if (!IS_ERR(dma->chan_tx))
 		dma_release_channel(dma->chan_tx);
 	return ret;
 }
@@ -788,8 +795,11 @@ static int at91_twi_probe(struct platform_device *pdev)
 	clk_prepare_enable(dev->clk);
 
 	if (dev->pdata->has_dma_support) {
-		if (at91_twi_configure_dma(dev, phy_addr) == 0)
+		rc = at91_twi_configure_dma(dev, phy_addr);
+		if (rc == 0)
 			dev->use_dma = true;
+		else if (rc == -EPROBE_DEFER)
+			return rc;
 	}
 
 	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
-- 
2.0.3
