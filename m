From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 15 Jun 2012 11:09:07 +0200
Subject: [PATCH v2 2/7] ARM: at91: add of default irq priorities support
In-Reply-To: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
References: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1339751352-24296-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

You will have to set the default priority for all the irq.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 .../devicetree/bindings/arm/atmel-aic.txt          |    2 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   34 ++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi                 |   34 ++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   34 ++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   34 ++++++++++++++++
 arch/arm/mach-at91/at91sam9x5.c                    |   42 --------------------
 arch/arm/mach-at91/irq.c                           |   21 ++++++++++
 7 files changed, 159 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/arm/atmel-aic.txt
index 1953b0c..66aa53d 100644
--- a/Documentation/devicetree/bindings/arm/atmel-aic.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-aic.txt
@@ -16,6 +16,8 @@ Required properties:
       Default flag for internal sources should be set to 4 (active high).
 - reg: Should contain AIC registers location and length
 - atmel,external-irqs: u32 array of external irqs.
+- atmel,default-irq-priorities: u32 array of default irq priorities. This need
+  to contain all the irq.
 
 Examples:
 	/*
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index f2c9643..791ef87 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -57,6 +57,40 @@
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
 				atmel,external-irqs = <29 30 31>;
+				atmel,default-irq-priorities = <
+					7	/* Advanced Interrupt Controller */
+					7	/* System Peripherals */
+					1	/* Parallel IO Controller A */
+					1	/* Parallel IO Controller B */
+					1	/* Parallel IO Controller C */
+					0	/* Analog-to-Digital Converter */
+					5	/* USART 0 */
+					5	/* USART 1 */
+					5	/* USART 2 */
+					0	/* Multimedia Card Interface */
+					2	/* USB Device Port */
+					6	/* Two-Wire Interface */
+					5	/* Serial Peripheral Interface 0 */
+					5	/* Serial Peripheral Interface 1 */
+					5	/* Serial Synchronous Controller */
+					0
+					0
+					0	/* Timer Counter 0 */
+					0	/* Timer Counter 1 */
+					0	/* Timer Counter 2 */
+					2	/* USB Host port */
+					3	/* Ethernet */
+					0	/* Image Sensor Interface */
+					5	/* USART 3 */
+					5	/* USART 4 */
+					5	/* USART 5 */
+					0	/* Timer Counter 3 */
+					0	/* Timer Counter 4 */
+					0	/* Timer Counter 5 */
+					0	/* Advanced Interrupt Controller */
+					0	/* Advanced Interrupt Controller */
+					0	/* Advanced Interrupt Controller */
+				>;
 			};
 
 			ramc0: ramc at ffffea00 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index c803636..8a5923a 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -53,6 +53,40 @@
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
 				atmel,external-irqs = <30 31>;
+				atmel,default-irq-priorities = <
+					7	/* Advanced Interrupt Controller (FIQ) */
+					7	/* System Peripherals */
+					1	/* Parallel IO Controller A */
+					1	/* Parallel IO Controller B */
+					1	/* Parallel IO Controller C, D and E */
+					0
+					0
+					5	/* USART 0 */
+					5	/* USART 1 */
+					5	/* USART 2 */
+					0	/* Multimedia Card Interface 0 */
+					0	/* Multimedia Card Interface 1 */
+					3	/* CAN */
+					6	/* Two-Wire Interface */
+					5	/* Serial Peripheral Interface 0 */
+					5	/* Serial Peripheral Interface 1 */
+					4	/* Serial Synchronous Controller 0 */
+					4	/* Serial Synchronous Controller 1 */
+					5	/* AC97 Controller */
+					0	/* Timer Counter 0, 1 and 2 */
+					0	/* Pulse Width Modulation Controller */
+					3	/* Ethernet */
+					0
+					0	/* 2D Graphic Engine */
+					2	/* USB Device Port */
+					0	/* Image Sensor Interface */
+					3	/* LDC Controller */
+					0	/* DMA Controller */
+					0
+					2	/* USB Host port */
+					0	/* Advanced Interrupt Controller (IRQ0) */
+					0	/* Advanced Interrupt Controller (IRQ1) */
+				>;
 			};
 
 			pmc: pmc at fffffc00 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2d01ce2..d70e4f0 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -58,6 +58,40 @@
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
 				atmel,external-irqs = <31>;
+				atmel,default-irq-priorities = <
+					7	/* Advanced Interrupt Controller (FIQ) */
+					7	/* System Peripherals */
+					1	/* Parallel IO Controller A */
+					1	/* Parallel IO Controller B */
+					1	/* Parallel IO Controller C */
+					1	/* Parallel IO Controller D and E */
+					0
+					5	/* USART 0 */
+					5	/* USART 1 */
+					5	/* USART 2 */
+					5	/* USART 3 */
+					0	/* Multimedia Card Interface 0 */
+					6	/* Two-Wire Interface 0 */
+					6	/* Two-Wire Interface 1 */
+					5	/* Serial Peripheral Interface 0 */
+					5	/* Serial Peripheral Interface 1 */
+					4	/* Serial Synchronous Controller 0 */
+					4	/* Serial Synchronous Controller 1 */
+					0	/* Timer Counter 0, 1, 2, 3, 4 and 5 */
+					0	/* Pulse Width Modulation Controller */
+					0	/* Touch Screen Controller */
+					0	/* DMA Controller */
+					2	/* USB Host High Speed port */
+					3	/* LDC Controller */
+					5	/* AC97 Controller */
+					3	/* Ethernet */
+					0	/* Image Sensor Interface */
+					2	/* USB Device High speed port */
+					0
+					0	/* Multimedia Card Interface 1 */
+					0
+					0	/* Advanced Interrupt Controller (IRQ0) */
+				>;
 			};
 
 			ramc0: ramc at ffffe400 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 6a0a0fb..fcd9d43 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -56,6 +56,40 @@
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
 				atmel,external-irqs = <31>;
