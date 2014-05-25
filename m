From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 25 May 2014 17:19:05 +0800
Subject: [PATCH] ata: ep93xx: use dmaengine_prep_slave_sg api instead of
 internal callback
Message-ID: <1401009545-31925-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

it is better to use generic api instead of calling an internal callback
like channel->device->device_prep_slave_sg().

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/ata/pata_ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index cad9d45..6ad5c07 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -708,8 +708,8 @@ static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
 	struct dma_chan *channel = qc->dma_dir == DMA_TO_DEVICE
 		? drv_data->dma_tx_channel : drv_data->dma_rx_channel;
 
-	txd = channel->device->device_prep_slave_sg(channel, qc->sg,
-		 qc->n_elem, qc->dma_dir, DMA_CTRL_ACK, NULL);
+	txd = dmaengine_prep_slave_sg(channel, qc->sg, qc->n_elem, qc->dma_dir,
+		DMA_CTRL_ACK);
 	if (!txd) {
 		dev_err(qc->ap->dev, "failed to prepare slave for sg dma\n");
 		return;
-- 
1.9.3
