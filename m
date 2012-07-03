From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Jul 2012 16:22:34 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO Controllers
In-Reply-To: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Message-ID: <1341325365-21393-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both IRQ and GPIO controllers can now be represented in DT.  The IRQ
controllers are setup first, and then the GPIO controllers. Interrupts
for GPIO lines are placed directly after the main interrupts in the
interrupt space.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/arm/mrvl/intc.txt          |   19 +++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   23 +++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   27 ++++
 arch/arm/mach-dove/irq.c                           |   58 +++----
 arch/arm/mach-kirkwood/board-dt.c                  |    3 +-
 arch/arm/mach-kirkwood/irq.c                       |   38 ++---
 arch/arm/mach-mv78xx0/irq.c                        |   22 +--
 arch/arm/mach-orion5x/irq.c                        |   22 +--
 arch/arm/plat-orion/gpio.c                         |  166 +++++++++++++++-----
 arch/arm/plat-orion/include/plat/gpio.h            |   16 +-
 arch/arm/plat-orion/include/plat/irq.h             |    3 +-
 arch/arm/plat-orion/irq.c                          |   40 +++++
 13 files changed, 306 insertions(+), 132 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
index 80b9a94..8927e10 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
+++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
@@ -38,3 +38,22 @@ Example:
 		reg-names = "mux status", "mux mask";
 		mrvl,intc-nr-irqs = <2>;
 	};
+
+* Marvell Orion Interrupt controller
+
+Required properties
+- compatible :  Should be "marvell,orion-intc".
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. Supported value is <1>.
+- interrupt-controller : Declare this node to be an interrupt controller.
+- reg : Interrupt mask address.
+
+Example:
+
+	intc: interrupt-controller {
+        	compatible = "marvell,orion-intc", "marvell,intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+                reg = <0xfed20204 0x04>,
+		      <0xfed20214 0x04>;
+        };
diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
index 05428f3..e137874 100644
--- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -27,3 +27,26 @@ Example:
 		interrupt-controller;
 		#interrupt-cells = <1>;
       };
