From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 06 Oct 2015 11:23:59 +0300
Subject: [PATCH 1/2] exynos_mct: Allow to use architected timer mode
In-Reply-To: <cover.1444119342.git.p.fedin@samsung.com>
References: <cover.1444119342.git.p.fedin@samsung.com>
Message-ID: <64e124ca664a6eb266af33cc178fa4749a0c1358.1444119342.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MCT is actually compatible with architected timer and can be accessed
using CP15 registers. This allows to use virtualization extensions on
Exynos boards, provided you have the appropriate bootloader.

Compatibility mode is enabled if armv7-timer device node is inserted
into MCT node. In this case the driver will only enable counter and
exit, leaving the rest for the architected timer driver.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 029f96a..a48492d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -510,7 +510,7 @@ static struct notifier_block exynos4_mct_cpu_nb = {
 	.notifier_call = exynos4_mct_cpu_notify,
 };
 
-static void __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
+static void __init exynos4_timer_resources(struct device_node *np)
 {
 	int err, cpu;
 	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
@@ -527,10 +527,6 @@ static void __init exynos4_timer_resources(struct device_node *np, void __iomem
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
 
-	reg_base = base;
-	if (!reg_base)
-		panic("%s: unable to ioremap mct address space\n", __func__);
-
 	if (mct_int_type == MCT_INT_PPI) {
 
 		err = request_percpu_irq(mct_irqs[MCT_L0_IRQ],
@@ -574,8 +570,19 @@ out_irq:
 
 static void __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
+	struct device_node *child;
 	u32 nr_irqs, i;
 
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: unable to ioremap mct address space\n", __func__);
+
+	for_each_child_of_node(np, child)
+		if (of_device_is_compatible(child, "arm,armv7-timer")) {
+			exynos4_mct_frc_start();
+			return;
+		}
+
 	mct_int_type = int_type;
 
 	/* This driver uses only one global timer interrupt */
@@ -594,7 +601,7 @@ static void __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-	exynos4_timer_resources(np, of_iomap(np, 0));
+	exynos4_timer_resources(np);
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
 }
-- 
2.4.4
