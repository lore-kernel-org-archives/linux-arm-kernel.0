From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sun,  1 Nov 2015 15:41:36 +0100
Subject: [PATCH v3 2/7] spi: imx: replace fixed timeout with calculated one
In-Reply-To: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1446388901-6073-3-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anton Bondarenko <anton_bondarenko@mentor.com>

Fixed timeout value can fire while transaction is ongoing. This may happen
because there are no strict requirements on SPI transaction duration.
Dynamic timeout value is generated based on SCLK and transaction size.

There is also 4 * SCLK delay between TX bursts related to CS change.

Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
---
 drivers/spi/spi-imx.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index bd7b721..9b80c7f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -57,7 +57,6 @@
 
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
@@ -314,8 +314,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 {
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
-
-	u32 clk = config->speed_hz, delay;
+	u32 delay;
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -327,7 +326,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/* set clock speed */
-	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz, &clk);
+	spi_imx->spi_bus_clk = config->speed_hz;
+	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz,
+				  &spi_imx->spi_bus_clk);
 
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
@@ -367,7 +368,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 * the SPI communication as the device on the other end would consider
 	 * the change of SCLK polarity as a clock tick already.
 	 */
-	delay = (2 * 1000000) / clk;
+	delay = (2 * USEC_PER_SEC) / spi_imx->spi_bus_clk;
 	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
 		udelay(delay);
 	else			/* SCLK is _very_ slow */
@@ -890,12 +891,40 @@ static void spi_imx_dma_tx_callback(void *cookie)
 	complete(&spi_imx->dma_tx_completion);
 }
 
+static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
+{
+	unsigned long coef1 = 1;
+	unsigned long coef2 = MSEC_PER_SEC;
+	unsigned long timeout = 0;
+
+	/* Swap coeficients to avoid div by 0 */
+	if (spi_imx->spi_bus_clk < MSEC_PER_SEC) {
+		coef1 = MSEC_PER_SEC;
+		coef2 = 1;
+	}
+
+	/* Time with actual data transfer */
+	timeout += DIV_ROUND_UP(8 * size * coef1,
+				spi_imx->spi_bus_clk / coef2);
+
+	/* Take CS change delay related to HW */
+	timeout += DIV_ROUND_UP((size - 1) * 4 * coef1,
+				spi_imx->spi_bus_clk / coef2);
+
+	/* Add extra second for scheduler related activities */
+	timeout += MSEC_PER_SEC;
+
+	/* Double calculated timeout */
+	return msecs_to_jiffies(2 * timeout);
+}
+
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
 	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
 	int ret;
 	unsigned long timeout;
+	unsigned long transfer_timeout;
 	const int left = transfer->len % spi_imx->wml;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
@@ -956,9 +985,11 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	dma_async_issue_pending(master->dma_tx);
 	spi_imx->devtype_data->trigger(spi_imx);
 
+	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
+
 	/* Wait SDMA to finish the data transfer.*/
 	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
-						IMX_DMA_TIMEOUT);
+						transfer_timeout);
 	if (!timeout) {
 		pr_warn("%s %s: I/O Error in DMA TX\n",
 			dev_driver_string(&master->dev),
@@ -966,8 +997,10 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		dmaengine_terminate_all(master->dma_tx);
 		dmaengine_terminate_all(master->dma_rx);
 	} else {
+		transfer_timeout = spi_imx_calculate_timeout(spi_imx,
+							     spi_imx->wml);
 		timeout = wait_for_completion_timeout(
-				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
+				&spi_imx->dma_rx_completion, transfer_timeout);
 		if (!timeout) {
 			pr_warn("%s %s: I/O Error in DMA RX\n",
 				dev_driver_string(&master->dev),
@@ -989,7 +1022,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 			spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TCEN);
 
 			timeout = wait_for_completion_timeout(
-					&spi_imx->xfer_done, IMX_DMA_TIMEOUT);
+					&spi_imx->xfer_done, transfer_timeout);
 			if (!timeout) {
 				pr_warn("%s %s: I/O Error in RX tail\n",
 					dev_driver_string(&master->dev),
-- 
2.6.2
