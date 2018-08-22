From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2018 22:41:10 +0200
Subject: [PATCH 10/11] gpio: ep93xx: Cut gpio_to_irq() usage
In-Reply-To: <20180822204111.9581-1-linus.walleij@linaro.org>
References: <20180822204111.9581-1-linus.walleij@linaro.org>
Message-ID: <20180822204111.9581-11-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the callback into the gpiolib creating a
circular call to convert between GPIO numbers and IRQs
and pushes the whole business into the driver, just
using an array of IRQ bases for the three IRQ capable
ports.

This way we get rid of including <linux/gpio.h> that
no driver should include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ep93xx.c | 48 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 1248d83f860b..d45d8ac3b525 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -17,8 +17,6 @@
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
-/* FIXME: this is here for gpio_to_irq() - get rid of this! */
-#include <linux/gpio.h>
 
 #define EP93XX_GPIO_F_INT_STATUS 0x5c
 #define EP93XX_GPIO_A_INT_STATUS 0xa0
@@ -30,6 +28,15 @@
 /* Maximum value for irq capable line identifiers */
 #define EP93XX_GPIO_LINE_MAX_IRQ 23
 
+/*
+ * IRQ numbers used by this driver is 64 ..87
+ *
+ * Map GPIO A0..A7  (0..7)  to irq 64..71,
+ *          B0..B7  (7..15) to irq 72..79, and
+ *          F0..F7 (16..24) to irq 80..87.
+ */
+static unsigned int ep93xx_gpio_irq_base[3] = { 64, 72, 80 };
+
 struct ep93xx_gpio {
 	void __iomem		*base;
 	struct gpio_chip	gc[8];
@@ -112,13 +119,13 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 
 	stat = readb(epg->base + EP93XX_GPIO_A_INT_STATUS);
 	for_each_set_bit(offset, &stat, 8) {
-		int gpio_irq = gpio_to_irq(0) + offset;
+		int gpio_irq = ep93xx_gpio_irq_base[0] + offset;
 		generic_handle_irq(gpio_irq);
 	}
 
 	stat = readb(epg->base + EP93XX_GPIO_B_INT_STATUS);
 	for_each_set_bit(offset, &stat, 8) {
-		int gpio_irq = gpio_to_irq(8) + offset;
+		int gpio_irq = ep93xx_gpio_irq_base[1] + offset;
 		generic_handle_irq(gpio_irq);
 	}
 
@@ -130,12 +137,12 @@ static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 	/*
 	 * map discontiguous hw irq range to continuous sw irq range:
 	 *
-	 *  IRQ_EP93XX_GPIO{0..7}MUX -> gpio_to_irq(EP93XX_GPIO_LINE_F({0..7})
+	 *  IRQ_EP93XX_GPIO{0..7}MUX -> EP93XX_GPIO_LINE_F{0..7}
 	 */
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	unsigned int irq = irq_desc_get_irq(desc);
 	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
-	int gpio_irq = gpio_to_irq(16) + port_f_idx;
+	int gpio_irq = ep93xx_gpio_irq_base[2] + port_f_idx;
 
 	chained_irq_enter(irqchip, desc);
 	generic_handle_irq(gpio_irq);
@@ -268,27 +275,24 @@ static void ep93xx_gpio_init_irq(struct platform_device *pdev,
 	int i;
 
 	/* The A bank */
-	for (gpio_irq = gpio_to_irq(0);
-	     gpio_irq < gpio_to_irq(8);
-	     gpio_irq++) {
+	for (i = 0; i < 8; i++) {
+		gpio_irq = ep93xx_gpio_irq_base[0] + i;
 		irq_set_chip_data(gpio_irq, &epg->gc[0]);
 		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
 		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
 	}
 	/* The B bank */
-	for (gpio_irq = gpio_to_irq(8);
-	     gpio_irq < gpio_to_irq(16);
-	     gpio_irq++) {
+	for (i = 0; i < 8; i++) {
+		gpio_irq = ep93xx_gpio_irq_base[1] + i;
 		irq_set_chip_data(gpio_irq, &epg->gc[1]);
 		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
 		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
 	}
 	/* The F bank */
-	for (gpio_irq = gpio_to_irq(16);
-	     gpio_irq < gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ);
-	     gpio_irq++) {
+	for (i = 0; i < 8; i++) {
+		gpio_irq = ep93xx_gpio_irq_base[2] + i;
 		irq_set_chip_data(gpio_irq, &epg->gc[5]);
 		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
@@ -350,19 +354,15 @@ static int ep93xx_gpio_set_config(struct gpio_chip *gc, unsigned offset,
 	return 0;
 }
 
-/*
- * Map GPIO A0..A7  (0..7)  to irq 64..71,
- *          B0..B7  (7..15) to irq 72..79, and
- *          F0..F7 (16..24) to irq 80..87.
- */
-static int ep93xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+static int ep93xx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
-	int gpio = chip->base + offset;
+	int port = ep93xx_gpio_port(gc);
 
-	if (gpio > EP93XX_GPIO_LINE_MAX_IRQ)
+	/* Those are the ports supporting IRQ */
+	if (port != 0 && port != 1 && port != 5)
 		return -EINVAL;
 
-	return 64 + gpio;
+	return ep93xx_gpio_irq_base[port] + offset;
 }
 
 static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
-- 
2.17.1
