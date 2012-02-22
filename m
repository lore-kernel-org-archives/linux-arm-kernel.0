From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 22 Feb 2012 16:57:32 +0100
Subject: [PATCH] ARM: at91/pio: add new PIO3 features
Message-ID: <1329926252-9523-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support for new PIO controller found on some
at91sam SOCs.
- more peripheral multiplexing
- more features to configure on a PIO (pull-down, Schmitt trigger, debouncer)
- support for several IRQ triggering features (type and polarity)

Support for those new features are retrieved from the device tree
compatibility string.

Debugfs at91_gpio file is updated to monitor configuration.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/gpio/gpio_atmel.txt        |    2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    8 +-
 arch/arm/mach-at91/board-dt.c                      |    1 +
 arch/arm/mach-at91/gpio.c                          |  262 ++++++++++++++++++--
 arch/arm/mach-at91/include/mach/at91_pio.h         |   25 ++
 arch/arm/mach-at91/include/mach/gpio.h             |    5 +
 6 files changed, 282 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
index a7bcaec..66efc80 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
@@ -1,7 +1,7 @@
 * Atmel GPIO controller (PIO)
 
 Required properties:
-- compatible: "atmel,at91rm9200-gpio"
+- compatible: "atmel,<chip>-gpio", where <chip> is at91rm9200 or at91sam9x5.
 - reg: Should contain GPIO controller registers location and length
 - interrupts: Should be the port interrupt shared by all the pins.
 - #gpio-cells: Should be two.  The first cell is the pin number and
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index bb0c676..a02e636 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -89,7 +89,7 @@
 			};
 
 			pioA: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffff400 0x100>;
 				interrupts = <2 4>;
 				#gpio-cells = <2>;
@@ -98,7 +98,7 @@
 			};
 
 			pioB: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffff600 0x100>;
 				interrupts = <2 4>;
 				#gpio-cells = <2>;
@@ -107,7 +107,7 @@
 			};
 
 			pioC: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffff800 0x100>;
 				interrupts = <3 4>;
 				#gpio-cells = <2>;
@@ -116,7 +116,7 @@
 			};
 
 			pioD: gpio at fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
+				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 				reg = <0xfffffa00 0x100>;
 				interrupts = <3 4>;
 				#gpio-cells = <2>;
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index e0df4e5..0c5663a 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -92,6 +92,7 @@ static const struct of_device_id irq_of_match[] __initconst = {
 
 	{ .compatible = "atmel,at91rm9200-aic", .data = at91_aic_of_init },
 	{ .compatible = "atmel,at91rm9200-gpio", .data = at91_gpio_of_irq_setup },
+	{ .compatible = "atmel,at91sam9x5-gpio", .data = at91_gpio_of_irq_setup },
 	{ /*sentinel*/ }
 };
 
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 567df65..0174de9 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -76,6 +76,14 @@ static struct at91_gpio_chip gpio_chip[] = {
 };
 
 static int gpio_banks;
+static unsigned long at91_gpio_caps;
+
+/* All PIO controllers support PIO3 features */
+#define AT91_GPIO_CAP_PIO3	(1 <<  0)
+
+#define has_pio3()	(at91_gpio_caps & AT91_GPIO_CAP_PIO3)
+
+/*--------------------------------------------------------------------------*/
 
 static inline void __iomem *pin_to_controller(unsigned pin)
 {
@@ -92,6 +100,52 @@ static inline unsigned pin_to_mask(unsigned pin)
 }
 
 
