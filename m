From: jiada_wang@mentor.com (Jiada Wang)
Date: Thu, 8 Jun 2017 14:16:03 +0900
Subject: [PATCH linux-next v4 4/4] spi: imx: Add support for SPI Slave mode
In-Reply-To: <20170608051603.16070-1-jiada_wang@mentor.com>
References: <20170608051603.16070-1-jiada_wang@mentor.com>
Message-ID: <20170608051603.16070-5-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously i.MX SPI controller only works in Master mode.
This patch adds support to i.MX51, i.MX53 and i.MX6 ECSPI
controller to work also in Slave mode.

Currently SPI Slave mode support patch has the following limitations:
1. The stale data in RXFIFO will be dropped when the Slave does any new
   transfer.
2. One transfer can be finished only after all transfer->len data been
   transferred to master device
3. Slave device only accepts transfer->len data. Any data longer than this
   from master device will be dropped. Any data shorter than this from
   master will cause SPI to stuck due to mentioned HW limitation 2.
4. Only PIO transfer is supported in Slave mode.

Following HW limitation applies:
1.  ECSPI has a HW issue when works in Slave mode, after 64
    words written to TXFIFO, even TXFIFO becomes empty,
    ECSPI_TXDATA keeps shift out the last word data,
    so we have to disable ECSPI when in slave mode after the
    transfer completes
2.  Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip
    Select (SS) signal in Slave mode is not functional" burst size must
    be set exactly to the size of the transfer. This limit SPI transaction
    with maximum 2^12 bits. This errata affects i.MX53 and i.MX6 ECSPI
    controllers.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spi-imx.c | 226 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 196 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 8e6f339..8211cad 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -53,9 +53,12 @@
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
+#define MXC_INT_RDR	BIT(4) /* Receive date threshold interrupt */
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
+/* The maximum bytes that IMX53_ECSPI can transfer in slave mode.*/
+#define MX53_MAX_TRANSFER_BYTES		512
 
 enum spi_imx_devtype {
 	IMX1_CSPI,
@@ -75,7 +78,9 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*disable)(struct spi_imx_data *);
 	bool has_dmamode;
+	bool has_slavemode;
 	unsigned int fifo_size;
 	enum spi_imx_devtype devtype;
 };
@@ -104,6 +109,11 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
+	/* Slave mode */
+	bool slave_mode;
+	bool slave_aborted;
+	unsigned int slave_burst;
+
 	/* DMA */
 	bool usedma;
 	u32 wml;
@@ -217,6 +227,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (!master->dma_rx)
 		return false;
 
+	if (spi_imx->slave_mode)
+		return false;
+
 	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
 
 	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
@@ -256,6 +269,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
+#define MX51_ECSPI_INT_RDREN		(1 <<  4)
 
 #define MX51_ECSPI_DMA      0x14
 #define MX51_ECSPI_DMA_TX_WML(wml)	((wml) & 0x3f)
@@ -272,6 +286,44 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
+static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
+{
+	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
+
+	if (spi_imx->rx_buf) {
+		int n_bytes = spi_imx->slave_burst % sizeof(val);
+
+		if (!n_bytes)
+			n_bytes = sizeof(val);
+
+		memcpy(spi_imx->rx_buf,
+		       ((u8 *)&val) + sizeof(val) - n_bytes, n_bytes);
+
+		spi_imx->rx_buf += n_bytes;
+		spi_imx->slave_burst -= n_bytes;
+	}
+}
+
+static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
+{
+	u32 val = 0;
+	int n_bytes = spi_imx->count % sizeof(val);
+
+	if (!n_bytes)
+		n_bytes = sizeof(val);
+
+	if (spi_imx->tx_buf) {
+		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
+		       spi_imx->tx_buf, n_bytes);
+		val = cpu_to_be32(val);
+		spi_imx->tx_buf += n_bytes;
+	}
+
+	spi_imx->count -= n_bytes;
+
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
+}
+
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 				      unsigned int fspi, unsigned int *fres)
@@ -321,6 +373,9 @@ static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
 	if (enable & MXC_INT_RR)
 		val |= MX51_ECSPI_INT_RREN;
 
