From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Jan 2012 19:05:11 +0100
Subject: [PATCH 2/3] ARM: at91/tc: add device tree support to atmel_tclib
In-Reply-To: <1326996312-9244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1326996312-9244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <185a4d609becfcd60bbd15b09612160cf6ea9346.1326995849.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree support added to atmel_tclib: the generic Timer Counter
library. This is used by the clocksource/clockevent driver tcb_clksrc.

The current DT enabled platforms are also modified to use it:
- .dtsi files are modified to add Timer Counter Block entries
- alias are created to allow identification of each block
- clkdev lookup tables are added for clocks identification.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi       |   14 ++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi       |   15 +++++++++++++++
 arch/arm/mach-at91/at91sam9260.c         |    7 +++++++
 arch/arm/mach-at91/at91sam9260_devices.c |   17 +++++++++++++++++
 arch/arm/mach-at91/at91sam9g45.c         |    3 +++
 arch/arm/mach-at91/at91sam9g45_devices.c |   17 +++++++++++++++++
 drivers/misc/atmel_tclib.c               |   27 +++++++++++++++++++++++++--
 7 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 4cd2749..073a538 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -26,6 +26,8 @@
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
+		tcb0 = &tcb0;
+		tcb1 = &tcb1;
 	};
 	cpus {
 		cpu at 0 {
@@ -63,6 +65,18 @@
 				interrupts = <1 4>;
 			};
 
+			tcb0: timer at fffa0000 {
+				compatible = "atmel,at91rm9200-tcb";
+				reg = <0xfffa0000 0x100>;
+				interrupts = <17 4 18 4 19 4>;
+			};
+
+			tcb1: timer at fffdc000 {
+				compatible = "atmel,at91rm9200-tcb";
+				reg = <0xfffdc000 0x100>;
+				interrupts = <26 4 27 4 28 4>;
+			};
+
 			pioA: gpio at fffff400 {
 				compatible = "atmel,at91rm9200-gpio";
 				reg = <0xfffff400 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 0d21c8e..9406062 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -27,6 +27,8 @@
 		gpio2 = &pioC;
 		gpio3 = &pioD;
 		gpio4 = &pioE;
+		tcb0 = &tcb0;
+		tcb1 = &tcb1;
 	};
 	cpus {
 		cpu at 0 {
@@ -64,6 +66,19 @@
 				interrupts = <1 4>;
 			};
 
+
+			tcb0: timer at fff7c000 {
+				compatible = "atmel,at91rm9200-tcb";
+				reg = <0xfff7c000 0x100>;
+				interrupts = <18 4>;
+			};
+
+			tcb1: timer at fffd4000 {
+				compatible = "atmel,at91rm9200-tcb";
+				reg = <0xfffd4000 0x100>;
+				interrupts = <18 4>;
+			};
+
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index aad68b1..69b1cc1 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -208,6 +208,13 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fffd0000.serial", &usart3_clk),
 	CLKDEV_CON_DEV_ID("usart", "fffd4000.serial", &usart4_clk),
 	CLKDEV_CON_DEV_ID("usart", "fffd8000.serial", &usart5_clk),
+	/* more tc lookup table for DT entries */
+	CLKDEV_CON_DEV_ID("t0_clk", "fffa0000.timer", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "fffa0000.timer", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "fffa0000.timer", &tc2_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "fffdc000.timer", &tc3_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "fffdc000.timer", &tc4_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "fffdc000.timer", &tc5_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index ea66087..39cb6f2 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -698,8 +698,25 @@ static struct platform_device at91sam9260_tcb1_device = {
 	.num_resources	= ARRAY_SIZE(tcb1_resources),
 };
 
+#if defined(CONFIG_OF)
+static struct of_device_id tcb_ids[] = {
+	{ .compatible = "atmel,at91rm9200-tcb" },
+	{ /*sentinel*/ }
+};
+#endif
+
 static void __init at91_add_device_tc(void)
 {
+#if defined(CONFIG_OF)
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, tcb_ids);
+	if (np) {
+		of_node_put(np);
+		return;
+	}
+#endif
+
 	platform_device_register(&at91sam9260_tcb0_device);
 	platform_device_register(&at91sam9260_tcb1_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 4895b04..0e30a75 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -230,6 +230,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fff90000.serial", &usart1_clk),
 	CLKDEV_CON_DEV_ID("usart", "fff94000.serial", &usart2_clk),
 	CLKDEV_CON_DEV_ID("usart", "fff98000.serial", &usart3_clk),
+	/* more tc lookup table for DT entries */
+	CLKDEV_CON_DEV_ID("t0_clk", "fff7c000.timer", &tcb0_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 545bbe9..a0a217d 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -995,8 +995,25 @@ static struct platform_device at91sam9g45_tcb1_device = {
 	.num_resources	= ARRAY_SIZE(tcb1_resources),
 };
 
+#if defined(CONFIG_OF)
+static struct of_device_id tcb_ids[] = {
+	{ .compatible = "atmel,at91rm9200-tcb" },
+	{ /*sentinel*/ }
+};
+#endif
+
 static void __init at91_add_device_tc(void)
 {
+#if defined(CONFIG_OF)
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, tcb_ids);
+	if (np) {
+		of_node_put(np);
+		return;
+	}
+#endif
+
 	platform_device_register(&at91sam9g45_tcb0_device);
 	platform_device_register(&at91sam9g45_tcb1_device);
 }
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 7a6512a..de6dea7 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -6,8 +6,10 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/of.h>
 
 /*
  * This is a thin library to solve the problem of how to portably allocate
@@ -48,7 +50,13 @@ struct atmel_tc *atmel_tc_alloc(unsigned block, const char *name)
 
 	spin_lock(&tc_list_lock);
 	list_for_each_entry(tc, &tc_list, node) {
-		if (tc->pdev->id == block) {
+		if (tc->pdev->dev.of_node) {
+			if (of_alias_get_id(tc->pdev->dev.of_node, "tcb")
+					== block) {
+				pdev = tc->pdev;
+				break;
+			}
+		} else if (tc->pdev->id == block) {
 			pdev = tc->pdev;
 			break;
 		}
@@ -105,6 +113,18 @@ void atmel_tc_free(struct atmel_tc *tc)
 }
 EXPORT_SYMBOL_GPL(atmel_tc_free);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id atmel_tcb_dt_ids[] = {
+	{
+		.compatible = "atmel,at91rm9200-tcb",
+	}, {
+		/* sentinel */
+	}
+};
+
+MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
+#endif
+
 static int __init tc_probe(struct platform_device *pdev)
 {
 	struct atmel_tc *tc;
@@ -154,7 +174,10 @@ static int __init tc_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver tc_driver = {
-	.driver.name	= "atmel_tcb",
+	.driver = {
+		.name	= "atmel_tcb",
+		.of_match_table	= of_match_ptr(atmel_tcb_dt_ids),
+	},
 };
 
 static int __init tc_init(void)
-- 
1.7.5.4
