From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 10 Jul 2011 01:16:35 +0800
Subject: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
In-Reply-To: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi_imx_devtype_data has already been driver private data.  There is
really no need to make a copy in spi_imx_data.  Instead, a reference
pointer works perfectly fine.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/spi-imx.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 69d6dba..1c55dc9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -96,7 +96,7 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
-	struct spi_imx_devtype_data devtype_data;
+	struct spi_imx_devtype_data *devtype_data;
 };
 
 #define MXC_SPI_BUF_RX(type)						\
@@ -539,7 +539,7 @@ static void __maybe_unused mx1_reset(struct spi_imx_data *spi_imx)
  * These version numbers are taken from the Freescale driver.  Unfortunately it
  * doesn't support i.MX1, so this entry doesn't match the scheme. :-(
  */
-static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
+static struct spi_imx_devtype_data spi_imx_devtype_data[] = {
 #ifdef CONFIG_SPI_IMX_VER_IMX1
 	[SPI_IMX_VER_IMX1] = {
 		.intctrl = mx1_intctrl,
@@ -607,21 +607,21 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
-	while (spi_imx->txfifo < spi_imx->devtype_data.fifosize) {
+	while (spi_imx->txfifo < spi_imx->devtype_data->fifosize) {
 		if (!spi_imx->count)
 			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
 
-	spi_imx->devtype_data.trigger(spi_imx);
+	spi_imx->devtype_data->trigger(spi_imx);
 }
 
 static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 {
 	struct spi_imx_data *spi_imx = dev_id;
 
-	while (spi_imx->devtype_data.rx_available(spi_imx)) {
+	while (spi_imx->devtype_data->rx_available(spi_imx)) {
 		spi_imx->rx(spi_imx);
 		spi_imx->txfifo--;
 	}
@@ -635,12 +635,12 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 		/* No data left to push, but still waiting for rx data,
 		 * enable receive data available interrupt.
 		 */
-		spi_imx->devtype_data.intctrl(
+		spi_imx->devtype_data->intctrl(
 				spi_imx, MXC_INT_RR);
 		return IRQ_HANDLED;
 	}
 
-	spi_imx->devtype_data.intctrl(spi_imx, 0);
+	spi_imx->devtype_data->intctrl(spi_imx, 0);
 	complete(&spi_imx->xfer_done);
 
 	return IRQ_HANDLED;
@@ -677,7 +677,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	} else
 		BUG();
 
-	spi_imx->devtype_data.config(spi_imx, &config);
+	spi_imx->devtype_data->config(spi_imx, &config);
 
 	return 0;
 }
@@ -696,7 +696,7 @@ static int spi_imx_transfer(struct spi_device *spi,
 
 	spi_imx_push(spi_imx);
 
-	spi_imx->devtype_data.intctrl(spi_imx, MXC_INT_TE);
+	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
 
 	wait_for_completion(&spi_imx->xfer_done);
 
@@ -811,7 +811,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	init_completion(&spi_imx->xfer_done);
 
 	spi_imx->devtype_data =
-		spi_imx_devtype_data[pdev->id_entry->driver_data];
+		&spi_imx_devtype_data[pdev->id_entry->driver_data];
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -854,9 +854,9 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	clk_enable(spi_imx->clk);
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk);
 
-	spi_imx->devtype_data.reset(spi_imx);
+	spi_imx->devtype_data->reset(spi_imx);
 
-	spi_imx->devtype_data.intctrl(spi_imx, 0);
+	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
-- 
1.7.4.1
