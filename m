From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  2 Mar 2012 20:54:06 +0100
Subject: [PATCH 4/6] ARM: at91: add RSTC (Reset Controller) dt support
In-Reply-To: <20120302192844.GB21255@game.jcrosoft.org>
References: <20120302192844.GB21255@game.jcrosoft.org>
Message-ID: <1330718048-9314-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/arm/atmel-at91.txt         |   12 ++++++++
 arch/arm/boot/dts/at91sam9g20.dtsi                 |    5 +++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +++
 arch/arm/mach-at91/at91sam9x5.c                    |    1 -
 arch/arm/mach-at91/setup.c                         |   30 ++++++++++++++++++++
 6 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 1aeaf6f..a64f867 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -30,3 +30,15 @@ One interrupt per TC channel in a TC block:
 		reg = <0xfffdc000 0x100>;
 		interrupts = <26 4 27 4 28 4>;
 	};
+
+RSTC Reset Controller required properties:
+- compatible: Should be "atmel,<chip>-rstc".
+  <chip> can be "at91sam9260" or "at91sam9g45"
+- reg: Should contain registers location and length
+
+Example:
+
+	rstc at fffffd00 {
+		compatible = "atmel,at91sam9260-rstc";
+		reg = <0xfffffd00 0x10>;
+	};
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index ee94828..5414347 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -64,6 +64,11 @@
 				reg = <0xfffffc00 0x100>;
 			};
 
+			rstc at fffffd00 {
+				compatible = "atmel,at91sam9260-rstc";
+				reg = <0xfffffd00 0x10>;
+			};
+
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index dfb71d5..e2ccba5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -65,6 +65,11 @@
 				reg = <0xfffffc00 0x100>;
 			};
 
+			rstc at fffffd00 {
+				compatible = "atmel,at91sam9g45-rstc";
+				reg = <0xfffffd00 0x10>;
+			};
+
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a7d7107..54e3030 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -63,6 +63,11 @@
 				reg = <0xfffffc00 0x100>;
 			};
 
+			rstc at fffffe00 {
+				compatible = "atmel,at91sam9g45-rstc";
+				reg = <0xfffffe00 0x10>;
+			};
+
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 7333276..0b82c34 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -309,7 +309,6 @@ static void __init at91sam9x5_ioremap_registers(void)
 
 void __init at91sam9x5_initialize(void)
 {
-	arm_pm_restart = at91sam9g45_restart;
 	at91_extern_irq = (1 << AT91SAM9X5_ID_IRQ0);
 
 	/* Register GPIO subsystem (using DT) */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index d7abc25..3e48b59 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -287,8 +287,38 @@ void __init at91_ioremap_matrix(u32 base_addr)
 }
 
 #if defined(CONFIG_OF)
+static struct of_device_id rstc_ids[] = {
+	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9_alt_restart },
+	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
+	{ /*sentinel*/ }
+};
+
+static void at91_dt_rstc(void)
+{
+	struct device_node *np;
+	const struct of_device_id *of_id;
+
+	np = of_find_matching_node(NULL, rstc_ids);
+	if (!np)
+		panic("unable to find compatible rstc node in dtb\n");
+
+	at91_rstc_base = of_iomap(np, 0);
+	if (!at91_rstc_base)
+		panic("unable to map rstc cpu registers\n");
+
+	of_id = of_match_node(rstc_ids, np);
+	if (!of_id)
+		panic("AT91: rtsc no restart function availlable\n");
+
+	arm_pm_restart = of_id->data;
+
+	of_node_put(np);
+}
+
 void __init at91_dt_initialize(void)
 {
+	at91_dt_rstc();
+
 	/* temporary until have the ramc binding*/
 	at91_boot_soc.ioremap_registers();
 
-- 
1.7.7
