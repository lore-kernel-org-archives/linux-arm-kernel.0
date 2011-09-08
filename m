From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  8 Sep 2011 22:13:07 +0200
Subject: [PATCH 2/4 v2] mach-integrator: clockevent supports oneshot mode
Message-ID: <1315512787-20991-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator AP timer has no problem supporting oneshot
ticks with proper code, so let's do it so we can have
NOHZ configured in for this platform too.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Make sure that setting the periodic mode arms and fires a
  periodic timer, and have the oneshot mode leave the timer
  disabled until the .set_next_event occurs.
- Tested in both in explicit periodic and oneshot mode, by
  removing the CLOCK_EVT_FEAT_ONESHOT and testing, and
  removing CLOCK_EVT_FEAT_PERIODIC and testing. In periodic
  mode I get ~6050 timer interrupts per minute, in
  oneshot mode with NOHZ I get ~3066 timer interrups per
  minute so it seems to be working.
---
 arch/arm/mach-integrator/integrator_ap.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index aa30ab6..e66a8bc 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -360,15 +360,29 @@ static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_devic
 {
 	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
 
-	BUG_ON(mode == CLOCK_EVT_MODE_ONESHOT);
+	/* Disable timer */
+	writel(ctrl, clkevt_base + TIMER_CTRL);
 
-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
-		writel(ctrl, clkevt_base + TIMER_CTRL);
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* Enable the timer and start the periodic tick */
 		writel(timer_reload, clkevt_base + TIMER_LOAD);
 		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* Leave the timer disabled, .set_next_event will enable it */
+		ctrl &= ~TIMER_CTRL_PERIODIC;
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+	default:
+		/* Just leave in disabled state */
+		break;
 	}
 
-	writel(ctrl, clkevt_base + TIMER_CTRL);
 }
 
 static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
@@ -385,7 +399,7 @@ static int clkevt_set_next_event(unsigned long next, struct clock_event_device *
 static struct clock_event_device integrator_clockevent = {
 	.name		= "timer1",
 	.shift		= 34,
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= clkevt_set_mode,
 	.set_next_event	= clkevt_set_next_event,
 	.rating		= 300,
-- 
1.7.6
