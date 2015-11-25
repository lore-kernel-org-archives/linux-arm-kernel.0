From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 25 Nov 2015 10:54:04 +0530
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify already
 reset timer counter
Message-ID: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GT counter is common to every core in a cluster. There is a usecase
when Linux is spawned by a 'master' firmware/OS running on some core of
the same cluster and the GT is used by the both.
 Linux, upon boot, resetting the GT counter is obviously fatal to the
other OS. So provide a way for DT to tell Linux if it's running in that
'slave' mode and must not reset the counter.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 Documentation/devicetree/bindings/arm/global_timer.txt |  6 ++++++
 drivers/clocksource/arm_global_timer.c                 | 12 +++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
index bdae3a8..bb897a9 100644
--- a/Documentation/devicetree/bindings/arm/global_timer.txt
+++ b/Documentation/devicetree/bindings/arm/global_timer.txt
@@ -17,6 +17,12 @@
 
 - clocks : Should be phandle to a clock.
 
+
+** Optional properties:
+
+- arm,gt_no_reset : Firmware/bootloader already initialized the
+	global timer-counter and expects it to be not reset again.
+
 Example:
 
 	timer at 2c000600 {
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a2cb6fa..952bab6 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -51,6 +51,7 @@ static void __iomem *gt_base;
 static unsigned long gt_clk_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
+static bool gt_reset_counter;
 
 /*
  * To get the value from the Global Timer Counter register proceed as follows:
@@ -212,9 +213,11 @@ static u64 notrace gt_sched_clock_read(void)
 
 static void __init gt_clocksource_init(void)
 {
-	writel(0, gt_base + GT_CONTROL);
-	writel(0, gt_base + GT_COUNTER0);
-	writel(0, gt_base + GT_COUNTER1);
+	if (gt_reset_counter) {
+		writel(0, gt_base + GT_CONTROL);
+		writel(0, gt_base + GT_COUNTER0);
+		writel(0, gt_base + GT_COUNTER1);
+	}
 	/* enables timer on all the cores */
 	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
@@ -303,6 +306,9 @@ static void __init global_timer_of_register(struct device_node *np)
 		goto out_irq;
 	}
 
+	/* See if we are told we can't reset the global timer counter */
+	gt_reset_counter = !of_property_read_bool(np, "arm,gt_no_reset");
+
 	/* Immediately configure the timer on the boot CPU */
 	gt_clocksource_init();
 	gt_clockevents_init(this_cpu_ptr(gt_evt));
-- 
1.9.1
