From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 20:16:03 +0100
Subject: [PATCH v4 1/6] ARM: at91/aic: add irq domain and device tree support
In-Reply-To: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <85d531b5686e5eff623bed9618f802198409905f.1323975517.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an irqdomain for the AIC interrupt controller.
The device tree support is mapping the registers and
is using the irq_domain_simple_ops to manage hwirq
translation.
The documentation is describing the meaning of the
two cells required for using this "interrupt-controller"
in a device tree node.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
This patch should go on top of Jamie's patch:
"irqdomain: export irq_domain_simple_ops for !CONFIG_OF"
https://lkml.org/lkml/2011/12/1/109

v4: - use irq_alloc_descs() to find irq_base
    - add a new constant AIC_BASE_IRQ that will allow to skip
      first interrupt numbers (in the future)

v3: - change number of cells to define an AIC interrupt (irq trigger type)
    - change current .dtsi files to match specification
    - use irq_domain_simple_ops (for DT mapping)

v2: - use of_irq_init() function for device tree probing
    - add documentation
    - use own simple struct irq_domain_ops


 .../devicetree/bindings/arm/atmel-aic.txt          |   38 ++++++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   16 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   14 ++--
 arch/arm/mach-at91/include/mach/irqs.h             |    3 +-
 arch/arm/mach-at91/irq.c                           |   91 +++++++++++++++-----
 6 files changed, 126 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-aic.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/arm/atmel-aic.txt
new file mode 100644
index 0000000..ade2761
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-aic.txt
@@ -0,0 +1,38 @@
+* Advanced Interrupt Controller (AIC)
+
+Required properties:
+- compatible: Should be "atmel,<chip>-dma"
+- interrupt-controller: Identifies the node as an interrupt controller.
+- interrupt-parent: For single AIC system, it is an empty property.
+- #interrupt-cells: The number of cells to define the interrupts. It sould be 2.
+  The first cell is the GPIO number.
+  The second cell is used to specify flags:
+    bits[3:0] trigger type and level flags:
+      1 = low-to-high edge triggered.
+      2 = high-to-low edge triggered.
+      4 = active high level-sensitive.
+      8 = active low level-sensitive.
+      Valid combinations are 1, 2, 3, 4, 8.
+      Default flag for internal sources should be set to 4 (active high).
+- reg: Should contain AIC registers location and length
+
+Examples:
+	/*
+	 * AIC
+	 */
+	aic: interrupt-controller at fffff000 {
+		compatible = "atmel,at91rm9200-aic";
+		interrupt-controller;
+		interrupt-parent;
+		#interrupt-cells = <2>;
+		reg = <0xfffff000 0x200>;
+	};
+
+	/*
+	 * An interrupt generating device that is wired to an AIC.
+	 */
+	dma: dma-controller at ffffec00 {
+		compatible = "atmel,at91sam9g45-dma";
+		reg = <0xffffec00 0x200>;
+		interrupts = <21 4>;
+	};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e084b7e..ad13928 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -318,6 +318,7 @@ config ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select IRQ_DOMAIN
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index aeef042..0782f80 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -47,7 +47,7 @@
 			ranges;
 
 			aic: interrupt-controller at fffff000 {
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				interrupt-parent;
@@ -57,14 +57,14 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1>;
+				interrupts = <1 4>;
 				status = "disabled";
 			};
 
 			usart0: serial at fffb0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb0000 0x200>;
-				interrupts = <6>;
+				interrupts = <6 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -73,7 +73,7 @@
 			usart1: serial at fffb4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb4000 0x200>;
-				interrupts = <7>;
+				interrupts = <7 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -82,7 +82,7 @@
 			usart2: serial at fffb8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb8000 0x200>;
-				interrupts = <8>;
+				interrupts = <8 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -91,7 +91,7 @@
 			usart3: serial at fffd0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd0000 0x200>;
-				interrupts = <23>;
+				interrupts = <23 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -100,7 +100,7 @@
 			usart4: serial at fffd4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd4000 0x200>;
-				interrupts = <24>;
+				interrupts = <24 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -109,7 +109,7 @@
 			usart5: serial at fffd8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd8000 0x200>;
