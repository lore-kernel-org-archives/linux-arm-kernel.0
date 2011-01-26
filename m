From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 26 Jan 2011 16:22:48 -0700
Subject: [PATCH] ep93xx: implement gpiolib set_debounce for built-in GPIOs
Message-ID: <201101261622.48750.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO Ports A, B, and F on the ep93xx provide interrupt capability.  It is
possible to debounce the input signal on these ports when interrupts are
enabled.

Support for this debounce capability was provided with an ep93xx internal
function.  Now that gpiolib knows about gpio debounce, use the gpiolib
method and do not export the internal function.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index bec34b8..a889fa7 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -61,7 +61,7 @@ static inline void ep93xx_gpio_int_mask(unsigned line)
 	gpio_int_unmasked[line >> 3] &= ~(1 << (line & 7));
 }
 
-void ep93xx_gpio_int_debounce(unsigned int irq, int enable)
+static void ep93xx_gpio_int_debounce(unsigned int irq, bool enable)
 {
 	int line = irq_to_gpio(irq);
 	int port = line >> 3;
@@ -75,7 +75,6 @@ void ep93xx_gpio_int_debounce(unsigned int irq, int enable)
 	__raw_writeb(gpio_int_debounce[port],
 		EP93XX_GPIO_REG(int_debounce_register_offset[port]));
 }
-EXPORT_SYMBOL(ep93xx_gpio_int_debounce);
 
 static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
@@ -335,6 +334,20 @@ static void ep93xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 	local_irq_restore(flags);
 }
 
+static int ep93xx_gpio_set_debounce(struct gpio_chip *chip,
+				    unsigned offset, unsigned debounce)
+{
+	int gpio = chip->base + offset;
+	int irq = gpio_to_irq(gpio);
+
+	if (irq < 0)
+		return -EINVAL;
+
+	ep93xx_gpio_int_debounce(irq, debounce ? true : false);
+
+	return 0;
+}
+
 static void ep93xx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
 	struct ep93xx_gpio_chip *ep93xx_chip = to_ep93xx_gpio_chip(chip);
@@ -434,6 +447,18 @@ void __init ep93xx_gpio_init(void)
 				 EP93XX_SYSCON_DEVCFG_GONIDE |
 				 EP93XX_SYSCON_DEVCFG_HONIDE);
 
-	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++)
-		gpiochip_add(&ep93xx_gpio_banks[i].chip);
+	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
+		struct gpio_chip *chip = &ep93xx_gpio_banks[i].chip;
+
+		/*
+		 * Ports A, B, and F support input debouncing when
+		 * used as interrupts.
+		 */
+		if (!strcmp(chip->label, "A") ||
+		    !strcmp(chip->label, "B") ||
+		    !strcmp(chip->label, "F"))
+			chip->set_debounce = ep93xx_gpio_set_debounce;
+
+		gpiochip_add(chip);
+	}
 }
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
index c991b14..c57152c 100644
--- a/arch/arm/mach-ep93xx/include/mach/gpio.h
+++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
@@ -99,8 +99,6 @@
 /* maximum value for irq capable line identifiers */
 #define EP93XX_GPIO_LINE_MAX_IRQ	EP93XX_GPIO_LINE_F(7)
 
-extern void ep93xx_gpio_int_debounce(unsigned int irq, int enable);
-
 /* new generic GPIO API - see Documentation/gpio.txt */
 
 #include <asm-generic/gpio.h>
