From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 20:16:05 +0100
Subject: [PATCH 3/6] ARM: at91/gpio: add DT support
In-Reply-To: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <876f676ec80d2db927e379654be76171ca496422.1323975517.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/gpio/gpio_at91.txt         |   20 +++
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   28 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   45 +++++++
 arch/arm/mach-at91/gpio.c                          |  127 ++++++++++++++++----
 4 files changed, 198 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_at91.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_at91.txt b/Documentation/devicetree/bindings/gpio/gpio_at91.txt
new file mode 100644
index 0000000..a7bcaec
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_at91.txt
@@ -0,0 +1,20 @@
+* Atmel GPIO controller (PIO)
+
+Required properties:
+- compatible: "atmel,at91rm9200-gpio"
+- reg: Should contain GPIO controller registers location and length
+- interrupts: Should be the port interrupt shared by all the pins.
+- #gpio-cells: Should be two.  The first cell is the pin number and
+  the second cell is used to specify optional parameters (currently
+  unused).
+- gpio-controller: Marks the device node as a GPIO controller.
+
+Example:
+	pioA: gpio at fffff200 {
+		compatible = "atmel,at91rm9200-gpio";
+		reg = <0xfffff200 0x100>;
+		interrupts = <2 4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 0782f80..ea942b5 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -23,6 +23,9 @@
 		serial4 = &usart3;
 		serial5 = &usart4;
 		serial6 = &usart5;
+		gpio0 = &pioA;
+		gpio1 = &pioB;
+		gpio2 = &pioC;
 	};
 	cpus {
 		cpu at 0 {
@@ -54,6 +57,31 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+
+			pioA: gpio at fffff400 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff400 0x100>;
+				interrupts = <2 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
+			pioB: gpio at fffff600 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff600 0x100>;
+				interrupts = <3 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
+			pioC: gpio at fffff800 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff800 0x100>;
+				interrupts = <4 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index e89b1d7..ebc9617 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -22,6 +22,11 @@
 		serial2 = &usart1;
 		serial3 = &usart2;
 		serial4 = &usart3;
+		gpio0 = &pioA;
+		gpio1 = &pioB;
+		gpio2 = &pioC;
+		gpio3 = &pioD;
+		gpio4 = &pioE;
 	};
 	cpus {
 		cpu at 0 {
@@ -59,6 +64,46 @@
 				interrupts = <21 4>;
 			};
 
+			pioA: gpio at fffff200 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff200 0x100>;
+				interrupts = <2 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
+			pioB: gpio at fffff400 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff400 0x100>;
+				interrupts = <3 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
+			pioC: gpio at fffff600 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff600 0x100>;
+				interrupts = <4 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
+			pioD: gpio at fffff800 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffff800 0x100>;
+				interrupts = <5 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
+			pioE: gpio at fffffa00 {
+				compatible = "atmel,at91rm9200-gpio";
+				reg = <0xfffffa00 0x100>;
+				interrupts = <5 4>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 7ffb893..edb453a 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
+#include <linux/of_address.h>
 
 #include <mach/hardware.h>
 #include <mach/at91_pio.h>
@@ -624,40 +625,122 @@ static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	}
 }
 
+#ifdef CONFIG_OF_GPIO
+static void __init of_at91_gpio_init_one(struct device_node *np)
+{
+	int alias_id;
+	struct at91_gpio_chip *at91_gpio;
+	const unsigned int *intspec;
+
+	if (!np)
+		return;
+
+	alias_id = of_alias_get_id(np, "gpio");
+	if (alias_id >= MAX_GPIO_BANKS) {
+		pr_err("at91_gpio, failed alias id(%d) > MAX_GPIO_BANKS(%d), ignoring.\n",
+								alias_id, MAX_GPIO_BANKS);
+		return;
+	}
+
+	at91_gpio = &gpio_chip[alias_id];
+	at91_gpio->chip.base = alias_id * at91_gpio->chip.ngpio;
+
+	at91_gpio->regbase = of_iomap(np, 0);
+	if (!at91_gpio->regbase) {
+		pr_err("at91_gpio.%d, failed to map registers, ignoring.\n",
+								alias_id);
+		return;
+	}
+
+	/* Get the interrupts property */
+	intspec = of_get_property(np, "interrupts", NULL);
+	BUG_ON(!intspec);
+	at91_gpio->id = be32_to_cpup(intspec);
+
+	at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
+	if (!at91_gpio->clock) {
+		pr_err("at91_gpio.%d, failed to get clock, ignoring.\n",
+								alias_id);
+		return;
+	}
+
+	/* enable PIO controller's clock */
+	clk_enable(at91_gpio->clock);
+
+	at91_gpio->chip.of_node = np;
+	gpio_banks = max(gpio_banks, alias_id + 1);
+}
+
+static int __init of_at91_gpio_init(void)
+{
+	struct device_node *np = NULL;
+
+	/*
+	 * This isn't ideal, but it gets things hooked up until this
+	 * driver is converted into a platform_device
+	 */
+	do {
+		np = of_find_compatible_node(np, NULL, "atmel,at91rm9200-gpio");
+
+		of_at91_gpio_init_one(np);
+	} while (np);
+
+	return gpio_banks > 0 ? 0 : -EINVAL;
+}
+#else
+static int __init of_at91_gpio_init(void)
+{
+	return -EINVAL;
+}
+#endif
+
+static void __init at91_gpio_init_one(int i, u32 regbase, int id)
+{
+	struct at91_gpio_chip *at91_gpio = &gpio_chip[i];
+
+	at91_gpio->chip.base = i * at91_gpio->chip.ngpio;
+	at91_gpio->id = id;
+
+	at91_gpio->regbase = ioremap(regbase, 512);
+	if (!at91_gpio->regbase) {
+		pr_err("at91_gpio.%d, failed to map registers, ignoring.\n", i);
+		return;
+	}
+
+	at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
+	if (!at91_gpio->clock) {
+		pr_err("at91_gpio.%d, failed to get clock, ignoring.\n", i);
+		return;
+	}
+
+	/* enable PIO controller's clock */
+	clk_enable(at91_gpio->clock);
+	gpio_banks = max(gpio_banks, i + 1);
+}
+
 /*
  * Called from the processor-specific init to enable GPIO pin support.
  */
 void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
 {
-	unsigned		i;
+	unsigned i;
 	struct at91_gpio_chip *at91_gpio, *last = NULL;
 
 	BUG_ON(nr_banks > MAX_GPIO_BANKS);
 
-	gpio_banks = nr_banks;
+	if (of_at91_gpio_init() < 0) {
+		/* no GPIO controller found in device tree */
+		for (i = 0; i < nr_banks; i++)
+			at91_gpio_init_one(i, data[i].regbase, data[i].id);
+	}
 
-	for (i = 0; i < nr_banks; i++) {
+	for (i = 0; i < gpio_banks; i++) {
 		at91_gpio = &gpio_chip[i];
 
-		at91_gpio->id = data[i].id;
-		at91_gpio->chip.base = i * 32;
-
-		at91_gpio->regbase = ioremap(data[i].regbase, 512);
-		if (!at91_gpio->regbase) {
-			pr_err("at91_gpio.%d, failed to map registers, ignoring.\n", i);
-			continue;
-		}
-
-		at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
-		if (!at91_gpio->clock) {
-			pr_err("at91_gpio.%d, failed to get clock, ignoring.\n", i);
-			continue;
-		}
-
-		/* enable PIO controller's clock */
-		clk_enable(at91_gpio->clock);
-
-		/* AT91SAM9263_ID_PIOCDE groups PIOC, PIOD, PIOE */
+		/*
+		 * GPIO controller are grouped on some SoC:
+		 * PIOC, PIOD and PIOE can share the same IRQ line
+		 */
 		if (last && last->id == at91_gpio->id)
 			last->next = at91_gpio;
 		last = at91_gpio;
-- 
1.7.5.4
