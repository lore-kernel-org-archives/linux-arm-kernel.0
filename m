From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Dec 2017 12:28:42 +0000 (GMT)
Subject: Applied "spi: pxa2xx: avoid redundant gpio_to_desc(desc_to_gpio())
 round-trip" to the spi tree
In-Reply-To: <20171221003731.21633-1-linux@rasmusvillemoes.dk>
Message-ID: <20171221122842.367A744006B@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: avoid redundant gpio_to_desc(desc_to_gpio()) round-trip

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

>From 221886646f75964ca31cf60f1811b2c9c4e965a5 Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 21 Dec 2017 01:37:31 +0100
Subject: [PATCH] spi: pxa2xx: avoid redundant gpio_to_desc(desc_to_gpio())
 round-trip

gpio_free(gpio) simply does gpiod_free(gpio_to_desc(gpio)), so it's
simpler and cleaner to use gpiod_free directly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4cb515a3104c..c209dc1047b5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1237,7 +1237,7 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	 * different chip_info, release previously requested GPIO
 	 */
 	if (chip->gpiod_cs) {
-		gpio_free(desc_to_gpio(chip->gpiod_cs));
+		gpiod_free(chip->gpiod_cs);
 		chip->gpiod_cs = NULL;
 	}
 
@@ -1417,7 +1417,7 @@ static void cleanup(struct spi_device *spi)
 
 	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
 	    chip->gpiod_cs)
-		gpio_free(desc_to_gpio(chip->gpiod_cs));
+		gpiod_free(chip->gpiod_cs);
 
 	kfree(chip);
 }
-- 
2.15.0
