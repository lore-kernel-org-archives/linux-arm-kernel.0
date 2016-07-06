From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  6 Jul 2016 16:53:12 +0200
Subject: [PATCH 1/2] spi: clps711x: Driver refactor
Message-ID: <20160706145326.2658600-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shiyan <shc_work@mail.ru>

This is a complex patch for refactoring CLPS711X SPI driver.
This change adds devicetree support and removes board support.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-clps711x.c | 69 +++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 8c30de0315e7..18193df2eba8 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -1,7 +1,7 @@
 /*
  *  CLPS711X SPI bus driver
  *
- *  Copyright (C) 2012-2014 Alexander Shiyan <shc_work@mail.ru>
+ *  Copyright (C) 2012-2016 Alexander Shiyan <shc_work@mail.ru>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -20,9 +19,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/clps711x.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_data/spi-clps711x.h>
 
-#define DRIVER_NAME	"spi-clps711x"
+#define DRIVER_NAME		"clps711x-spi"
 
 #define SYNCIO_FRMLEN(x)	((x) << 8)
 #define SYNCIO_TXFRMEN		(1 << 14)
@@ -40,6 +38,17 @@ struct spi_clps711x_data {
 
 static int spi_clps711x_setup(struct spi_device *spi)
 {
+	if (!spi->controller_state) {
+		int ret;
+
+		ret = devm_gpio_request(&spi->master->dev, spi->cs_gpio,
+					dev_name(&spi->master->dev));
+		if (ret)
+			return ret;
+
+		spi->controller_state = spi;
+	}
+
 	/* We are expect that SPI-device is not selected */
 	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 
@@ -104,20 +113,9 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 static int spi_clps711x_probe(struct platform_device *pdev)
 {
 	struct spi_clps711x_data *hw;
-	struct spi_clps711x_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct spi_master *master;
 	struct resource *res;
-	int i, irq, ret;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data supplied\n");
-		return -EINVAL;
-	}
-
-	if (pdata->num_chipselect < 1) {
-		dev_err(&pdev->dev, "At least one CS must be defined\n");
-		return -EINVAL;
-	}
+	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -127,40 +125,24 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->cs_gpios = devm_kzalloc(&pdev->dev, sizeof(int) *
-					pdata->num_chipselect, GFP_KERNEL);
-	if (!master->cs_gpios) {
-		ret = -ENOMEM;
-		goto err_out;
-	}
-
-	master->bus_num = pdev->id;
+	master->bus_num = -1;
 	master->mode_bits = SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(1, 8);
-	master->num_chipselect = pdata->num_chipselect;
+	master->dev.of_node = pdev->dev.of_node;
 	master->setup = spi_clps711x_setup;
 	master->prepare_message = spi_clps711x_prepare_message;
 	master->transfer_one = spi_clps711x_transfer_one;
 
 	hw = spi_master_get_devdata(master);
 
-	for (i = 0; i < master->num_chipselect; i++) {
-		master->cs_gpios[i] = pdata->chipselect[i];
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't get CS GPIO %i\n", i);
-			goto err_out;
-		}
-	}
-
 	hw->spi_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hw->spi_clk)) {
 		ret = PTR_ERR(hw->spi_clk);
 		goto err_out;
 	}
 
-	hw->syscon = syscon_regmap_lookup_by_pdevname("syscon.3");
+	hw->syscon =
+		syscon_regmap_lookup_by_compatible("cirrus,ep7209-syscon3");
 	if (IS_ERR(hw->syscon)) {
 		ret = PTR_ERR(hw->syscon);
 		goto err_out;
@@ -185,14 +167,8 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		goto err_out;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-	if (!ret) {
-		dev_info(&pdev->dev,
-			 "SPI bus driver initialized. Master clock %u Hz\n",
-			 master->max_speed_hz);
+	if (!ret)
 		return 0;
-	}
-
-	dev_err(&pdev->dev, "Failed to register master\n");
 
 err_out:
 	spi_master_put(master);
@@ -200,9 +176,16 @@ err_out:
 	return ret;
 }
 
+static const struct of_device_id clps711x_spi_dt_ids[] = {
+	{ .compatible = "cirrus,ep7209-spi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_spi_dt_ids);
+
 static struct platform_driver clps711x_spi_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
+		.of_match_table = clps711x_spi_dt_ids,
 	},
 	.probe	= spi_clps711x_probe,
 };
-- 
2.9.0
