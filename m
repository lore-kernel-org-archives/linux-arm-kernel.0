From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 21:55:12 +0100
Subject: [PATCH 3/5] ARM: integrator: switch to fetch clocks from device tree
Message-ID: <1390251312-6327-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This atomic commit changes the Integrator clock implementation
and the machines to register clocks from the device tree and
use these instead of the previous hard-coded clocks.

In the clock implementation all hard-coded clocks and the
special initialization function call goes away, and is
replaced by two compatible strings for the two clocks
available on the core module.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mike, looking for an ACK to reform this clock handling.
---
 .../devicetree/bindings/clock/arm-integrator.txt   | 34 +++++++++
 arch/arm/mach-integrator/integrator_ap.c           | 19 +++--
 arch/arm/mach-integrator/integrator_cp.c           |  6 --
 drivers/clk/versatile/clk-integrator.c             | 80 +++++++++-------------
 include/linux/platform_data/clk-integrator.h       |  1 -
 5 files changed, 80 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/arm-integrator.txt

diff --git a/Documentation/devicetree/bindings/clock/arm-integrator.txt b/Documentation/devicetree/bindings/clock/arm-integrator.txt
new file mode 100644
index 000000000000..652914b17b95
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/arm-integrator.txt
@@ -0,0 +1,34 @@
+Clock bindings for ARM Integrator Core Module clocks
+
+Auxilary Oscillator Clock
+
+This is a configurable clock fed from a 24 MHz chrystal,
+used for generating e.g. video clocks. It is located on the
+core module and there is only one of these.
+
+This clock node *must* be a subnode of the core module, since
+it obtains the base address for it's address range from its
+parent node.
+
+
+Required properties:
+- compatible: must be "arm,integrator-cm-auxosc"
+- #clock-cells: must be <0>
+
+Optional properties:
+- clocks: parent clock(s)
+
+Example:
+
+core-module at 10000000 {
+	xtal24mhz: xtal24mhz at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+	auxosc: cm_aux_osc at 25M {
+		#clock-cells = <0>;
+		compatible = "arm,integrator-cm-auxosc";
+		clocks = <&xtal24mhz>;
+	};
+};
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index d50dc2dbfd89..1b80a83fe58d 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -42,6 +42,7 @@
 #include <linux/sys_soc.h>
 #include <linux/termios.h>
 #include <linux/sched_clock.h>
+#include <linux/clk-provider.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -412,10 +413,7 @@ static void __init ap_of_timer_init(void)
 	struct clk *clk;
 	unsigned long rate;
 
-	clk = clk_get_sys("ap_timer", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
-	rate = clk_get_rate(clk);
+	of_clk_init(NULL);
 
 	err = of_property_read_string(of_aliases,
 				"arm,timer-primary", &path);
@@ -425,6 +423,12 @@ static void __init ap_of_timer_init(void)
 	base = of_iomap(node, 0);
 	if (WARN_ON(!base))
 		return;
+
+	clk = of_clk_get(node, 0);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+	rate = clk_get_rate(clk);
+
 	writel(0, base + TIMER_CTRL);
 	integrator_clocksource_init(rate, base);
 
@@ -437,6 +441,12 @@ static void __init ap_of_timer_init(void)
 	if (WARN_ON(!base))
 		return;
 	irq = irq_of_parse_and_map(node, 0);
+
+	clk = of_clk_get(node, 0);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+	rate = clk_get_rate(clk);
+
 	writel(0, base + TIMER_CTRL);
 	integrator_clockevent_init(rate, base, irq);
 }
@@ -450,7 +460,6 @@ static void __init ap_init_irq_of(void)
 {
 	cm_init();
 	of_irq_init(fpga_irq_of_match);
-	integrator_clk_init(false);
 }
 
 /* For the Device Tree, add in the UART callbacks as AUXDATA */
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 4fc0a195de01..cf02c91f7c8c 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -23,7 +23,6 @@
 #include <linux/irqchip/versatile-fpga.h>
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
-#include <linux/platform_data/clk-integrator.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -33,8 +32,6 @@
 #include <mach/platform.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
-#include <asm/hardware/icst.h>
 
 #include <mach/lm.h>
 