+static char peripheral_function(void __iomem *pio, unsigned mask)
+{
+	char	ret = 'X';
+	u8	select;
+
+	if (pio) {
+		if (has_pio3()) {
+			select = !!(__raw_readl(pio + PIO_ABCDSR1) & mask);
+			select |= (!!(__raw_readl(pio + PIO_ABCDSR2) & mask) << 1);
+			ret = 'A' + select;
+		} else {
+			ret = __raw_readl(pio + PIO_ABSR) & mask ?
+							'B' : 'A';
+		}
+	}
+
+	return ret;
+}
+
+static void gpio_printf(struct seq_file *s, void __iomem *pio, unsigned mask)
+{
+	char	*trigger = NULL;
+	char	*polarity = NULL;
+
+	if (__raw_readl(pio + PIO_IMR) & mask) {
+		if (!has_pio3() || !(__raw_readl(pio + PIO_AIMMR) & mask )) {
+			trigger = "edge";
+			polarity = "both";
+		} else {
+			if (__raw_readl(pio + PIO_ELSR) & mask) {
+				trigger = "level";
+				polarity = __raw_readl(pio + PIO_FRLHSR) & mask ?
+					"high" : "low";
+			} else {
+				trigger = "edge";
+				polarity = __raw_readl(pio + PIO_FRLHSR) & mask ?
+						"rising" : "falling";
+			}
+		}
+		seq_printf(s, "IRQ:%s-%s\t", trigger, polarity);
+	} else {
+		seq_printf(s, "GPIO:%s\t\t",
+				__raw_readl(pio + PIO_PDSR) & mask ? "1" : "0");
+	}
+}
+
 /*--------------------------------------------------------------------------*/
 
 /* Not all hardware capabilities are exposed through these calls; they
@@ -139,7 +193,14 @@ int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup)
 
 	__raw_writel(mask, pio + PIO_IDR);
 	__raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
-	__raw_writel(mask, pio + PIO_ASR);
+	if (has_pio3()) {
+		__raw_writel(__raw_readl(pio + PIO_ABCDSR1) & ~mask,
+							pio + PIO_ABCDSR1);
+		__raw_writel(__raw_readl(pio + PIO_ABCDSR2) & ~mask,
+							pio + PIO_ABCDSR2);
+	} else {
+		__raw_writel(mask, pio + PIO_ASR);
+	}
 	__raw_writel(mask, pio + PIO_PDR);
 	return 0;
 }
@@ -159,7 +220,14 @@ int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup)
 
 	__raw_writel(mask, pio + PIO_IDR);
 	__raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
-	__raw_writel(mask, pio + PIO_BSR);
+	if (has_pio3()) {
+		__raw_writel(__raw_readl(pio + PIO_ABCDSR1) | mask,
+							pio + PIO_ABCDSR1);
+		__raw_writel(__raw_readl(pio + PIO_ABCDSR2) & ~mask,
+							pio + PIO_ABCDSR2);
+	} else {
+		__raw_writel(mask, pio + PIO_BSR);
+	}
 	__raw_writel(mask, pio + PIO_PDR);
 	return 0;
 }
@@ -167,8 +235,50 @@ EXPORT_SYMBOL(at91_set_B_periph);
 
 
 /*
- * mux the pin to the gpio controller (instead of "A" or "B" peripheral), and
- * configure it for an input.
+ * mux the pin to the "C" internal peripheral role.
+ */
+int __init_or_module at91_set_C_periph(unsigned pin, int use_pullup)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !has_pio3())
+		return -EINVAL;
+
+	__raw_writel(mask, pio + PIO_IDR);
+	__raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
+	__raw_writel(__raw_readl(pio + PIO_ABCDSR1) & ~mask, pio + PIO_ABCDSR1);
+	__raw_writel(__raw_readl(pio + PIO_ABCDSR2) | mask, pio + PIO_ABCDSR2);
+	__raw_writel(mask, pio + PIO_PDR);
+	return 0;
+}
+EXPORT_SYMBOL(at91_set_C_periph);
+
+
+/*
+ * mux the pin to the "D" internal peripheral role.
+ */
+int __init_or_module at91_set_D_periph(unsigned pin, int use_pullup)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !has_pio3())
+		return -EINVAL;
+
+	__raw_writel(mask, pio + PIO_IDR);
+	__raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
+	__raw_writel(__raw_readl(pio + PIO_ABCDSR1) | mask, pio + PIO_ABCDSR1);
+	__raw_writel(__raw_readl(pio + PIO_ABCDSR2) | mask, pio + PIO_ABCDSR2);
+	__raw_writel(mask, pio + PIO_PDR);
+	return 0;
+}
+EXPORT_SYMBOL(at91_set_D_periph);
+
+
+/*
+ * mux the pin to the gpio controller (instead of "A", "B", "C"
+ * or "D" peripheral), and configure it for an input.
  */
 int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup)
 {
@@ -188,8 +298,8 @@ EXPORT_SYMBOL(at91_set_gpio_input);
 
 
 /*
- * mux the pin to the gpio controller (instead of "A" or "B" peripheral),
- * and configure it for an output.
+ * mux the pin to the gpio controller (instead of "A", "B", "C"
+ * or "D" peripheral), and configure it for an output.
  */
 int __init_or_module at91_set_gpio_output(unsigned pin, int value)
 {
@@ -219,12 +329,37 @@ int __init_or_module at91_set_deglitch(unsigned pin, int is_on)
 
 	if (!pio)
 		return -EINVAL;
+
+	if (has_pio3() && is_on)
+		__raw_writel(mask, pio + PIO_IFSCDR);
 	__raw_writel(mask, pio + (is_on ? PIO_IFER : PIO_IFDR));
 	return 0;
 }
 EXPORT_SYMBOL(at91_set_deglitch);
 
 /*
+ * enable/disable the debounce filter;
+ */
+int __init_or_module at91_set_debounce(unsigned pin, int is_on, int div)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !has_pio3())
+		return -EINVAL;
+
+	if (is_on) {
+		__raw_writel(mask, pio + PIO_IFSCER);
+		__raw_writel(div & PIO_SCDR_DIV, pio + PIO_SCDR);
+		__raw_writel(mask, pio + PIO_IFER);
+	} else {
+		__raw_writel(mask, pio + PIO_IFDR);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(at91_set_debounce);
+
+/*
  * enable/disable the multi-driver; This is only valid for output and
  * allows the output pin to run as an open collector output.
  */
@@ -242,6 +377,41 @@ int __init_or_module at91_set_multi_drive(unsigned pin, int is_on)
 EXPORT_SYMBOL(at91_set_multi_drive);
 
 /*
+ * enable/disable the pull-down.
+ * If pull-up already enabled while calling the function, we disable it.
+ */
+int __init_or_module at91_set_pulldown(unsigned pin, int is_on)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !has_pio3())
+		return -EINVAL;
+
+	/* Disable pull-up anyway */
+	__raw_writel(mask, pio + PIO_PUDR);
+	__raw_writel(mask, pio + (is_on ? PIO_PPDER : PIO_PPDDR));
+	return 0;
+}
+EXPORT_SYMBOL(at91_set_pulldown);
+
+/*
+ * disable Schmitt trigger
+ */
+int __init_or_module at91_disable_schmitt_trig(unsigned pin)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !has_pio3())
+		return -EINVAL;
+
+	__raw_writel(__raw_readl(pio + PIO_SCHMITT) | mask, pio + PIO_SCHMITT);
+	return 0;
+}
+EXPORT_SYMBOL(at91_disable_schmitt_trig);
+
+/*
  * assuming the pin is muxed as a gpio output, set its value.
  */
 int at91_set_gpio_value(unsigned pin, int value)
