From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:32:01 -0600
Subject: [PATCH 5/7] ARM: timer-sp: support timer clock freq other than 1MHz
In-Reply-To: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
Message-ID: <1294875123-14086-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The timer-sp code is fixed to 1MHz timer clock. Add clock api
calls to get the timer clock frequency and support for independent
clock frequencies.

Rename timer names for clocksource and clockevent to timer-sp or
the clock connection ID string if provided.

Compile tested on integrator, realview, versatile, and vexpress. Boot
tested on vexpress.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/common/timer-sp.c               |   43 +++++++++++++++++++++---------
 arch/arm/include/asm/hardware/timer-sp.h |    4 +-
 arch/arm/mach-integrator/integrator_cp.c |    4 +-
 arch/arm/mach-realview/core.c            |    4 +-
 arch/arm/mach-versatile/core.c           |    4 +-
 arch/arm/mach-vexpress/v2m.c             |    4 +-
 6 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 6ef3342..c5572d0 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -18,6 +18,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -26,12 +28,7 @@
 
 #include <asm/hardware/arm_timer.h>
 
-/*
- * These timers are currently always setup to be clocked at 1MHz.
- */
-#define TIMER_FREQ_KHZ	(1000)
-#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
-
+static unsigned long sp804_clksrc_rate;
 static void __iomem *clksrc_base;
 
 static cycle_t sp804_read(struct clocksource *cs)
@@ -40,19 +37,28 @@ static cycle_t sp804_read(struct clocksource *cs)
 }
 
 static struct clocksource clocksource_sp804 = {
-	.name		= "timer3",
 	.rating		= 200,
 	.read		= sp804_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-void __init sp804_clocksource_init(void __iomem *base)
+void __init sp804_clocksource_init(void __iomem *base, char *clk_id)
 {
+	struct clk *clk;
 	struct clocksource *cs = &clocksource_sp804;
 
+	cs->name = clk_id ? clk_id : "timer-sp";
+
 	clksrc_base = base;
 
+	clk = clk_get_sys("sp804", clk_id);
+	if (IS_ERR(clk) || clk_enable(clk))
+		panic("sp804 clksrc: cannot get clock\n");
+
+	clk_enable(clk);
+	sp804_clksrc_rate = clk_get_rate(clk);
+
 	/* setup timer 0 as free-running clocksource */
 	writel(0, clksrc_base + TIMER_CTRL);
 	writel(0xffffffff, clksrc_base + TIMER_LOAD);
@@ -60,10 +66,11 @@ void __init sp804_clocksource_init(void __iomem *base)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clksrc_base + TIMER_CTRL);
 
-	clocksource_register_khz(cs, TIMER_FREQ_KHZ);
+	clocksource_register_hz(cs, sp804_clksrc_rate);
 }
 
 
+static unsigned long sp804_clkevt_rate;
 static void __iomem *clkevt_base;
 
 /*
@@ -90,7 +97,7 @@ static void sp804_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
+		writel(sp804_clkevt_rate / HZ, clkevt_base + TIMER_LOAD);
 		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 		break;
 
@@ -120,7 +127,6 @@ static int sp804_set_next_event(unsigned long next,
 }
 
 static struct clock_event_device sp804_clockevent = {
-	.name		= "timer0",
 	.shift		= 32,
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= sp804_set_mode,
@@ -136,14 +142,25 @@ static struct irqaction sp804_timer_irq = {
 	.dev_id		= &sp804_clockevent,
 };
 
-void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq)
+void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq,
+				   char *clk_id)
 {
+	struct clk *clk;
 	struct clock_event_device *evt = &sp804_clockevent;
 
+	evt->name = clk_id ? clk_id : "timer-sp";
+
 	clkevt_base = base;
 
+	clk = clk_get_sys("sp804", clk_id);
+	if (IS_ERR(clk) || clk_enable(clk))
+		panic("sp804 clkevt: cannot get clock\n");
+
+	clk_enable(clk);
+	sp804_clkevt_rate = clk_get_rate(clk);
+
 	evt->irq = timer_irq;
-	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
+	evt->mult = div_sc(sp804_clkevt_rate, NSEC_PER_SEC, evt->shift);
 	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
 	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
 
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index 21e75e3..dc31cb0 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -1,2 +1,2 @@
-void sp804_clocksource_init(void __iomem *);
-void sp804_clockevents_init(void __iomem *, unsigned int);
+void sp804_clocksource_init(void __iomem *, char *);
+void sp804_clockevents_init(void __iomem *, unsigned int, char *);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index d99a880..10ba4f0 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -598,8 +598,8 @@ static void __init intcp_timer_init(void)
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER2_VA_BASE);
-	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1);
+	sp804_clocksource_init(TIMER2_VA_BASE, NULL);
+	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1, NULL);
 }
 
 static struct sys_timer cp_timer = {
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 16b8a81..1a9d0f9 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -702,8 +702,8 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer2_va_base + TIMER_CTRL);
 	writel(0, timer3_va_base + TIMER_CTRL);
 
-	sp804_clocksource_init(timer3_va_base);
-	sp804_clockevents_init(timer0_va_base, timer_irq);
+	sp804_clocksource_init(timer3_va_base, NULL);
+	sp804_clockevents_init(timer0_va_base, timer_irq, NULL);
 }
 
 /*
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 399e2ef..b0685ad 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -939,8 +939,8 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER3_VA_BASE);
-	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
+	sp804_clocksource_init(TIMER3_VA_BASE, NULL);
+	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, NULL);
 }
 
 struct sys_timer versatile_timer = {
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index e371d99..8bb28b9 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -55,8 +55,8 @@ static void __init v2m_timer_init(void)
 	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1));
-	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
+	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), NULL);
+	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0, NULL);
 }
 
 struct sys_timer v2m_timer = {
-- 
1.7.1
