From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: move 16-bit timer support to
	Integrator/AP
References: <git-1267729916-d812bfe0155031706019561409a54500168b6caf@rmk-PC>
Message-ID: <git-1267729916-5a852a86ebb11b488b619f8386b6df6332c730de@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Only Integrator/AP has 16-bit timers, so move the support into the
Integrator/AP specific support files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/common.h        |    1 -
 arch/arm/mach-integrator/core.c          |  157 -----------------------------
 arch/arm/mach-integrator/integrator_ap.c |  158 +++++++++++++++++++++++++++++-
 arch/arm/mach-integrator/integrator_cp.c |    2 -
 4 files changed, 155 insertions(+), 163 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/common.h

diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
deleted file mode 100644
index cdbe710..0000000
--- a/arch/arm/mach-integrator/common.h
+++ /dev/null
@@ -1 +0,0 @@
-extern void integrator_time_init(u32, unsigned int);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index ac2b0c5..b02cfc0 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -19,8 +19,6 @@
 #include <linux/termios.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
 #include <linux/io.h>
 
 #include <asm/clkdev.h>
@@ -28,14 +26,11 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <mach/cm.h>
 #include <asm/system.h>
 #include <asm/leds.h>
 #include <asm/mach/time.h>
 
-#include "common.h"
-
 static struct amba_pl010_data integrator_uart_data;
 
 static struct amba_device rtc_device = {
@@ -220,155 +215,3 @@ void cm_control(u32 mask, u32 set)
 }
 
 EXPORT_SYMBOL(cm_control);
-
-/*
- * Where is the timer (VA)?
- */
-#define TIMER0_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER0_BASE)
-#define TIMER1_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER1_BASE)
-#define TIMER2_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER2_BASE)
-
-/*
- * How long is the timer interval?
- */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >= 0x100000
-#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
-#elif TIMER_INTERVAL >= 0x10000
-#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
-#else
-#define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
-#endif
-
-static unsigned long timer_reload;
-
-static void __iomem * const clksrc_base = (void __iomem *)TIMER2_VA_BASE;
-
-static cycle_t timersp_read(struct clocksource *cs)
-{
-	return ~(readl(clksrc_base + TIMER_VALUE) & 0xffff);
-}
-
-static struct clocksource clocksource_timersp = {
-	.name		= "timer2",
-	.rating		= 200,
-	.read		= timersp_read,
-	.mask		= CLOCKSOURCE_MASK(16),
-	.shift		= 16,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static void integrator_clocksource_init(u32 khz)
-{
-	struct clocksource *cs = &clocksource_timersp;
-	void __iomem *base = clksrc_base;
-	u32 ctrl = TIMER_CTRL_ENABLE;
-
-	if (khz >= 1500) {
-		khz /= 16;
-		ctrl = TIMER_CTRL_DIV16;
-	}
-
-	writel(ctrl, base + TIMER_CTRL);
-	writel(0xffff, base + TIMER_LOAD);
-
-	cs->mult = clocksource_khz2mult(khz, cs->shift);
-	clocksource_register(cs);
-}
-
-static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t integrator_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
-{
-	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
-
-	BUG_ON(mode == CLOCK_EVT_MODE_ONESHOT);
-
-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
-		writel(ctrl, clkevt_base + TIMER_CTRL);
-		writel(timer_reload, clkevt_base + TIMER_LOAD);
-		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
-	}
-
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-}
-
-static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
-{
-	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
-
-	writel(ctrl & ~TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
-
-	return 0;
-}
-
-static struct clock_event_device integrator_clockevent = {
-	.name		= "timer1",
-	.shift		= 34,
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.set_mode	= clkevt_set_mode,
-	.set_next_event	= clkevt_set_next_event,
-	.rating		= 300,
-	.cpumask	= cpu_all_mask,
-};
-
-static struct irqaction integrator_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= integrator_timer_interrupt,
-	.dev_id		= &integrator_clockevent,
-};
-
-static void integrator_clockevent_init(u32 khz, unsigned int ctrl)
-{
-	struct clock_event_device *evt = &integrator_clockevent;
-
-	if (khz * 1000 > 0x100000 * HZ) {
-		khz /= 256;
-		ctrl |= TIMER_CTRL_DIV256;
-	} else if (khz * 1000 > 0x10000 * HZ) {
-		khz /= 16;
-		ctrl |= TIMER_CTRL_DIV16;
-	}
-
-	timer_reload = khz * 1000 / HZ;
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-
-	evt->irq = IRQ_TIMERINT1;
-	evt->mult = div_sc(khz, NSEC_PER_MSEC, evt->shift);
-	evt->max_delta_ns = clockevent_delta2ns(0xffff, evt);
-	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
-
-	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
-	clockevents_register_device(evt);
-}
-
-/*
- * Set up timer(s).
- */
-void __init integrator_time_init(u32 khz, unsigned int ctrl)
-{
-	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
-
-	integrator_clocksource_init(khz);
-	integrator_clockevent_init(khz, ctrl);
-}
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index c89b231..227cf4d 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -27,10 +27,14 @@
 #include <linux/sysdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
