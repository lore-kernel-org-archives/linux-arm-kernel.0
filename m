From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 23 Jun 2017 14:55:47 +0200
Subject: [PATCH 5/8] spi: stm32: use normal conditional statements instead of
 ternary operator
In-Reply-To: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498222550-19092-6-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace ternary operator use by normal condition statements
to ease code reading.
It also removes redundant !!.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spi-stm32.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 0997d6d..72efc63 100644
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
1.9.1
