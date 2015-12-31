From: v1ron@mail.ru (Roman Volkov)
Date: Thu, 31 Dec 2015 21:02:05 +0300
Subject: [PATCH v2 RESEND 1/3] clocksource/vt8500: Use MIN_OSCR_DELTA from PXA
In-Reply-To: <1451584927-4051-1-git-send-email-v1ron@mail.ru>
References: <1451584927-4051-1-git-send-email-v1ron@mail.ru>
Message-ID: <1451584927-4051-2-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

Since vt8500 and PXA timers are identical, use MIN_OSCR_DELTA from PXA,
which is bigger than existing value. It is required to determine the
minimum delay which hardware can generate.

This commit fixes vt8500 breakage in Linux 4.2 introduced by
c6eb3f7 ('hrtimer: Get rid of hrtimer softirq')

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 drivers/clocksource/vt8500_timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index a92e94b..dfc3bb4 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -50,6 +50,8 @@
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 
+#define MIN_OSCR_DELTA		16
+
 static void __iomem *regbase;
 
 static cycle_t vt8500_timer_read(struct clocksource *cs)
@@ -80,7 +82,7 @@ static int vt8500_timer_set_next_event(unsigned long cycles,
 		cpu_relax();
 	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
 
-	if ((signed)(alarm - clocksource.read(&clocksource)) <= 16)
+	if ((signed)(alarm - clocksource.read(&clocksource)) <= MIN_OSCR_DELTA)
 		return -ETIME;
 
 	writel(1, regbase + TIMER_IER_VAL);
@@ -151,7 +153,7 @@ static void __init vt8500_timer_init(struct device_node *np)
 		pr_err("%s: setup_irq failed for %s\n", __func__,
 							clockevent.name);
 	clockevents_config_and_register(&clockevent, VT8500_TIMER_HZ,
-					4, 0xf0000000);
+					MIN_OSCR_DELTA * 2, 0xf0000000);
 }
 
 CLOCKSOURCE_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
-- 
2.6.2
