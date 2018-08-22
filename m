From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2018 22:41:08 +0200
Subject: [PATCH 08/11] gpio: ep93xx: Use the hwirq and port
In-Reply-To: <20180822204111.9581-1-linus.walleij@linaro.org>
References: <20180822204111.9581-1-linus.walleij@linaro.org>
Message-ID: <20180822204111.9581-9-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the IRQ-related functions, switch to using the hwirq
and port number found from the current struct gpio_chip *

As the lower 3 bits of the IRQ number is identical to the
lower 3 bits of the GPIO number we can cut some corners.

Call directly into the gpiochip to set up the direction
and read the input instead of using the consumer API.

This enabled us to cut the confusing irq_to_gpio() macro
that is a remnant of the old generic GPIO API as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ep93xx.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 3b235b25c028..b2139ec43ce2 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -16,11 +16,10 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
+#include <linux/bitops.h>
 /* FIXME: this is here for gpio_to_irq() - get rid of this! */
 #include <linux/gpio.h>
 
-#define irq_to_gpio(irq)	((irq) - gpio_to_irq(0))
-
 #define EP93XX_GPIO_F_INT_STATUS 0x5c
 #define EP93XX_GPIO_A_INT_STATUS 0xa0
 #define EP93XX_GPIO_B_INT_STATUS 0xbc
@@ -151,9 +150,8 @@ static void ep93xx_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	int line = irq_to_gpio(d->irq);
-	int port = line >> 3;
-	int port_mask = 1 << (line & 7);
+	int port = ep93xx_gpio_port(gc);
+	int port_mask = BIT(d->irq & 7);
 
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH) {
 		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
@@ -167,9 +165,8 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	int line = irq_to_gpio(d->irq);
-	int port = line >> 3;
-	int port_mask = 1 << (line & 7);
+	int port = ep93xx_gpio_port(gc);
+	int port_mask = BIT(d->irq & 7);
 
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH)
 		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
@@ -184,10 +181,9 @@ static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	int line = irq_to_gpio(d->irq);
-	int port = line >> 3;
+	int port = ep93xx_gpio_port(gc);
 
-	gpio_int_unmasked[port] &= ~(1 << (line & 7));
+	gpio_int_unmasked[port] &= ~BIT(d->irq & 7);
 	ep93xx_gpio_update_int_params(epg, port);
 }
 
@@ -195,10 +191,9 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	int line = irq_to_gpio(d->irq);
-	int port = line >> 3;
+	int port = ep93xx_gpio_port(gc);
 
-	gpio_int_unmasked[port] |= 1 << (line & 7);
+	gpio_int_unmasked[port] |= BIT(d->irq & 7);
 	ep93xx_gpio_update_int_params(epg, port);
 }
 
@@ -211,12 +206,12 @@ static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	const int gpio = irq_to_gpio(d->irq);
-	const int port = gpio >> 3;
-	const int port_mask = 1 << (gpio & 7);
+	int port = ep93xx_gpio_port(gc);
+	int offset = d->irq & 7;
+	int port_mask = BIT(offset);
 	irq_flow_handler_t handler;
 
-	gpio_direction_input(gpio);
+	gc->direction_input(gc, offset);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -242,7 +237,7 @@ static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 	case IRQ_TYPE_EDGE_BOTH:
 		gpio_int_type1[port] |= port_mask;
 		/* set initial polarity based on current input level */
-		if (gpio_get_value(gpio))
+		if (gc->get(gc, offset))
 			gpio_int_type2[port] &= ~port_mask; /* falling */
 		else
 			gpio_int_type2[port] |= port_mask; /* rising */
-- 
2.17.1
