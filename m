From: robherring2@gmail.com (Rob Herring)
Date: Sat,  2 Oct 2010 09:34:45 -0500
Subject: [PATCH v2 2/3] ARM: timer-sp: support timer clock freq other than 1MHz
In-Reply-To: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
References: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
Message-ID: <1286030086-25556-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@smooth-stone.com>

The timer-sp code is fixed to 1MHz timer clock. Add clock api
calls to get the timer clock frequency and support for independent
clock frequencies.

Rename timer names for clocksource and clockevent to timer-sp or
the clock connection ID string if provided.

Signed-off-by: Rob Herring <rob.herring@smooth-stone.com>
---
 arch/arm/common/timer-sp.c               |   34 ++++++++++++++++++++++--------
 arch/arm/include/asm/hardware/timer-sp.h |    4 +-
 arch/arm/mach-integrator/integrator_cp.c |    4 +-
 arch/arm/mach-realview/core.c            |    4 +-
 arch/arm/mach-versatile/core.c           |    4 +-
 arch/arm/mach-vexpress/ct-ca9x4.c        |    4 +-
 arch/arm/mach-vexpress/v2m.c             |    4 +-
 7 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 4740313..1062af7 100644
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
@@ -29,9 +31,9 @@
 /*
  * These timers are currently always setup to be clocked at 1MHz.
  */
-#define TIMER_FREQ_KHZ	(1000)
-#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
+#define TIMER_FREQ_HZ	(1000000)
 
+static unsigned long sp804_clksrc_rate = TIMER_FREQ_HZ;
 static void __iomem *clksrc_base;
 
 static cycle_t sp804_read(struct clocksource *cs)
@@ -40,7 +42,6 @@ static cycle_t sp804_read(struct clocksource *cs)
 }
 
 static struct clocksource clocksource_sp804 = {
-	.name		= "timer3",
 	.rating		= 200,
 	.read		= sp804_read,
 	.mask		= CLOCKSOURCE_MASK(32),
@@ -48,12 +49,19 @@ static struct clocksource clocksource_sp804 = {
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
+	if (!IS_ERR(clk))
+		sp804_clksrc_rate = clk_get_rate(clk);
+
 	/* setup timer 0 as free-running clocksource */
 	writel(0, clksrc_base + TIMER_CTRL);
 	writel(0xffffffff, clksrc_base + TIMER_LOAD);
@@ -61,11 +69,12 @@ void __init sp804_clocksource_init(void __iomem *base)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clksrc_base + TIMER_CTRL);
 
-	cs->mult = clocksource_khz2mult(TIMER_FREQ_KHZ, cs->shift);
+	cs->mult = clocksource_khz2mult(sp804_clksrc_rate / 1000, cs->shift);
 	clocksource_register(cs);
 }
 
 
+static unsigned long sp804_clkevt_rate = TIMER_FREQ_HZ;
 static void __iomem *clkevt_base;
 
 /*
@@ -92,7 +101,7 @@ static void sp804_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
+		writel(sp804_clkevt_rate / HZ, clkevt_base + TIMER_LOAD);
 		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 		break;
 
@@ -122,7 +131,6 @@ static int sp804_set_next_event(unsigned long next,
 }
 
 static struct clock_event_device sp804_clockevent = {
-	.name		= "timer0",
 	.shift		= 32,
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= sp804_set_mode,
@@ -138,14 +146,22 @@ static struct irqaction sp804_timer_irq = {
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
+	if (!IS_ERR(clk))
+		sp804_clkevt_rate = clk_get_rate(clk);
+
 	evt->irq = timer_irq;
-	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
+	evt->mult = div_sc(sp804_clkevt_rate / 1000, NSEC_PER_MSEC, evt->shift);
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
index 6c432a0..0b1c14a 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -589,8 +589,8 @@ static void __init intcp_timer_init(void)
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER2_VA_BASE);
-	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1);
+	sp804_clocksource_init(TIMER2_VA_BASE, NULL);
+	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1, NULL);
 }
 
 static struct sys_timer cp_timer = {
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 121c6d6..6051224 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -690,8 +690,8 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer2_va_base + TIMER_CTRL);
 	writel(0, timer3_va_base + TIMER_CTRL);
 
-	sp804_clocksource_init(timer3_va_base);
-	sp804_clockevents_init(timer0_va_base, timer_irq);
+	sp804_clocksource_init(timer3_va_base, NULL);
+	sp804_clockevents_init(timer0_va_base, timer_irq, NULL);
 }
 
 /*
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 6b93bd6..e4d6c01 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -920,8 +920,8 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER3_VA_BASE);
-	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
+	sp804_clocksource_init(TIMER3_VA_BASE, NULL);
+	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, NULL);
 }
 
 struct sys_timer versatile_timer = {
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 685e6ee..48185c2 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -73,8 +73,8 @@ static void ct_ca9x4_timer_init(void)
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1));
-	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
+	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), NULL);
+	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0, NULL);
 }
 
 static struct sys_timer ct_ca9x4_timer = {
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 5bc853d..37ad2a5 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -53,8 +53,8 @@ static void v2m_timer_init(void)
 	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1));
-	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
+	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), NULL);
+	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0, NULL);
 }
 
 struct sys_timer v2m_timer = {
-- 
1.7.0.4
