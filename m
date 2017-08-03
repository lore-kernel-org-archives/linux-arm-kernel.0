From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu,  3 Aug 2017 13:40:33 +0200
Subject: [PATCH RFC 2/2] spi: pxa2xx: Only claim CS GPIOs when the slave
 device is created
In-Reply-To: <cover.1501760433.git.jan.kiszka@siemens.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
Message-ID: <5a691263ccf9d61134d6184861b37eaf37b13b77.1501760433.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoid hogging chip select GPIOs just because they are listed for the
master. They might be mulitplexed and, if no slave device is attached,
used for different purposes. Moreover, this strategy avoids having to
allocate a cs_gpiods structure.

Tested on the IOT2000 where the second SPI bus is connected to an
Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
usage.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/spi/spi-pxa2xx.c | 68 +++++++++++++++++++++---------------------------
 drivers/spi/spi-pxa2xx.h |  3 +--
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7faba738110c..577a2f4ba3bf 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1213,19 +1213,34 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct device *pdev = &drv_data->pdev->dev;
 	struct gpio_desc *gpiod;
 	int err = 0;
 
 	if (chip == NULL)
 		return 0;
 
-	if (drv_data->cs_gpiods) {
-		gpiod = drv_data->cs_gpiods[spi->chip_select];
-		if (gpiod) {
-			chip->gpiod_cs = gpiod;
-			chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
-			gpiod_set_value(gpiod, chip->gpio_cs_inverted);
+	if (drv_data->cs_count > 0) {
+		/* setup() might be called multiple times. */
+		if (chip->gpiod_cs)
+			return 0;
+
+		if (spi->chip_select >= drv_data->cs_count)
+			return -EINVAL;
+
+		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
+
+		gpiod = gpiod_get_index(pdev, "cs", spi->chip_select,
+					chip->gpio_cs_inverted ?
+				        GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
+		if (IS_ERR(gpiod)) {
+			/* Means use native chip select */
+			if (PTR_ERR(gpiod) == -ENOENT)
+				return 0;
+
+			return (int)PTR_ERR(gpiod);
 		}
+		chip->gpiod_cs = gpiod;
 
 		return 0;
 	}
@@ -1415,9 +1430,13 @@ static void cleanup(struct spi_device *spi)
 	if (!chip)
 		return;
 
-	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
-	    chip->gpiod_cs)
-		gpio_free(desc_to_gpio(chip->gpiod_cs));
+	if (drv_data->ssp_type != CE4100_SSP && chip->gpiod_cs) {
+		if (drv_data->cs_count > 0)
+			gpiod_put(chip->gpiod_cs);
+		else
+			gpio_free(desc_to_gpio(chip->gpiod_cs));
+		chip->gpiod_cs = NULL;
+	}
 
 	kfree(chip);
 }
@@ -1752,37 +1771,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = platform_info->num_chipselect;
 
 	count = gpiod_count(&pdev->dev, "cs");
-	if (count > 0) {
-		int i;
-
+	if (count > 0)
 		master->num_chipselect = max_t(int, count,
 			master->num_chipselect);
-
-		drv_data->cs_gpiods = devm_kcalloc(&pdev->dev,
-			master->num_chipselect, sizeof(struct gpio_desc *),
-			GFP_KERNEL);
-		if (!drv_data->cs_gpiods) {
-			status = -ENOMEM;
-			goto out_error_clock_enabled;
-		}
-
-		for (i = 0; i < master->num_chipselect; i++) {
-			struct gpio_desc *gpiod;
-
-			gpiod = devm_gpiod_get_index(dev, "cs", i,
-						     GPIOD_OUT_HIGH);
-			if (IS_ERR(gpiod)) {
-				/* Means use native chip select */
-				if (PTR_ERR(gpiod) == -ENOENT)
-					continue;
-
-				status = (int)PTR_ERR(gpiod);
-				goto out_error_clock_enabled;
-			} else {
-				drv_data->cs_gpiods[i] = gpiod;
-			}
-		}
-	}
+	drv_data->cs_count = count;
 
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 94f7b0713281..8551c881f636 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -67,8 +67,7 @@ struct driver_data {
 
 	void __iomem *lpss_base;
 
-	/* GPIOs for chip selects */
-	struct gpio_desc **cs_gpiods;
+	int cs_count;
 };
 
 struct chip_data {
-- 
2.12.3
