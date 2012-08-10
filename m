From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:02:00 +0200
Subject: [PATCH 03/14] arm: at91: at91sam9x5: fix gpio number per bank
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1344603731-32667-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the serie 5 bank b and d have 19 and 22 pins only.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 .../devicetree/bindings/gpio/gpio_atmel.txt        |    5 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    2 ++
 arch/arm/mach-at91/gpio.c                          |   33 +++++++++++++-------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
index 66efc80..f2caa9f 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
@@ -9,6 +9,10 @@ Required properties:
   unused).
 - gpio-controller: Marks the device node as a GPIO controller.
 
+optional properties:
+- gpio-nb: Number of gpio if absent 32.
+
+
 Example:
 	pioA: gpio at fffff200 {
 		compatible = "atmel,at91rm9200-gpio";
@@ -16,5 +20,6 @@ Example:
 		interrupts = <2 4>;
 		#gpio-cells = <2>;
 		gpio-controller;
+		gpio-nb = <19>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 8c314d5..8b56730 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -130,6 +130,7 @@
 					interrupts = <2 4 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
+					gpio-nb = <19>;
 					interrupt-controller;
 				};
 
@@ -148,6 +149,7 @@
 					interrupts = <3 4 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
+					gpio-nb = <22>;
 					interrupt-controller;
 				};
 			};
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 3770d72..8b476fd 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -33,6 +33,8 @@
 
 #include "generic.h"
 
+#define MAX_NB_GPIO_PER_BANK	32
+
 struct at91_gpio_chip {
 	struct gpio_chip	chip;
 	struct at91_gpio_chip	*next;		/* Bank sharing same clock */
@@ -57,7 +59,7 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset);
 static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 
-#define AT91_GPIO_CHIP(name, nr_gpio)					\
+#define AT91_GPIO_CHIP(name)						\
 	{								\
 		.chip = {						\
 			.label		  = name,			\
@@ -69,16 +71,16 @@ static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 			.set		  = at91_gpiolib_set,		\
 			.dbg_show	  = at91_gpiolib_dbg_show,	\
 			.to_irq		  = at91_gpiolib_to_irq,	\
-			.ngpio		  = nr_gpio,			\
+			.ngpio		  = MAX_NB_GPIO_PER_BANK,	\
 		},							\
 	}
 
 static struct at91_gpio_chip gpio_chip[] = {
-	AT91_GPIO_CHIP("pioA", 32),
-	AT91_GPIO_CHIP("pioB", 32),
-	AT91_GPIO_CHIP("pioC", 32),
-	AT91_GPIO_CHIP("pioD", 32),
-	AT91_GPIO_CHIP("pioE", 32),
+	AT91_GPIO_CHIP("pioA"),
+	AT91_GPIO_CHIP("pioB"),
+	AT91_GPIO_CHIP("pioC"),
+	AT91_GPIO_CHIP("pioD"),
+	AT91_GPIO_CHIP("pioE"),
 };
 
 static int gpio_banks;
@@ -93,7 +95,7 @@ static unsigned long at91_gpio_caps;
 
 static inline void __iomem *pin_to_controller(unsigned pin)
 {
-	pin /= 32;
+	pin /= MAX_NB_GPIO_PER_BANK;
 	if (likely(pin < gpio_banks))
 		return gpio_chip[pin].regbase;
 
@@ -102,7 +104,7 @@ static inline void __iomem *pin_to_controller(unsigned pin)
 
 static inline unsigned pin_to_mask(unsigned pin)
 {
-	return 1 << (pin % 32);
+	return 1 << (pin % MAX_NB_GPIO_PER_BANK);
 }
 
 
@@ -999,6 +1001,7 @@ static void __init of_at91_gpio_init_one(struct device_node *np)
 {
 	int alias_idx;
 	struct at91_gpio_chip *at91_gpio;
+	uint32_t ngpio;
 
 	if (!np)
 		return;
@@ -1011,7 +1014,7 @@ static void __init of_at91_gpio_init_one(struct device_node *np)
 	}
 
 	at91_gpio = &gpio_chip[alias_idx];
-	at91_gpio->chip.base = alias_idx * at91_gpio->chip.ngpio;
+	at91_gpio->chip.base = alias_idx * MAX_NB_GPIO_PER_BANK;
 
 	at91_gpio->regbase = of_iomap(np, 0);
 	if (!at91_gpio->regbase) {
@@ -1031,6 +1034,14 @@ static void __init of_at91_gpio_init_one(struct device_node *np)
 	if (of_device_is_compatible(np, "atmel,at91sam9x5-gpio"))
 		at91_gpio_caps |= AT91_GPIO_CAP_PIO3;
 
+	if (!of_property_read_u32(np, "gpio-nb", &ngpio)) {
+		if (ngpio >= MAX_NB_GPIO_PER_BANK)
+			pr_err("at91_gpio.%d, gpio-nb >= %d failback to %d\n",
+			       alias_idx, MAX_NB_GPIO_PER_BANK, MAX_NB_GPIO_PER_BANK);
+		else
+			at91_gpio->chip.ngpio = ngpio;
+	}
+
 	/* Setup clock */
 	if (at91_gpio_setup_clk(alias_idx))
 		goto ioremap_err;
@@ -1068,7 +1079,7 @@ static void __init at91_gpio_init_one(int idx, u32 regbase, int pioc_hwirq)
 {
 	struct at91_gpio_chip *at91_gpio = &gpio_chip[idx];
 
-	at91_gpio->chip.base = idx * at91_gpio->chip.ngpio;
+	at91_gpio->chip.base = idx * MAX_NB_GPIO_PER_BANK;
 	at91_gpio->pioc_hwirq = pioc_hwirq;
 	at91_gpio->pioc_idx = idx;
 
-- 
1.7.10.4