+
+* Marvell Orion GPIO Controller
+
+Required properties:
+- compatible         : Should be "marvell,orion-gpio"
+- reg                : Address and length of the register set for controller.
+- gpio-controller    : So we know this is a gpio controller.
+- ngpio              : How many gpios this controller has.
+- interrupts	     : Up to 4 Interrupts for the controller.
+
+Optional properties:
+- mask-offset        : For SMP Orions, offset for Nth CPU
+
+Example:
+
+		gpio0: gpio at 10100 {
+			compatible = "marvell,orion-gpio";
+			#gpio-cells = <2>;
+			gpio-controller;
+			reg = <0x10100 0x40>;
+			ngpio = <32>;
+			interrupts = <35>, <36>, <37>, <38>;
+		};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..39bb941 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1105,6 +1105,7 @@ config PLAT_ORION
 	bool
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
 	select COMMON_CLK
 
 config PLAT_PXA
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 926528b..66544d7 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -2,6 +2,15 @@
 
 / {
 	compatible = "mrvl,kirkwood";
+	interrupt-parent = <&intc>;
+
+	intc: interrupt-controller {
+		compatible = "marvell,orion-intc", "marvell,intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xf1020204 0x04>,
+		      <0xf1020214 0x04>;
+	};
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
@@ -9,6 +18,24 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		gpio0: gpio at 10100 {
+			compatible = "marvell,orion-gpio";
+			#gpio-cells = <2>;
+			gpio-controller;
+			reg = <0x10100 0x40>;
+			ngpio = <32>;
+			interrupts = <35>, <36>, <37>, <38>;
+		};
+
+		gpio1: gpio at 10140 {
+			compatible = "marvell,orion-gpio";
+			#gpio-cells = <2>;
+			gpio-controller;
+			reg = <0x10140 0x40>;
+			ngpio = <18>;
+			interrupts = <39>, <40>, <41>;
+		};
+
 		serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index f07fd16..9bc97a5 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -20,22 +20,6 @@
 #include <mach/bridge-regs.h>
 #include "common.h"
 
-static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	int irqoff;
-	BUG_ON(irq < IRQ_DOVE_GPIO_0_7 || irq > IRQ_DOVE_HIGH_GPIO);
-
-	irqoff = irq <= IRQ_DOVE_GPIO_16_23 ? irq - IRQ_DOVE_GPIO_0_7 :
-		3 + irq - IRQ_DOVE_GPIO_24_31;
-
-	orion_gpio_irq_handler(irqoff << 3);
-	if (irq == IRQ_DOVE_HIGH_GPIO) {
-		orion_gpio_irq_handler(40);
-		orion_gpio_irq_handler(48);
-		orion_gpio_irq_handler(56);
-	}
-}
-
 static void pmu_irq_mask(struct irq_data *d)
 {
 	int pin = irq_to_pmu(d->irq);
@@ -90,6 +74,27 @@ static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
+static int __initdata gpio0_irqs[4] = {
+	IRQ_DOVE_GPIO_0_7,
+	IRQ_DOVE_GPIO_8_15,
+	IRQ_DOVE_GPIO_16_23,
+	IRQ_DOVE_GPIO_24_31,
+};
+
+static int __initdata gpio1_irqs[4] = {
+	IRQ_DOVE_HIGH_GPIO,
+	0,
+	0,
+	0,
+};
+
+static int __initdata gpio2_irqs[4] = {
+	0,
+	0,
+	0,
+	0,
+};
+
 void __init dove_init_irq(void)
 {
 	int i;
@@ -100,19 +105,14 @@ void __init dove_init_irq(void)
 	/*
 	 * Initialize gpiolib for GPIOs 0-71.
 	 */
-	orion_gpio_init(0, 32, DOVE_GPIO_LO_VIRT_BASE, 0,
-			IRQ_DOVE_GPIO_START);
-	irq_set_chained_handler(IRQ_DOVE_GPIO_0_7, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_DOVE_GPIO_8_15, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_DOVE_GPIO_16_23, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_DOVE_GPIO_24_31, gpio_irq_handler);
-
-	orion_gpio_init(32, 32, DOVE_GPIO_HI_VIRT_BASE, 0,
-			IRQ_DOVE_GPIO_START + 32);
-	irq_set_chained_handler(IRQ_DOVE_HIGH_GPIO, gpio_irq_handler);
-
-	orion_gpio_init(64, 8, DOVE_GPIO2_VIRT_BASE, 0,
-			IRQ_DOVE_GPIO_START + 64);
+	orion_gpio_init(NULL, 0, 32, (void __iomem *)DOVE_GPIO_LO_VIRT_BASE, 0,
+			IRQ_DOVE_GPIO_START, gpio0_irqs);
+
+	orion_gpio_init(NULL, 32, 32, (void __iomem *)DOVE_GPIO_HI_VIRT_BASE, 0,
+			IRQ_DOVE_GPIO_START + 32, gpio1_irqs);
+
+	orion_gpio_init(NULL, 64, 8, (void __iomem *)DOVE_GPIO2_VIRT_BASE, 0,
+			IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
 
 	/*
 	 * Mask and clear PMU interrupts
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index edc3f8a..27ac3d8 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -18,6 +18,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
+#include <plat/irq.h>
 #include "common.h"
 
 static struct of_device_id kirkwood_dt_match_table[] __initdata = {
@@ -84,7 +85,7 @@ DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
 	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
+	.init_irq	= orion_dt_init_irq,
 	.timer		= &kirkwood_timer,
 	.init_machine	= kirkwood_dt_init,
 	.restart	= kirkwood_restart,
diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
index c4c68e5..720063f 100644
--- a/arch/arm/mach-kirkwood/irq.c
+++ b/arch/arm/mach-kirkwood/irq.c
@@ -9,20 +9,23 @@
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/io.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
-#include "common.h"
 
-static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	BUG_ON(irq < IRQ_KIRKWOOD_GPIO_LOW_0_7);
-	BUG_ON(irq > IRQ_KIRKWOOD_GPIO_HIGH_16_23);
+static int __initdata gpio0_irqs[4] = {
+	IRQ_KIRKWOOD_GPIO_LOW_0_7,
+	IRQ_KIRKWOOD_GPIO_LOW_8_15,
+	IRQ_KIRKWOOD_GPIO_LOW_16_23,
+	IRQ_KIRKWOOD_GPIO_LOW_24_31,
+};
 
-	orion_gpio_irq_handler((irq - IRQ_KIRKWOOD_GPIO_LOW_0_7) << 3);
-}
+static int __initdata gpio1_irqs[4] = {
+	IRQ_KIRKWOOD_GPIO_HIGH_0_7,
+	IRQ_KIRKWOOD_GPIO_HIGH_8_15,
+	IRQ_KIRKWOOD_GPIO_HIGH_16_23,
+	0,
+};
 
 void __init kirkwood_init_irq(void)
 {
@@ -32,17 +35,8 @@ void __init kirkwood_init_irq(void)
 	/*
 	 * Initialize gpiolib for GPIOs 0-49.
 	 */
-	orion_gpio_init(0, 32, GPIO_LOW_VIRT_BASE, 0,
-			IRQ_KIRKWOOD_GPIO_START);
-	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_0_7, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_8_15, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_16_23, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_24_31, gpio_irq_handler);
-
-	orion_gpio_init(32, 18, GPIO_HIGH_VIRT_BASE, 0,
-			IRQ_KIRKWOOD_GPIO_START + 32);
-	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_0_7, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_8_15, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_16_23,
-				gpio_irq_handler);
+	orion_gpio_init(NULL, 0, 32, (void __iomem *)GPIO_LOW_VIRT_BASE, 0,
+			IRQ_KIRKWOOD_GPIO_START, gpio0_irqs);
+	orion_gpio_init(NULL, 32, 18, (void __iomem *)GPIO_HIGH_VIRT_BASE, 0,
+			IRQ_KIRKWOOD_GPIO_START + 32, gpio1_irqs);
 }
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index e421b70..eff9a75 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -9,19 +9,17 @@
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/pci.h>
 #include <linux/irq.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
 #include "common.h"
 