-				interrupts = <25>;
+				interrupts = <25 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index db6a452..e89b1d7 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -46,7 +46,7 @@
 			ranges;
 
 			aic: interrupt-controller at fffff000 {
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				interrupt-parent;
@@ -56,20 +56,20 @@
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
-				interrupts = <21>;
+				interrupts = <21 4>;
 			};
 
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-				interrupts = <1>;
+				interrupts = <1 4>;
 				status = "disabled";
 			};
 
 			usart0: serial at fff8c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff8c000 0x200>;
-				interrupts = <7>;
+				interrupts = <7 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -78,7 +78,7 @@
 			usart1: serial at fff90000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff90000 0x200>;
-				interrupts = <8>;
+				interrupts = <8 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -87,7 +87,7 @@
 			usart2: serial at fff94000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff94000 0x200>;
-				interrupts = <9>;
+				interrupts = <9 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
@@ -96,7 +96,7 @@
 			usart3: serial at fff98000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff98000 0x200>;
-				interrupts = <10>;
+				interrupts = <10 4>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				status = "disabled";
diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
index ac8b7df..e3ee0fc 100644
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ b/arch/arm/mach-at91/include/mach/irqs.h
@@ -25,6 +25,7 @@
 #include <mach/at91_aic.h>
 
 #define NR_AIC_IRQS 32
+#define AIC_BASE_IRQ 0
 
 
 /*
@@ -40,7 +41,7 @@
  * symbols in gpio.h for ones handled indirectly as GPIOs.
  * We make provision for 5 banks of GPIO.
  */
-#define	NR_IRQS		(NR_AIC_IRQS + (5 * 32))
+#define	NR_IRQS		(AIC_BASE_IRQ + NR_AIC_IRQS + (5 * 32))
 
 /* FIQ is AIC source 0. */
 #define FIQ_START AT91_ID_FIQ
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index be6b639..3e3d521 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -24,6 +24,10 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/types.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -34,22 +38,28 @@
 #include <asm/mach/map.h>
 
 void __iomem *at91_aic_base;
+static struct irq_domain at91_aic_domain;
+
+static inline unsigned int aic_irq(struct irq_data *d)
+{
+	return d->hwirq;
+}
 
 static void at91_aic_mask_irq(struct irq_data *d)
 {
 	/* Disable interrupt on AIC */
-	at91_aic_write(AT91_AIC_IDCR, 1 << d->irq);
+	at91_aic_write(AT91_AIC_IDCR, 1 << aic_irq(d));
 }
 
 static void at91_aic_unmask_irq(struct irq_data *d)
 {
 	/* Enable interrupt on AIC */
-	at91_aic_write(AT91_AIC_IECR, 1 << d->irq);
+	at91_aic_write(AT91_AIC_IECR, 1 << aic_irq(d));
 }
 
 unsigned int at91_extern_irq;
 
-#define is_extern_irq(irq) ((1 << (irq)) & at91_extern_irq)
+#define is_extern_irq(hwirq) ((1 << (hwirq)) & at91_extern_irq)
 
 static int at91_aic_set_type(struct irq_data *d, unsigned type)
 {
@@ -63,13 +73,13 @@ static int at91_aic_set_type(struct irq_data *d, unsigned type)
 		srctype = AT91_AIC_SRCTYPE_RISING;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		if ((d->irq == AT91_ID_FIQ) || is_extern_irq(d->irq))		/* only supported on external interrupts */
+		if ((aic_irq(d) == AT91_ID_FIQ) || is_extern_irq(aic_irq(d)))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_LOW;
 		else
 			return -EINVAL;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		if ((d->irq == AT91_ID_FIQ) || is_extern_irq(d->irq))		/* only supported on external interrupts */
+		if ((aic_irq(d) == AT91_ID_FIQ) || is_extern_irq(aic_irq(d)))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_FALLING;
 		else
 			return -EINVAL;
@@ -78,8 +88,8 @@ static int at91_aic_set_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 	}
 
-	smr = at91_aic_read(AT91_AIC_SMR(d->irq)) & ~AT91_AIC_SRCTYPE;
-	at91_aic_write(AT91_AIC_SMR(d->irq), smr | srctype);
+	smr = at91_aic_read(AT91_AIC_SMR(aic_irq(d))) & ~AT91_AIC_SRCTYPE;
+	at91_aic_write(AT91_AIC_SMR(aic_irq(d)), smr | srctype);
 	return 0;
 }
 
