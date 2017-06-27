From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 27 Jun 2017 17:45:20 +0200
Subject: [PATCHv2 8/9] spi: stm32: fix potential dereference null return value
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498578321-13980-9-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the usage of rx_dma_desc and tx_dma_desc pointers
returned by dmaengine_prep_slave_sg, which can be null.

Detected by CoverityScan, CID#1446587 ("Dereference null return value")

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spi-stm32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index fdbc648..bee74e3 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -775,9 +775,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					xfer->rx_sg.nents,
 					rx_dma_conf.direction,
 					DMA_PREP_INTERRUPT);
-
-		rx_dma_desc->callback = stm32_spi_dma_cb;
-		rx_dma_desc->callback_param = spi;
 	}
 
 	tx_dma_desc = NULL;
@@ -790,11 +787,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					xfer->tx_sg.nents,
 					tx_dma_conf.direction,
 					DMA_PREP_INTERRUPT);
-
-		if (spi->cur_comm == SPI_SIMPLEX_TX) {
-			tx_dma_desc->callback = stm32_spi_dma_cb;
-			tx_dma_desc->callback_param = spi;
-		}
 	}
 
 	if ((spi->tx_buf && !tx_dma_desc) ||
@@ -802,6 +794,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		goto dma_desc_error;
 
 	if (rx_dma_desc) {
+		rx_dma_desc->callback = stm32_spi_dma_cb;
+		rx_dma_desc->callback_param = spi;
+
 		if (dma_submit_error(dmaengine_submit(rx_dma_desc))) {
 			dev_err(spi->dev, "Rx DMA submit failed\n");
 			goto dma_desc_error;
@@ -811,6 +806,11 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	if (tx_dma_desc) {
+		if (spi->cur_comm == SPI_SIMPLEX_TX) {
+			tx_dma_desc->callback = stm32_spi_dma_cb;
+			tx_dma_desc->callback_param = spi;
+		}
+
 		if (dma_submit_error(dmaengine_submit(tx_dma_desc))) {
 			dev_err(spi->dev, "Tx DMA submit failed\n");
 			goto dma_submit_error;
-- 
1.9.1
