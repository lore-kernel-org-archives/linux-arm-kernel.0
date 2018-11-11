From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 11 Nov 2018 21:23:59 +0100
Subject: [PATCH V2 7/7] mmc: bcm2835: Properly handle dmaengine_prep_slave_sg
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case dmaengine_prep_slave_sg fails we need to call dma_unmap_sg.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index c42bdaa..82e4b08 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -518,13 +518,16 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 	desc = dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_slave,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
-	if (desc) {
-		desc->callback = bcm2835_dma_complete;
-		desc->callback_param = host;
-		host->dma_desc = desc;
-		host->dma_chan = dma_chan;
-		host->dma_dir = dir_data;
+	if (!desc) {
+		dma_unmap_sg(dma_chan->device->dev, data->sg, sg_len, dir_data);
+		return;
 	}
+
+	desc->callback = bcm2835_dma_complete;
+	desc->callback_param = host;
+	host->dma_desc = desc;
+	host->dma_chan = dma_chan;
+	host->dma_dir = dir_data;
 }
 
 static void bcm2835_start_dma(struct bcm2835_host *host)
-- 
2.7.4
