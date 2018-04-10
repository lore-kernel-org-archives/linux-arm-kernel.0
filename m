From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 10 Apr 2018 14:51:38 +0200
Subject: [PATCH v2 2/5] ARM: timer-sp: Use of_clk_get_parent_count() instead
 of open coding
In-Reply-To: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1523364701-15383-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v2 1/5] clk: Extract OF clock helpers in
<linux/of_clk.h>".

v2:
  - of_clk_get_parent_count() was moved to <linux/of_clk.h>,
  - Dropped RFC, as a dummy is now available in the !CONFIG_COMMON_CLK
    case.
---
 drivers/clocksource/timer-sp804.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 3ac9dec9a03852f9..e01222ea888ff9d2 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_clk.h>
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
@@ -245,7 +246,7 @@ static int __init sp804_of_init(struct device_node *np)
 		clk1 = NULL;
 
 	/* Get the 2nd clock if the timer has 3 timer clocks */
-	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
+	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
 			pr_err("sp804: %s clock not found: %d\n", np->name,
-- 
2.7.4
