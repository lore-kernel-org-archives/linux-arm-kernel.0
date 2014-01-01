From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 Jan 2014 10:09:28 +0400
Subject: [PATCH 1/2] spi: clps711x: Driver refactor
Message-ID: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a complex patch for refactoring CLPS711X SPI driver.
Major changes:
- Eliminate <mach/hardware.h> usage.
- Devicetree support.

Since we do not have any platform users of this driver,
non-DT support is removed. DT users will be introduced later
once DT support for this platform will be completed.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/spi/Kconfig                        |   2 +-
 drivers/spi/spi-clps711x.c                 | 233 ++++++++++-------------------
 include/linux/platform_data/spi-clps711x.h |  21 ---
 3 files changed, 84 insertions(+), 172 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-clps711x.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 81b96e5..54c7bb2a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -150,7 +150,7 @@ config SPI_BUTTERFLY
 
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
-	depends on ARCH_CLPS711X
+	depends on OF && (ARCH_CLPS711X || COMPILE_TEST)
 	help
 	  This enables dedicated general purpose SPI/Microwire1-compatible
 	  master mode interface (SSI1) for CLPS711X-based CPUs.
diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 6f03d7e..9d8eb39 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -1,7 +1,7 @@
 /*
  *  CLPS711X SPI bus driver
  *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *  Copyright (C) 2012-2014 Alexander Shiyan <shc_work@mail.ru>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -9,113 +9,77 @@
  * (at your option) any later version.
  */
 
-#include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/clps711x.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_data/spi-clps711x.h>
-
-#include <mach/hardware.h>
 
-#define DRIVER_NAME	"spi-clps711x"
+#define SYNCIO_FRMLEN(x)	(((x) & 0x1f) << 8)
+#define SYNCIO_SMCKEN		(1 << 13)
+#define SYNCIO_TXFRMEN		(1 << 14)
 
 struct spi_clps711x_data {
 	struct completion	done;
-
+	void __iomem		*syncio;
+	struct regmap		*syscon3;
 	struct clk		*spi_clk;
-	u32			max_speed_hz;
-
 	u8			*tx_buf;
 	u8			*rx_buf;
-	int			count;
+	unsigned int		bpw;
 	int			len;
-
-	int			chipselect[0];
 };
 
 static int spi_clps711x_setup(struct spi_device *spi)
 {
-	struct spi_clps711x_data *hw = spi_master_get_devdata(spi->master);
+	if (!spi->controller_state) {
+		int ret;
 
-	/* We are expect that SPI-device is not selected */
-	gpio_direction_output(hw->chipselect[spi->chip_select],
-			      !(spi->mode & SPI_CS_HIGH));
+		ret = devm_gpio_request(&spi->master->dev, spi->cs_gpio, NULL);
+		if (ret)
+			return ret;
 
-	return 0;
-}
-
-static void spi_clps711x_setup_mode(struct spi_device *spi)
-{
-	/* Setup edge for transfer */
-	if (spi->mode & SPI_CPHA)
-		clps_writew(clps_readw(SYSCON3) | SYSCON3_ADCCKNSEN, SYSCON3);
-	else
-		clps_writew(clps_readw(SYSCON3) & ~SYSCON3_ADCCKNSEN, SYSCON3);
-}
-
-static int spi_clps711x_setup_xfer(struct spi_device *spi,
-				   struct spi_transfer *xfer)
-{
-	u32 speed = xfer->speed_hz ? : spi->max_speed_hz;
-	u8 bpw = xfer->bits_per_word;
-	struct spi_clps711x_data *hw = spi_master_get_devdata(spi->master);
-
-	if (bpw != 8) {
-		dev_err(&spi->dev, "Unsupported master bus width %i\n", bpw);
-		return -EINVAL;
+		spi->controller_state = spi;
 	}
 
-	/* Setup SPI frequency divider */
-	if (!speed || (speed >= hw->max_speed_hz))
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(3), SYSCON1);
-	else if (speed >= (hw->max_speed_hz / 2))
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(2), SYSCON1);
-	else if (speed >= (hw->max_speed_hz / 8))
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(1), SYSCON1);
-	else
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(0), SYSCON1);
-
-	return 0;
+	return gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 }
 
 static int spi_clps711x_transfer_one_message(struct spi_master *master,
 					     struct spi_message *msg)
 {
 	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
+	struct spi_device *spi = msg->spi;
 	struct spi_transfer *xfer;
-	int status = 0, cs = hw->chipselect[msg->spi->chip_select];
-	u32 data;
 
-	spi_clps711x_setup_mode(msg->spi);
+	/* Setup mode for transfer */
+	regmap_update_bits(hw->syscon3, SYSCON_OFFSET, SYSCON3_ADCCKNSEN,
+			   (spi->mode & SPI_CPHA) ? SYSCON3_ADCCKNSEN : 0);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		if (spi_clps711x_setup_xfer(msg->spi, xfer)) {
-			status = -EINVAL;
-			goto out_xfr;
-		}
+		u8 data;
 
-		gpio_set_value(cs, !!(msg->spi->mode & SPI_CS_HIGH));
+		clk_set_rate(hw->spi_clk, xfer->speed_hz ? : spi->max_speed_hz);
+
+		gpio_set_value(spi->cs_gpio, !!(spi->mode & SPI_CS_HIGH));
 
 		reinit_completion(&hw->done);
 
-		hw->count = 0;
 		hw->len = xfer->len;
+		hw->bpw = xfer->bits_per_word ? : spi->bits_per_word;
 		hw->tx_buf = (u8 *)xfer->tx_buf;
 		hw->rx_buf = (u8 *)xfer->rx_buf;
 
 		/* Initiate transfer */
-		data = hw->tx_buf ? hw->tx_buf[hw->count] : 0;
-		clps_writel(data | SYNCIO_FRMLEN(8) | SYNCIO_TXFRMEN, SYNCIO);
-
+		data = hw->tx_buf ? *hw->tx_buf++ : 0;
+		writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
+		       hw->syncio);
 		wait_for_completion(&hw->done);
 
 		if (xfer->delay_usecs)