-static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	BUG_ON(irq < IRQ_MV78XX0_GPIO_0_7 || irq > IRQ_MV78XX0_GPIO_24_31);
-
-	orion_gpio_irq_handler((irq - IRQ_MV78XX0_GPIO_0_7) << 3);
-}
+static int __initdata gpio0_irqs[4] = {
+	IRQ_MV78XX0_GPIO_0_7,
+	IRQ_MV78XX0_GPIO_8_15,
+	IRQ_MV78XX0_GPIO_16_23,
+	IRQ_MV78XX0_GPIO_24_31,
+};
 
 void __init mv78xx0_init_irq(void)
 {
@@ -34,11 +32,7 @@ void __init mv78xx0_init_irq(void)
 	 * registers for core #1 are@an offset of 0x18 from those of
 	 * core #0.)
 	 */
-	orion_gpio_init(0, 32, GPIO_VIRT_BASE,
+	orion_gpio_init(NULL, 0, 32, (void __iomem *)GPIO_VIRT_BASE,
 			mv78xx0_core_index() ? 0x18 : 0,
-			IRQ_MV78XX0_GPIO_START);
-	irq_set_chained_handler(IRQ_MV78XX0_GPIO_0_7, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_MV78XX0_GPIO_8_15, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_MV78XX0_GPIO_16_23, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_MV78XX0_GPIO_24_31, gpio_irq_handler);
+			IRQ_MV78XX0_GPIO_START, gpio0_irqs);
 }
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index b1b45ff..17da709 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -11,19 +11,16 @@
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/io.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
-#include "common.h"
 
