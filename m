From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:57:10 +0100
Subject: [PATCH v1 13/14] spi: rockchip: support 4bit words
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-14-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

The hardware supports 4, 8 and 16bit spi words,
so add the missing support for 4bit words.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 41 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1297f081818d..9e47e81553a1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -54,6 +54,9 @@
 
 /* Bit fields in CTRLR0 */
 #define CR0_DFS_OFFSET				0
+#define CR0_DFS_4BIT				0x0
+#define CR0_DFS_8BIT				0x1
+#define CR0_DFS_16BIT				0x2
 
 #define CR0_CFS_OFFSET				2
 
@@ -464,15 +467,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
 		bool use_dma)
 {
-	u32 dmacr = 0;
-
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
 	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
 	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
+	u32 cr1;
+	u32 dmacr = 0;
 
 	cr0 |= rs->rsd << CR0_RSD_OFFSET;
-	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
@@ -482,6 +484,27 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else if (use_dma)
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
+	switch (xfer->bits_per_word) {
+	case 4:
+		cr0 |= CR0_DFS_4BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len - 1;
+		break;
+	case 8:
+		cr0 |= CR0_DFS_8BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len - 1;
+		break;
+	case 16:
+		cr0 |= CR0_DFS_16BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len / 2 - 1;
+		break;
+	default:
+		/* we only whitelist 4, 8 and 16 bit words in
+		 * master->bits_per_word_mask, so this shouldn't
+		 * happen
+		 */
+		unreachable();
+	}
+
 	if (use_dma) {
 		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
@@ -490,13 +513,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	}
 
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
-
-	if (rs->n_bytes == 1)
-		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
-	else if (rs->n_bytes == 2)
-		writel_relaxed((xfer->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
-	else
-		writel_relaxed((xfer->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	writel_relaxed(cr1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
 	/* unfortunately setting the fifo threshold level to generate an
 	 * interrupt exactly when the fifo is full doesn't seem to work,
@@ -545,7 +562,7 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
-	rs->n_bytes = xfer->bits_per_word >> 3;
+	rs->n_bytes = xfer->bits_per_word <= 8 ? 1 : 2;
 
 	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
@@ -667,7 +684,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
 	master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
 	master->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
-- 
2.19.1
