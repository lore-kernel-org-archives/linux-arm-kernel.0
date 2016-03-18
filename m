From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Fri, 18 Mar 2016 16:00:52 +0800
Subject: [RESEND PATCH v4 4/5] clocksource: a little improvment for printk in
 arm_arch_timer.c
In-Reply-To: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1458288053-29031-5-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch defines pr_fmt(fmt) for all pr_* functions.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d0b01fb5..db466d5 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -29,6 +29,9 @@
 
 #include <clocksource/arm_arch_timer.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt) "arch_timer: " fmt
+
 #define CNTTIDR		0x08
 #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
 
@@ -388,12 +391,12 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 
 	/* Check the timer frequency. */
 	if (arch_timer_rate == 0)
-		pr_warn("Architected timer frequency not available\n");
+		pr_warn("frequency not available\n");
 }
 
 static void arch_timer_banner(unsigned type)
 {
-	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
+	pr_info("%s%s%s timer(s) running@%lu.%02luMHz (%s%s%s).\n",
 		     type & ARCH_CP15_TIMER ? "cp15" : "",
 		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
 		     type & ARCH_MEM_TIMER ? "mmio" : "",
@@ -497,7 +500,7 @@ static void __init arch_counter_register(unsigned type)
 
 static void arch_timer_stop(struct clock_event_device *clk)
 {
-	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
+	pr_debug("teardown, disable IRQ%d cpu #%d\n",
 		 clk->irq, smp_processor_id());
 
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
@@ -596,8 +599,7 @@ static int __init arch_timer_register(void)
 	}
 
 	if (err) {
-		pr_err("arch_timer: can't register interrupt %d (%d)\n",
-		       ppi, err);
+		pr_err("can't register interrupt %d (%d)\n", ppi, err);
 		goto out_free;
 	}
 
@@ -649,7 +651,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
 	if (ret) {
-		pr_err("arch_timer: Failed to request mem timer irq\n");
+		pr_err("Failed to request mem timer irq\n");
 		kfree(t);
 	}
 
@@ -726,7 +728,7 @@ static void __init arch_timer_init(void)
 		}
 
 		if (!has_ppi) {
-			pr_warn("arch_timer: No interrupt available, giving up\n");
+			pr_warn("No interrupt available, giving up\n");
 			return;
 		}
 	}
@@ -740,7 +742,7 @@ static void __init arch_timer_of_init(struct device_node *np)
 	int i;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
-		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
+		pr_warn("multiple nodes in dt, skipping\n");
 		return;
 	}
 
@@ -775,7 +777,7 @@ static void __init arch_timer_mem_init(struct device_node *np)
 	arch_timers_present |= ARCH_MEM_TIMER;
 	cntctlbase = of_iomap(np, 0);
 	if (!cntctlbase) {
-		pr_err("arch_timer: Can't find CNTCTLBase\n");
+		pr_err("Can't find CNTCTLBase\n");
 		return;
 	}
 
@@ -790,7 +792,7 @@ static void __init arch_timer_mem_init(struct device_node *np)
 		u32 cntacr;
 
 		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("arch_timer: Missing frame-number\n");
+			pr_err("Missing frame-number\n");
 			of_node_put(frame);
 			goto out;
 		}
@@ -818,7 +820,7 @@ static void __init arch_timer_mem_init(struct device_node *np)
 
 	base = arch_counter_base = of_iomap(best_frame, 0);
 	if (!base) {
-		pr_err("arch_timer: Can't map frame's registers\n");
+		pr_err("Can't map frame's registers\n");
 		goto out;
 	}
 
@@ -828,7 +830,7 @@ static void __init arch_timer_mem_init(struct device_node *np)
 		irq = irq_of_parse_and_map(best_frame, PHYS_SPI);
 
 	if (!irq) {
-		pr_err("arch_timer: Frame missing %s irq",
+		pr_err("Frame missing %s irq",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
 		goto out;
 	}
@@ -850,7 +852,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	struct arch_timer_data data;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
-		pr_warn("arch_timer: already initialized, skipping\n");
+		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-- 
2.5.0
