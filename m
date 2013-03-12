From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 01:08:34 +0800
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for sp804
In-Reply-To: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all code to parse sp804 in integrator platform driver. Use
clocksource_of_init() instead since these code are implemented in sp804
driver already.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/integrator.dtsi        |    3 +++
 arch/arm/boot/dts/integratorap.dts       |   15 +++++------
 arch/arm/boot/dts/integratorcp.dts       |    9 +++----
 arch/arm/mach-integrator/Kconfig         |    3 +++
 arch/arm/mach-integrator/integrator_ap.c |   41 +-----------------------------
 arch/arm/mach-integrator/integrator_cp.c |   35 ++-----------------------
 6 files changed, 20 insertions(+), 86 deletions(-)

diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 813b91d..749ac21 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -9,18 +9,21 @@
 		reg = <0x13000000 0x100>;
 		interrupt-parent = <&pic>;
 		interrupts = <5>;
+		status = "disabled";
 	};
 
 	timer at 13000100 {
 		reg = <0x13000100 0x100>;
 		interrupt-parent = <&pic>;
 		interrupts = <6>;
+		status = "disabled";
 	};
 
 	timer at 13000200 {
 		reg = <0x13000200 0x100>;
 		interrupt-parent = <&pic>;
 		interrupts = <7>;
+		status = "disabled";
 	};
 
 	pic at 14000000 {
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index c9c3fa3..70e321c 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -9,11 +9,6 @@
 	model = "ARM Integrator/AP";
 	compatible = "arm,integrator-ap";
 
-	aliases {
-		arm,timer-primary = &timer2;
-		arm,timer-secondary = &timer1;
-	};
-
 	chosen {
 		bootargs = "root=/dev/ram0 console=ttyAM0,38400n8 earlyprintk";
 	};
@@ -24,15 +19,19 @@
 	};
 
 	timer0: timer at 13000000 {
-		compatible = "arm,integrator-timer";
+		compatible = "arm,sp804", "arm,primecell";
 	};
 
 	timer1: timer at 13000100 {
-		compatible = "arm,integrator-timer";
+		compatible = "arm,sp804", "arm,primecell";
+		arm,sp804-clockevent = <0>;
+		status = "ok";
 	};
 
 	timer2: timer at 13000200 {
-		compatible = "arm,integrator-timer";
+		compatible = "arm,sp804", "arm,primecell";
+		arm,sp804-clocksource = <0>;
+		status = "ok";
 	};
 
 	pic: pic at 14000000 {
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 8b11939..19b2e3e 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -9,11 +9,6 @@
 	model = "ARM Integrator/CP";
 	compatible = "arm,integrator-cp";
 
-	aliases {
-		arm,timer-primary = &timer2;
-		arm,timer-secondary = &timer1;
-	};
-
 	chosen {
 		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
 	};
@@ -29,10 +24,14 @@
 
 	timer1: timer at 13000100 {
 		compatible = "arm,sp804", "arm,primecell";
+		arm,sp804-clockevent = <0>;
+		status = "ok";
 	};
 
 	timer2: timer at 13000200 {
 		compatible = "arm,sp804", "arm,primecell";
+		arm,sp804-clocksource = <0>;
+		status = "ok";
 	};
 
 	pic: pic at 14000000 {
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index abeff25..031f43a 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -5,6 +5,7 @@ menu "Integrator Options"
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
 	select CLKSRC_MMIO
+	select CLKSRC_OF
 	select MIGHT_HAVE_PCI
 	select SERIAL_AMBA_PL010
 	select SERIAL_AMBA_PL010_CONSOLE
@@ -15,6 +16,8 @@ config ARCH_INTEGRATOR_AP
 
 config ARCH_INTEGRATOR_CP
 	bool "Support Integrator/CP platform"
+	select CLKSRC_MMIO
+	select CLKSRC_OF
 	select ARCH_CINTEGRATOR
 	select ARM_TIMER_SP804
 	select PLAT_VERSATILE_CLCD
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index c2112ff..2266944 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -425,45 +425,6 @@ void __init ap_init_early(void)
 
 #ifdef CONFIG_OF
 
-static void __init ap_of_timer_init(void)
-{
-	struct device_node *node;
-	const char *path;
-	void __iomem *base;
-	int err;
-	int irq;
-	struct clk *clk;
-	unsigned long rate;
-
-	clk = clk_get_sys("ap_timer", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
-	rate = clk_get_rate(clk);
-
-	err = of_property_read_string(of_aliases,
-				"arm,timer-primary", &path);
-	if (WARN_ON(err))
-		return;
-	node = of_find_node_by_path(path);
-	base = of_iomap(node, 0);
-	if (WARN_ON(!base))
-		return;
-	writel(0, base + TIMER_CTRL);
-	integrator_clocksource_init(rate, base);
-
-	err = of_property_read_string(of_aliases,
-				"arm,timer-secondary", &path);
-	if (WARN_ON(err))
-		return;
-	node = of_find_node_by_path(path);
-	base = of_iomap(node, 0);
-	if (WARN_ON(!base))
-		return;
-	irq = irq_of_parse_and_map(node, 0);
-	writel(0, base + TIMER_CTRL);
-	integrator_clockevent_init(rate, base, irq);
-}
-
 static const struct of_device_id fpga_irq_of_match[] __initconst = {
 	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
 	{ /* Sentinel */ }
@@ -582,7 +543,7 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.init_early	= ap_init_early,
 	.init_irq	= ap_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
-	.init_time	= ap_of_timer_init,
+	.init_time	= clocksource_of_init,
 	.init_machine	= ap_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = ap_dt_board_compat,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 40373ec..6e1c340 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -28,6 +28,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sys_soc.h>
+#include <linux/clocksource.h>
 #include <clocksource/arm_timer.h>
 #include <clocksource/timer-sp.h>
 
@@ -251,38 +252,6 @@ static void __init intcp_init_early(void)
 
 #ifdef CONFIG_OF
 
-static void __init cp_of_timer_init(void)
-{
-	struct device_node *node;
-	const char *path;
-	void __iomem *base;
-	int err;
-	int irq;
-
-	err = of_property_read_string(of_aliases,
-				"arm,timer-primary", &path);
-	if (WARN_ON(err))
-		return;
-	node = of_find_node_by_path(path);
-	base = of_iomap(node, 0);
-	if (WARN_ON(!base))
-		return;
-	writel(0, base + TIMER_CTRL);
-	sp804_clocksource_init(base, node->name);
-
-	err = of_property_read_string(of_aliases,
-				"arm,timer-secondary", &path);
-	if (WARN_ON(err))
-		return;
-	node = of_find_node_by_path(path);
-	base = of_iomap(node, 0);
-	if (WARN_ON(!base))
-		return;
-	irq = irq_of_parse_and_map(node, 0);
-	writel(0, base + TIMER_CTRL);
-	sp804_clockevents_init(base, irq, node->name);
-}
-
 static const struct of_device_id fpga_irq_of_match[] __initconst = {
 	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
 	{ /* Sentinel */ }
@@ -386,7 +355,7 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
-	.init_time	= cp_of_timer_init,
+	.init_time	= clocksource_of_init,
 	.init_machine	= intcp_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = intcp_dt_board_compat,
-- 
1.7.10.4
