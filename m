From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 Mar 2013 14:53:08 +0100
Subject: [PATCH 02/10] arm: zynq: Move timer to clocksource interface
In-Reply-To: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1364219596-4954-2-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clocksource timer initialization.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/common.c |    2 +-
 arch/arm/mach-zynq/common.h |    2 --
 arch/arm/mach-zynq/timer.c  |   27 ++++++++-------------------
 3 files changed, 9 insertions(+), 22 deletions(-)

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
index 896ba3e..3b1faed 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -22,7 +22,6 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
-#include "common.h"
 
 /*
  * This driver configures the 2 16-bit count-up timers as follows:
@@ -387,11 +386,17 @@ static void __init zynq_ttc_setup_clockevent(struct clk *clk,
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
@@ -422,20 +427,4 @@ static void __init xttcps_timer_init_of(struct device_node *timer)
 	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
 }
 
-
-void __init xttcps_timer_init(void)
-{
-	const char * const timer_list[] = {
-		"xlnx,ttc",
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
+CLOCKSOURCE_OF_DECLARE(zynq, "xlnx,ttc", xttcps_timer_init);
-- 
1.7.9.7
