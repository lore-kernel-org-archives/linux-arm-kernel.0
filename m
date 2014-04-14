From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 Apr 2014 14:30:01 +0800
Subject: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
In-Reply-To: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

sometimes t->tx can be equal with t->rx. for example, spidev will make
tx and rx point to spidev->buffer at the same time. currently, for this
case, we map the buffer BIDIRECTION to fix the cache consistency.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 3c12f39..0c039d4 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -383,7 +383,8 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 		struct dma_async_tx_descriptor *rx_desc, *tx_desc;
 
 		sspi->dst_start = dma_map_single(&spi->dev,
-				sspi->rx, t->len, DMA_FROM_DEVICE);
+				sspi->rx, t->len, (t->tx_buf != t->rx_buf) ?
+				DMA_FROM_DEVICE : DMA_BIDIRECTIONAL);
 		rx_desc = dmaengine_prep_slave_single(sspi->rx_chan,
 			sspi->dst_start, t->len, DMA_DEV_TO_MEM,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -391,7 +392,9 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 		rx_desc->callback_param = &sspi->rx_done;
 
 		sspi->src_start = dma_map_single(&spi->dev,
-				(void *)sspi->tx, t->len, DMA_TO_DEVICE);
+				(void *)sspi->tx, t->len,
+				(t->tx_buf != t->rx_buf) ?
+				DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
 		tx_desc = dmaengine_prep_slave_single(sspi->tx_chan,
 			sspi->src_start, t->len, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-- 
1.7.5.4