@@ -347,7 +517,10 @@ void at91_gpio_resume(void)
  * To use any AT91_PIN_* as an externally triggered IRQ, first call
  * at91_set_gpio_input() then maybe enable its glitch filter.
  * Then just request_irq() with the pin ID; it works like any ARM IRQ
- * handler, though it always triggers on rising and falling edges.
+ * handler.
+ * First implementation always triggers on rising and falling edges
+ * whereas the newer PIO3 can be additionally configured to trigger on
+ * level, edge with any polarity.
  *
  * Alternatively, certain pins may be used directly as IRQ0..IRQ6 after
  * configuring them with at91_set_a_periph() or at91_set_b_periph().
@@ -385,12 +558,55 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	}
 }
 
+/* Alternate irq type for PIO3 support */
+static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
+{
+	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
+	void __iomem	*pio = at91_gpio->regbase;
+	unsigned	mask = 1 << d->hwirq;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		__raw_writel(mask, pio + PIO_ESR);
+		__raw_writel(mask, pio + PIO_REHLSR);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		__raw_writel(mask, pio + PIO_ESR);
+		__raw_writel(mask, pio + PIO_FELLSR);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		__raw_writel(mask, pio + PIO_LSR);
+		__raw_writel(mask, pio + PIO_FELLSR);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		__raw_writel(mask, pio + PIO_LSR);
+		__raw_writel(mask, pio + PIO_REHLSR);
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		/*
+		 * disable additional interrupt modes:
+		 * fall back to default behavior
+		 */
+		__raw_writel(mask, pio + PIO_AIMDR);
+		return 0;
+	case IRQ_TYPE_NONE:
+	default:
+		pr_warn("AT91: No type for irq %d\n", gpio_to_irq(d->irq));
+		return -EINVAL;
+	}
+
+	/* enable additional interrupt modes */
+	__raw_writel(mask, pio + PIO_AIMER);
+
+	return 0;
+}
+
 static struct irq_chip gpio_irqchip = {
 	.name		= "GPIO",
 	.irq_disable	= gpio_irq_mask,
 	.irq_mask	= gpio_irq_mask,
 	.irq_unmask	= gpio_irq_unmask,
-	.irq_set_type	= gpio_irq_type,
+	/* .irq_set_type is set dynamically */
 	.irq_set_wake	= gpio_irq_set_wake,
 };
 