@@ -123,13 +87,13 @@ static int spi_clps711x_transfer_one_message(struct spi_master *master,
 
 		if (xfer->cs_change ||
 		    list_is_last(&xfer->transfer_list, &msg->transfers))
-			gpio_set_value(cs, !(msg->spi->mode & SPI_CS_HIGH));
+			gpio_set_value(spi->cs_gpio,
+				       !(spi->mode & SPI_CS_HIGH));
 
 		msg->actual_length += xfer->len;
 	}
 
-out_xfr:
-	msg->status = status;
+	msg->status = 0;
 	spi_finalize_current_message(master);
 
 	return 0;
@@ -138,19 +102,18 @@ out_xfr:
 static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 {
 	struct spi_clps711x_data *hw = (struct spi_clps711x_data *)dev_id;
-	u32 data;
+	u8 data;
 
 	/* Handle RX */
-	data = clps_readb(SYNCIO);
+	data = readb(hw->syncio);
 	if (hw->rx_buf)
-		hw->rx_buf[hw->count] = (u8)data;
-
-	hw->count++;
+		*hw->rx_buf++ = data;
 
 	/* Handle TX */
-	if (hw->count < hw->len) {
-		data = hw->tx_buf ? hw->tx_buf[hw->count] : 0;
-		clps_writel(data | SYNCIO_FRMLEN(8) | SYNCIO_TXFRMEN, SYNCIO);
+	if (--hw->len > 0) {
+		data = hw->tx_buf ? *hw->tx_buf++ : 0;
+		writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
+		       hw->syncio);
 	} else
 		complete(&hw->done);
 
@@ -159,116 +122,86 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 
 static int spi_clps711x_probe(struct platform_device *pdev)
 {
-	int i, ret;
-	struct spi_master *master;
+	struct device_node *np = pdev->dev.of_node;
 	struct spi_clps711x_data *hw;
-	struct spi_clps711x_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct spi_master *master;
+	struct resource *res;
+	int irq, ret;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data supplied\n");
-		return -EINVAL;
-	}
+	master = spi_alloc_master(&pdev->dev, sizeof(*hw));
+	if (!master)
+		return -ENOMEM;
 
-	if (pdata->num_chipselect < 1) {
-		dev_err(&pdev->dev, "At least one CS must be defined\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
 		return -EINVAL;
-	}
 
-	master = spi_alloc_master(&pdev->dev,
-				  sizeof(struct spi_clps711x_data) +
-				  sizeof(int) * pdata->num_chipselect);
-	if (!master) {
-		dev_err(&pdev->dev, "SPI allocating memory error\n");
-		return -ENOMEM;
+	hw = spi_master_get_devdata(master);
+
+	hw->spi_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(hw->spi_clk)) {
+		ret = PTR_ERR(hw->spi_clk);
+		goto err_out;
 	}
 
-	master->bus_num = pdev->id;
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 8);
+	master->bus_num = -1;
+	master->dev.of_node = np;
 	master->mode_bits = SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->num_chipselect = pdata->num_chipselect;
 	master->setup = spi_clps711x_setup;
 	master->transfer_one_message = spi_clps711x_transfer_one_message;
 
-	hw = spi_master_get_devdata(master);
-
-	for (i = 0; i < master->num_chipselect; i++) {
-		hw->chipselect[i] = pdata->chipselect[i];
-		if (!gpio_is_valid(hw->chipselect[i])) {
-			dev_err(&pdev->dev, "Invalid CS GPIO %i\n", i);
-			ret = -EINVAL;
-			goto err_out;
-		}
-		if (gpio_request(hw->chipselect[i], DRIVER_NAME)) {
-			dev_err(&pdev->dev, "Can't get CS GPIO %i\n", i);
-			ret = -EINVAL;
-			goto err_out;
-		}
+	hw->syscon3 = syscon_regmap_lookup_by_phandle(np, "syscon");
+	if (IS_ERR(hw->syscon3)) {
+		ret = PTR_ERR(hw->syscon3);
+		goto err_out;
 	}
 
-	hw->spi_clk = devm_clk_get(&pdev->dev, "spi");
-	if (IS_ERR(hw->spi_clk)) {
-		dev_err(&pdev->dev, "Can't get clocks\n");
-		ret = PTR_ERR(hw->spi_clk);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hw->syncio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hw->syncio)) {
+		ret = PTR_ERR(hw->syncio);
 		goto err_out;
 	}
-	hw->max_speed_hz = clk_get_rate(hw->spi_clk);
 
 	init_completion(&hw->done);
-	platform_set_drvdata(pdev, master);
 
 	/* Disable extended mode due hardware problems */
-	clps_writew(clps_readw(SYSCON3) & ~SYSCON3_ADCCON, SYSCON3);
+	ret = regmap_update_bits(hw->syscon3, SYSCON_OFFSET, SYSCON3_ADCCON, 0);
+	if (ret)
+		goto err_out;
 
 	/* Clear possible pending interrupt */
-	clps_readl(SYNCIO);
+	readl(hw->syncio);
 
-	ret = devm_request_irq(&pdev->dev, IRQ_SSEOTI, spi_clps711x_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, spi_clps711x_isr, 0,
 			       dev_name(&pdev->dev), hw);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't request IRQ\n");
+	if (ret)
 		goto err_out;
-	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-	if (!ret) {
-		dev_info(&pdev->dev,
-			 "SPI bus driver initialized. Master clock %u Hz\n",
-			 hw->max_speed_hz);
+	if (!ret)
 		return 0;
-	}
-
-	dev_err(&pdev->dev, "Failed to register master\n");
 
 err_out:
-	while (--i >= 0)
-		if (gpio_is_valid(hw->chipselect[i]))
-			gpio_free(hw->chipselect[i]);
-
 	spi_master_put(master);
 
 	return ret;
 }
 