-static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	BUG_ON(irq < IRQ_ORION5X_GPIO_0_7 || irq > IRQ_ORION5X_GPIO_24_31);
-
-	orion_gpio_irq_handler((irq - IRQ_ORION5X_GPIO_0_7) << 3);
-}
+static int __initdata gpio0_irqs[4] = {
+	IRQ_ORION5X_GPIO_0_7,
+	IRQ_ORION5X_GPIO_8_15,
+	IRQ_ORION5X_GPIO_16_23,
+	IRQ_ORION5X_GPIO_24_31,
+};
 
 void __init orion5x_init_irq(void)
 {
@@ -32,9 +29,6 @@ void __init orion5x_init_irq(void)
 	/*
 	 * Initialize gpiolib for GPIOs 0-31.
 	 */
-	orion_gpio_init(0, 32, GPIO_VIRT_BASE, 0, IRQ_ORION5X_GPIO_START);
-	irq_set_chained_handler(IRQ_ORION5X_GPIO_0_7, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_ORION5X_GPIO_8_15, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_ORION5X_GPIO_16_23, gpio_irq_handler);
-	irq_set_chained_handler(IRQ_ORION5X_GPIO_24_31, gpio_irq_handler);
+	orion_gpio_init(NULL, 0, 32, (void __iomem *)GPIO_VIRT_BASE, 0,
+			IRQ_ORION5X_GPIO_START, gpio0_irqs);
 }
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index af95af2..dfda74f 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -8,15 +8,22 @@
  * warranty of any kind, whether express or implied.
  */
 
+#define DEBUG
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <plat/gpio.h>
 
 /*
  * GPIO unit register offsets.
@@ -38,6 +45,7 @@ struct orion_gpio_chip {
 	unsigned long		valid_output;
 	int			mask_offset;
 	int			secondary_irq_base;
+	struct irq_domain       *domain;
 };
 
 static void __iomem *GPIO_OUT(struct orion_gpio_chip *ochip)
@@ -222,10 +230,10 @@ static int orion_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
 	struct orion_gpio_chip *ochip =
 		container_of(chip, struct orion_gpio_chip, chip);
 
-	return ochip->secondary_irq_base + pin;
+	return irq_create_mapping(ochip->domain,
+				  ochip->secondary_irq_base + pin);
 }
 
-
 /*
  * Orion-specific GPIO API extensions.
  */
@@ -353,12 +361,10 @@ static int gpio_irq_set_type(struct irq_data *d, u32 type)
 	int pin;
 	u32 u;
 
-	pin = d->irq - gc->irq_base;
+	pin = d->hwirq - ochip->secondary_irq_base;
 
 	u = readl(GPIO_IO_CONF(ochip)) & (1 << pin);
 	if (!u) {
-		printk(KERN_ERR "orion gpio_irq_set_type failed "
-				"(irq %d, pin %d).\n", d->irq, pin);
 		return -EINVAL;
 	}
 
@@ -397,17 +403,53 @@ static int gpio_irq_set_type(struct irq_data *d, u32 type)
 			u &= ~(1 << pin);	/* rising */
 		writel(u, GPIO_IN_POL(ochip));
 	}
-
 	return 0;
 }
 
