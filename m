From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Jun 2017 13:04:37 +0100
Subject: Applied "spi: stm32: fix error check on mbr being -ve" to the spi tree
In-Reply-To: <20170622163449.23925-1-colin.king@canonical.com>
Message-ID: <E1dONKH-0006aB-Py@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: fix error check on mbr being -ve

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

>From a2f07d38d6981ed220d86b7df07e4ac6a1734443 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 22 Jun 2017 17:34:49 +0100
Subject: [PATCH] spi: stm32: fix error check on mbr being -ve

The error check of mbr < 0 is always false because mbr is a u32. Make
mbt an int so that a -ve error return from stm32_spi_prepare_mbr can be
detected.

Detected by CoverityScan, CID#1446586 ("Unsigned compared against 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 0553f61ab3b7..305ecd5334fc 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -857,7 +857,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	}
 
 	if (spi->cur_speed != transfer->speed_hz) {
-		u32 mbr;
+		int mbr;
 
 		/* Update spi->cur_speed with real clock speed */
 		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz);
@@ -869,7 +869,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		transfer->speed_hz = spi->cur_speed;
 
 		cfg1_clrb |= SPI_CFG1_MBR;
-		cfg1_setb |= (mbr << SPI_CFG1_MBR_SHIFT) & SPI_CFG1_MBR;
+		cfg1_setb |= ((u32)mbr << SPI_CFG1_MBR_SHIFT) & SPI_CFG1_MBR;
 	}
 
 	if (cfg1_clrb || cfg1_setb)
-- 
2.13.1
