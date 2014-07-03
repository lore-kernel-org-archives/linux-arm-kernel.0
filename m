From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  3 Jul 2014 20:52:51 +0800
Subject: [PATCH] clocksource: sirf: fix incorrect clock enable counter for
 timer
Message-ID: <1404391971-24214-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

in the clocksource driver, we didn't explicitly enable the clock.
it makes the clk reference counter wrong.
we didn't encounter any hang issue because the tick's clock input
has been open and is shared by some other hardware components, but
if we don't enable those components in kernel, in the stage of
disabling unused clk in kernel boot, Linux tick hangs.

this patch fixes it. it does an explicit prepare and enable to the
clock input, and increases the usage counter of the clk.

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clocksource/timer-marco.c  | 3 +++
 drivers/clocksource/timer-prima2.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index dbd3039..330e930 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -260,6 +260,9 @@ static void __init sirfsoc_marco_timer_init(struct device_node *np)
 
 	clk = of_clk_get(np, 0);
 	BUG_ON(IS_ERR(clk));
+
+	BUG_ON(clk_prepare_enable(clk));
+
 	rate = clk_get_rate(clk);
 
 	BUG_ON(rate < MARCO_CLOCK_FREQ);
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index a722aac..ce18d57 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -200,6 +200,9 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	clk = of_clk_get(np, 0);
 	BUG_ON(IS_ERR(clk));
+
+	BUG_ON(clk_prepare_enable(clk));
+
 	rate = clk_get_rate(clk);
 
 	BUG_ON(rate < PRIMA2_CLOCK_FREQ);
-- 
1.9.3