@@ -440,7 +656,7 @@ static int at91_gpio_show(struct seq_file *s, void *unused)
 	/* print heading */
 	seq_printf(s, "Pin\t");
 	for (bank = 0; bank < gpio_banks; bank++) {
-		seq_printf(s, "PIO%c\t", 'A' + bank);
+		seq_printf(s, "PIO%c\t\t", 'A' + bank);
 	};
 	seq_printf(s, "\n\n");
 
@@ -454,11 +670,10 @@ static int at91_gpio_show(struct seq_file *s, void *unused)
 			unsigned	mask = pin_to_mask(pin);
 
 			if (__raw_readl(pio + PIO_PSR) & mask)
-				seq_printf(s, "GPIO:%s", __raw_readl(pio + PIO_PDSR) & mask ? "1" : "0");
+				gpio_printf(s, pio, mask);
 			else
-				seq_printf(s, "%s", __raw_readl(pio + PIO_ABSR) & mask ? "B" : "A");
-
-			seq_printf(s, "\t");
+				seq_printf(s, "%c\t\t",
+						peripheral_function(pio, mask));
 		}
 
 		seq_printf(s, "\n");
@@ -529,6 +744,12 @@ int __init at91_gpio_of_irq_setup(struct device_node *node,
 	int			alias_idx = of_alias_get_id(node, "gpio");
 	struct at91_gpio_chip	*at91_gpio = &gpio_chip[alias_idx];
 
+	/* Setup proper .irq_set_type function */
+	if (has_pio3())
+		gpio_irqchip.irq_set_type = alt_gpio_irq_type;
+	else
+		gpio_irqchip.irq_set_type = gpio_irq_type;
+
 	/* Disable irqs of this PIO controller */
 	__raw_writel(~0, at91_gpio->regbase + PIO_IDR);
 
@@ -593,6 +814,12 @@ void __init at91_gpio_irq_setup(void)
 	int			gpio_irqnbr = 0;
 	struct at91_gpio_chip	*this, *prev;
 
+	/* Setup proper .irq_set_type function */
+	if (has_pio3())
+		gpio_irqchip.irq_set_type = alt_gpio_irq_type;
+	else
+		gpio_irqchip.irq_set_type = gpio_irq_type;
+
 	for (pioc = 0, this = gpio_chip, prev = NULL;
 			pioc++ < gpio_banks;
 			prev = this, this++) {
@@ -696,9 +923,8 @@ static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 					   at91_get_gpio_value(pin) ?
 					   "set" : "clear");
 			else
-				seq_printf(s, "[periph %s]\n",
-					   __raw_readl(pio + PIO_ABSR) &
-					   mask ? "B" : "A");
+				seq_printf(s, "[periph %c]\n",
+					   peripheral_function(pio, mask));
 		}
 	}
 }
@@ -781,6 +1007,10 @@ static void __init of_at91_gpio_init_one(struct device_node *np)
 		goto ioremap_err;
 	}
 
+	/* Get capabilities from compatibility property */
+	if (of_device_is_compatible(np, "atmel,at91sam9x5-gpio"))
+		at91_gpio_caps |= AT91_GPIO_CAP_PIO3;
+
 	/* Setup clock */
 	if (at91_gpio_setup_clk(alias_idx))
 		goto ioremap_err;
