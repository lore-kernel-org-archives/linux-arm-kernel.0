From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jan 2018 11:23:36 +0000
Subject: Applied "spi: a3700: Allow to enable or disable FIFO mode" to the spi
 tree
In-Reply-To: <1516205728-3256-4-git-send-email-maxime.chevallier@smile.fr>
Message-ID: <E1ec8IC-0003tZ-Bb@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: a3700: Allow to enable or disable FIFO mode

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

>From a456c9320d997fdb26bfab496dd9e37f155cc788 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@smile.fr>
Date: Wed, 17 Jan 2018 17:15:27 +0100
Subject: [PATCH] spi: a3700: Allow to enable or disable FIFO mode

The armada 3700 SPI controller allows to make transfers without using
the 32 bytes RFIFO and WFIFO.

This commit enable switching between FIFO and non-FIFO mode, which is
necessary to implement full-duplex transfers.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 07f227e3c834..97938c6d6267 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -185,12 +185,15 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 	return 0;
 }
 
-static void a3700_spi_fifo_mode_set(struct a3700_spi *a3700_spi)
+static void a3700_spi_fifo_mode_set(struct a3700_spi *a3700_spi, bool enable)
 {
 	u32 val;
 
 	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
-	val |= A3700_SPI_FIFO_MODE;
+	if (enable)
+		val |= A3700_SPI_FIFO_MODE;
+	else
+		val &= ~A3700_SPI_FIFO_MODE;
 	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
 }
 
@@ -291,7 +294,7 @@ static int a3700_spi_init(struct a3700_spi *a3700_spi)
 		a3700_spi_deactivate_cs(a3700_spi, i);
 
 	/* Enable FIFO mode */
-	a3700_spi_fifo_mode_set(a3700_spi);
+	a3700_spi_fifo_mode_set(a3700_spi, true);
 
 	/* Set SPI mode */
 	a3700_spi_mode_set(a3700_spi, master->mode_bits);
-- 
2.15.1
