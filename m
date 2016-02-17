From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 14:28:49 +0100
Subject: [PATCH 03/13] spi: imx: replace fixed timeout with calculated
In-Reply-To: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1455715739-25161-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>

Fixed timeout value can fire while transaction is ongoing. This may happen
because there are no strict requirements on SPI transaction duration.
Dynamic timeout value is generated based on SCLK and transaction size.

There is also 4 * SCLK delay between TX bursts related to HW internal CS change.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7904d45..b277375 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,7 +56,6 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
-#define IMX_DMA_TIMEOUT (msecs_to_jiffies(3000))
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
@@ -93,6 +92,7 @@ struct spi_imx_data {
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
+	unsigned int spi_bus_clk;
 
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
@@ -333,6 +333,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 
 	/* set clock speed */
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, config->speed_hz, &clk);
+	spi_imx->spi_bus_clk = clk;
 
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
@@ -915,11 +916,26 @@ static void spi_imx_dma_tx_callback(void *cookie)
 	complete(&spi_imx->dma_tx_completion);
 }
 
+static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
+{
+	unsigned long timeout = 0;
+
+	/* Time with actual data transfer and CS change delay related to HW */
+	timeout = (8 + 4) * size / spi_imx->spi_bus_clk;
+
+	/* Add extra second for scheduler related activities */
+	timeout += 1;
+
+	/* Double calculated timeout */
+	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+}
+
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
 	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
 	int ret;
+	unsigned long transfer_timeout;
 	unsigned long timeout;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
@@ -966,16 +982,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	dma_async_issue_pending(master->dma_tx);
 	spi_imx->devtype_data->trigger(spi_imx);
 
+	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
+
 	/* Wait SDMA to finish the data transfer.*/
 	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
-						IMX_DMA_TIMEOUT);
+						transfer_timeout);
 	if (!timeout) {
 		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
 		dmaengine_terminate_all(master->dma_tx);
 		dmaengine_terminate_all(master->dma_rx);
 	} else {
 		timeout = wait_for_completion_timeout(
-				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
+				&spi_imx->dma_rx_completion, transfer_timeout);
 		if (!timeout) {
 			dev_err(spi_imx->dev, "I/O Error in DMA RX\n");
 			spi_imx->devtype_data->reset(spi_imx);
-- 
2.7.0
