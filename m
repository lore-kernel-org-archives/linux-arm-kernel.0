From: v1ron@mail.ru (Roman Volkov)
Date: Fri,  1 Jan 2016 16:24:42 +0300
Subject: [PATCH v3 2/3] clocksource/vt8500: Remove the 'loops' variable
In-Reply-To: <1451654683-2401-1-git-send-email-v1ron@mail.ru>
References: <1451654683-2401-1-git-send-email-v1ron@mail.ru>
Message-ID: <1451654683-2401-3-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

The purpose of the 'loops' variable is unclear. vt8500 hardware does not
require any protections, in case if these variables intended for preventing
infinite loops (identical PXA timer works perfectly without these ones).

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
Acked-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/clocksource/vt8500_timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index dfc3bb4..eb08d96 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -48,18 +48,14 @@
 #define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
 #define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
 
-#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-
 #define MIN_OSCR_DELTA		16
 
 static void __iomem *regbase;
 
 static cycle_t vt8500_timer_read(struct clocksource *cs)
 {
-	int loops = msecs_to_loops(10);
 	writel(3, regbase + TIMER_CTRL_VAL);
-	while ((readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
-						&& --loops)
+	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
 		cpu_relax();
 	return readl(regbase + TIMER_COUNT_VAL);
 }
@@ -75,10 +71,8 @@ static struct clocksource clocksource = {
 static int vt8500_timer_set_next_event(unsigned long cycles,
 				    struct clock_event_device *evt)
 {
-	int loops = msecs_to_loops(10);
 	cycle_t alarm = clocksource.read(&clocksource) + cycles;
-	while ((readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
-						&& --loops)
+	while (readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
 		cpu_relax();
 	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
 
-- 
2.6.2
