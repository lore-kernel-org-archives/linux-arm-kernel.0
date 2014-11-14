From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 14 Nov 2014 17:12:54 +0100
Subject: [PATCH 2/2] spi: atmel: introduce probe deferring
In-Reply-To: <1415981574-11165-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415981574-11165-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415981574-11165-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return probe defer if requesting a dma channel without a dma controller
probed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/spi/spi-atmel.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f1760fa..62c293d 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -424,14 +424,23 @@ static int atmel_spi_configure_dma(struct atmel_spi *as)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	as->dma.chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!as->dma.chan_tx) {
+	as->dma.chan_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(as->dma.chan_tx)) {
+		err = PTR_ERR(as->dma.chan_tx);
+		if (err == -EPROBE_DEFER) {
+			dev_warn(dev, "no DMA channel available at the moment\n");
+			return err;
+		}
 		dev_err(dev,
 			"DMA TX channel not available, SPI unable to use DMA\n");
 		err = -EBUSY;
 		goto error;
 	}
 
+	/*
+	 * No reason to check EPROBE_DEFER here since we have already requested
+	 * tx channel. If it fails here, it's for another reason.
+	 */
 	as->dma.chan_rx = dma_request_slave_channel(dev, "rx");
 
 	if (!as->dma.chan_rx) {
@@ -453,7 +462,7 @@ static int atmel_spi_configure_dma(struct atmel_spi *as)
 error:
 	if (as->dma.chan_rx)
 		dma_release_channel(as->dma.chan_rx);
-	if (as->dma.chan_tx)
+	if (!IS_ERR(as->dma.chan_tx))
 		dma_release_channel(as->dma.chan_tx);
 	return err;
 }
@@ -1324,8 +1333,11 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	as->use_dma = false;
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
-		if (atmel_spi_configure_dma(as) == 0)
+		ret = atmel_spi_configure_dma(as);
+		if (ret == 0)
 			as->use_dma = true;
+		else if (ret == -EPROBE_DEFER)
+			return ret;
 	} else {
 		as->use_pdc = true;
 	}
-- 
2.0.3
