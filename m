From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:06:09 +0000 (GMT)
Subject: Applied "spi: rockchip: support 4bit words" to the spi tree
In-Reply-To: <20181031105711.19575-14-esmil@mailme.dk>
Message-ID: <20181105120609.37CCD1124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: support 4bit words

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 65498c6ae2414a1425aa6c4231e79e2998afec05 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:10 +0100
Subject: [PATCH] spi: rockchip: support 4bit words

The hardware supports 4, 8 and 16bit spi words,
so add the missing support for 4bit words.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
