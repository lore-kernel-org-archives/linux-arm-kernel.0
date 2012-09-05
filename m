From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  5 Sep 2012 10:40:55 +0200
Subject: [PATCH 6/8] gpio: 74x164: Add support for daisy-chaining
In-Reply-To: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1346834457-6257-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These types of shift registers can be daisy-chained, each new value sent
while the output pin is kept low will make the previous value shift to
the next register in the chain.

This patch add support for chained shift registers, through the
registers-number dt property.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpio/gpio-74x164.c |   42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index ff8d3d8..79b3e10 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -19,9 +19,10 @@
 
 struct gen_74x164_chip {
 	struct spi_device	*spi;
+	u8			*buffer;
 	struct gpio_chip	gpio_chip;
 	struct mutex		lock;
-	u8			port_config;
+	u32			registers;
 	int			chip_select;
 };
 
@@ -32,23 +33,31 @@ static struct gen_74x164_chip *gpio_to_74x164_chip(struct gpio_chip *gc)
 
 static int __gen_74x164_write_config(struct gen_74x164_chip *chip)
 {
-	int ret;
+	int i, ret;
 
 	gpio_set_value(chip->chip_select, 0);
-	ret = spi_write(chip->spi,
-			 &chip->port_config, sizeof(chip->port_config));
+
+	for (i = chip->registers - 1; i >= 0; i--) {
+		ret = spi_write(chip->spi,
+				chip->buffer + i, sizeof(u8));
+		if (ret)
+			return ret;
+	}
+
 	gpio_set_value(chip->chip_select, 1);
 
-	return ret;
+	return 0;
 }
 
 static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
 {
 	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
+	u8 bank = offset / 8;
+	u8 pin = offset % 8;
 	int ret;
 
 	mutex_lock(&chip->lock);
-	ret = (chip->port_config >> offset) & 0x1;
+	ret = (*(chip->buffer + bank) >> pin) & 0x1;
 	mutex_unlock(&chip->lock);
 
 	return ret;
@@ -58,12 +67,14 @@ static void gen_74x164_set_value(struct gpio_chip *gc,
 		unsigned offset, int val)
 {
 	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
+	u8 bank = offset / 8;
+	u8 pin = offset % 8;
 
 	mutex_lock(&chip->lock);
 	if (val)
-		chip->port_config |= (1 << offset);
+		*(chip->buffer + bank) |= (1 << pin);
 	else
-		chip->port_config &= ~(1 << offset);
+		*(chip->buffer + bank) &= ~(1 << pin);
 
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
@@ -110,7 +121,20 @@ static int __devinit gen_74x164_probe(struct spi_device *spi)
 	chip->gpio_chip.get = gen_74x164_get_value;
 	chip->gpio_chip.set = gen_74x164_set_value;
 	chip->gpio_chip.base = -1;
-	chip->gpio_chip.ngpio = 8;
+
+	if (of_property_read_u32(spi->dev.of_node, "registers-number", &chip->registers)) {
+		dev_err(&spi->dev, "Missing registers-number property in the DT.\n");
+		ret = -EINVAL;
+		goto exit_destroy;
+	}
+
+	chip->gpio_chip.ngpio = 8 * chip->registers;
+	chip->buffer = devm_kzalloc(&spi->dev, chip->gpio_chip.ngpio, GFP_KERNEL);
+	if (!chip->buffer) {
+		ret = -ENOMEM;
+		goto exit_destroy;
+	}
+
 	chip->gpio_chip.can_sleep = 1;
 	chip->gpio_chip.dev = &spi->dev;
 	chip->gpio_chip.owner = THIS_MODULE;
-- 
1.7.9.5