+#include <asm/hardware/arm_timer.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
@@ -44,8 +48,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include "common.h"
-
 /* 
  * All IO addresses are mapped onto VA 0xFFFx.xxxx, where x.xxxx
  * is the (PA >> 12).
@@ -335,9 +337,159 @@ static void __init ap_init(void)
 	}
 }
 
+/*
+ * Where is the timer (VA)?
+ */
+#define TIMER0_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER0_BASE)
+#define TIMER1_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER1_BASE)
+#define TIMER2_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER2_BASE)
+
+/*
+ * How long is the timer interval?
+ */
+#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
+#if TIMER_INTERVAL >= 0x100000
+#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
+#elif TIMER_INTERVAL >= 0x10000
+#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
+#else
+#define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
+#endif
+
+static unsigned long timer_reload;
+
+static void __iomem * const clksrc_base = (void __iomem *)TIMER2_VA_BASE;
+
+static cycle_t timersp_read(struct clocksource *cs)
+{
+	return ~(readl(clksrc_base + TIMER_VALUE) & 0xffff);
+}
+
+static struct clocksource clocksource_timersp = {
+	.name		= "timer2",
+	.rating		= 200,
+	.read		= timersp_read,
+	.mask		= CLOCKSOURCE_MASK(16),
+	.shift		= 16,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void integrator_clocksource_init(u32 khz)
+{
+	struct clocksource *cs = &clocksource_timersp;
+	void __iomem *base = clksrc_base;
+	u32 ctrl = TIMER_CTRL_ENABLE;
+
+	if (khz >= 1500) {
+		khz /= 16;
+		ctrl = TIMER_CTRL_DIV16;
+	}
+
+	writel(ctrl, base + TIMER_CTRL);
+	writel(0xffff, base + TIMER_LOAD);
+
+	cs->mult = clocksource_khz2mult(khz, cs->shift);
+	clocksource_register(cs);
+}
+
+static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t integrator_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/* clear the interrupt */
+	writel(1, clkevt_base + TIMER_INTCLR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
+
+	BUG_ON(mode == CLOCK_EVT_MODE_ONESHOT);
+
+	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		writel(timer_reload, clkevt_base + TIMER_LOAD);
+		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+	}
+
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+}
+
+static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
+{
+	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
+
+	writel(ctrl & ~TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+	writel(next, clkevt_base + TIMER_LOAD);
+	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+
+	return 0;
+}
+
+static struct clock_event_device integrator_clockevent = {
+	.name		= "timer1",
+	.shift		= 34,
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.set_mode	= clkevt_set_mode,
+	.set_next_event	= clkevt_set_next_event,
+	.rating		= 300,
+	.cpumask	= cpu_all_mask,
+};
+
+static struct irqaction integrator_timer_irq = {
+	.name		= "timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= integrator_timer_interrupt,
+	.dev_id		= &integrator_clockevent,
+};
+
+static void integrator_clockevent_init(u32 khz)
+{
+	struct clock_event_device *evt = &integrator_clockevent;
+	unsigned int ctrl = 0;
+
+	if (khz * 1000 > 0x100000 * HZ) {
+		khz /= 256;
+		ctrl |= TIMER_CTRL_DIV256;
+	} else if (khz * 1000 > 0x10000 * HZ) {
+		khz /= 16;
+		ctrl |= TIMER_CTRL_DIV16;
+	}
+
+	timer_reload = khz * 1000 / HZ;
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+
+	evt->irq = IRQ_TIMERINT1;
+	evt->mult = div_sc(khz, NSEC_PER_MSEC, evt->shift);
+	evt->max_delta_ns = clockevent_delta2ns(0xffff, evt);
+	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
+
+	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
+	clockevents_register_device(evt);
+}
+
+/*
+ * Set up timer(s).
+ */
 static void __init ap_init_timer(void)
 {
-	integrator_time_init(TICKS_PER_uSEC * 1000, 0);
+	u32 khz = TICKS_PER_uSEC * 1000;
+
+	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
+	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
+	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
+
+	integrator_clocksource_init(khz);
+	integrator_clockevent_init(khz);
 }
 
 static struct sys_timer ap_timer = {
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index a7575c4..5a5a8c1 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -43,8 +43,6 @@
 
 #include <plat/timer-sp.h>
 
-#include "common.h"
-
 #define INTCP_PA_FLASH_BASE		0x24000000
 #define INTCP_FLASH_SIZE		SZ_32M
 
