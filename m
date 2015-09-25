From: anton_bondarenko@mentor.com (Anton Bondarenko)
Date: Fri, 25 Sep 2015 19:57:15 +0200
Subject: [PATCH v2 8/8] spi: imx: Add support for SPI Slave mode for imx53 and
 imx6 chips
In-Reply-To: <cover.1442923630.git.anton_bondarenko@mentor.com>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
Message-ID: <cf6fb92ac2c64a2a7efca7996f4699941f56ec2e.1442923630.git.anton_bondarenko@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently i.MX SPI controller only works in Master mode.
This patch adds support to work also in Slave mode by adding
"fsl,spi-slave-mode" in corresponding ecspi node in devicetree.

Currently SPI Slave mode support patch has the following limitations:
1. The stale data in RXFIFO will be dropped when the Slave does any new
   transfer.
2. One transfer can be finished only after all transfer->len data been
   transferred to master device
3. Slave device only accepts transfer->len data. Any data longer than this
   from master device will be dropped. Any data shorter than this from
   master will cause SPI to stuck du to mentioned HW limitation 2.

Following HW limitation applies:
1.  ECSPI has a HW issue when works in Slave mode, after 64
    words written to TXFIFO, even TXFIFO becomes empty,
    ECSPI_TXDATA keeps shift out the last word data,
    so we have to disable ECSPI when in slave mode after the
    transfer completes
2.  Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip
    Select (SS) signal in Slave mode is not functional" burst size must
    be set exactly to the size of the transfer. This limit SPI transaction
    with maximum 2^12 bits.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Muzaffar Mahmood <muzaffar_mahmood@mentor.com>
Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
---
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   1 +
 drivers/spi/spi-imx.c                              | 169 ++++++++++++++++++---
 2 files changed, 146 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 425485f..ffe28f2 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -15,6 +15,7 @@ Required properties:
 - interrupts : Should contain CSPI/eCSPI interrupt
 - fsl,spi-num-chipselects : Contains the number of the chipselect
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
+- fsl,spi-slave-mode : Indicate the spi controller works in Slave mode.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
 See the clock consumer binding,
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 1bf0739a..f271d1e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -55,6 +55,7 @@
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
+#define MXC_INT_RDR	BIT(4) /* Receive date threshold interrupt */
 #define MXC_INT_TCEN	BIT(7)   /* Transfer complete */
 
 /* The maximum  bytes that a sdma BD can transfer.*/
@@ -84,6 +85,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*disable)(struct spi_imx_data *);
 	enum spi_imx_devtype devtype;
 };
 
@@ -108,6 +110,10 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
+	unsigned int slave_mode;
+	unsigned int slave_burst;
+	unsigned int total_count;
+
 	/* DMA */
 	unsigned int dma_is_inited;
 	unsigned int dma_finished;
@@ -248,6 +254,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
+#define MX51_ECSPI_INT_RDREN	BIT(4)
 #define MX51_ECSPI_INT_TCEN		BIT(7)
 
 #define MX51_ECSPI_DMA      0x14
@@ -268,6 +275,52 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TEST			0x20
 #define MX51_ECSPI_LOOP			BIT(31)
 
+static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
+{
+	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
+
+	if (spi_imx->rx_buf) {
+		int shift = spi_imx->slave_burst % sizeof(val);
+
+		if (shift) {
+			memcpy(spi_imx->rx_buf,
+			       ((u8 *)&val) + sizeof(val) - shift, shift);
+		} else {
+			*((u32 *)spi_imx->rx_buf) = val;
+			shift = sizeof(val);
+		}
+
+		spi_imx->rx_buf += shift;
+		spi_imx->slave_burst -= shift;
+	}
+}
+
+static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
+{
+	u32 val = 0;
+	int shift = spi_imx->count % sizeof(val);
+
+	if (spi_imx->tx_buf) {
+		if (shift) {
+			memcpy(((u8 *)&val) + sizeof(val) - shift,
+			       spi_imx->tx_buf, shift);
+		} else {
+			val = *((u32 *)spi_imx->tx_buf);
+			shift = sizeof(val);
+		}
+
+		val = cpu_to_be32(val);
+		spi_imx->tx_buf += shift;
+	}
+
+	if (!shift)
+		shift = sizeof(val);
+
+	spi_imx->count -= shift;
+
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
+}
+
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
 				      unsigned int *fres)
@@ -316,6 +369,9 @@ static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int
 	if (enable & MXC_INT_RR)
 		val |= MX51_ECSPI_INT_RREN;
 
+	if (enable & MXC_INT_RDR)
+		val |= MX51_ECSPI_INT_RDREN;
+
 	if (enable & MXC_INT_TCEN)
 		val |= MX51_ECSPI_INT_TCEN;
 
@@ -335,6 +391,15 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static void __maybe_unused mx51_ecspi_disable(struct spi_imx_data *spi_imx)
+{
+	u32 ctrl;
+
+	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	ctrl &= ~MX51_ECSPI_CTRL_ENABLE;
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+}
+
 static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
@@ -343,14 +408,11 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	u32 delay;
 	u32 lpb = 0;
 
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
 
 	/* set clock speed */
 	spi_imx->spi_bus_clk = config->speed_hz;
@@ -360,9 +422,22 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
 