diff --git a/arch/arm/mach-at91/include/mach/at91_pio.h b/arch/arm/mach-at91/include/mach/at91_pio.h
index c6a31bf..732b11c 100644
--- a/arch/arm/mach-at91/include/mach/at91_pio.h
+++ b/arch/arm/mach-at91/include/mach/at91_pio.h
@@ -40,10 +40,35 @@
 #define PIO_PUER	0x64	/* Pull-up Enable Register */
 #define PIO_PUSR	0x68	/* Pull-up Status Register */
 #define PIO_ASR		0x70	/* Peripheral A Select Register */
+#define PIO_ABCDSR1	0x70	/* Peripheral ABCD Select Register 1 [some sam9 only] */
 #define PIO_BSR		0x74	/* Peripheral B Select Register */
+#define PIO_ABCDSR2	0x74	/* Peripheral ABCD Select Register 2 [some sam9 only] */
 #define PIO_ABSR	0x78	/* AB Status Register */
+#define PIO_IFSCDR	0x80	/* Input Filter Slow Clock Disable Register */
+#define PIO_IFSCER	0x84	/* Input Filter Slow Clock Enable Register */
+#define PIO_IFSCSR	0x88	/* Input Filter Slow Clock Status Register */
+#define PIO_SCDR	0x8c	/* Slow Clock Divider Debouncing Register */
+#define		PIO_SCDR_DIV	(0x3fff <<  0)		/* Slow Clock Divider Mask */
+#define PIO_PPDDR	0x90	/* Pad Pull-down Disable Register */
+#define PIO_PPDER	0x94	/* Pad Pull-down Enable Register */
+#define PIO_PPDSR	0x98	/* Pad Pull-down Status Register */
 #define PIO_OWER	0xa0	/* Output Write Enable Register */
 #define PIO_OWDR	0xa4	/* Output Write Disable Register */
 #define PIO_OWSR	0xa8	/* Output Write Status Register */
+#define PIO_AIMER	0xb0	/* Additional Interrupt Modes Enable Register */
+#define PIO_AIMDR	0xb4	/* Additional Interrupt Modes Disable Register */
+#define PIO_AIMMR	0xb8	/* Additional Interrupt Modes Mask Register */
+#define PIO_ESR		0xc0	/* Edge Select Register */
+#define PIO_LSR		0xc4	/* Level Select Register */
+#define PIO_ELSR	0xc8	/* Edge/Level Status Register */
+#define PIO_FELLSR	0xd0	/* Falling Edge/Low Level Select Register */
+#define PIO_REHLSR	0xd4	/* Rising Edge/ High Level Select Register */
+#define PIO_FRLHSR	0xd8	/* Fall/Rise - Low/High Status Register */
+#define PIO_SCHMITT	0x100	/* Schmitt Trigger Register */
+
+#define ABCDSR_PERIPH_A	0x0
+#define ABCDSR_PERIPH_B	0x1
+#define ABCDSR_PERIPH_C	0x2
+#define ABCDSR_PERIPH_D	0x3
 
 #endif
diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
index 7cf009b..eed465a 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -191,10 +191,15 @@
 extern int __init_or_module at91_set_GPIO_periph(unsigned pin, int use_pullup);
 extern int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup);
 extern int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup);
+extern int __init_or_module at91_set_C_periph(unsigned pin, int use_pullup);
+extern int __init_or_module at91_set_D_periph(unsigned pin, int use_pullup);
 extern int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup);
 extern int __init_or_module at91_set_gpio_output(unsigned pin, int value);
 extern int __init_or_module at91_set_deglitch(unsigned pin, int is_on);
+extern int __init_or_module at91_set_debounce(unsigned pin, int is_on, int div);
 extern int __init_or_module at91_set_multi_drive(unsigned pin, int is_on);
+extern int __init_or_module at91_set_pulldown(unsigned pin, int is_on);
+extern int __init_or_module at91_disable_schmitt_trig(unsigned pin);
 
 /* callable@any time */
 extern int at91_set_gpio_value(unsigned pin, int value);
-- 
1.7.9
