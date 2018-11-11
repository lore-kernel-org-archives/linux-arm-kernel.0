From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 11 Nov 2018 21:23:58 +0100
Subject: [PATCH V2 6/7] mmc: bcm2835: Refactor dma_map_sg handling
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1541967839-2847-7-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two variables len within bcm2835_prepare_dma. So rename the result
of dma_map_sg to sg_len. While we are at this add a bail out to simplify the
following change.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 2c7589f..c42bdaa 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -464,7 +464,7 @@ static void bcm2835_transfer_pio(struct bcm2835_host *host)
 static
 void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 {
-	int len, dir_data, dir_slave;
+	int sg_len, dir_data, dir_slave;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
 
@@ -510,15 +510,13 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				     &host->dma_cfg_rx :
 				     &host->dma_cfg_tx);
 
-	len = dma_map_sg(dma_chan->device->dev, data->sg, data->sg_len,
-			 dir_data);
+	sg_len = dma_map_sg(dma_chan->device->dev, data->sg, data->sg_len,
+			    dir_data);
+	if (!sg_len)
+		return;
 
-	if (len > 0) {
-		desc = dmaengine_prep_slave_sg(dma_chan, data->sg,
-					       len, dir_slave,
-					       DMA_PREP_INTERRUPT |
-					       DMA_CTRL_ACK);
-	}
+	desc = dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_slave,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (desc) {
 		desc->callback = bcm2835_dma_complete;
-- 
2.7.4
