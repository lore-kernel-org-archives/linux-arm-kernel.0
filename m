From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:41:02 +0530
Subject: [PATCH 08/18] ARM/ks8695/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <7cfa3c69ca97acfd7cac19652d82aa610015bab8.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate ks8695 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

There is nothing to be done for oneshot or shutdown states and so are
not implemented.

Acked-by: Greg Ungerer <gerg@uclinux.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-ks8695/time.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
index a197874bf382..18eb0fbd8d82 100644
--- a/arch/arm/mach-ks8695/time.c
+++ b/arch/arm/mach-ks8695/time.c
@@ -54,28 +54,25 @@
 /* Timer0 Timeout Counter Register */
 #define T0TC_WATCHDOG		(0xff)		/* Enable watchdog mode */
 
-static void ks8695_set_mode(enum clock_event_mode mode,
-			    struct clock_event_device *evt)
+static int ks8695_set_periodic(struct clock_event_device *evt)
 {
+	u32 rate = DIV_ROUND_CLOSEST(KS8695_CLOCK_RATE, HZ);
+	u32 half = DIV_ROUND_CLOSEST(rate, 2);
 	u32 tmcon;
 
-	if (mode == CLOCK_EVT_FEAT_PERIODIC) {
-		u32 rate = DIV_ROUND_CLOSEST(KS8695_CLOCK_RATE, HZ);
-		u32 half = DIV_ROUND_CLOSEST(rate, 2);
-
-		/* Disable timer 1 */
-		tmcon = readl_relaxed(KS8695_TMR_VA + KS8695_TMCON);
-		tmcon &= ~TMCON_T1EN;
-		writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
+	/* Disable timer 1 */
+	tmcon = readl_relaxed(KS8695_TMR_VA + KS8695_TMCON);
+	tmcon &= ~TMCON_T1EN;
+	writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
 
-		/* Both registers need to count down */
-		writel_relaxed(half, KS8695_TMR_VA + KS8695_T1TC);
-		writel_relaxed(half, KS8695_TMR_VA + KS8695_T1PD);
+	/* Both registers need to count down */
+	writel_relaxed(half, KS8695_TMR_VA + KS8695_T1TC);
+	writel_relaxed(half, KS8695_TMR_VA + KS8695_T1PD);
 
-		/* Re-enable timer1 */
-		tmcon |= TMCON_T1EN;
-		writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
-	}
+	/* Re-enable timer1 */
+	tmcon |= TMCON_T1EN;
+	writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
+	return 0;
 }
 
 static int ks8695_set_next_event(unsigned long cycles,
@@ -102,11 +99,13 @@ static int ks8695_set_next_event(unsigned long cycles,
 }
 
 static struct clock_event_device clockevent_ks8695 = {
-	.name		= "ks8695_t1tc",
-	.rating		= 300, /* Reasonably fast and accurate clock event */
-	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-	.set_next_event	= ks8695_set_next_event,
-	.set_mode	= ks8695_set_mode,
+	.name			= "ks8695_t1tc",
+	/* Reasonably fast and accurate clock event */
+	.rating			= 300,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC,
+	.set_next_event		= ks8695_set_next_event,
+	.set_state_periodic	= ks8695_set_periodic,
 };
 
 /*
-- 
2.4.0
