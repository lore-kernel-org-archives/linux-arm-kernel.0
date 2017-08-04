From: broonie@kernel.org (Mark Brown)
Date: Fri, 04 Aug 2017 12:44:29 +0100
Subject: Applied "spi: pxa2xx: Convert to GPIO descriptor API where possible"
 to the spi tree
In-Reply-To: <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
Message-ID: <E1ddb1p-0007H9-IR@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: Convert to GPIO descriptor API where possible

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

>From c18d925fca20d33c3d04e5002a883f62d699543e Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 3 Aug 2017 13:40:32 +0200
Subject: [PATCH] spi: pxa2xx: Convert to GPIO descriptor API where possible

We still need to request/free GPIOs passed via the legacy path of
pxa2xx_spi_chip::gpio_cs, but we can use the gpiod API otherwise.

Consistently use the descriptor API instead of the legacy one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 32 ++++++++++++++++----------------
 drivers/spi/spi-pxa2xx.h |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6e5af88b7c6f..4cb515a3104c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -402,8 +402,8 @@ static void cs_assert(struct driver_data *drv_data)
 		return;
 	}
 
-	if (gpio_is_valid(chip->gpio_cs)) {
-		gpio_set_value(chip->gpio_cs, chip->gpio_cs_inverted);
+	if (chip->gpiod_cs) {
+		gpiod_set_value(chip->gpiod_cs, chip->gpio_cs_inverted);
 		return;
 	}
 
@@ -424,8 +424,8 @@ static void cs_deassert(struct driver_data *drv_data)
 		return;
 	}
 
-	if (gpio_is_valid(chip->gpio_cs)) {
-		gpio_set_value(chip->gpio_cs, !chip->gpio_cs_inverted);
+	if (chip->gpiod_cs) {
+		gpiod_set_value(chip->gpiod_cs, !chip->gpio_cs_inverted);
 		return;
 	}
 
@@ -1213,17 +1213,16 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct gpio_desc *gpiod;
 	int err = 0;
 
 	if (chip == NULL)
 		return 0;
 
 	if (drv_data->cs_gpiods) {
-		struct gpio_desc *gpiod;
-
 		gpiod = drv_data->cs_gpiods[spi->chip_select];
 		if (gpiod) {
-			chip->gpio_cs = desc_to_gpio(gpiod);
+			chip->gpiod_cs = gpiod;
 			chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
 			gpiod_set_value(gpiod, chip->gpio_cs_inverted);
 		}
@@ -1237,8 +1236,10 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	/* NOTE: setup() can be called multiple times, possibly with
 	 * different chip_info, release previously requested GPIO
 	 */
-	if (gpio_is_valid(chip->gpio_cs))
-		gpio_free(chip->gpio_cs);
+	if (chip->gpiod_cs) {
+		gpio_free(desc_to_gpio(chip->gpiod_cs));
+		chip->gpiod_cs = NULL;
+	}
 
 	/* If (*cs_control) is provided, ignore GPIO chip select */
 	if (chip_info->cs_control) {
@@ -1254,11 +1255,11 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 			return err;
 		}
 
-		chip->gpio_cs = chip_info->gpio_cs;
+		gpiod = gpio_to_desc(chip_info->gpio_cs);
+		chip->gpiod_cs = gpiod;
 		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
 
-		err = gpio_direction_output(chip->gpio_cs,
-					!chip->gpio_cs_inverted);
+		err = gpiod_direction_output(gpiod, !chip->gpio_cs_inverted);
 	}
 
 	return err;
@@ -1317,8 +1318,7 @@ static int setup(struct spi_device *spi)
 			}
 
 			chip->frm = spi->chip_select;
-		} else
-			chip->gpio_cs = -1;
+		}
 		chip->enable_dma = drv_data->master_info->enable_dma;
 		chip->timeout = TIMOUT_DFLT;
 	}
@@ -1416,8 +1416,8 @@ static void cleanup(struct spi_device *spi)
 		return;
 
 	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
-	    gpio_is_valid(chip->gpio_cs))
-		gpio_free(chip->gpio_cs);
+	    chip->gpiod_cs)
+		gpio_free(desc_to_gpio(chip->gpiod_cs));
 
 	kfree(chip);
 }
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 2823a00a9405..94f7b0713281 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -83,7 +83,7 @@ struct chip_data {
 	u16 lpss_tx_threshold;
 	u8 enable_dma;
 	union {
-		int gpio_cs;
+		struct gpio_desc *gpiod_cs;
 		unsigned int frm;
 	};
 	int gpio_cs_inverted;
-- 
2.13.3