-void __init orion_gpio_init(int gpio_base, int ngpio,
-			    u32 base, int mask_offset, int secondary_irq_base)
+static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	struct orion_gpio_chip *ochip = irq_get_handler_data(irq);
+	u32 cause, type;
+	int i;
+
+	if (ochip == NULL)
+		return;
+
+	cause = readl(GPIO_DATA_IN(ochip)) & readl(GPIO_LEVEL_MASK(ochip));
+	cause |= readl(GPIO_EDGE_CAUSE(ochip)) & readl(GPIO_EDGE_MASK(ochip));
+
+	for (i = 0; i < ochip->chip.ngpio; i++) {
+		int irq;
+
+		irq = ochip->secondary_irq_base + i;
+
+		if (!(cause & (1 << i)))
+			continue;
+
+		type = irqd_get_trigger_type(irq_get_irq_data(irq));
+		if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
+			/* Swap polarity (race with GPIO line) */
+			u32 polarity;
+
+			polarity = readl(GPIO_IN_POL(ochip));
+			polarity ^= 1 << i;
+			writel(polarity, GPIO_IN_POL(ochip));
+		}
+		generic_handle_irq(irq);
+	}
+}
+
+void __init orion_gpio_init(struct device_node *np,
+			    int gpio_base, int ngpio,
+			    void __iomem *base, int mask_offset,
+			    int secondary_irq_base,
+			    int irqs[4])
 {
 	struct orion_gpio_chip *ochip;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	char gc_label[16];
+	int i;
 
 	if (orion_gpio_chip_count == ARRAY_SIZE(orion_gpio_chips))
 		return;
@@ -426,6 +468,10 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 	ochip->chip.base = gpio_base;
 	ochip->chip.ngpio = ngpio;
 	ochip->chip.can_sleep = 0;
+#ifdef CONFIG_OF
+	ochip->chip.of_node = np;
+#endif
+
 	spin_lock_init(&ochip->lock);
 	ochip->base = (void __iomem *)base;
 	ochip->valid_input = 0;
@@ -435,8 +481,6 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 
 	gpiochip_add(&ochip->chip);
 
-	orion_gpio_chip_count++;
-
 	/*
 	 * Mask and clear GPIO interrupts.
 	 */
@@ -444,16 +488,28 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 	writel(0, GPIO_EDGE_MASK(ochip));
 	writel(0, GPIO_LEVEL_MASK(ochip));
 
-	gc = irq_alloc_generic_chip("orion_gpio_irq", 2, secondary_irq_base,
+	/* Setup the interrupt handlers. Each chip can have up to 4
+	 * interrupt handlers, with each handler dealing with 8 GPIO
+	 * pins. */
+
+	for (i = 0; i < 4; i++) {
+		if (irqs[i]) {
+			irq_set_handler_data(irqs[i], ochip);
+			irq_set_chained_handler(irqs[i], gpio_irq_handler);
+		}
+	}
+
+	gc = irq_alloc_generic_chip("orion_gpio_irq", 2,
+				    secondary_irq_base,
 				    ochip->base, handle_level_irq);
 	gc->private = ochip;
-
 	ct = gc->chip_types;
 	ct->regs.mask = ochip->mask_offset + GPIO_LEVEL_MASK_OFF;
 	ct->type = IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW;
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
 	ct->chip.irq_set_type = gpio_irq_set_type;
+	ct->chip.name = ochip->chip.label;
 
 	ct++;
 	ct->regs.mask = ochip->mask_offset + GPIO_EDGE_MASK_OFF;
@@ -464,41 +520,69 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
 	ct->chip.irq_set_type = gpio_irq_set_type;
 	ct->handler = handle_edge_irq;
+	ct->chip.name = ochip->chip.label;
 
 	irq_setup_generic_chip(gc, IRQ_MSK(ngpio), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
-}
 
-void orion_gpio_irq_handler(int pinoff)
-{
-	struct orion_gpio_chip *ochip;
-	u32 cause, type;
-	int i;
-
-	ochip = orion_gpio_chip_find(pinoff);
-	if (ochip == NULL)
-		return;
-
-	cause = readl(GPIO_DATA_IN(ochip)) & readl(GPIO_LEVEL_MASK(ochip));
-	cause |= readl(GPIO_EDGE_CAUSE(ochip)) & readl(GPIO_EDGE_MASK(ochip));
-
-	for (i = 0; i < ochip->chip.ngpio; i++) {
-		int irq;
+	/* Setup irq domain on top of the generic chip. */
+	ochip->domain = irq_domain_add_legacy(np,
+					      ochip->chip.ngpio,
+					      ochip->secondary_irq_base,
+					      ochip->secondary_irq_base,
+					      &irq_domain_simple_ops,
+					      ochip);
+	if (!ochip->domain)
+		panic("%s: couldn't allocate irq domain (DT).\n",
+		      ochip->chip.label);
 
-		irq = ochip->secondary_irq_base + i;
+	orion_gpio_chip_count++;
+}
 
-		if (!(cause & (1 << i)))
-			continue;
+#ifdef CONFIG_OF
+static void __init orion_gpio_of_init_one(struct device_node *np,
+					  int irq_gpio_base)
+{
+	int ngpio, gpio_base, mask_offset;
+	void __iomem *base;
+	int ret, i;
+	int irqs[4];
+	int secondary_irq_base;
+
+	ret = of_property_read_u32(np, "ngpio", &ngpio);
+	if (ret)
+		goto out;
+	ret = of_property_read_u32(np, "mask-offset", &mask_offset);
+	if (ret == -EINVAL)
+		mask_offset = 0;
+	else
+		goto out;
+	base = of_iomap(np, 0);
+	if (!base)
+		goto out;
+
+	secondary_irq_base = irq_gpio_base + (32 * orion_gpio_chip_count);
+	gpio_base = 32 * orion_gpio_chip_count;
+
+	/* Get the interrupt numbers. Each chip can have up to 4
+	 * interrupt handlers, with each handler dealing with 8 GPIO
+	 * pins. */
+
+	for (i = 0; i < 4; i++)
+		irqs[i] = irq_of_parse_and_map(np, i);
+
+	orion_gpio_init(np, gpio_base, ngpio, base, mask_offset,
+			secondary_irq_base, irqs);
+	return;
+out:
+	pr_err("%s: %s: missing mandatory property\n", __func__, np->name);
+}
 
-		type = irqd_get_trigger_type(irq_get_irq_data(irq));
-		if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
-			/* Swap polarity (race with GPIO line) */
-			u32 polarity;
+void __init orion_gpio_of_init(int irq_gpio_base)
+{
+	struct device_node *np;
 
-			polarity = readl(GPIO_IN_POL(ochip));
-			polarity ^= 1 << i;
-			writel(polarity, GPIO_IN_POL(ochip));
-		}
-		generic_handle_irq(irq);
-	}
+	for_each_compatible_node(np, NULL, "marvell,orion-gpio")
+		orion_gpio_of_init_one(np, irq_gpio_base);
 }
+#endif
diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
index bec0c98..81c6fc8 100644
--- a/arch/arm/plat-orion/include/plat/gpio.h
+++ b/arch/arm/plat-orion/include/plat/gpio.h
@@ -13,7 +13,7 @@
 
 #include <linux/init.h>
 #include <linux/types.h>
-
+#include <linux/irqdomain.h>
 /*
  * Orion-specific GPIO API extensions.
  */
@@ -27,13 +27,11 @@ int orion_gpio_led_blink_set(unsigned gpio, int state,
 void orion_gpio_set_valid(unsigned pin, int mode);
 
 /* Initialize gpiolib. */
-void __init orion_gpio_init(int gpio_base, int ngpio,
-			    u32 base, int mask_offset, int secondary_irq_base);
-
-/*
- * GPIO interrupt handling.
- */
-void orion_gpio_irq_handler(int irqoff);
-
+void __init orion_gpio_init(struct device_node *np,
+			    int gpio_base, int ngpio,
+			    void __iomem *base, int mask_offset,
+			    int secondary_irq_base,
+			    int irq[4]);
 
+void __init orion_gpio_of_init(int irq_gpio_base);
 #endif
diff --git a/arch/arm/plat-orion/include/plat/irq.h b/arch/arm/plat-orion/include/plat/irq.h
index f05eeab..50547e4 100644
--- a/arch/arm/plat-orion/include/plat/irq.h
+++ b/arch/arm/plat-orion/include/plat/irq.h
@@ -12,6 +12,5 @@
 #define __PLAT_IRQ_H
 
 void orion_irq_init(unsigned int irq_start, void __iomem *maskaddr);
-
-
+void __init orion_dt_init_irq(void);
 #endif
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 2d5b9c1..d751964 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -11,8 +11,12 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <plat/irq.h>
+#include <plat/gpio.h>
 
 void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 {
@@ -32,3 +36,39 @@ void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 }
+
+#ifdef CONFIG_OF
+static int __init orion_add_irq_domain(struct device_node *np,
+				       struct device_node *interrupt_parent)
+{
+	int i = 0, irq_gpio;
+	void __iomem *base;
+
+	do {
+		base = of_iomap(np, i);
+		if (base) {
+			orion_irq_init(i * 32, base);
+			i++;
+		}
+	} while (base);
+
+	irq_domain_add_legacy(np, i * 32, 0, 0,
+			      &irq_domain_simple_ops, NULL);
+
+	irq_gpio = i * 32;
+	orion_gpio_of_init(irq_gpio);
+
+	return 0;
+}
+
+static const struct of_device_id orion_irq_match[] = {
+	{ .compatible = "marvell,orion-intc",
+	  .data = orion_add_irq_domain, },
+	{},
+};
+
+void __init orion_dt_init_irq(void)
+{
+	of_irq_init(orion_irq_match);
+}
+#endif
-- 
1.7.10
