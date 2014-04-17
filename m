From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Apr 2014 11:06:45 +0200
Subject: [PATCH v3 1/2] clocksource: sun5i: Add support for reset controller
In-Reply-To: <1397725606-18000-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397725606-18000-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1397725606-18000-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31 that uses this timer has the timer IP asserted in reset.
Add an optional reset property to the DT, and deassert the timer from reset if
it's there.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt       | 4 ++++
 drivers/clocksource/timer-sun5i.c                                   | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
index 7c26154b8bbb..27cfc7d7ccd7 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
@@ -9,6 +9,9 @@ Required properties:
 		one)
 - clocks: phandle to the source clock (usually the AHB clock)
 
+Optionnal properties:
+- resets: phandle to a reset controller asserting the timer
+
 Example:
 
 timer at 01c60000 {
@@ -19,4 +22,5 @@ timer at 01c60000 {
 		     <0 53 1>,
 		     <0 54 1>;
 	clocks = <&ahb1_gates 19>;
+	resets = <&ahb1rst 19>;
 };
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index deebcd6469fc..02268448dc85 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqreturn.h>
+#include <linux/reset.h>
 #include <linux/sched_clock.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -143,6 +144,7 @@ static u64 sun5i_timer_sched_read(void)
 
 static void __init sun5i_timer_init(struct device_node *node)
 {
+	struct reset_control *rstc;
 	unsigned long rate;
 	struct clk *clk;
 	int ret, irq;
@@ -162,6 +164,10 @@ static void __init sun5i_timer_init(struct device_node *node)
 	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
 
+	rstc = of_reset_control_get(node, NULL);
+	if (!IS_ERR(rstc))
+		reset_control_deassert(rstc);
+
 	writel(~0, timer_base + TIMER_INTVAL_LO_REG(1));
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
 	       timer_base + TIMER_CTL_REG(1));
-- 
1.9.1
