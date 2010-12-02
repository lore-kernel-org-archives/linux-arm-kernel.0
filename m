From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:35 +0100
Subject: [PATCH 7/9] spi/pxa2xx: Add chipselect support for Sodaville
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291312057-7933-8-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI core on Sodaville supports chip selects. Its configuration
moved into the SSSR register at bit 0 and 1. Thus Sodaville can be hooked
up with up to 4 devices.
This patch ensures that the bits which are otherwiese reserved are only
touched on Sodaville and not on any other PXAs. Also it makes sure that
the status register does not lose the CS information while clearing the
ROR bit.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/pxa2xx_spi.c   |   93 ++++++++++++++++++++++++++++++++------------
 include/linux/pxa2xx_ssp.h |    2 +
 2 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 81cfbbc..a54685b 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -163,7 +163,10 @@ struct chip_data {
 	u8 enable_dma;
 	u8 bits_per_word;
 	u32 speed_hz;
-	int gpio_cs;
+	union {
+		int gpio_cs;
+		unsigned int frm;
+	};
 	int gpio_cs_inverted;
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
@@ -176,6 +179,11 @@ static void cs_assert(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	if (drv_data->ssp_type == CE4100_SSP) {
+		write_SSSR(drv_data->cur_chip->frm, drv_data->ioaddr);
+		return;
+	}
+
 	if (chip->cs_control) {
 		chip->cs_control(PXA2XX_CS_ASSERT);
 		return;
@@ -189,6 +197,9 @@ static void cs_deassert(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	if (drv_data->ssp_type == CE4100_SSP)
+		return;
+
 	if (chip->cs_control) {
 		chip->cs_control(PXA2XX_CS_DEASSERT);
 		return;
@@ -198,6 +209,25 @@ static void cs_deassert(struct driver_data *drv_data)
 		gpio_set_value(chip->gpio_cs, !chip->gpio_cs_inverted);
 }
 
+static void write_SSSR_CS(struct driver_data *drv_data, u32 val)
+{
+	void __iomem *reg = drv_data->ioaddr;
+
+	if (drv_data->ssp_type == CE4100_SSP)
+		val |= read_SSSR(reg) & SSSR_ALT_FRM_MASK;
+
+	write_SSSR(val, reg);
+}
+
+static int pxa25x_ssp_comp(struct driver_data *drv_data)
+{
+	if (drv_data->ssp_type == PXA25x_SSP)
+		return 1;
+	if (drv_data->ssp_type == CE4100_SSP)
+		return 1;
+	return 0;
+}
+
 static int flush(struct driver_data *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
@@ -209,7 +239,7 @@ static int flush(struct driver_data *drv_data)
 			read_SSDR(reg);
 		}
 	} while ((read_SSSR(reg) & SSSR_BSY) && --limit);
-	write_SSSR(SSSR_ROR, reg);
+	write_SSSR_CS(drv_data, SSSR_ROR);
 
 	return limit;
 }
@@ -502,9 +532,9 @@ static void dma_error_stop(struct driver_data *drv_data, const char *msg)
 	/* Stop and reset */
 	DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
 	DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
-	write_SSSR(drv_data->clear_sr, reg);
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	write_SSCR1(read_SSCR1(reg) & ~drv_data->dma_cr1, reg);
-	if (drv_data->ssp_type != PXA25x_SSP)
+	if (!pxa25x_ssp_comp(drv_data))
 		write_SSTO(0, reg);
 	flush(drv_data);
 	write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
@@ -524,7 +554,7 @@ static void dma_transfer_complete(struct driver_data *drv_data)
 
 	/* Clear and disable interrupts on SSP and DMA channels*/
 	write_SSCR1(read_SSCR1(reg) & ~drv_data->dma_cr1, reg);
-	write_SSSR(drv_data->clear_sr, reg);
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
 	DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
 
@@ -617,7 +647,7 @@ static irqreturn_t dma_transfer(struct driver_data *drv_data)
 
 		/* Clear and disable timeout interrupt, do the rest in
 		 * dma_transfer_complete */
-		if (drv_data->ssp_type != PXA25x_SSP)
+		if (!pxa25x_ssp_comp(drv_data))
 			write_SSTO(0, reg);
 
 		/* finish this transfer, start the next */
@@ -635,9 +665,9 @@ static void int_error_stop(struct driver_data *drv_data, const char* msg)
 	void __iomem *reg = drv_data->ioaddr;
 
 	/* Stop and reset SSP */
-	write_SSSR(drv_data->clear_sr, reg);
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
-	if (drv_data->ssp_type != PXA25x_SSP)
+	if (!pxa25x_ssp_comp(drv_data))
 		write_SSTO(0, reg);
 	flush(drv_data);
 	write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
@@ -653,9 +683,9 @@ static void int_transfer_complete(struct driver_data *drv_data)
 	void __iomem *reg = drv_data->ioaddr;
 
 	/* Stop SSP */
-	write_SSSR(drv_data->clear_sr, reg);
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
-	if (drv_data->ssp_type != PXA25x_SSP)
+	if (!pxa25x_ssp_comp(drv_data))
 		write_SSTO(0, reg);
 
 	/* Update total byte transfered return count actual bytes read */
@@ -711,7 +741,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	if (drv_data->tx == drv_data->tx_end) {
 		write_SSCR1(read_SSCR1(reg) & ~SSCR1_TIE, reg);
 		/* PXA25x_SSP has no timeout, read trailing bytes */
-		if (drv_data->ssp_type == PXA25x_SSP) {
+		if (pxa25x_ssp_comp(drv_data)) {
 			if (!wait_ssp_rx_stall(reg))
 			{
 				int_error_stop(drv_data, "interrupt_transfer: "
@@ -754,9 +784,9 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 
 		write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
 		write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
-		if (drv_data->ssp_type != PXA25x_SSP)
+		if (!pxa25x_ssp_comp(drv_data))
 			write_SSTO(0, reg);
-		write_SSSR(drv_data->clear_sr, reg);
+		write_SSSR_CS(drv_data, drv_data->clear_sr);
 
 		dev_err(&drv_data->pdev->dev, "bad message state "
 			"in interrupt handler\n");
@@ -869,7 +899,7 @@ static unsigned int ssp_get_clk_div(struct ssp_device *ssp, int rate)
 {
 	unsigned long ssp_clk = clk_get_rate(ssp->clk);
 
-	if (ssp->type == PXA25x_SSP)
+	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
 		return ((ssp_clk / (2 * rate) - 1) & 0xff) << 8;
 	else
 		return ((ssp_clk / rate - 1) & 0xfff) << 8;
@@ -1095,7 +1125,7 @@ static void pump_transfers(unsigned long data)
 
 		/* Clear status  */
 		cr1 = chip->cr1 | chip->threshold | drv_data->int_cr1;
-		write_SSSR(drv_data->clear_sr, reg);
+		write_SSSR_CS(drv_data, drv_data->clear_sr);
 	}
 
 	/* see if we need to reload the config registers */
@@ -1105,7 +1135,7 @@ static void pump_transfers(unsigned long data)
 
 		/* stop the SSP, and update the other bits */
 		write_SSCR0(cr0 & ~SSCR0_SSE, reg);
-		if (drv_data->ssp_type != PXA25x_SSP)
+		if (!pxa25x_ssp_comp(drv_data))
 			write_SSTO(chip->timeout, reg);
 		/* first set CR1 without interrupt and service enables */
 		write_SSCR1(cr1 & SSCR1_CHANGE_MASK, reg);
@@ -1113,7 +1143,7 @@ static void pump_transfers(unsigned long data)
 		write_SSCR0(cr0, reg);
 
 	} else {
-		if (drv_data->ssp_type != PXA25x_SSP)
+		if (!pxa25x_ssp_comp(drv_data))
 			write_SSTO(chip->timeout, reg);
 	}
 
@@ -1240,14 +1270,13 @@ static int setup(struct spi_device *spi)
 	uint tx_thres = TX_THRESH_DFLT;
 	uint rx_thres = RX_THRESH_DFLT;
 
-	if (drv_data->ssp_type != PXA25x_SSP
+	if (!pxa25x_ssp_comp(drv_data)
 		&& (spi->bits_per_word < 4 || spi->bits_per_word > 32)) {
 		dev_err(&spi->dev, "failed setup: ssp_type=%d, bits/wrd=%d "
 				"b/w not 4-32 for type non-PXA25x_SSP\n",
 				drv_data->ssp_type, spi->bits_per_word);
 		return -EINVAL;
-	}
-	else if (drv_data->ssp_type == PXA25x_SSP
+	} else if (pxa25x_ssp_comp(drv_data)
 			&& (spi->bits_per_word < 4
 				|| spi->bits_per_word > 16)) {
 		dev_err(&spi->dev, "failed setup: ssp_type=%d, bits/wrd=%d "
@@ -1266,7 +1295,17 @@ static int setup(struct spi_device *spi)
 			return -ENOMEM;
 		}
 
-		chip->gpio_cs = -1;
+		if (drv_data->ssp_type == CE4100_SSP) {
+			if (spi->chip_select > 4) {
+				dev_err(&spi->dev, "failed setup: "
+				"cs number must not be > 4.\n");
+				kfree(chip);
+				return -EINVAL;
+			}
+
+			chip->frm = spi->chip_select;
+		} else
+			chip->gpio_cs = -1;
 		chip->enable_dma = 0;
 		chip->timeout = TIMOUT_DFLT;
 		chip->dma_burst_size = drv_data->master_info->enable_dma ?
@@ -1322,7 +1361,7 @@ static int setup(struct spi_device *spi)
 			| (((spi->mode & SPI_CPOL) != 0) ? SSCR1_SPO : 0);
 
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
-	if (drv_data->ssp_type != PXA25x_SSP)
+	if (!pxa25x_ssp_comp(drv_data))
 		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
 			clk_get_rate(ssp->clk)
 				/ (1 + ((chip->cr0 & SSCR0_SCR(0xfff)) >> 8)),
@@ -1357,17 +1396,21 @@ static int setup(struct spi_device *spi)
 
 	spi_set_ctldata(spi, chip);
 
+	if (drv_data->ssp_type == CE4100_SSP)
+		return 0;
+
 	return setup_cs(spi, chip, chip_info);
 }
 
 static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
 
 	if (!chip)
 		return;
 
-	if (gpio_is_valid(chip->gpio_cs))
+	if (drv_data->ssp_type != CE4100_SSP && gpio_is_valid(chip->gpio_cs))
 		gpio_free(chip->gpio_cs);
 
 	kfree(chip);
@@ -1507,7 +1550,7 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 
 	drv_data->ioaddr = ssp->mmio_base;
 	drv_data->ssdr_physical = ssp->phys_base + SSDR;
-	if (ssp->type == PXA25x_SSP) {
+	if (pxa25x_ssp_comp(drv_data)) {
 		drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE;
 		drv_data->dma_cr1 = 0;
 		drv_data->clear_sr = SSSR_ROR;
@@ -1569,7 +1612,7 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 			| SSCR0_Motorola
 			| SSCR0_DataSize(8),
 			drv_data->ioaddr);
-	if (drv_data->ssp_type != PXA25x_SSP)
+	if (!pxa25x_ssp_comp(drv_data))
 		write_SSTO(0, drv_data->ioaddr);
 	write_SSPSP(0, drv_data->ioaddr);
 
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index c3aa334..2f691e4 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -72,6 +72,7 @@
 #define SSCR1_SPH	(1 << 4)	/* Motorola SPI SSPSCLK phase setting */
 #define SSCR1_MWDS	(1 << 5)	/* Microwire Transmit Data Size */
 
+#define SSSR_ALT_FRM_MASK	3	/* Masks the SFRM signal number */
 #define SSSR_TNF	(1 << 2)	/* Transmit FIFO Not Full */
 #define SSSR_RNE	(1 << 3)	/* Receive FIFO Not Empty */
 #define SSSR_BSY	(1 << 4)	/* SSP Busy */
@@ -160,6 +161,7 @@ enum pxa_ssp_type {
 	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
 	PXA27x_SSP,
 	PXA168_SSP,
+	CE4100_SSP,
 };
 
 struct ssp_device {
-- 
1.7.3.2
