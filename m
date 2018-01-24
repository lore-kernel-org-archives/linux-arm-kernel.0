From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Jan 2018 15:36:19 +0000
Subject: Applied "spi: a3700: Remove endianness swapping for full-duplex
 transfers" to the spi tree
In-Reply-To: <1516803048-26942-3-git-send-email-maxime.chevallier@smile.fr>
Message-ID: <E1eeN63-0004rM-Pw@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: a3700: Remove endianness swapping for full-duplex transfers

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

>From 34b1fcaeb21de2a64004a95a1dc52d7e9998b733 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@smile.fr>
Date: Wed, 24 Jan 2018 15:10:48 +0100
Subject: [PATCH] spi: a3700: Remove endianness swapping for full-duplex
 transfers

Fixes the following sparse warnings :
line 767: warning: incorrect type in assignment (different base types)
line 767:    expected unsigned int [unsigned] [assigned] [usertype] val_out
line 767:    got restricted __le32 [usertype] <noident>
line 776: warning: cast to restricted __le32

This takes advantage of readl/writel to do the endianness reordering,
and removes an extra variable in the function.

Fixes: f68a7dcb91b7 ("spi: a3700: Add full-duplex support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index f32b83c7209f..1f42bd04e630 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -739,7 +739,7 @@ static int a3700_spi_transfer_one_full_duplex(struct spi_master *master,
 				  struct spi_transfer *xfer)
 {
 	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
-	u32 val_in, val_out;
+	u32 val;
 
 	/* Disable FIFO mode */
 	a3700_spi_fifo_mode_set(a3700_spi, false);
@@ -753,21 +753,20 @@ static int a3700_spi_transfer_one_full_duplex(struct spi_master *master,
 			a3700_spi_bytelen_set(a3700_spi, 1);
 
 		if (a3700_spi->byte_len == 1)
-			val_out = *a3700_spi->tx_buf;
+			val = *a3700_spi->tx_buf;
 		else
-			val_out = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
+			val = *(u32 *)a3700_spi->tx_buf;
 
-		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val_out);
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
 
 		/* Wait for all the data to be shifted in / out */
 		while (!(spireg_read(a3700_spi, A3700_SPI_IF_CTRL_REG) &
 				A3700_SPI_XFER_DONE))
 			cpu_relax();
 
-		val_in = le32_to_cpu(spireg_read(a3700_spi,
-						 A3700_SPI_DATA_IN_REG));
+		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
 
-		memcpy(a3700_spi->rx_buf, &val_in, a3700_spi->byte_len);
+		memcpy(a3700_spi->rx_buf, &val, a3700_spi->byte_len);
 
 		a3700_spi->buf_len -= a3700_spi->byte_len;
 		a3700_spi->tx_buf += a3700_spi->byte_len;
-- 
2.15.1
