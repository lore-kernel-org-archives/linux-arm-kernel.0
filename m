From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:21 -0500
Subject: [PATCH v2 11/13] ARM: integrator-cp: convert use CLKSRC_OF for timer
 init
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-12-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move the integrator-cp timer init to timer-sp.c and use CLKSRC_OF. There is
no reason to use the aliases, so drop them from the init code.

The integrator-cp timers are mistakenly called sp804 timers in the dts, but
in fact they are not sp804 dual timers, but single timers with the same
programming model. Fix the dts to reflect this.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorcp.dts       |    6 ++---
 arch/arm/common/timer-sp.c               |   35 ++++++++++++++++++++++++++++++
 arch/arm/mach-integrator/integrator_cp.c |   34 -----------------------------
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 8b11939..ff1aea0 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -24,15 +24,15 @@
 	};
 
 	timer0: timer at 13000000 {
-		compatible = "arm,sp804", "arm,primecell";
+		compatible = "arm,integrator-cp-timer";
 	};
 
 	timer1: timer at 13000100 {
-		compatible = "arm,sp804", "arm,primecell";
+		compatible = "arm,integrator-cp-timer";
 	};
 
 	timer2: timer at 13000200 {
-		compatible = "arm,sp804", "arm,primecell";
+		compatible = "arm,integrator-cp-timer";
 	};
 
 	pic: pic at 14000000 {
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index ded926f..ddc7407 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -31,6 +31,7 @@
 
 #include <asm/sched_clock.h>
 #include <asm/hardware/arm_timer.h>
+#include <asm/hardware/timer-sp.h>
 
 static long __init sp804_get_clock_rate(struct clk *clk)
 {
@@ -262,3 +263,37 @@ err:
 	iounmap(base);
 }
 CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
+
+static void __init integrator_cp_of_init(struct device_node *np)
+{
+	static int init_count = 0;
+	void __iomem *base;
+	int irq;
+	const char *name = of_get_property(np, "compatible", NULL);
+
+	base = of_iomap(np, 0);
+	if (WARN_ON(!base))
+		return;
+
+	/* Ensure timer is disabled */
+	writel(0, base + TIMER_CTRL);
+
+	if (init_count == 2 || !of_device_is_available(np))
+		goto err;
+
+	if (!init_count)
+		sp804_clocksource_init(base, name);
+	else {
+		irq = irq_of_parse_and_map(np, 0);
+		if (irq <= 0)
+			goto err;
+
+		sp804_clockevents_init(base, irq, name);
+	}
+
+	init_count++;
+	return;
+err:
+	iounmap(base);
+}
+CLOCKSOURCE_OF_DECLARE(intcp, "arm,integrator-cp-timer", integrator_cp_of_init);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2b0db82..5781f3c 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -250,39 +250,6 @@ static void __init intcp_init_early(void)
 }
 
 #ifdef CONFIG_OF
-
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
@@ -386,7 +353,6 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
-	.init_time	= cp_of_timer_init,
 	.init_machine	= intcp_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = intcp_dt_board_compat,
-- 
1.7.10.4
