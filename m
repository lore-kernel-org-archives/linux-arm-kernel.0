From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 16:46:30 +0100
Subject: [PATCH 3/4] gpio: ep93xx: remove private irq_to_gpio function
In-Reply-To: <1455551208-2825510-1-git-send-email-arnd@arndb.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
Message-ID: <1455551208-2825510-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ep93xx goes through its own back-and-forth dance every time
it wants to know the gpio number for an irq line, when it really
just hardcodes a fixed offset in ep93xx_gpio_to_irq().

This removes the pointless macro and replaces the conversion inside
of the driver with simple add/subtract operations, using an
explicit macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-ep93xx.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 20e5846bda28..cd83d30e8ff7 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -18,12 +18,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-#include <linux/gpio/driver.h>
-/* FIXME: this is here for gpio_to_irq() - get rid of this! */
 #include <linux/gpio.h>
 
-#define irq_to_gpio(irq)	((irq) - gpio_to_irq(0))
-
 void __iomem *ep93xx_gpio_base; /* FIXME: put this into irq_data */
 
 #define EP93XX_GPIO_REG(x)		(ep93xx_gpio_base + (x))
@@ -35,6 +31,7 @@ void __iomem *ep93xx_gpio_base; /* FIXME: put this into irq_data */
 #define EP93XX_GPIO_LINE_MAX		63
 
 /* maximum value for irq capable line identifiers */
+#define EP93XX_GPIO_IRQ_BASE		64
 #define EP93XX_GPIO_LINE_MAX_IRQ	23
 
 
@@ -77,7 +74,7 @@ static void ep93xx_gpio_update_int_params(unsigned port)
 
 static void ep93xx_gpio_int_debounce(unsigned int irq, bool enable)
 {
-	int line = irq_to_gpio(irq);
+	int line = irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
@@ -98,7 +95,7 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 	status = readb(EP93XX_GPIO_A_INT_STATUS);
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i)) {
-			int gpio_irq = gpio_to_irq(0) + i;
+			int gpio_irq = EP93XX_GPIO_IRQ_BASE + i;
 			generic_handle_irq(gpio_irq);
 		}
 	}
@@ -106,7 +103,7 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 	status = readb(EP93XX_GPIO_B_INT_STATUS);
 	for (i = 0; i < 8; i++) {
 		if (status & (1 << i)) {
-			int gpio_irq = gpio_to_irq(8) + i;
+			int gpio_irq = EP93XX_GPIO_IRQ_BASE + 8 + i;
 			generic_handle_irq(gpio_irq);
 		}
 	}
@@ -121,14 +118,14 @@ static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 	 */
 	unsigned int irq = irq_desc_get_irq(desc);
 	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
-	int gpio_irq = gpio_to_irq(16) + port_f_idx;
+	int gpio_irq = EP93XX_GPIO_IRQ_BASE + 16 + port_f_idx;
 
 	generic_handle_irq(gpio_irq);
 }
 
 static void ep93xx_gpio_irq_ack(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
@@ -142,7 +139,7 @@ static void ep93xx_gpio_irq_ack(struct irq_data *d)
 
 static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
@@ -157,7 +154,7 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 
 static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] &= ~(1 << (line & 7));
@@ -166,7 +163,7 @@ static void ep93xx_gpio_irq_mask(struct irq_data *d)
 
 static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
-	int line = irq_to_gpio(d->irq);
+	int line = d->irq - EP93XX_GPIO_IRQ_BASE;
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] |= 1 << (line & 7);
@@ -180,7 +177,7 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
  */
 static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
-	const int gpio = irq_to_gpio(d->irq);
+	const int gpio = d->irq - EP93XX_GPIO_IRQ_BASE;
 	const int port = gpio >> 3;
 	const int port_mask = 1 << (gpio & 7);
 	irq_flow_handler_t handler;
@@ -241,14 +238,14 @@ static struct irq_chip ep93xx_gpio_irq_chip = {
 
 static void ep93xx_gpio_init_irq(struct platform_device *pdev)
 {
-	int gpio_irq;
+	int gpio;
 	int i;
 
-	for (gpio_irq = gpio_to_irq(0);
-	     gpio_irq <= gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ); ++gpio_irq) {
-		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
+	for (gpio = 0; gpio <= EP93XX_GPIO_LINE_MAX_IRQ; ++gpio) {
+		irq_set_chip_and_handler(EP93XX_GPIO_IRQ_BASE + gpio,
+					 &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
-		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
+		irq_clear_status_flags(EP93XX_GPIO_IRQ_BASE + gpio, IRQ_NOREQUEST);
 	}
 
 	irq_set_chained_handler(platform_get_irq(pdev, 0),
@@ -294,7 +291,7 @@ static int ep93xx_gpio_set_debounce(struct gpio_chip *chip,
 				    unsigned offset, unsigned debounce)
 {
 	int gpio = chip->base + offset;
-	int irq = gpio_to_irq(gpio);
+	int irq = EP93XX_GPIO_IRQ_BASE + gpio;
 
 	if (irq < 0)
 		return -EINVAL;
@@ -316,7 +313,7 @@ static int ep93xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	if (gpio > EP93XX_GPIO_LINE_MAX_IRQ)
 		return -EINVAL;
 
-	return 64 + gpio;
+	return EP93XX_GPIO_IRQ_BASE + gpio;
 }
 
 static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
-- 
2.7.0
