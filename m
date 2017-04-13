From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Thu, 13 Apr 2017 05:14:04 -0700
Subject: [PATCH RFC 5/5] spi: imx: Add support for SPI Slave mode for imx53
 and imx6 chips
In-Reply-To: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1492085644-4195-6-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

Previously i.MX SPI controller only works in Master mode.
This patch adds support to work also in Slave mode.

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
    with maximum 2^12 bits.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spi-imx.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 159 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b2323b9..f6e1baa 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -53,9 +53,13 @@
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
+#define MXC_INT_RDR	BIT(4) /* Receive date threshold interrupt */
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
+/* The maximum bytes that IMX53_ECSPI can transfer in slave mode.*/
+#define MX53_MAX_TRANSFER_BYTES		512
+
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
@@ -79,6 +83,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*disable)(struct spi_imx_data *);
 	enum spi_imx_devtype devtype;
 };
 
@@ -104,6 +109,10 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
+	/* Slave mode */
+	unsigned int slave_mode;
+	unsigned int slave_burst;
+
 	/* DMA */
 	bool usedma;
 	u32 wml;
@@ -156,6 +165,19 @@ static inline bool spi_imx_has_dmamode(struct spi_imx_data *d)
 	}
 }
 
+static bool spi_imx_has_slavemode(struct spi_master *master)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+
+	switch (spi_imx->devtype_data->devtype) {
+	case IMX51_ECSPI:
+	case IMX53_ECSPI:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #define MXC_SPI_BUF_RX(type)						\
 static void spi_imx_buf_rx_##type(struct spi_imx_data *spi_imx)		\
 {									\
@@ -285,6 +307,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
+#define MX51_ECSPI_INT_RDREN		(1 <<  4)
 
 #define MX51_ECSPI_DMA      0x14
 #define MX51_ECSPI_DMA_TX_WML(wml)	((wml) & 0x3f)
@@ -301,6 +324,51 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
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
 static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 				      unsigned int fspi, unsigned int *fres)
@@ -350,6 +418,9 @@ static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
 	if (enable & MXC_INT_RR)
 		val |= MX51_ECSPI_INT_RREN;
 
+	if (enable & MXC_INT_RDR)
+		val |= MX51_ECSPI_INT_RDREN;
+
 	writel(val, spi_imx->base + MX51_ECSPI_INT);
 }
 
@@ -362,6 +433,15 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
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
 static int mx51_ecspi_config(struct spi_device *spi,
 			     struct spi_imx_config *config)
 {
@@ -370,14 +450,13 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	u32 clk = config->speed_hz, delay, reg;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
-	/*
-	 * The hardware seems to have a race condition when changing modes. The
-	 * current assumption is that the selection of the channel arrives
-	 * earlier in the hardware than the mode bits when they are written at
-	 * the same time.
-	 * So set master mode for all channels as we do not support slave mode.
-	 */
-	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
+	writel(0, spi_imx->base + MX51_ECSPI_CTRL);
+
+	/* set Master or Slave mode */
+	if (spi_imx->slave_mode)
+		ctrl &= ~MX51_ECSPI_CTRL_MODE_MASK;
+	else
+		ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/* set clock speed */
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, config->speed_hz, &clk);
@@ -386,9 +465,21 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		ctrl |= (spi_imx->slave_burst * 8 - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
+	else
+		ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
 
-	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+	/*
+	 * eCSPI burst completion by Chip Select signal in Slave mode
+	 * is not functional, config SPI burst completed when
+	 * BURST_LENGTH + 1 bits are received
+	 */
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+	else
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
 	if (spi->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
@@ -767,6 +858,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -776,6 +868,7 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.disable = mx51_ecspi_disable,
 	.devtype = IMX53_ECSPI,
 };
 
@@ -838,14 +931,16 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
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
@@ -927,6 +1022,8 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
 
+	spi_imx->slave_mode = spi->slave_mode;
+
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
 	if (!config.bpw)
@@ -944,7 +1041,8 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->tx = spi_imx_buf_tx_u32;
 	}
 
-	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
+	if (!spi->slave_mode &&
+	    spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
 		spi_imx->usedma = 1;
 	else
 		spi_imx->usedma = 0;
@@ -956,6 +1054,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 			return ret;
 	}
 
+	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
+		spi_imx->rx = mx53_ecspi_rx_slave;
+		spi_imx->tx = mx53_ecspi_tx_slave;
+		spi_imx->slave_burst = t->len;
+	}
+
 	spi_imx->devtype_data->config(spi, &config);
 
 	return 0;
@@ -1117,16 +1221,46 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned long transfer_timeout;
 	unsigned long timeout;
+	int ret = transfer->len;
+
+	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode &&
+	    transfer->len > MX53_MAX_TRANSFER_BYTES) {
+		pr_err("Transaction too big, max size is %d bytes\n",
+		       MX53_MAX_TRANSFER_BYTES);
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
 
+	if (spi_imx->slave_mode) {
+		spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE |
+							MXC_INT_RDR);
+
+		if (wait_for_completion_interruptible(&spi_imx->xfer_done) < 0)
+			ret = -EINTR;
+
+		/* ecspi has a HW issue when works in Slave mode,
+		 * after 64 words writtern to TXFIFO, even TXFIFO becomes empty,
+		 * ECSPI_TXDATA keeps shift out the last word data,
+		 * so we have to disable ECSPI when in slave mode after the
+		 * transfer completes
+		 */
+		if (spi_imx->devtype_data->disable)
+			spi_imx->devtype_data->disable(spi_imx);
+
+		goto out;
+	}
+
 	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
@@ -1139,7 +1273,8 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		return -ETIMEDOUT;
 	}
 
-	return transfer->len;
+out:
+	return ret;
 }
 
 static int spi_imx_transfer(struct spi_device *spi,
@@ -1147,6 +1282,10 @@ static int spi_imx_transfer(struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
+	/* flush rxfifo before transfer */
+	while (spi_imx->devtype_data->rx_available(spi_imx))
+		spi_imx->rx(spi_imx);
+
 	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
 	else
@@ -1155,6 +1294,11 @@ static int spi_imx_transfer(struct spi_device *spi,
 
 static int spi_imx_setup(struct spi_device *spi)
 {
+	if (spi->slave_mode) {
+		dev_dbg(&spi->dev, "%s: slave mode\n", __func__);
+		return 0;
+	}
+
 	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
@@ -1254,6 +1398,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
+	spi_imx->bitbang.master->has_slavemode = spi_imx_has_slavemode;
 
 	init_completion(&spi_imx->xfer_done);
 
-- 
2.7.4
