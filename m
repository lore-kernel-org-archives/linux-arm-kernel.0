From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 30 Jun 2015 14:30:48 +0530
Subject: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
In-Reply-To: <55925268.4050109@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
 <55925268.4050109@linaro.org>
Message-ID: <20150630090048.GA4626@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-06-15, 10:25, Daniel Lezcano wrote:
> Could you add in the changelog the subtle change with
> set_mode(RESUME) and this code. As a default the timer was stopped
> when entering in the set_mode function, now with the new API, this
> is done explicitly.

> Can you replace this line with a call to asm9260_timer_shutdown ?

How does this look ?

--------------------------8<------------------

Message-Id: <12839571df542ecc8b9304b7de9881216d45aef8.1435654791.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 27 Feb 2015 13:39:52 +0530
Subject: [PATCH] clocksource: asm9260: Migrate to new 'set-state' interface

Migrate asm9260 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

As a default the timer was stopped when entering in the set_mode(RESUME)
function, now this is done explicitly with the new API.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/asm9260_timer.c | 64 ++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 4c2ba59897e8..217438d39eb3 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -120,38 +120,52 @@ static int asm9260_timer_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void asm9260_timer_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *evt)
+static inline void __asm9260_timer_shutdown(struct clock_event_device *evt)
 {
 	/* stop timer0 */
 	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + CLR_REG);
+}
+
+static int asm9260_timer_shutdown(struct clock_event_device *evt)
+{
+	__asm9260_timer_shutdown(evt);
+	return 0;
+}
+
+static int asm9260_timer_set_oneshot(struct clock_event_device *evt)
+{
+	__asm9260_timer_shutdown(evt);
+
+	/* enable reset and stop on match */
+	writel_relaxed(BM_MCR_RES_EN(0) | BM_MCR_STOP_EN(0),
+		       priv.base + HW_MCR + SET_REG);
+	return 0;
+}
+
+static int asm9260_timer_set_periodic(struct clock_event_device *evt)
+{
+	__asm9260_timer_shutdown(evt);
 
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
