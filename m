From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 21:56:23 +0200
Subject: [PATCHv2 5/8] clocksource: sun4i: Factor out some timer code
In-Reply-To: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1372449386-1334-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The set_next_event and set_mode callbacks share a lot of common code we
can easily factor to avoid duplication and mistakes.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 48 ++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 695c8c8..6ef10d9 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -37,24 +37,46 @@
 
 static void __iomem *timer_base;
 
+static void sun4i_clkevt_time_stop(u8 timer)
+{
+	u32 val = readl(timer_base + TIMER_CTL_REG(timer));
+	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(timer));
+	udelay(1);
+}
+
+static void sun4i_clkevt_time_setup(u8 timer, unsigned long delay)
+{
+	writel(delay, timer_base + TIMER_INTVAL_REG(timer));
+}
+
+static void sun4i_clkevt_time_start(u8 timer, bool periodic)
+{
+	u32 val = readl(timer_base + TIMER_CTL_REG(timer));
+
+	if (periodic)
+		val &= ~TIMER_CTL_ONESHOT;
+	else
+		val |= TIMER_CTL_ONESHOT;
+
+	writel(val | TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(timer));
+}
+
 static void sun4i_clkevt_mode(enum clock_event_mode mode,
 			      struct clock_event_device *clk)
 {
-	u32 u = readl(timer_base + TIMER_CTL_REG(0));
-
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		u &= ~(TIMER_CTL_ONESHOT);
-		writel(u | TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
+		sun4i_clkevt_time_stop(0);
+		sun4i_clkevt_time_start(0, true);
 		break;
-
 	case CLOCK_EVT_MODE_ONESHOT:
-		writel(u | TIMER_CTL_ONESHOT, timer_base + TIMER_CTL_REG(0));
+		sun4i_clkevt_time_stop(0);
+		sun4i_clkevt_time_start(0, false);
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	default:
-		writel(u & ~(TIMER_CTL_ENABLE), timer_base + TIMER_CTL_REG(0));
+		sun4i_clkevt_time_stop(0);
 		break;
 	}
 }
@@ -62,15 +84,9 @@ static void sun4i_clkevt_mode(enum clock_event_mode mode,
 static int sun4i_clkevt_next_event(unsigned long evt,
 				   struct clock_event_device *unused)
 {
-	u32 val = readl(timer_base + TIMER_CTL_REG(0));
-	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
-	udelay(1);
-
-	writel(evt, timer_base + TIMER_INTVAL_REG(0));
-
-	val = readl(timer_base + TIMER_CTL_REG(0));
-	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
-	       timer_base + TIMER_CTL_REG(0));
+	sun4i_clkevt_time_stop(0);
+	sun4i_clkevt_time_setup(0, evt);
+	sun4i_clkevt_time_start(0, false);
 
 	return 0;
 }
-- 
1.8.3.1
