From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 01:08:35 +0800
Subject: [PATCH v2 06/14] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363108124-17484-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all code to parse sp804. Use clocksource_of_init() instead since
all these code are implemented in sp804 driver already.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |    2 ++
 arch/arm/boot/dts/vexpress-v2m.dtsi     |    2 ++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts  |    2 ++
 arch/arm/mach-vexpress/Kconfig          |    1 +
 arch/arm/mach-vexpress/v2m.c            |   13 ++-----------
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index ac870fb..3fa798f 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -183,6 +183,8 @@
 				interrupts = <2>;
 				clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
 				clock-names = "timclken1", "timclken2", "apb_pclk";
+				arm,sp804-clocksource = <0x20>;
+				arm,sp804-clockevent = <0>;
 			};
 
 			v2m_timer23: timer at 120000 {
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index f142036..86e4046 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -182,6 +182,8 @@
 				interrupts = <2>;
 				clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
 				clock-names = "timclken1", "timclken2", "apb_pclk";
+				arm,sp804-clocksource = <0x20>;
+				arm,sp804-clockevent = <0>;
 			};
 
 			v2m_timer23: timer at 12000 {
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 1420bb1..a2eba95 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -98,6 +98,8 @@
 			     <0 49 4>;
 		clocks = <&oscclk2>, <&oscclk2>;
 		clock-names = "timclk", "apb_pclk";
+		arm,sp804-clocksource = <0x20>;
+		arm,sp804-clockevent = <0>;
 	};
 
 	watchdog at 100e5000 {
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 52d315b..ff78c15 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,6 +5,7 @@ config ARCH_VEXPRESS
 	select ARM_GIC
 	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
+	select CLKSRC_OF
 	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
 	select CPU_V7
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 51e8701..bb599d3 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -21,6 +21,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/vexpress.h>
+#include <linux/clocksource.h>
 #include <clocksource/arm_timer.h>
 #include <clocksource/timer-sp.h>
 
@@ -431,19 +432,9 @@ void __init v2m_dt_init_early(void)
 
 static void __init v2m_dt_timer_init(void)
 {
-	struct device_node *node = NULL;
-
 	vexpress_clk_of_init();
 
-	do {
-		node = of_find_compatible_node(node, NULL, "arm,sp804");
-	} while (node && vexpress_get_site_by_node(node) != VEXPRESS_SITE_MB);
-	if (node) {
-		pr_info("Using SP804 '%s' as a clock & events source\n",
-				node->full_name);
-		v2m_sp804_init(of_iomap(node, 0),
-				irq_of_parse_and_map(node, 0));
-	}
+	clocksource_of_init();
 
 	if (arch_timer_of_register() != 0)
 		twd_local_timer_of_register();
-- 
1.7.10.4
