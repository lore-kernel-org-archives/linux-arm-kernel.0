From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Thu, 21 Dec 2017 01:37:31 +0100
Subject: [PATCH] spi: pxa2xx: avoid redundant gpio_to_desc(desc_to_gpio())
 round-trip
Message-ID: <20171221003731.21633-1-linux@rasmusvillemoes.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_free(gpio) simply does gpiod_free(gpio_to_desc(gpio)), so it's
simpler and cleaner to use gpiod_free directly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
2.11.0
