From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Feb 2017 11:38:21 +0100
Subject: [PATCH v2 3/6] spi: davinci: use rx buffer as dummy tx buffer
In-Reply-To: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487327904-28311-4-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When doing rx-only transfer, the transfer will fail
if the number of SG entries exceeds 20.
This happens because the eDMA DMA engine is limited
to 20 SG entries in one transaction, and when the
DMA transcation is resumed (which takes > 150us),
rx errors occurs because the slave is still transmitting.
Fix this by using the rx buffer as the dummy tx buffer,
so that resuming the rx transcation happens at the same
time as resuming the tx transcation.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 9823908..2632ae0 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -656,6 +656,12 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		if (!rxdesc)
 			goto err_desc;
 
+		if (!t->tx_buf) {
+			/* use rx buffer as dummy tx buffer */
+			t->tx_sg.sgl = t->rx_sg.sgl;
+			t->tx_sg.nents = t->rx_sg.nents;
+		}
+
 		txdesc = dmaengine_prep_slave_sg(dspi->dma_tx,
 				t->tx_sg.sgl, t->tx_sg.nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -958,7 +964,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
-	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
+	master->flags = SPI_MASTER_MUST_RX;
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
 	master->can_dma = davinci_spi_can_dma;
-- 
2.7.4
