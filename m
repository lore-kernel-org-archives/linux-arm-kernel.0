From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Sep 2012 22:35:39 +0200
Subject: [PATCH 1/3] gpio: 74x164: Add support for the daisy-chaining
In-Reply-To: <1347309341-15447-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1347309341-15447-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1347309341-15447-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shift registers have an output pin that, when enabled, propagates
the values of its internal register to the pins. If another value comes
to the register while the output pin is disabled, this new value will
makae the older shift into the next register in the chain.

This patch adds support for daisy-chaining the registers, using the
regular SPI chip select mechanism to manage the output pin, and the
registers-number dt property to set the number of chained registers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpio/gpio-74x164.c |   68 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 2e31bd3..ed3e551 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -14,14 +14,18 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/74x164.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#define GEN_74X164_NUMBER_GPIOS	8
+
 struct gen_74x164_chip {
 	struct spi_device	*spi;
+	u8			*buffer;
 	struct gpio_chip	gpio_chip;
 	struct mutex		lock;
-	u8			port_config;
+	u32			registers;
 };
 
 static struct gen_74x164_chip *gpio_to_74x164_chip(struct gpio_chip *gc)
@@ -31,17 +35,47 @@ static struct gen_74x164_chip *gpio_to_74x164_chip(struct gpio_chip *gc)
 
 static int __gen_74x164_write_config(struct gen_74x164_chip *chip)
 {
-	return spi_write(chip->spi,
-			 &chip->port_config, sizeof(chip->port_config));
+	struct spi_message message;
+	struct spi_transfer *msg_buf;
+	int i, ret = 0;
+
+	msg_buf = kzalloc(chip->registers * sizeof(struct spi_transfer),
+			GFP_KERNEL);
+	if (!msg_buf)
+		return -ENOMEM;
+
+	spi_message_init(&message);
+
+	/*
+	 * Since the registers are chained, every byte sent will make
+	 * the previous byte shift to the next register in the
+	 * chain. Thus, the first byte send will end up in the last
+	 * register at the end of the transfer. So, to have a logical
+	 * numbering, send the bytes in reverse order so that the last
+	 * byte of the buffer will end up in the last register.
+	 */
+	for (i = chip->registers - 1; i >= 0; i--) {
+		msg_buf[i].tx_buf = chip->buffer +i;
+		msg_buf[i].len = sizeof(u8);
+		spi_message_add_tail(msg_buf + i, &message);
+	}
+
+	ret = spi_sync(chip->spi, &message);
+
+	kfree(msg_buf);
+
+	return ret;
 }
 
 static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
 {
 	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
+	u8 bank = offset / 8;
+	u8 pin = offset % 8;
 	int ret;
 
 	mutex_lock(&chip->lock);
-	ret = (chip->port_config >> offset) & 0x1;
+	ret = (chip->buffer[bank] >> pin) & 0x1;
 	mutex_unlock(&chip->lock);
 
 	return ret;
@@ -51,12 +85,14 @@ static void gen_74x164_set_value(struct gpio_chip *gc,
 		unsigned offset, int val)
 {
 	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
+	u8 bank = offset / 8;
+	u8 pin = offset % 8;
 
 	mutex_lock(&chip->lock);
 	if (val)
-		chip->port_config |= (1 << offset);
+		chip->buffer[bank] |= (1 << pin);
 	else
-		chip->port_config &= ~(1 << offset);
+		chip->buffer[bank] &= ~(1 << pin);
 
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
@@ -75,6 +111,11 @@ static int __devinit gen_74x164_probe(struct spi_device *spi)
 	struct gen_74x164_chip_platform_data *pdata;
 	int ret;
 
+	if (!spi->dev.of_node) {
+		dev_err(&spi->dev, "No device tree data available.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * bits_per_word cannot be configured in platform data
 	 */
@@ -104,7 +145,20 @@ static int __devinit gen_74x164_probe(struct spi_device *spi)
 	chip->gpio_chip.direction_output = gen_74x164_direction_output;
 	chip->gpio_chip.get = gen_74x164_get_value;
 	chip->gpio_chip.set = gen_74x164_set_value;
-	chip->gpio_chip.ngpio = 8;
+
+	if (of_property_read_u32(spi->dev.of_node, "registers-number", &chip->registers)) {
+		dev_err(&spi->dev, "Missing registers-number property in the DT.\n");
+		ret = -EINVAL;
+		goto exit_destroy;
+	}
+
+	chip->gpio_chip.ngpio = GEN_74X164_NUMBER_GPIOS * chip->registers;
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
