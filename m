From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Sep 2012 15:31:18 -0600
Subject: [PATCH 4/5] ARM: tegra: enhance timer.c to get information from
 device tree
In-Reply-To: <1348090279-22631-1-git-send-email-swarren@wwwdotorg.org>
References: <1348090279-22631-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1348090279-22631-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Modify Tegra's timer code to parse the Tegra timer IRQ from device tree,
and to instantiate the TWD from device tree, rather than relying on hard-
coded values from <mach/irqs.h>.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/timer.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index eccdce9..ef38c3c 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -26,13 +26,13 @@
 #include <linux/clocksource.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
 
 #include <asm/mach/time.h>
 #include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
 
 #include <mach/iomap.h>
-#include <mach/irqs.h>
 
 #include "board.h"
 #include "clock.h"
@@ -158,30 +158,32 @@ static struct irqaction tegra_timer_irq = {
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_HIGH,
 	.handler	= tegra_timer_interrupt,
 	.dev_id		= &tegra_clockevent,
-	.irq		= INT_TMR3,
 };
 
-#ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
-			      TEGRA_ARM_PERIF_BASE + 0x600,
-			      IRQ_LOCALTIMER);
-
-static void __init tegra_twd_init(void)
-{
-	int err = twd_local_timer_register(&twd_local_timer);
-	if (err)
-		pr_err("twd_local_timer_register failed %d\n", err);
-}
-#else
-#define tegra_twd_init()	do {} while(0)
-#endif
+static const struct of_device_id timer_match[] __initconst = {
+	{ .compatible = "nvidia,tegra20-timer" },
+	{}
+};
 
 static void __init tegra_init_timer(void)
 {
+	struct device_node *np;
 	struct clk *clk;
 	unsigned long rate;
 	int ret;
 
+	np = of_find_matching_node(NULL, timer_match);
+	if (!np) {
+		pr_err("Failed to find timer DT node\n");
+		BUG();
+	}
+
+	tegra_timer_irq.irq = irq_of_parse_and_map(np, 2);
+	if (tegra_timer_irq.irq <= 0) {
+		pr_err("Failed to map timer IRQ\n");
+		BUG();
+	}
+
 	clk = clk_get_sys("timer", NULL);
 	if (IS_ERR(clk)) {
 		pr_warn("Unable to get timer clock."
@@ -202,6 +204,8 @@ static void __init tegra_init_timer(void)
 	else
 		clk_prepare_enable(clk);
 
+	of_node_put(np);
+
 	switch (rate) {
 	case 12000000:
 		timer_writel(0x000b, TIMERUS_USEC_CFG);
@@ -241,7 +245,9 @@ static void __init tegra_init_timer(void)
 	tegra_clockevent.cpumask = cpu_all_mask;
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_register_device(&tegra_clockevent);
-	tegra_twd_init();
+#ifdef CONFIG_HAVE_ARM_TWD
+	twd_local_timer_of_register();
+#endif
 	register_persistent_clock(NULL, tegra_read_persistent_clock);
 }
 
-- 
1.7.0.4
