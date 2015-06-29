From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 29 Jun 2015 21:04:27 +0800
Subject: [PATCH v2 1/4] spi: support spi without dma channel to use can_dma()
In-Reply-To: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1435583070-9600-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For spi without dma channel and use can_dma(), it can
use master->dev for struct device.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/spi/spi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d5d7d22..cfd76e9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -539,8 +539,15 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 	if (!master->can_dma)
 		return 0;
 
-	tx_dev = master->dma_tx->device->dev;
-	rx_dev = master->dma_rx->device->dev;
+	if (master->dma_tx)
+		tx_dev = master->dma_tx->device->dev;
+	else
+		tx_dev = &master->dev;
+
+	if (master->dma_rx)
+		rx_dev = master->dma_rx->device->dev;
+	else
+		rx_dev = &master->dev;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!master->can_dma(master, msg->spi, xfer))
@@ -579,8 +586,15 @@ static int spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 	if (!master->cur_msg_mapped || !master->can_dma)
 		return 0;
 
-	tx_dev = master->dma_tx->device->dev;
-	rx_dev = master->dma_rx->device->dev;
+	if (master->dma_tx)
+		tx_dev = master->dma_tx->device->dev;
+	else
+		tx_dev = &master->dev;
+
+	if (master->dma_rx)
+		rx_dev = master->dma_rx->device->dev;
+	else
+		rx_dev = &master->dev;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!master->can_dma(master, msg->spi, xfer))
-- 
1.8.1.1.dirty