+	if (enable & MXC_INT_RDR)
+		val |= MX51_ECSPI_INT_RDREN;
+
 	writel(val, spi_imx->base + MX51_ECSPI_INT);
 }
 
@@ -333,6 +388,15 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
+{
+	u32 ctrl;
+
+	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	ctrl &= ~MX51_ECSPI_CTRL_ENABLE;
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+}
+
 static int mx51_ecspi_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -340,14 +404,11 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	u32 clk = spi_imx->speed_hz, delay, reg;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
-	/*
-	 * The hardware seems to have a race condition when changing modes. The
-	 * current assumption is that the selection of the channel arrives
-	 * earlier in the hardware than the mode bits when they are written at
-	 * the same time.
-	 * So set master mode for all channels as we do not support slave mode.
-	 */
-	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
+	/* set Master or Slave mode */
+	if (spi_imx->slave_mode)
+		ctrl &= ~MX51_ECSPI_CTRL_MODE_MASK;
+	else
+		ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/*
 	 * Enable SPI_RDY handling (falling edge/level triggered).
@@ -362,9 +423,22 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	ctrl |= (spi_imx->bits_per_word - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		ctrl |= (spi_imx->slave_burst * 8 - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
+	else
+		ctrl |= (spi_imx->bits_per_word - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
 
-	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+	/*
+	 * eCSPI burst completion by Chip Select signal in Slave mode
+	 * is not functional for imx53 Soc, config SPI burst completed when
+	 * BURST_LENGTH + 1 bits are received
+	 */
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+	else
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
 	if (spi->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
@@ -698,6 +772,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.reset = mx1_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.has_slavemode = false,
 	.devtype = IMX1_CSPI,
 };
 
@@ -709,6 +784,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.reset = mx21_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.has_slavemode = false,
 	.devtype = IMX21_CSPI,
 };
 
@@ -721,6 +797,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	.reset = mx21_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.has_slavemode = false,
 	.devtype = IMX27_CSPI,
 };
 
@@ -732,6 +809,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.reset = mx31_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.has_slavemode = false,
 	.devtype = IMX31_CSPI,
 };
 
@@ -744,6 +822,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.reset = mx31_reset,
 	.fifo_size = 8,
 	.has_dmamode = true,
+	.has_slavemode = false,
 	.devtype = IMX35_CSPI,
 };
 
@@ -755,6 +834,8 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
+	.has_slavemode = true,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -766,6 +847,8 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
+	.has_slavemode = true,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX53_ECSPI,
 };
 
@@ -828,14 +911,16 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 		spi_imx->txfifo++;
 	}
 
-	spi_imx->devtype_data->trigger(spi_imx);
+	if (!spi_imx->slave_mode)
+		spi_imx->devtype_data->trigger(spi_imx);
 }
 
 static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 {
 	struct spi_imx_data *spi_imx = dev_id;
 
-	while (spi_imx->devtype_data->rx_available(spi_imx)) {
+	while (spi_imx->txfifo &&
+	       spi_imx->devtype_data->rx_available(spi_imx)) {
 		spi_imx->rx(spi_imx);
 		spi_imx->txfifo--;
 	}
@@ -939,6 +1024,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 			return ret;
 	}
 
+	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
+		spi_imx->rx = mx53_ecspi_rx_slave;
+		spi_imx->tx = mx53_ecspi_tx_slave;
+		spi_imx->slave_burst = t->len;
+	}
+
 	spi_imx->devtype_data->config(spi);
 
 	return 0;
@@ -1123,11 +1214,61 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	return transfer->len;
 }
 
