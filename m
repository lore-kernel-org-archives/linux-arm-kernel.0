From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 26 Mar 2013 18:43:34 +0100
Subject: [PATCH v2 02/10] arm: zynq: Move timer to clocksource interface
In-Reply-To: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <f52a3cf90aa71956f77782e64575158a70300bcd.1364319776.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clocksource timer initialization.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v2: Free allocated space for structures
    Till this time this was only one timer driver which
    could be possible to use on zynq.
---
 arch/arm/mach-zynq/common.c |    2 +-
 arch/arm/mach-zynq/common.h |    2 --
 arch/arm/mach-zynq/timer.c  |   43 ++++++++++++++++++++-----------------------
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 76493b0..68e0907 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -78,7 +78,7 @@ static void __init xilinx_zynq_timer_init(void)
 
 	xilinx_zynq_clocks_init(slcr);
 
-	xttcps_timer_init();
+	clocksource_of_init();
 }
 
 /**
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 8b4dbba..5050bb1 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -17,6 +17,4 @@
 #ifndef __MACH_ZYNQ_COMMON_H__
 #define __MACH_ZYNQ_COMMON_H__
 
-void __init xttcps_timer_init(void);
-
 #endif
diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index 82357d9..ab5b839 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -22,7 +22,6 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
-#include "common.h"
 
 /*
  * This driver configures the 2 16-bit count-up timers as follows:
@@ -260,8 +259,10 @@ static void __init xttc_setup_clocksource(struct clk *clk, void __iomem *base)
 	ttccs->xttc.clk = clk;
 
 	err = clk_prepare_enable(ttccs->xttc.clk);
-	if (WARN_ON(err))
+	if (WARN_ON(err)) {
+		kfree(ttccs);
 		return;
+	}
 
 	ttccs->xttc.clk_rate_change_nb.notifier_call =
 		xttcps_rate_change_clocksource_cb;
@@ -290,9 +291,10 @@ static void __init xttc_setup_clocksource(struct clk *clk, void __iomem *base)
 
 	err = clocksource_register_hz(&ttccs->cs,
 			clk_get_rate(ttccs->xttc.clk) / PRESCALE);
-	if (WARN_ON(err))
+	if (WARN_ON(err)) {
+		kfree(ttccs);
 		return;
-
+	}
 }
 
 static int xttcps_rate_change_clockevent_cb(struct notifier_block *nb,
@@ -341,8 +343,10 @@ static void __init xttc_setup_clockevent(struct clk *clk,
 	ttcce->xttc.clk = clk;
 
 	err = clk_prepare_enable(ttcce->xttc.clk);
-	if (WARN_ON(err))
+	if (WARN_ON(err)) {
+		kfree(ttcce);
 		return;
+	}
 
 	ttcce->xttc.clk_rate_change_nb.notifier_call =
 		xttcps_rate_change_clockevent_cb;
@@ -373,8 +377,10 @@ static void __init xttc_setup_clockevent(struct clk *clk,
 	err = request_irq(irq, xttcps_clock_event_interrupt,
 			  IRQF_DISABLED | IRQF_TIMER,
 			  ttcce->ce.name, ttcce);
-	if (WARN_ON(err))
+	if (WARN_ON(err)) {
+		kfree(ttcce);
 		return;
+	}
 
 	clockevents_config_and_register(&ttcce->ce,
 			clk_get_rate(ttcce->xttc.clk) / PRESCALE, 1, 0xfffe);
@@ -386,11 +392,17 @@ static void __init xttc_setup_clockevent(struct clk *clk,
  * Initializes the timer hardware and register the clock source and clock event
  * timers with Linux kernal timer framework
  */
-static void __init xttcps_timer_init_of(struct device_node *timer)
+static void __init xttcps_timer_init(struct device_node *timer)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
 	struct clk *clk;
+	static int initialized;
+
+	if (initialized)
+		return;
+
+	initialized = 1;
 
 	/*
 	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
@@ -421,19 +433,4 @@ static void __init xttcps_timer_init_of(struct device_node *timer)
 	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
 }
 
-void __init xttcps_timer_init(void)
-{
-	const char * const timer_list[] = {
-		"cdns,ttc",
-		NULL
-	};
-	struct device_node *timer;
-
-	timer = of_find_compatible_node(NULL, NULL, timer_list[0]);
-	if (!timer) {
-		pr_err("ERROR: no compatible timer found\n");
-		BUG();
-	}
-
-	xttcps_timer_init_of(timer);
-}
+CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", xttcps_timer_init);
-- 
1.7.9.7
