From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:15 +0530
Subject: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate asm9260 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/asm9260_timer.c | 61 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 4c2ba59897e8..67ff6f2abf19 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -120,38 +120,49 @@ static int asm9260_timer_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void asm9260_timer_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *evt)
+static int asm9260_timer_shutdown(struct clock_event_device *evt)
 {
 	/* stop timer0 */
 	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + CLR_REG);
+	return 0;
+}
+
+static int asm9260_timer_set_oneshot(struct clock_event_device *evt)
+{
+	/* stop timer0 */
+	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + CLR_REG);
+
+	/* enable reset and stop on match */
+	writel_relaxed(BM_MCR_RES_EN(0) | BM_MCR_STOP_EN(0),
+		       priv.base + HW_MCR + SET_REG);
+	return 0;
+}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* disable reset and stop on match */
-		writel_relaxed(BM_MCR_RES_EN(0) | BM_MCR_STOP_EN(0),
-				priv.base + HW_MCR + CLR_REG);
-		/* configure match count for TC0 */
-		writel_relaxed(priv.ticks_per_jiffy, priv.base + HW_MR0);
-		/* enable TC0 */
-		writel_relaxed(BM_C0_EN, priv.base + HW_TCR + SET_REG);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* enable reset and stop on match */
-		writel_relaxed(BM_MCR_RES_EN(0) | BM_MCR_STOP_EN(0),
-				priv.base + HW_MCR + SET_REG);
-		break;
-	default:
-		break;
-	}
+static int asm9260_timer_set_periodic(struct clock_event_device *evt)
+{
+	/* stop timer0 */
+	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + CLR_REG);
+
+	/* disable reset and stop on match */
+	writel_relaxed(BM_MCR_RES_EN(0) | BM_MCR_STOP_EN(0),
+		       priv.base + HW_MCR + CLR_REG);
+	/* configure match count for TC0 */
+	writel_relaxed(priv.ticks_per_jiffy, priv.base + HW_MR0);
+	/* enable TC0 */
+	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + SET_REG);
+	return 0;
 }
 
 static struct clock_event_device event_dev = {
-	.name		= DRIVER_NAME,
-	.rating		= 200,
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event	= asm9260_timer_set_next_event,
-	.set_mode	= asm9260_timer_set_mode,
+	.name			= DRIVER_NAME,
+	.rating			= 200,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event		= asm9260_timer_set_next_event,
+	.set_state_shutdown	= asm9260_timer_shutdown,
+	.set_state_periodic	= asm9260_timer_set_periodic,
+	.set_state_oneshot	= asm9260_timer_set_oneshot,
+	.tick_resume		= asm9260_timer_shutdown,
 };
 
 static irqreturn_t asm9260_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