-static int spi_clps711x_remove(struct platform_device *pdev)
-{
-	int i;
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
-
-	for (i = 0; i < master->num_chipselect; i++)
-		if (gpio_is_valid(hw->chipselect[i]))
-			gpio_free(hw->chipselect[i]);
-
-	return 0;
-}
+static const struct of_device_id clps711x_spi_dt_ids[] = {
+	{ .compatible = "cirrus,clps711x-spi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_spi_dt_ids);
 
 static struct platform_driver clps711x_spi_driver = {
 	.driver	= {
-		.name	= DRIVER_NAME,
-		.owner	= THIS_MODULE,
+		.name		= "clps711x-spi",
+		.owner		= THIS_MODULE,
+		.of_match_table	= clps711x_spi_dt_ids,
 	},
 	.probe	= spi_clps711x_probe,
-	.remove	= spi_clps711x_remove,
 };
 module_platform_driver(clps711x_spi_driver);
 
diff --git a/include/linux/platform_data/spi-clps711x.h b/include/linux/platform_data/spi-clps711x.h
deleted file mode 100644
index 301956e..0000000
--- a/include/linux/platform_data/spi-clps711x.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  CLPS711X SPI bus driver definitions
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-#define ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-
-/* Board specific platform_data */
-struct spi_clps711x_pdata {
-	int *chipselect;	/* Array of GPIO-numbers */
-	int num_chipselect;	/* Total count of GPIOs */
-};
-
-#endif
-- 
1.8.3.2
