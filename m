From: stigge@antcom.de (Roland Stigge)
Date: Wed, 17 Oct 2012 14:31:42 +0200
Subject: [PATCH RFC 10/15 v5] gpio-pl061: Add block GPIO API
In-Reply-To: <1350477107-26512-1-git-send-email-stigge@antcom.de>
References: <1350477107-26512-1-git-send-email-stigge@antcom.de>
Message-ID: <1350477107-26512-11-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds block GPIO API support to the gpio-pl061 driver.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 drivers/gpio/gpio-pl061.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- linux-2.6.orig/drivers/gpio/gpio-pl061.c
+++ linux-2.6/drivers/gpio/gpio-pl061.c
@@ -123,6 +123,21 @@ static void pl061_set_value(struct gpio_
 	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
 }
 
+static unsigned long pl061_get_block(struct gpio_chip *gc, unsigned long mask)
+{
+	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
+
+	return !!readb(chip->base + (mask << 2));
+}
+
+static void pl061_set_block(struct gpio_chip *gc, unsigned long mask,
+			    unsigned long values)
+{
+	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
+
+	writeb(values & mask, chip->base + (mask << 2));
+}
+
 static int pl061_to_irq(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
@@ -256,6 +271,8 @@ static int pl061_probe(struct amba_devic
 	chip->gc.direction_output = pl061_direction_output;
 	chip->gc.get = pl061_get_value;
 	chip->gc.set = pl061_set_value;
+	chip->gc.get_block = pl061_get_block;
+	chip->gc.set_block = pl061_set_block;
 	chip->gc.to_irq = pl061_to_irq;
 	chip->gc.ngpio = PL061_GPIO_NR;
 	chip->gc.label = dev_name(&dev->dev);