@@ -43,8 +40,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <asm/hardware/timer-sp.h>
-
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
@@ -258,7 +253,6 @@ static void __init intcp_init_irq_of(void)
 {
 	cm_init();
 	of_irq_init(fpga_irq_of_match);
-	integrator_clk_init(true);
 }
 
 /*
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index bda8967e09c2..19864b5690e9 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -10,20 +10,17 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
-#include <linux/platform_data/clk-integrator.h>
-
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "clk-icst.h"
 
-/*
- * Implementation of the ARM Integrator/AP and Integrator/CP clock tree.
- * Inspired by portions of:
- * plat-versatile/clock.c and plat-versatile/include/plat/clock.h
- */
+#define INTEGRATOR_HDR_LOCK_OFFSET	0x14
 
-static const struct icst_params cp_auxvco_params = {
+/* Base offset for the core module */
+static void __iomem *cm_base;
+
+static const struct icst_params cp_auxosc_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
 	.vco_min	= ICST525_VCO_MIN,
@@ -35,50 +32,37 @@ static const struct icst_params cp_auxvco_params = {
 	.idx2s		= icst525_idx2s,
 };
 
-static const struct clk_icst_desc __initdata cp_icst_desc = {
-	.params = &cp_auxvco_params,
+static const struct clk_icst_desc __initdata cm_auxosc_desc = {
+	.params = &cp_auxosc_params,
 	.vco_offset = 0x1c,
 	.lock_offset = INTEGRATOR_HDR_LOCK_OFFSET,
 };
 
-/*
- * integrator_clk_init() - set up the integrator clock tree
- * @is_cp: pass true if it's the Integrator/CP else AP is assumed
- */
-void __init integrator_clk_init(bool is_cp)
+static void __init of_integrator_cm_osc_setup(struct device_node *np)
 {
-	struct clk *clk;
-
-	/* APB clock dummy */
-	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
-	clk_register_clkdev(clk, "apb_pclk", NULL);
-
-	/* UART reference clock */
-	clk = clk_register_fixed_rate(NULL, "uartclk", NULL, CLK_IS_ROOT,
-				14745600);
-	clk_register_clkdev(clk, NULL, "uart0");
-	clk_register_clkdev(clk, NULL, "uart1");
-	if (is_cp)
-		clk_register_clkdev(clk, NULL, "mmci");
-
-	/* 24 MHz clock */
-	clk = clk_register_fixed_rate(NULL, "clk24mhz", NULL, CLK_IS_ROOT,
-				24000000);
-	clk_register_clkdev(clk, NULL, "kmi0");
-	clk_register_clkdev(clk, NULL, "kmi1");
-	if (!is_cp)
-		clk_register_clkdev(clk, NULL, "ap_timer");
+	struct clk *clk = ERR_PTR(-EINVAL);
+	const char *clk_name = np->name;
+	const struct clk_icst_desc *desc = &cm_auxosc_desc;
 
-	if (!is_cp)
-		return;
+	if (!cm_base) {
+		/* Remap the core module base if not done yet */
+		struct device_node *parent;
 
-	/* 1 MHz clock */
-	clk = clk_register_fixed_rate(NULL, "clk1mhz", NULL, CLK_IS_ROOT,
-				1000000);
-	clk_register_clkdev(clk, NULL, "sp804");
+		parent = of_get_parent(np);
+		if (!np) {
+			pr_err("no parent on core module clock\n");
+			return;
+		}
+		cm_base = of_iomap(parent, 0);
+		if (!cm_base) {
+			pr_err("could not remap core module base\n");
+			return;
+		}
+	}
 
-	/* ICST VCO clock used on the Integrator/CP CLCD */
-	clk = icst_clk_register(NULL, &cp_icst_desc, "icst",
-				__io_address(INTEGRATOR_HDR_BASE));
-	clk_register_clkdev(clk, NULL, "clcd");
+	clk = icst_clk_register(NULL, desc, clk_name, cm_base);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(integrator_cm_auxosc_clk,
+	"arm,integrator-cm-auxosc", of_integrator_cm_osc_setup);
diff --git a/include/linux/platform_data/clk-integrator.h b/include/linux/platform_data/clk-integrator.h
index 280edac9d0a5..addd48cac625 100644
--- a/include/linux/platform_data/clk-integrator.h
+++ b/include/linux/platform_data/clk-integrator.h
@@ -1,3 +1,2 @@
-void integrator_clk_init(bool is_cp);
 void integrator_impd1_clk_init(void __iomem *base, unsigned int id);
 void integrator_impd1_clk_exit(unsigned int id);
-- 
1.8.4.2
