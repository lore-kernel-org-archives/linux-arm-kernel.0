From: v1ron@mail.ru (Roman Volkov)
Date: Mon, 21 Dec 2015 01:28:10 +0300
Subject: [PATCH 2/4] clocksource/vt8500: Remove the 'loops' variable
In-Reply-To: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
References: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
Message-ID: <1450650492-18996-3-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

The purpose of the 'loops' variable is unclear. vt8500 hardware does not
require any protections, in case if these variables intended for preventing
infinite loops (identical PXA timer works perfectly without these ones). If
the loops count will not be calculated correctly, these variables will only
break the loop too early and introduce problems.

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 drivers/clocksource/vt8500_timer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index 13ed892..f40ded8 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -48,8 +48,6 @@
 #define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
 #define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
 
-#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-
 #define timer_readl(addr)	readl_relaxed(regbase + addr)
 #define timer_writel(v, addr)	writel_relaxed(v, regbase + addr)
 
@@ -57,10 +55,10 @@ static void __iomem *regbase;
 
 static cycle_t vt8500_timer_read(struct clocksource *cs)
 {
-	int loops = msecs_to_loops(10);
 	timer_writel(3, TIMER_CTRL_VAL);
-	while ((timer_readl((TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE) && --loops)
+	while (timer_readl(TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
 		cpu_relax();
+
 	return timer_readl(TIMER_COUNT_VAL);
 }
 
@@ -75,9 +73,8 @@ static struct clocksource clocksource = {
 static int vt8500_timer_set_next_event(unsigned long cycles,
 				    struct clock_event_device *evt)
 {
-	int loops = msecs_to_loops(10);
 	cycle_t alarm = clocksource.read(&clocksource) + cycles;
-	while ((timer_readl(TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE) && --loops)
+	while (timer_readl(TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
 		cpu_relax();
 	timer_writel((unsigned long)alarm, TIMER_MATCH_VAL);
 
-- 
2.6.2
