From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:57:08 +0100
Subject: [PATCH v5 10/11] spi: imx: replace fixed timeout with calculated
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1449334629-4715-11-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed timeout value can fire while transaction is ongoing. This may happen
because there are no strict requirements on SPI transaction duration.
Dynamic timeout value is generated based on SCLK and transaction size.

There is also 4 * SCLK delay between TX bursts related to HW internal CS change.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index adfa9cf..f7ee288 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,7 +56,6 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
-#define IMX_DMA_TIMEOUT (msecs_to_jiffies(3000))
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
@@ -92,6 +91,7 @@ struct spi_imx_data {
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
+	unsigned int spi_bus_clk;
 
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
@@ -318,7 +318,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 {
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
 	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
-	u32 clk = config->speed_hz, delay;
+	u32 delay;
 	u32 lpb = 0;
 
 	/*
@@ -331,7 +331,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/* set clock speed */
-	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz, &clk);
+	spi_imx->spi_bus_clk = config->speed_hz;
+	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz,
+				  &spi_imx->spi_bus_clk);
 
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
@@ -377,7 +379,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 * the SPI communication as the device on the other end would consider
 	 * the change of SCLK polarity as a clock tick already.
 	 */
-	delay = (2 * 1000000) / clk;
+	delay = (2 * USEC_PER_SEC) / spi_imx->spi_bus_clk;
 	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
 		udelay(delay);
 	else			/* SCLK is _very_ slow */
@@ -911,11 +913,26 @@ static void spi_imx_dma_tx_callback(void *cookie)
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
@@ -962,9 +979,11 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
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
@@ -972,8 +991,10 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
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
-- 
2.6.3
