From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Jul 2017 17:07:02 +0100
Subject: Applied "spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created" to the spi tree
In-Reply-To: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
Message-ID: <E1dX8Y2-0005II-GS@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: Only claim CS GPIOs when the slave device is created

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

>From 676a4e3bab445d53fca4756865e2c0e2a87c38d6 Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Sat, 8 Jul 2017 10:41:18 +0200
Subject: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created

Avoid hogging chip select GPIOs just because they are listed for the
master. They might be mulitplexed and, if no slave device is attached,
used for different purposes. Moreover, this strategy avoids having to
allocate a cs_gpiods structure.

Tested on the IOT2000 where the second SPI bus is connected to an
Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
usage.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 59 +++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 38d053682892..be991266a6ce 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1213,21 +1213,33 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct device *pdev = &drv_data->pdev->dev;
+	struct gpio_desc *gpiod;
 	int err = 0;
+	int count;
 
 	if (chip == NULL)
 		return 0;
 
-	if (drv_data->cs_gpiods) {
-		struct gpio_desc *gpiod;
+	count = gpiod_count(pdev, "cs");
+	if (count > 0) {
+		if (spi->chip_select >= count)
+			return -EINVAL;
+
+		gpiod = gpiod_get_index(pdev, "cs", spi->chip_select,
+					GPIOD_OUT_HIGH);
+		if (IS_ERR(gpiod)) {
+			/* Means use native chip select */
+			if (PTR_ERR(gpiod) == -ENOENT)
+				return 0;
 
-		gpiod = drv_data->cs_gpiods[spi->chip_select];
-		if (gpiod) {
-			chip->gpio_cs = desc_to_gpio(gpiod);
-			chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
-			gpiod_set_value(gpiod, chip->gpio_cs_inverted);
+			return PTR_ERR(gpiod);
 		}
 
+		chip->gpio_cs = desc_to_gpio(gpiod);
+		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
+		gpiod_set_value(gpiod, chip->gpio_cs_inverted);
+
 		return 0;
 	}
 
@@ -1415,8 +1427,7 @@ static void cleanup(struct spi_device *spi)
 	if (!chip)
 		return;
 
-	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
-	    gpio_is_valid(chip->gpio_cs))
+	if (drv_data->ssp_type != CE4100_SSP && gpio_is_valid(chip->gpio_cs))
 		gpio_free(chip->gpio_cs);
 
 	kfree(chip);
@@ -1752,38 +1763,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = platform_info->num_chipselect;
 
 	count = gpiod_count(&pdev->dev, "cs");
-	if (count > 0) {
-		int i;
-
+	if (count > 0)
 		master->num_chipselect = max_t(int, count,
 			master->num_chipselect);
 
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
-
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
 
-- 
2.13.2
