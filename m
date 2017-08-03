From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu,  3 Aug 2017 13:40:32 +0200
Subject: [PATCH RFC 1/2] spi: pxa2xx: Convert to GPIO descriptor API where
 possible
In-Reply-To: <cover.1501760433.git.jan.kiszka@siemens.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
Message-ID: <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We still need to request/free GPIOs passed via the legacy path of
pxa2xx_spi_chip::gpio_cs, but we can use the gpiod API otherwise.

Consistently use the descriptor API instead of the legacy one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/spi/spi-pxa2xx.c | 32 ++++++++++++++++----------------
 drivers/spi/spi-pxa2xx.h |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 38d053682892..7faba738110c 100644
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
2.12.3
