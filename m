From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:41:10 +0530
Subject: [PATCH 16/18] ARM/w90x900/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <6c724d4388997588f38587213ce1ab7d3925b87c.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate w90x900 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-w90x900/time.c | 51 ++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index 9230d3725599..cd1966ec9143 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -48,31 +48,32 @@
 
 static unsigned int timer0_load;
 
-static void nuc900_clockevent_setmode(enum clock_event_mode mode,
-		struct clock_event_device *clk)
+static int nuc900_clockevent_shutdown(struct clock_event_device *evt)
 {
-	unsigned int val;
+	unsigned int val = __raw_readl(REG_TCSR0) & ~(0x03 << 27);
 
-	val = __raw_readl(REG_TCSR0);
-	val &= ~(0x03 << 27);
+	__raw_writel(val, REG_TCSR0);
+	return 0;
+}
+
+static int nuc900_clockevent_set_oneshot(struct clock_event_device *evt)
+{
+	unsigned int val = __raw_readl(REG_TCSR0) & ~(0x03 << 27);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		__raw_writel(timer0_load, REG_TICR0);
-		val |= (PERIOD | COUNTEN | INTEN | PRESCALE);
-		break;
+	val |= (ONESHOT | COUNTEN | INTEN | PRESCALE);
 
-	case CLOCK_EVT_MODE_ONESHOT:
-		val |= (ONESHOT | COUNTEN | INTEN | PRESCALE);
-		break;
+	__raw_writel(val, REG_TCSR0);
+	return 0;
+}
 
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+static int nuc900_clockevent_set_periodic(struct clock_event_device *evt)
+{
+	unsigned int val = __raw_readl(REG_TCSR0) & ~(0x03 << 27);
 
+	__raw_writel(timer0_load, REG_TICR0);
+	val |= (PERIOD | COUNTEN | INTEN | PRESCALE);
 	__raw_writel(val, REG_TCSR0);
+	return 0;
 }
 
 static int nuc900_clockevent_setnextevent(unsigned long evt,
@@ -90,11 +91,15 @@ static int nuc900_clockevent_setnextevent(unsigned long evt,
 }
 
 static struct clock_event_device nuc900_clockevent_device = {
-	.name		= "nuc900-timer0",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= nuc900_clockevent_setmode,
-	.set_next_event	= nuc900_clockevent_setnextevent,
-	.rating		= 300,
+	.name			= "nuc900-timer0",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= nuc900_clockevent_shutdown,
+	.set_state_periodic	= nuc900_clockevent_set_periodic,
+	.set_state_oneshot	= nuc900_clockevent_set_oneshot,
+	.tick_resume		= nuc900_clockevent_shutdown,
+	.set_next_event		= nuc900_clockevent_setnextevent,
+	.rating			= 300,
 };
 
 /*IRQ handler for the timer*/
-- 
2.4.0
