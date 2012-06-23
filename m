From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Sat, 23 Jun 2012 18:05:33 +0200
Subject: [PATCH v3 1/7] ARM: at91: aic add dt support for external irqs
In-Reply-To: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
References: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1340467539-12294-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 .../devicetree/bindings/arm/atmel-aic.txt          |    1 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |    1 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |    1 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    1 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    1 +
 arch/arm/mach-at91/at91sam9x5.c                    |    2 --
 arch/arm/mach-at91/irq.c                           |   12 ++++++++++++
 7 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/arm/atmel-aic.txt
index aabca4f..1953b0c 100644
--- a/Documentation/devicetree/bindings/arm/atmel-aic.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-aic.txt
@@ -15,6 +15,7 @@ Required properties:
       Valid combinations are 1, 2, 3, 4, 8.
       Default flag for internal sources should be set to 4 (active high).
 - reg: Should contain AIC registers location and length
+- atmel,external-irqs: u32 array of external irqs.
 
 Examples:
 	/*
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index f449efc..f2c9643 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -56,6 +56,7 @@
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
+				atmel,external-irqs = <29 30 31>;
 			};
 
 			ramc0: ramc at ffffea00 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 0209913..c803636 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -52,6 +52,7 @@
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
+				atmel,external-irqs = <30 31>;
 			};
 
 			pmc: pmc at fffffc00 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 7dbccaf..2d01ce2 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -57,6 +57,7 @@
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
+				atmel,external-irqs = <31>;
 			};
 
 			ramc0: ramc at ffffe400 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 6b3ef43..6a0a0fb 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -55,6 +55,7 @@
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
+				atmel,external-irqs = <31>;
 			};
 
 			ramc0: ramc at ffffe800 {
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 1b144b4..537710b 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -312,8 +312,6 @@ static void __init at91sam9x5_map_io(void)
 
 void __init at91sam9x5_initialize(void)
 {
-	at91_extern_irq = (1 << AT91SAM9X5_ID_IRQ0);
-
 	/* Register GPIO subsystem (using DT) */
 	at91_gpio_init(NULL, 0);
 }
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index 2d5d4c8..df8605f 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -194,6 +194,10 @@ static struct irq_domain_ops at91_aic_irq_ops = {
 int __init at91_aic_of_init(struct device_node *node,
 				     struct device_node *parent)
 {
+	struct property *prop;
+	const __be32 *p;
+	u32 val;
+
 	at91_aic_base = of_iomap(node, 0);
 	at91_aic_np = node;
 
@@ -202,6 +206,14 @@ int __init at91_aic_of_init(struct device_node *node,
 	if (!at91_aic_domain)
 		panic("Unable to add AIC irq domain (DT)\n");
 
+	at91_extern_irq = 0;
+	of_property_for_each_u32(node, "atmel,external-irqs", prop, p, val) {
+		if (val > 31)
+			pr_warn("AIC: external irq %d > 31 skip it\n", val);
+		else
+			at91_extern_irq |= (1 << val);
+	}
+
 	irq_set_default_host(at91_aic_domain);
 
 	at91_aic_hw_init(NR_AIC_IRQS);
-- 
1.7.5.4
