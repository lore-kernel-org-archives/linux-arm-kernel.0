From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 10 Mar 2011 19:08:56 +0100
Subject: [PATCH 5/6] AT91: pio: add new PIO3a features
In-Reply-To: <20110310180628.GH9351@game.jcrosoft.org>
References: <20110310180628.GH9351@game.jcrosoft.org>
Message-ID: <1299780537-16481-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

This patch adds the support for new PIO controller found on some
at91sam SOCs.
- more peripheral multiplexing
- more features to configure on a PIO (pull-down, Schmitt trigger, debouncer)
- support for several irq tirggering features (type and polarity)

Debugfs at91_gpio file is updated to monitor configuration.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/gpio.c                  |  240 ++++++++++++++++++++++++++--
 arch/arm/mach-at91/include/mach/at91_pio.h |   25 +++
 arch/arm/mach-at91/include/mach/gpio.h     |    5 +
 3 files changed, 257 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index af818a2..8f00902 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
+#include <mach/cpu.h>
 #include <mach/hardware.h>
 #include <mach/at91_pio.h>
 #include <mach/gpio.h>
@@ -69,6 +70,12 @@ static struct at91_gpio_chip gpio_chip[] = {
 
 static int gpio_banks;
 
+/*
+ * Functionnality can change with newer chips
+ */
+#define cpu_has_pio3()	(cpu_is_at91sam9x5())
+
+
 static inline void __iomem *pin_to_controller(unsigned pin)
 {
 	pin -= PIN_BASE;
@@ -86,6 +93,52 @@ static inline unsigned pin_to_mask(unsigned pin)
 }
 
 
+static char peripheral_function(void __iomem *pio, unsigned mask)
+{
+	char	ret = 'X';
+	u8	select;
+
+	if (pio) {
+		if (cpu_has_pio3()) {
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
+		if (!cpu_has_pio3() || !(__raw_readl(pio + PIO_AIMMR) & mask )) {
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
@@ -133,7 +186,14 @@ int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup)
 
 	__raw_writel(mask, pio + PIO_IDR);
 	__raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
-	__raw_writel(mask, pio + PIO_ASR);
+	if (cpu_has_pio3()) {
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
@@ -153,7 +213,14 @@ int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup)
 
 	__raw_writel(mask, pio + PIO_IDR);
 	__raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
-	__raw_writel(mask, pio + PIO_BSR);
+	if (cpu_has_pio3()) {
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
@@ -161,6 +228,48 @@ EXPORT_SYMBOL(at91_set_B_periph);
 
 
 /*
+ * mux the pin to the "C" internal peripheral role.
+ */
+int __init_or_module at91_set_C_periph(unsigned pin, int use_pullup)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !cpu_has_pio3())
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
+ * mux the pin to the "C" internal peripheral role.
+ */
+int __init_or_module at91_set_D_periph(unsigned pin, int use_pullup)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !cpu_has_pio3())
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
  * mux the pin to the gpio controller (instead of "A" or "B" peripheral), and
  * configure it for an input.
  */
@@ -213,12 +322,37 @@ int __init_or_module at91_set_deglitch(unsigned pin, int is_on)
 
 	if (!pio)
 		return -EINVAL;
+
+	if (cpu_has_pio3() && is_on)
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
+	if (!pio || !cpu_has_pio3())
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
@@ -236,6 +370,41 @@ int __init_or_module at91_set_multi_drive(unsigned pin, int is_on)
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
+	if (!pio || !cpu_has_pio3())
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
+	if (!pio || !cpu_has_pio3())
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
@@ -337,7 +506,10 @@ void at91_gpio_resume(void)
  * To use any AT91_PIN_* as an externally triggered IRQ, first call
  * at91_set_gpio_input() then maybe enable its glitch filter.
  * Then just request_irq() with the pin ID; it works like any ARM IRQ
- * handler, though it always triggers on rising and falling edges.
+ * handler.
+ * First implementation always triggers on rising and falling edges
+ * whereas the newer PIO3a can be additionally configured to trigger on
+ * level, edge with any polarity.
  *
  * Alternatively, certain pins may be used directly as IRQ0..IRQ6 after
  * configuring them with at91_set_a_periph() or at91_set_b_periph().
@@ -362,7 +534,7 @@ static void gpio_irq_unmask(struct irq_data *d)
 		__raw_writel(mask, pio + PIO_IER);
 }
 
-static int gpio_irq_type(struct irq_data *d, unsigned type)
+static int gpio_irq_type(unsigned pin, unsigned type)
 {
 	switch (type) {
 	case IRQ_TYPE_NONE:
@@ -373,11 +545,50 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	}
 }
 
+/* Alternate irq type for PIO3a support */
+static int alt_gpio_irq_type(unsigned pin, unsigned type)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
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
+		/* disable additional interrupt modes:
+		 * fall back to default behavior */
+		__raw_writel(mask, pio + PIO_AIMDR);
+		return 0;
+	case IRQ_TYPE_NONE:
+	default:
+		pr_warn("AT91: No type for irq %d\n", gpio_to_irq(pin));
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
 	.irq_mask	= gpio_irq_mask,
 	.irq_unmask	= gpio_irq_unmask,
-	.irq_set_type	= gpio_irq_type,
 	.irq_set_wake	= gpio_irq_set_wake,
 };
 
@@ -444,7 +655,7 @@ static int at91_gpio_show(struct seq_file *s, void *unused)
 	/* print heading */
 	seq_printf(s, "Pin\t");
 	for (bank = 0; bank < gpio_banks; bank++) {
-		seq_printf(s, "PIO%c\t", 'A' + bank);
+		seq_printf(s, "PIO%c\t\t", 'A' + bank);
 	};
 	seq_printf(s, "\n\n");
 
@@ -458,11 +669,10 @@ static int at91_gpio_show(struct seq_file *s, void *unused)
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
@@ -509,6 +719,11 @@ void __init at91_gpio_irq_setup(void)
 	unsigned		pioc, pin;
 	struct at91_gpio_chip	*this, *prev;
 
+	if (cpu_has_pio3())
+		gpio_irqchip.set_type = alt_gpio_irq_type;
+	else
+		gpio_irqchip.set_type = gpio_irq_type;
+
 	for (pioc = 0, pin = PIN_BASE, this = gpio_chip, prev = NULL;
 			pioc++ < gpio_banks;
 			prev = this, this++) {
@@ -605,9 +820,8 @@ static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
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
index ddeb645..18bec90 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -193,10 +193,15 @@
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
1.7.4.1
