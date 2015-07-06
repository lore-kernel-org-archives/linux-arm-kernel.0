From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 16:24:17 +0530
Subject: [PATCH 10/18] ARM/mmp/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <70d153f4a34217ffa7cefd2b29000ee07618f2aa.1436178990.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate mmp driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in set_mode(RESUME) except of
local_irq_{save|restore}(), which isn't required and so ->tick_resume
isn't implemented.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-mmp/time.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 10bfa03e58d4..dbc697b2fda1 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -124,32 +124,25 @@ static int timer_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void timer_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *dev)
+static int timer_set_shutdown(struct clock_event_device *evt)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		/* disable the matching interrupt */
-		__raw_writel(0x00, mmp_timer_base + TMR_IER(0));
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-	case CLOCK_EVT_MODE_PERIODIC:
-		break;
-	}
+	/* disable the matching interrupt */
+	__raw_writel(0x00, mmp_timer_base + TMR_IER(0));
 	local_irq_restore(flags);
+
+	return 0;
 }
 
 static struct clock_event_device ckevt = {
-	.name		= "clockevent",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 200,
-	.set_next_event	= timer_set_next_event,
-	.set_mode	= timer_set_mode,
+	.name			= "clockevent",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.set_next_event		= timer_set_next_event,
+	.set_state_shutdown	= timer_set_shutdown,
+	.set_state_oneshot	= timer_set_shutdown,
 };
 
 static cycle_t clksrc_read(struct clocksource *cs)
-- 
2.4.0
