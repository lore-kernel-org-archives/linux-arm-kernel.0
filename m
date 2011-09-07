From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 7 Sep 2011 10:30:51 +0200
Subject: [PATCH 2/4] mach-integrator: clockevent supports oneshot mode
Message-ID: <1315384251-27369-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Integrator AP timer has no problem supporting oneshot
ticks with proper code, so let's do it so we can have
NOHZ configured in for this platform too.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 7748be1..8516193 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -362,12 +362,20 @@ static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_devic
 {
 	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
 
-	BUG_ON(mode == CLOCK_EVT_MODE_ONESHOT);
-
-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
-		writel(ctrl, clkevt_base + TIMER_CTRL);
-		writel(timer_reload, clkevt_base + TIMER_LOAD);
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
 		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		ctrl &= ~TIMER_CTRL_PERIODIC;
+		ctrl |= TIMER_CTRL_ENABLE;
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+	default:
+		/* Just leave in disabled state */
+		break;
 	}
 
 	writel(ctrl, clkevt_base + TIMER_CTRL);
@@ -387,7 +395,7 @@ static int clkevt_set_next_event(unsigned long next, struct clock_event_device *
 static struct clock_event_device integrator_clockevent = {
 	.name		= "timer1",
 	.shift		= 34,
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= clkevt_set_mode,
 	.set_next_event	= clkevt_set_next_event,
 	.rating		= 300,
-- 
1.7.3.2