@@ -90,13 +100,13 @@ static u32 backups;
 
 static int at91_aic_set_wake(struct irq_data *d, unsigned value)
 {
-	if (unlikely(d->irq >= 32))
+	if (unlikely(aic_irq(d) >= at91_aic_domain.nr_irq))
 		return -EINVAL;
 
 	if (value)
-		wakeups |= (1 << d->irq);
+		wakeups |= (1 << aic_irq(d));
 	else
-		wakeups &= ~(1 << d->irq);
+		wakeups &= ~(1 << aic_irq(d));
 
 	return 0;
 }
@@ -127,36 +137,75 @@ static struct irq_chip at91_aic_chip = {
 	.irq_set_wake	= at91_aic_set_wake,
 };
 
+#if defined(CONFIG_OF)
+static int __init __at91_aic_of_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	at91_aic_base = of_iomap(node, 0);
+	at91_aic_domain.of_node = of_node_get(node);
+
+	return 0;
+}
+
+static const struct of_device_id aic_ids[] __initconst = {
+	{ .compatible = "atmel,at91rm9200-aic", .data = __at91_aic_of_init },
+	{ /*sentinel*/ }
+};
+
+static void __init at91_aic_of_init(void)
+{
+	of_irq_init(aic_ids);
+}
+#else
+static void __init at91_aic_of_init(void) {}
+#endif
+
 /*
  * Initialize the AIC interrupt controller.
  */
 void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 {
 	unsigned int i;
+	int hwirq, irq;
 
-	at91_aic_base = ioremap(AT91_AIC, 512);
+	if(of_have_populated_dt())
+		at91_aic_of_init();
+	else
+		at91_aic_base = ioremap(AT91_AIC, 512);
 
 	if (!at91_aic_base)
-		panic("Impossible to ioremap AT91_AIC\n");
+		panic("Unable to ioremap AIC registers\n");
+
+	/* Add irq domain for AIC */
+	at91_aic_domain.nr_irq = NR_AIC_IRQS;
+	at91_aic_domain.irq_base = irq_alloc_descs(-1, AIC_BASE_IRQ,
+						at91_aic_domain.nr_irq, 0);
+	if (IS_ERR_VALUE(at91_aic_domain.irq_base)) {
+		WARN(1, "Cannot allocate irq_descs, assuming pre-allocated\n");
+		at91_aic_domain.irq_base = AIC_BASE_IRQ;
+	}
+	at91_aic_domain.ops = &irq_domain_simple_ops;
+	irq_domain_add(&at91_aic_domain);
 
 	/*
 	 * The IVR is used by macro get_irqnr_and_base to read and verify.
 	 * The irq number is NR_AIC_IRQS when a spurious interrupt has occurred.
 	 */
-	for (i = 0; i < NR_AIC_IRQS; i++) {
+	irq_domain_for_each_irq((&at91_aic_domain), hwirq, irq) {
+
 		/* Put irq number in Source Vector Register: */
-		at91_aic_write(AT91_AIC_SVR(i), i);
+		at91_aic_write(AT91_AIC_SVR(hwirq), irq);
 		/* Active Low interrupt, with the specified priority */
-		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
+		at91_aic_write(AT91_AIC_SMR(hwirq), AT91_AIC_SRCTYPE_LOW | priority[hwirq]);
 
-		irq_set_chip_and_handler(i, &at91_aic_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-
-		/* Perform 8 End Of Interrupt Command to make sure AIC will not Lock out nIRQ */
-		if (i < 8)
-			at91_aic_write(AT91_AIC_EOICR, 0);
+		irq_set_chip_and_handler(irq, &at91_aic_chip, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 
+	/* Perform 8 End Of Interrupt Command to make sure AIC will not Lock out nIRQ */
+	for (i = 0; i < 8; i++)
+		at91_aic_write(AT91_AIC_EOICR, 0);
+
 	/*
 	 * Spurious Interrupt ID in Spurious Vector Register is NR_AIC_IRQS
 	 * When there is no current interrupt, the IRQ Vector Register reads the value stored in AIC_SPU
-- 
1.7.5.4
