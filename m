From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  5 Sep 2012 10:40:54 +0200
Subject: [PATCH 5/8] gpio: 74x164: Add output pin support
In-Reply-To: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1346834457-6257-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shift registers have an output that, when enabled, propagates the
values of its internal register to the pins. Make use of this pin
through the output-latch-gpio dt property.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpio/gpio-74x164.c |   32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 613067c..ff8d3d8 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
@@ -21,6 +22,7 @@ struct gen_74x164_chip {
 	struct gpio_chip	gpio_chip;
 	struct mutex		lock;
 	u8			port_config;
+	int			chip_select;
 };
 
 static struct gen_74x164_chip *gpio_to_74x164_chip(struct gpio_chip *gc)
@@ -30,8 +32,14 @@ static struct gen_74x164_chip *gpio_to_74x164_chip(struct gpio_chip *gc)
 
 static int __gen_74x164_write_config(struct gen_74x164_chip *chip)
 {
-	return spi_write(chip->spi,
+	int ret;
+
+	gpio_set_value(chip->chip_select, 0);
+	ret = spi_write(chip->spi,
 			 &chip->port_config, sizeof(chip->port_config));
+	gpio_set_value(chip->chip_select, 1);
+
+	return ret;
 }
 
 static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
@@ -73,6 +81,11 @@ static int __devinit gen_74x164_probe(struct spi_device *spi)
 	struct gen_74x164_chip *chip;
 	int ret;
 
+	if (!spi->dev.of_node) {
+		dev_err(&spi->dev, "No device tree data available.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * bits_per_word cannot be configured in platform data
 	 */
@@ -102,6 +115,23 @@ static int __devinit gen_74x164_probe(struct spi_device *spi)
 	chip->gpio_chip.dev = &spi->dev;
 	chip->gpio_chip.owner = THIS_MODULE;
 
+	chip->chip_select = of_get_named_gpio(spi->dev.of_node, "output-latch-gpio", 0);
+	if (gpio_is_valid(chip->chip_select)) {
+		int flags = GPIOF_OUT_INIT_HIGH;
+		if (of_get_property(spi->dev.of_node, "latch-active-low", NULL))
+			flags = GPIOF_OUT_INIT_LOW;
+		ret = devm_gpio_request_one(&spi->dev, chip->chip_select,
+					    flags, "output-latch");
+		if (ret) {
+			dev_err(&spi->dev,
+				"failed to request gpio %d: %d\n",
+				chip->chip_select, ret);
+			goto exit_destroy;
+		}
+	}
+
+	gpio_set_value(chip->chip_select, 1);
+
 	ret = __gen_74x164_write_config(chip);
 	if (ret) {
 		dev_err(&spi->dev, "Failed writing: %d\n", ret);
-- 
1.7.9.5
