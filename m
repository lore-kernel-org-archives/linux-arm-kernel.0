From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  8 Aug 2013 08:32:30 -0300
Subject: [PATCH v2 4/6] clocksource: armada-370-xp: Introduce new compatibles
In-Reply-To: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1375961552-12967-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP SoC clocksource driver cannot work without the 25 MHz
fixed timer. Therefore it's appropriate to introduce a new compatible
string and use it to set the 25 MHz fixed timer.

The 'marvell,timer-25MHz' property will be marked as deprecated.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 78 ++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index a781dce..da0d0e0 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -13,6 +13,25 @@
  *
  * Timer 0 is used as free-running clocksource, while timer 1 is
  * used as clock_event_device.
+ *
+ * ---
+ *
+ * The "marvell,armada-370-xp-timer" compatible and the "marvell,timer-25Mhz"
+ * property are deprecated. Instead, DT nodes should use one compatible for
+ * each SoC as appropriate.
+ *
+ * See Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+ *
+ * The rationale behind this is that the Armada 370 SoC and the Armada XP SoC
+ * timers are not really compatible:
+ *   * Armada 370 has no 25 MHz fixed timer.
+ *   * Armada XP cannot work properly without such 25 MHz fixed timer as
+ *     doing otherwise leads to using a clocksource whose frequency varies when
+ *     doing cpufreq frequency changes.
+ *
+ * Please note the deprecated compatible string "marvell,armada-370-xp-timer"
+ * and its behavior are kept only to maintain backwards compatibility,
+ * and should not be used in any new device trees.
  */
 
 #include <linux/init.h>
@@ -218,7 +237,7 @@ static struct notifier_block armada_370_xp_timer_cpu_nb = {
 	.notifier_call = armada_370_xp_timer_cpu_notify,
 };
 
-static void __init armada_370_xp_timer_init(struct device_node *np)
+static void __init armada_370_xp_timer_common_init(struct device_node *np)
 {
 	u32 clr = 0, set = 0;
 	int res;
@@ -227,20 +246,10 @@ static void __init armada_370_xp_timer_init(struct device_node *np)
 	WARN_ON(!timer_base);
 	local_base = of_iomap(np, 1);
 
-	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
-		/* The fixed 25MHz timer is available so let's use it */
+	if (timer25Mhz)
 		set = TIMER0_25MHZ;
-		timer_clk = 25000000;
-	} else {
-		unsigned long rate = 0;
-		struct clk *clk = of_clk_get(np, 0);
-		WARN_ON(IS_ERR(clk));
-		rate =  clk_get_rate(clk);
-		timer_clk = rate / TIMER_DIVIDER;
-
+	else
 		clr = TIMER0_25MHZ;
-		timer25Mhz = false;
-	}
 	timer_ctrl_clrset(clr, set);
 
 	/*
@@ -286,5 +295,48 @@ static void __init armada_370_xp_timer_init(struct device_node *np)
 	if (!res)
 		armada_370_xp_timer_setup(this_cpu_ptr(armada_370_xp_evt));
 }
+
+static void __init armada_370_xp_timer_init(struct device_node *np)
+{
+	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
+		/* The fixed 25MHz timer is required */
+		timer_clk = 25000000;
+	} else {
+		unsigned long rate = 0;
+		struct clk *clk = of_clk_get(np, 0);
+		WARN_ON(IS_ERR(clk));
+		rate =  clk_get_rate(clk);
+		timer_clk = rate / TIMER_DIVIDER;
+		timer25Mhz = false;
+	}
+
+	armada_370_xp_timer_common_init(np);
+}
+/* This one is DEPRECATED, but we keep it here for compatibility */
 CLOCKSOURCE_OF_DECLARE(armada_370_xp, "marvell,armada-370-xp-timer",
 		       armada_370_xp_timer_init);
+
+static void __init armada_xp_timer_init(struct device_node *np)
+{
+	/* The fixed 25MHz timer is required */
+	timer_clk = 25000000;
+
+	armada_370_xp_timer_common_init(np);
+}
+CLOCKSOURCE_OF_DECLARE(armada_xp, "marvell,armada-xp-timer",
+		       armada_xp_timer_init);
+
+static void __init armada_370_timer_init(struct device_node *np)
+{
+	unsigned long rate = 0;
+	struct clk *clk = of_clk_get(np, 0);
+
+	WARN_ON(IS_ERR(clk));
+	rate =  clk_get_rate(clk);
+	timer_clk = rate / TIMER_DIVIDER;
+	timer25Mhz = false;
+
+	armada_370_xp_timer_common_init(np);
+}
+CLOCKSOURCE_OF_DECLARE(armada_370, "marvell,armada-370-timer",
+		       armada_370_timer_init);
-- 
1.8.1.5
