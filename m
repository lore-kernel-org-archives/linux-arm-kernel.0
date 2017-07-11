From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Jul 2017 15:43:33 +0100
Subject: Applied "spi: imx: introduce fifo_size and has_dmamode in
 spi_imx_devtype_data" to the spi tree
In-Reply-To: <20170608051603.16070-2-jiada_wang@mentor.com>
Message-ID: <E1dUwNx-0005RL-IS@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: imx: introduce fifo_size and has_dmamode in spi_imx_devtype_data

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7da0ab95f90271a42cf122b158f14a5578dcf279 Mon Sep 17 00:00:00 2001
From: jiada wang <jiada_wang@mentor.com>
Date: Thu, 8 Jun 2017 14:16:00 +0900
Subject: [PATCH] spi: imx: introduce fifo_size and has_dmamode in
 spi_imx_devtype_data

Different ECSPI controller has different fifosize and DMA capability,
instead of calling functions to identify these information by check
devtype. add fifo_size and has_dmamode to spi_imx_devtype_data.
so that these information can be directly accessed.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f9698b7aeb3b..d3093f355dfb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -74,6 +74,8 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	bool has_dmamode;
+	unsigned int fifo_size;
 	enum spi_imx_devtype devtype;
 };
 
@@ -125,11 +127,6 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX51_ECSPI;
 }
 
-static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
-{
-	return is_imx51_ecspi(d) ? 64 : 8;
-}
-
 #define MXC_SPI_BUF_RX(type)						\
 static void spi_imx_buf_rx_##type(struct spi_imx_data *spi_imx)		\
 {									\
@@ -219,7 +216,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
 		return false;
 
-	for (i = spi_imx_get_fifosize(spi_imx) / 2; i > 0; i--) {
+	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
 		if (!(transfer->len % (i * bytes_per_word)))
 			break;
 	}
@@ -693,6 +690,8 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.trigger = mx1_trigger,
 	.rx_available = mx1_rx_available,
 	.reset = mx1_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX1_CSPI,
 };
 
@@ -702,6 +701,8 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
 	.reset = mx21_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX21_CSPI,
 };
 
@@ -712,6 +713,8 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
 	.reset = mx21_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX27_CSPI,
 };
 
@@ -721,6 +724,8 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
+	.fifo_size = 8,
+	.has_dmamode = false,
 	.devtype = IMX31_CSPI,
 };
 
@@ -731,6 +736,8 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
+	.fifo_size = 8,
+	.has_dmamode = true,
 	.devtype = IMX35_CSPI,
 };
 
@@ -740,6 +747,8 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.fifo_size = 64,
+	.has_dmamode = true,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -791,7 +800,7 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
-	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
+	while (spi_imx->txfifo < spi_imx->devtype_data->fifo_size) {
 		if (!spi_imx->count)
 			break;
 		spi_imx->tx(spi_imx);
@@ -938,7 +947,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	if (of_machine_is_compatible("fsl,imx6dl"))
 		return 0;
 
-	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
+	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
 	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
@@ -1262,7 +1271,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx35 and i.mx6 now, can remove the constraint
 	 * if validated on other chips.
 	 */
-	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx)) {
+	if (spi_imx->devtype_data->has_dmamode) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
 			goto out_clk_put;
-- 
2.13.2