-	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		ctrl |= (spi_imx->slave_burst * 8 - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
+	else
+		ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+
 
-	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
+	/*
+	 * eCSPI burst completion by Chip Select signal in Slave mode
+	 * is not functional, config SPI burst completed when
+	 * BURST_LENGTH + 1 bits are received
+	 */
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
+	else
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
 
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
@@ -402,11 +477,11 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
 	 */
-	if (spi_imx->dma_is_inited) {
-		dma = (spi_imx->wml - 1) << MX51_ECSPI_DMA_RX_WML_OFFSET
-		      | (spi_imx->wml - 1) << MX51_ECSPI_DMA_TX_WML_OFFSET
-		      | (1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
-		      | (1 << MX51_ECSPI_DMA_RXDEN_OFFSET);
+	if (spi_imx->dma_is_inited || spi_imx->slave_mode) {
+		dma = (spi_imx->wml - 1) << MX51_ECSPI_DMA_RX_WML_OFFSET;
+		if (spi_imx->dma_is_inited)
+			dma |=  (1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
+			      | (1 << MX51_ECSPI_DMA_RXDEN_OFFSET);
 
 		writel(dma, spi_imx->base + MX51_ECSPI_DMA);
 	}
@@ -697,6 +772,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -707,6 +783,7 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX53_ECSPI,
 };
 
@@ -775,14 +852,16 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
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
@@ -894,6 +973,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 			pr_err("Can't configure SDMA, error %d\n", ret);
 	}
 
+	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
+		spi_imx->rx = mx53_ecspi_rx_slave;
+		spi_imx->tx = mx53_ecspi_tx_slave;
+		spi_imx->slave_burst = t->len;
+	}
+
 	if (!ret)
 		ret = spi_imx->devtype_data->config(spi_imx, &config);
 
@@ -926,8 +1011,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	if (of_machine_is_compatible("fsl,imx6dl"))
 		return 0;
 
-	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
-
 	/* Prepare for TX DMA: */
 	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
@@ -1139,21 +1222,45 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	int result = transfer->len;
+
+	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode &&
+	    transfer->len > 512) {
+		pr_err("Transaction too big, max size is %d bytes\n", 512);
+		return -EMSGSIZE;
+	}
 
 	spi_imx->tx_buf = transfer->tx_buf;
 	spi_imx->rx_buf = transfer->rx_buf;
 	spi_imx->count = transfer->len;
 	spi_imx->txfifo = 0;
 
+	if (spi_imx->slave_mode)
+		spi_imx->slave_burst = spi_imx->count;
+
 	reinit_completion(&spi_imx->xfer_done);
 
 	spi_imx_push(spi_imx);
 
-	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
+	if (spi_imx->slave_mode)
+		spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE |
+							MXC_INT_RDR);
+	else
+		spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
+
+	if (wait_for_completion_interruptible(&spi_imx->xfer_done) < 0)
+		result = -EINTR;
 
-	wait_for_completion(&spi_imx->xfer_done);
+	/* ecspi has a HW issue when works in Slave mode,
+	 * after 64 words writtern to TXFIFO, even TXFIFO becomes empty,
+	 * ECSPI_TXDATA keeps shift out the last word data,
+	 * so we have to disable ECSPI when in slave mode after the
+	 * transfer completes
+	 */
+	if (spi_imx->slave_mode && spi_imx->devtype_data->disable)
+		spi_imx->devtype_data->disable(spi_imx);
 
-	return transfer->len;
+	return result;
 }
 
 static int spi_imx_transfer(struct spi_device *spi,
@@ -1162,6 +1269,10 @@ static int spi_imx_transfer(struct spi_device *spi,
 	int ret;
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
+	/* flush rxfifo before transfer */
+	while (spi_imx->devtype_data->rx_available(spi_imx))
+		spi_imx->rx(spi_imx);
+
 	if (spi_imx->bitbang.master->can_dma &&
 	    spi_imx_can_dma(spi_imx->bitbang.master, spi, transfer)) {
 		spi_imx->usedma = true;
@@ -1265,11 +1376,19 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 
+	if (of_get_property(np, "fsl,spi-slave-mode", NULL) &&
+	    is_imx5x_ecspi(spi_imx))
+		spi_imx->slave_mode = 1;
+
 	for (i = 0; i < master->num_chipselect; i++) {
 		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
 		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
 			cs_gpio = mxc_platform_info->chipselect[i];
 
+		/* slave mode doesn't support cs gpio */
+		if (spi_imx->slave_mode)
+			cs_gpio = -ENODEV;
+
 		spi_imx->chipselect[i] = cs_gpio;
 		if (!gpio_is_valid(cs_gpio))
 			continue;
@@ -1292,11 +1411,13 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA |
 				SPI_CS_HIGH;
 
-	if (is_imx5x_ecspi(spi_imx))
+	if (is_imx5x_ecspi(spi_imx) && !spi_imx->slave_mode)
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
 
 	init_completion(&spi_imx->xfer_done);
 
+	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spi_imx->base)) {
@@ -1343,7 +1464,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx6 now, can remove the constrain if validated on
 	 * other chips.
 	 */
-	if (is_imx5x_ecspi(spi_imx)) {
+	if (!spi_imx->slave_mode && is_imx5x_ecspi(spi_imx)) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
 			goto out_clk_put;
-- 
2.5.2