+static int spi_imx_pio_transfer_slave(struct spi_device *spi,
+				      struct spi_transfer *transfer)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	int ret = transfer->len;
+
+	if (is_imx53_ecspi(spi_imx) &&
+	    transfer->len > MX53_MAX_TRANSFER_BYTES) {
+		dev_err(&spi->dev, "Transaction too big, max size is %d bytes\n",
+			MX53_MAX_TRANSFER_BYTES);
+		return -EMSGSIZE;
+	}
+
+	spi_imx->tx_buf = transfer->tx_buf;
+	spi_imx->rx_buf = transfer->rx_buf;
+	spi_imx->count = transfer->len;
+	spi_imx->txfifo = 0;
+
+	reinit_completion(&spi_imx->xfer_done);
+	spi_imx->slave_aborted = false;
+
+	spi_imx_push(spi_imx);
+
+	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE | MXC_INT_RDR);
+
+	if (wait_for_completion_interruptible(&spi_imx->xfer_done) ||
+	    spi_imx->slave_aborted) {
+		dev_dbg(&spi->dev, "interrupted\n");
+		ret = -EINTR;
+	}
+
+	/* ecspi has a HW issue when works in Slave mode,
+	 * after 64 words writtern to TXFIFO, even TXFIFO becomes empty,
+	 * ECSPI_TXDATA keeps shift out the last word data,
+	 * so we have to disable ECSPI when in slave mode after the
+	 * transfer completes
+	 */
+	if (spi_imx->devtype_data->disable)
+		spi_imx->devtype_data->disable(spi_imx);
+
+	return ret;
+}
+
 static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
+	/* flush rxfifo before transfer */
+	while (spi_imx->devtype_data->rx_available(spi_imx))
+		spi_imx->rx(spi_imx);
+
+	if (spi_imx->slave_mode)
+		return spi_imx_pio_transfer_slave(spi, transfer);
+
 	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
 	else
@@ -1181,6 +1322,16 @@ spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 
+static int spi_imx_slave_abort(struct spi_master *master)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+
+	spi_imx->slave_aborted = true;
+	complete(&spi_imx->xfer_done);
+
+	return 0;
+}
+
 static int spi_imx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1192,13 +1343,24 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
 	int i, ret, irq, spi_drctl;
+	const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
+		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
+	bool slave_mode;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
 		return -EINVAL;
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
+	slave_mode = devtype_data->has_slavemode &&
+			of_property_read_bool(np, "spi-slave");
+	if (slave_mode)
+		master = spi_alloc_slave(&pdev->dev,
+					 sizeof(struct spi_imx_data));
+	else
+		master = spi_alloc_master(&pdev->dev,
+					  sizeof(struct spi_imx_data));
+
 	ret = of_property_read_u32(np, "fsl,spi-rdy-drctl", &spi_drctl);
 	if ((ret < 0) || (spi_drctl >= 0x3)) {
 		/* '11' is reserved */
@@ -1216,9 +1378,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
 	spi_imx->dev = &pdev->dev;
+	spi_imx->slave_mode = slave_mode;
 
-	spi_imx->devtype_data = of_id ? of_id->data :
-		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
+	spi_imx->devtype_data = devtype_data;
 
 	if (mxc_platform_info) {
 		master->num_chipselect = mxc_platform_info->num_chipselect;
@@ -1238,6 +1400,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
+	spi_imx->bitbang.master->slave_abort = spi_imx_slave_abort;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
@@ -1314,23 +1477,26 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	if (!master->cs_gpios) {
-		dev_err(&pdev->dev, "No CS GPIOs available\n");
-		ret = -EINVAL;
-		goto out_clk_put;
-	}
-
-	for (i = 0; i < master->num_chipselect; i++) {
-		if (!gpio_is_valid(master->cs_gpios[i]))
-			continue;
-
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
-				master->cs_gpios[i]);
+	if (!spi_imx->slave_mode) {
+		if (!master->cs_gpios) {
+			dev_err(&pdev->dev, "No CS GPIOs available\n");
+			ret = -EINVAL;
 			goto out_clk_put;
 		}
+
+		for (i = 0; i < master->num_chipselect; i++) {
+			if (!gpio_is_valid(master->cs_gpios[i]))
+				continue;
+
+			ret = devm_gpio_request(&pdev->dev,
+						master->cs_gpios[i],
+						DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
+					master->cs_gpios[i]);
+				goto out_clk_put;
+			}
+		}
 	}
 
 	dev_info(&pdev->dev, "probed\n");
-- 
2.9.3
