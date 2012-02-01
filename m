From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  1 Feb 2012 16:59:34 +0000
Subject: [PATCH v2 3/4] ARM: architected timers: add DT support
In-Reply-To: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
References: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328115575-24866-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add runtime DT support and documentation for the Cortex A7/A15
architected timers.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../devicetree/bindings/arm/arch_timer.txt         |   23 +++++++++
 arch/arm/kernel/arch_timer.c                       |   53 +++++++++++++++++---
 2 files changed, 69 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arch_timer.txt

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
new file mode 100644
index 0000000..84e93f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -0,0 +1,23 @@
+* ARM architected timer
+
+ARM Cortex-A7 and Cortex-A15 have a per-core architected timer, which
+provides a per-cpu local timer.
+
+The timer is attached to a GIC to deliver its two per-processor
+interrupts (one for the secure mode, one for the non-secure mode).
+
+** Timer node properties:
+
+- compatible : Should be "arm,armv7-timer"
+
+- interrupts : One or two interrupts for secure and non-secure mode
+
+- clock-frequency : The frequency of the main counter, in Hz. Optionnal.
+
+Example:
+
+	timer {
+		compatible = "arm,armv7-timer"";
+		interrupts = <1 13 0xf08 1 14 0xf08>;
+		clock-frequency = <100000000>;
+	};
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 1a203f0..6cb7d39 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -17,6 +17,7 @@
 #include <linux/jiffies.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/of_irq.h>
 #include <linux/io.h>
 
 #include <asm/cputype.h>
@@ -243,13 +244,10 @@ static struct local_timer_ops arch_timer_ops __cpuinitdata = {
 	.stop	= arch_timer_stop,
 };
 
-int __init arch_timer_register(struct arch_timer *at)
+static int __init arch_timer_common_register(void)
 {
 	int err;
 
-	if (at->res[0].start <= 0 || !(at->res[0].flags & IORESOURCE_IRQ))
-		return -EINVAL;
-
 	err = arch_timer_available();
 	if (err)
 		return err;
@@ -260,7 +258,6 @@ int __init arch_timer_register(struct arch_timer *at)
 
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 
-	arch_timer_ppi = at->res[0].start;
 	err = request_percpu_irq(arch_timer_ppi, arch_timer_handler,
 				 "arch_timer", arch_timer_evt);
 	if (err) {
@@ -269,8 +266,7 @@ int __init arch_timer_register(struct arch_timer *at)
 		goto out_free;
 	}
 
-	if (at->res[1].start > 0 || (at->res[1].flags & IORESOURCE_IRQ)) {
-		arch_timer_ppi2 = at->res[1].start;
+	if (arch_timer_ppi2) {
 		err = request_percpu_irq(arch_timer_ppi2, arch_timer_handler,
 					 "arch_timer", arch_timer_evt);
 		if (err) {
@@ -298,6 +294,49 @@ out_free:
 	return err;
 }
 
+int __init arch_timer_register(struct arch_timer *at)
+{
+	if (at->res[0].start <= 0 || !(at->res[0].flags & IORESOURCE_IRQ))
+		return -EINVAL;
+
+	arch_timer_ppi = at->res[0].start;
+
+	if (at->res[1].start > 0 || (at->res[1].flags & IORESOURCE_IRQ))
+		arch_timer_ppi2 = at->res[1].start;
+
+	return arch_timer_common_register();
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id arch_timer_of_match[] __initconst = {
+	{ .compatible	= "arm,armv7-timer",	},
+	{},
+};
+
+int __init arch_timer_of_register(void)
+{
+	struct device_node *np;
+	u32 freq;
+
+	np = of_find_matching_node(NULL, arch_timer_of_match);
+	if (!np) {
+		pr_err("arch_timer: can't find DT node\n");
+		return -ENODEV;
+	}
+
+	/* Try to determine the frequency from the device tree or CNTFRQ */
+	if (!of_property_read_u32(np, "clock-frequency", &freq))
+		arch_timer_rate = freq;
+
+	arch_timer_ppi = irq_of_parse_and_map(np, 0);
+	arch_timer_ppi2 = irq_of_parse_and_map(np, 1);
+	pr_info("arch_timer: found %s irqs %d %d\n",
+		np->name, arch_timer_ppi, arch_timer_ppi2);
+
+	return arch_timer_common_register();
+}
+#endif
+
 int arch_timer_sched_clock_init(void)
 {
 	int err;
-- 
1.7.7.1
