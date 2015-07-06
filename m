From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 16:24:09 +0530
Subject: [PATCH 02/18] ARM/cns3xxx/timer: Migrate to new 'set-state' interface
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <eeca96c0c6f144106b82df3f8b1cf60131c3c1f4.1436178990.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate cns3xxx driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

NOTE: We don't read TIMER1_2_CONTROL_OFFSET register on shutdown
anymore.

Cc: Krzysztof Halasa <khalasa@piap.pl>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-cns3xxx/core.c | 55 +++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 4e9837ded96d..11f9644f8f41 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -113,30 +113,33 @@ void cns3xxx_power_off(void)
  */
 static void __iomem *cns3xxx_tmr1;
 
-static void cns3xxx_timer_set_mode(enum clock_event_mode mode,
-				   struct clock_event_device *clk)
+static int cns3xxx_shutdown(struct clock_event_device *clk)
+{
+	writel(0, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
+	return 0;
+}
+
+static int cns3xxx_set_oneshot(struct clock_event_device *clk)
+{
+	unsigned long ctrl = readl(cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
+
+	/* period set, and timer enabled in 'next_event' hook */
+	ctrl |= (1 << 2) | (1 << 9);
+	writel(ctrl, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
+	return 0;
+}
+
+static int cns3xxx_set_periodic(struct clock_event_device *clk)
 {
 	unsigned long ctrl = readl(cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
 	int pclk = cns3xxx_cpu_clock() / 8;
 	int reload;
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		reload = pclk * 20 / (3 * HZ) * 0x25000;
-		writel(reload, cns3xxx_tmr1 + TIMER1_AUTO_RELOAD_OFFSET);
-		ctrl |= (1 << 0) | (1 << 2) | (1 << 9);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl |= (1 << 2) | (1 << 9);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		ctrl = 0;
-	}
-
+	reload = pclk * 20 / (3 * HZ) * 0x25000;
+	writel(reload, cns3xxx_tmr1 + TIMER1_AUTO_RELOAD_OFFSET);
+	ctrl |= (1 << 0) | (1 << 2) | (1 << 9);
 	writel(ctrl, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
+	return 0;
 }
 
 static int cns3xxx_timer_set_next_event(unsigned long evt,
@@ -151,12 +154,16 @@ static int cns3xxx_timer_set_next_event(unsigned long evt,
 }
 
 static struct clock_event_device cns3xxx_tmr1_clockevent = {
-	.name		= "cns3xxx timer1",
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= cns3xxx_timer_set_mode,
-	.set_next_event	= cns3xxx_timer_set_next_event,
-	.rating		= 350,
-	.cpumask	= cpu_all_mask,
+	.name			= "cns3xxx timer1",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= cns3xxx_shutdown,
+	.set_state_periodic	= cns3xxx_set_periodic,
+	.set_state_oneshot	= cns3xxx_set_oneshot,
+	.tick_resume		= cns3xxx_shutdown,
+	.set_next_event		= cns3xxx_timer_set_next_event,
+	.rating			= 350,
+	.cpumask		= cpu_all_mask,
 };
 
 static void __init cns3xxx_clockevents_init(unsigned int timer_irq)
-- 
2.4.0