+				atmel,default-irq-priorities = <
+					7	/* Advanced Interrupt Controller (FIQ) */
+					7	/* System Peripherals */
+					1	/* Parallel IO Controller A and B */
+					1	/* Parallel IO Controller C and D */
+					4	/* Soft Modem */
+					5	/* USART 0 */
+					5	/* USART 1 */
+					5	/* USART 2 */
+					5	/* USART 3 */
+					6	/* Two-Wire Interface 0 */
+					6	/* Two-Wire Interface 1 */
+					6	/* Two-Wire Interface 2 */
+					0	/* Multimedia Card Interface 0 */
+					5	/* Serial Peripheral Interface 0 */
+					5	/* Serial Peripheral Interface 1 */
+					5	/* UART 0 */
+					5	/* UART 1 */
+					0	/* Timer Counter 0, 1, 2, 3, 4 and 5 */
+					0	/* Pulse Width Modulation Controller */
+					0	/* ADC Controller */
+					0	/* DMA Controller 0 */
+					0	/* DMA Controller 1 */
+					2	/* USB Host High Speed port */
+					2	/* USB Device High speed port */
+					3	/* Ethernet MAC 0 */
+					3	/* LDC Controller or Image Sensor Interface */
+					0	/* Multimedia Card Interface 1 */
+					3	/* Ethernet MAC 1 */
+					4	/* Synchronous Serial Interface */
+					4	/* CAN Controller 0 */
+					4	/* CAN Controller 1 */
+					0	/* Advanced Interrupt Controller (IRQ0) */
+				>;
 			};
 
 			ramc0: ramc at ffffe800 {
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 537710b..1e7ef56 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -316,50 +316,8 @@ void __init at91sam9x5_initialize(void)
 	at91_gpio_init(NULL, 0);
 }
 
-/* --------------------------------------------------------------------
- *  Interrupt initialization
- * -------------------------------------------------------------------- */
-/*
- * The default interrupt priority levels (0 = lowest, 7 = highest).
- */
-static unsigned int at91sam9x5_default_irq_priority[NR_AIC_IRQS] __initdata = {
-	7,	/* Advanced Interrupt Controller (FIQ) */
-	7,	/* System Peripherals */
-	1,	/* Parallel IO Controller A and B */
-	1,	/* Parallel IO Controller C and D */
-	4,	/* Soft Modem */
-	5,	/* USART 0 */
-	5,	/* USART 1 */
-	5,	/* USART 2 */
-	5,	/* USART 3 */
-	6,	/* Two-Wire Interface 0 */
-	6,	/* Two-Wire Interface 1 */
-	6,	/* Two-Wire Interface 2 */
-	0,	/* Multimedia Card Interface 0 */
-	5,	/* Serial Peripheral Interface 0 */
-	5,	/* Serial Peripheral Interface 1 */
-	5,	/* UART 0 */
-	5,	/* UART 1 */
-	0,	/* Timer Counter 0, 1, 2, 3, 4 and 5 */
-	0,	/* Pulse Width Modulation Controller */
-	0,	/* ADC Controller */
-	0,	/* DMA Controller 0 */
-	0,	/* DMA Controller 1 */
-	2,	/* USB Host High Speed port */
-	2,	/* USB Device High speed port */
-	3,	/* Ethernet MAC 0 */
-	3,	/* LDC Controller or Image Sensor Interface */
-	0,	/* Multimedia Card Interface 1 */
-	3,	/* Ethernet MAC 1 */
-	4,	/* Synchronous Serial Interface */
-	4,	/* CAN Controller 0 */
-	4,	/* CAN Controller 1 */
-	0,	/* Advanced Interrupt Controller (IRQ0) */
-};
-
 struct at91_init_soc __initdata at91sam9x5_soc = {
 	.map_io = at91sam9x5_map_io,
-	.default_irq_priority = at91sam9x5_default_irq_priority,
 	.register_clocks = at91sam9x5_register_clocks,
 	.init = at91sam9x5_initialize,
 };
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index df8605f..8e6ac53 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -191,6 +191,25 @@ static struct irq_domain_ops at91_aic_irq_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
+static void __init at91_aic_of_priority(struct device_node *node)
+{
+	struct property *prop;
+	const __be32 *p;
+	u32 val;
+	int i = 0;
+
+	of_property_for_each_u32(node, "atmel,default-irq-priorities", prop, p, val) {
+		/* Put hardware irq number in Source Vector Register: */
+		at91_aic_write(AT91_AIC_SVR(i), i);
+		/* Active Low interrupt, with the specified priority */
+		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | val);
+		i++;
+	}
+
+	if (i < 1)
+		pr_warn("AIC: no valid default irqs priorities\n");
+}
+
 int __init at91_aic_of_init(struct device_node *node,
 				     struct device_node *parent)
 {
@@ -214,6 +233,8 @@ int __init at91_aic_of_init(struct device_node *node,
 			at91_extern_irq |= (1 << val);
 	}
 
+	at91_aic_of_priority(node);
+
 	irq_set_default_host(at91_aic_domain);
 
 	at91_aic_hw_init(NR_AIC_IRQS);
-- 
1.7.5.4
