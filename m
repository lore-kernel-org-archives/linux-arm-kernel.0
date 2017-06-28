From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:22 +0100
Subject: Applied "spi: stm32: use normal conditional statements instead of
 ternary operator" to the spi tree
In-Reply-To: <1498222550-19092-6-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIaY-0004dE-Sa@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: use normal conditional statements instead of ternary operator

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

>From 128ebb89c50e5452704de82d78845baeb3333c24 Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:17 +0200
Subject: [PATCH] spi: stm32: use normal conditional statements instead of
 ternary operator

This patch replace ternary operator use by normal condition statements
to ease code reading.
It also removes redundant !!.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3df4baa68d63..123529a1b40d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -267,7 +267,10 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 		return -EINVAL;
 
 	/* Determine the first power of 2 greater than or equal to div */
-	mbrdiv = (div & (div - 1)) ? fls(div) : fls(div) - 1;
+	if (div & (div - 1))
+		mbrdiv = fls(div);
+	else
+		mbrdiv = fls(div) - 1;
 
 	spi->cur_speed = spi->clk_rate / (1 << mbrdiv);
 
@@ -285,9 +288,12 @@ static u32 stm32_spi_prepare_fthlv(struct stm32_spi *spi)
 	/* data packet should not exceed 1/2 of fifo space */
 	half_fifo = (spi->fifo_size / 2);
 
-	fthlv = (spi->cur_bpw <= 8) ? half_fifo :
-		(spi->cur_bpw <= 16) ? (half_fifo / 2) :
-		(half_fifo / 4);
+	if (spi->cur_bpw <= 8)
+		fthlv = half_fifo;
+	else if (spi->cur_bpw <= 16)
+		fthlv = half_fifo / 2;
+	else
+		fthlv = half_fifo / 4;
 
 	/* align packet size with data registers access */
 	if (spi->cur_bpw > 8)
@@ -462,9 +468,9 @@ static bool stm32_spi_can_dma(struct spi_master *master,
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
 	dev_dbg(spi->dev, "%s: %s\n", __func__,
-		(!!(transfer->len > spi->fifo_size)) ? "true" : "false");
+		(transfer->len > spi->fifo_size) ? "true" : "false");
 
-	return !!(transfer->len > spi->fifo_size);
+	return (transfer->len > spi->fifo_size);
 }
 
 /**
@@ -493,7 +499,8 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 	 * Full-Duplex, need to poll RXP event to know if there are remaining
 	 * data, before disabling SPI.
 	 */
-	mask |= ((spi->rx_buf && !spi->cur_usedma) ? SPI_SR_RXP : 0);
+	if (spi->rx_buf && !spi->cur_usedma)
+		mask |= SPI_SR_RXP;
 
 	if (!(sr & mask)) {
 		dev_dbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
@@ -656,12 +663,18 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 	enum dma_slave_buswidth buswidth;
 	u32 maxburst;
 
-	buswidth = (spi->cur_bpw <= 8) ? DMA_SLAVE_BUSWIDTH_1_BYTE :
-		   (spi->cur_bpw <= 16) ? DMA_SLAVE_BUSWIDTH_2_BYTES :
-		   DMA_SLAVE_BUSWIDTH_4_BYTES;
+	if (spi->cur_bpw <= 8)
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	else if (spi->cur_bpw <= 16)
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	else
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	/* Valid for DMA Half or Full Fifo threshold */
-	maxburst = (spi->cur_fthlv == 2) ? 1 : spi->cur_fthlv;
+	if (spi->cur_fthlv == 2)
+		maxburst = 1;
+	else
+		maxburst = spi->cur_fthlv;
 
 	memset(dma_conf, 0, sizeof(struct dma_slave_config));
 	dma_conf->direction = dir;
@@ -920,9 +933,12 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 				~cfg2_clrb) | cfg2_setb,
 			       spi->base + STM32_SPI_CFG2);
 
-	nb_words = DIV_ROUND_UP(transfer->len * 8,
-				(spi->cur_bpw <= 8) ? 8 :
-				(spi->cur_bpw <= 16) ? 16 : 32);
+	if (spi->cur_bpw <= 8)
+		nb_words = transfer->len;
+	else if (spi->cur_bpw <= 16)
+		nb_words = DIV_ROUND_UP(transfer->len * 8, 16);
+	else
+		nb_words = DIV_ROUND_UP(transfer->len * 8, 32);
 	nb_words <<= SPI_CR2_TSIZE_SHIFT;
 
 	if (nb_words <= SPI_CR2_TSIZE) {
-- 
2.13.2
