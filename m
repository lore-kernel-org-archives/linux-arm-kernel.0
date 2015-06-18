From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:29 +0530
Subject: [PATCH 15/41] clocksource: nomadik-mtu: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <34bfbe2960c02dfc6ed20fd4ac72bdb755ed2444.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate nomadik-mtu driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/nomadik-mtu.c | 58 ++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index a709cfa49d85..bc8dd443c727 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -119,28 +119,27 @@ static void nmdk_clkevt_reset(void)
 	}
 }
 
-static void nmdk_clkevt_mode(enum clock_event_mode mode,
-			     struct clock_event_device *dev)
+static int nmdk_clkevt_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		clkevt_periodic = true;
-		nmdk_clkevt_reset();
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		clkevt_periodic = false;
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		writel(0, mtu_base + MTU_IMSC);
-		/* disable timer */
-		writel(0, mtu_base + MTU_CR(1));
-		/* load some high default value */
-		writel(0xffffffff, mtu_base + MTU_LR(1));
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	writel(0, mtu_base + MTU_IMSC);
+	/* disable timer */
+	writel(0, mtu_base + MTU_CR(1));
+	/* load some high default value */
+	writel(0xffffffff, mtu_base + MTU_LR(1));
+	return 0;
+}
+
+static int nmdk_clkevt_set_oneshot(struct clock_event_device *evt)
+{
+	clkevt_periodic = false;
+	return 0;
+}
+
+static int nmdk_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	clkevt_periodic = true;
+	nmdk_clkevt_reset();
+	return 0;
 }
 
 static void nmdk_clksrc_reset(void)
@@ -163,13 +162,16 @@ static void nmdk_clkevt_resume(struct clock_event_device *cedev)
 }
 
 static struct clock_event_device nmdk_clkevt = {
-	.name		= "mtu_1",
-	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC |
-	                  CLOCK_EVT_FEAT_DYNIRQ,
-	.rating		= 200,
-	.set_mode	= nmdk_clkevt_mode,
-	.set_next_event	= nmdk_clkevt_next,
-	.resume		= nmdk_clkevt_resume,
+	.name			= "mtu_1",
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_DYNIRQ,
+	.rating			= 200,
+	.set_state_shutdown	= nmdk_clkevt_shutdown,
+	.set_state_periodic	= nmdk_clkevt_set_periodic,
+	.set_state_oneshot	= nmdk_clkevt_set_oneshot,
+	.set_next_event		= nmdk_clkevt_next,
+	.resume			= nmdk_clkevt_resume,
 };
 
 /*
-- 
2.4.0
