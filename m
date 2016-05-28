From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 28 May 2016 17:33:50 +0800
Subject: [PATCH 1/4] clocksource: sp804: cleanup clk_get_sys()
In-Reply-To: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1464428033-52106-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the clk_get_sys() part into sp804_get_clock_rate(), cleanup the same code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5f45b9a..362e5d0 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -34,11 +34,19 @@
 
 #include "timer-sp.h"
 
-static long __init sp804_get_clock_rate(struct clk *clk)
+static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
 	int err;
 
+	if (!clk) {
+		clk = clk_get_sys("sp804", name);
+		if (IS_ERR(clk)) {
+			pr_err("sp804: clock not found: %ld\n", PTR_ERR(clk));
+			return PTR_ERR(clk);
+		}
+	}
+
 	err = clk_prepare(clk);
 	if (err) {
 		pr_err("sp804: clock failed to prepare: %d\n", err);
@@ -82,18 +90,7 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     struct clk *clk,
 						     int use_sched_clock)
 {
-	long rate;
-
-	if (!clk) {
-		clk = clk_get_sys("sp804", name);
-		if (IS_ERR(clk)) {
-			pr_err("sp804: clock not found: %d\n",
-			       (int)PTR_ERR(clk));
-			return;
-		}
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	long rate = sp804_get_clock_rate(clk, name);
 
 	if (rate < 0)
 		return;
@@ -189,17 +186,8 @@ static struct irqaction sp804_timer_irq = {
 void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
-	long rate;
-
-	if (!clk)
-		clk = clk_get_sys("sp804", name);
-	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
-			(int)PTR_ERR(clk));
-		return;
-	}
+	long rate = sp804_get_clock_rate(clk, name);
 
-	rate = sp804_get_clock_rate(clk);
 	if (rate < 0)
 		return;
 
-- 
1.7.12.4
