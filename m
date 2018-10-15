From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Oct 2018 14:31:09 +0200
Subject: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
In-Reply-To: <20181015123112.9379-1-m.szyprowski@samsung.com>
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
 <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
Message-ID: <20181015123112.9379-4-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
first configure and enable Exynos Multi-Core Timer, because they both
share some common hardware blocks. This patch adds a mode of cooperation
with arch_timer driver, so kernel can use CP15 based timer interface via
arch_timer driver, which is mandatory on ARM64. In such mode driver only
configures MCT registers and starts the timer but don't register any
clocksource or events in the system. Those are left to be handled by
arch_timer driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 52 +++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index a379f11fad2d..06cd30a6d59a 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -57,6 +57,7 @@
 #define TICK_BASE_CNT	1
 
 enum {
+	MCT_INT_NONE = 0,
 	MCT_INT_SPI,
 	MCT_INT_PPI
 };
@@ -238,6 +239,9 @@ static int __init exynos4_clocksource_init(void)
 {
 	exynos4_mct_frc_start();
 
+	if (!mct_int_type)
+		return 0;
+
 #if defined(CONFIG_ARM)
 	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
 	exynos4_delay_timer.freq = clk_rate;
@@ -343,6 +347,9 @@ static struct irqaction mct_comp_event_irq = {
 
 static int exynos4_clockevent_init(void)
 {
+	if (!mct_int_type)
+		return 0;
+
 	mct_comp_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&mct_comp_device, clk_rate,
 					0xf, 0xffffffff);
@@ -476,12 +483,12 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 
 		irq_force_affinity(evt->irq, cpumask_of(cpu));
 		enable_irq(evt->irq);
-	} else {
+	} else if (mct_int_type == MCT_INT_PPI) {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
-	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
-					0xf, 0x7fffffff);
-
+	if (mct_int_type)
+		clockevents_config_and_register(evt,
+			       clk_rate / (TICK_BASE_CNT + 1), 0xf, 0x7fffffff);
 	return 0;
 }
 
@@ -496,7 +503,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);
 		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-	} else {
+	} else if (mct_int_type == MCT_INT_PPI) {
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 	}
 	return 0;
@@ -529,7 +536,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 					 &percpu_mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     mct_irqs[MCT_L0_IRQ], err);
-	} else {
+	} else if (mct_int_type == MCT_INT_SPI) {
 		for_each_possible_cpu(cpu) {
 			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
 			struct mct_clock_event_device *pcpu_mevt =
@@ -564,7 +571,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 out_irq:
 	if (mct_int_type == MCT_INT_PPI) {
 		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
-	} else {
+	} else if (mct_int_type == MCT_INT_SPI) {
 		for_each_possible_cpu(cpu) {
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
@@ -585,17 +592,28 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 
 	mct_int_type = int_type;
 
-	/* This driver uses only one global timer interrupt */
-	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
+		struct device_node *np = of_find_compatible_node(NULL, NULL,
+							     "arm,armv8-timer");
+		if (np) {
+			mct_int_type = MCT_INT_NONE;
+			of_node_put(np);
+		}
+	}
 
-	/*
-	 * Find out the number of local irqs specified. The local
-	 * timer irqs are specified after the four global timer
-	 * irqs are specified.
-	 */
-	nr_irqs = of_irq_count(np);
-	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
-		mct_irqs[i] = irq_of_parse_and_map(np, i);
+	if (mct_int_type) {
+		/* This driver uses only one global timer interrupt */
+		mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+
+		/*
+		 * Find out the number of local irqs specified. The local
+		 * timer irqs are specified after the four global timer
+		 * irqs are specified.
+		 */
+		nr_irqs = of_irq_count(np);
+		for (i = MCT_L0_IRQ; i < nr_irqs; i++)
+			mct_irqs[i] = irq_of_parse_and_map(np, i);
+	}
 
 	ret = exynos4_timer_resources(np, of_iomap(np, 0));
 	if (ret)
-- 
2.17.1
