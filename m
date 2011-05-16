From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:30:56 +0100
Subject: [PATCH 16/19] clockevents: ARM sp804: allow clockevent name to be
	specified
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1dA-0003EH-61@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows platforms to specify the clcokevent name upon registration.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/timer-sp.c               |    7 ++++---
 arch/arm/include/asm/hardware/timer-sp.h |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 arch/arm/mach-realview/core.c            |    2 +-
 arch/arm/mach-versatile/core.c           |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c        |    3 ++-
 arch/arm/mach-vexpress/v2m.c             |    3 ++-
 7 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 45a5eb8..bf92afe 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -139,7 +139,6 @@ static int sp804_set_next_event(unsigned long next,
 }
 
 static struct clock_event_device sp804_clockevent = {
-	.name		= "timer0",
 	.shift		= 32,
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= sp804_set_mode,
@@ -155,13 +154,15 @@ static struct irqaction sp804_timer_irq = {
 	.dev_id		= &sp804_clockevent,
 };
 
-void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq)
+void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+	const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 
 	clkevt_base = base;
 
-	evt->irq = timer_irq;
+	evt->name = name;
+	evt->irq = irq;
 	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
 	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
 	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index 11c386b..4384d81 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -1,2 +1,2 @@
 void sp804_clocksource_init(void __iomem *, const char *);
-void sp804_clockevents_init(void __iomem *, unsigned int);
+void sp804_clockevents_init(void __iomem *, unsigned int, const char *);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 8fb8afb..c4914c6 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -484,7 +484,7 @@ static void __init intcp_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
 	sp804_clocksource_init(TIMER2_VA_BASE, "timer2");
-	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1);
+	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1, "timer1");
 }
 
 static struct sys_timer cp_timer = {
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 6a9cd1e..9f51555 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -553,7 +553,7 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer3_va_base + TIMER_CTRL);
 
 	sp804_clocksource_init(timer3_va_base, "timer3");
-	sp804_clockevents_init(timer0_va_base, timer_irq);
+	sp804_clockevents_init(timer0_va_base, timer_irq, "timer0");
 }
 
 /*
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index b0b7de6..4e78c37 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -772,7 +772,7 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
 	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
-	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
+	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, "timer0");
 }
 
 struct sys_timer versatile_timer = {
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6004f06..2712133 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -72,7 +72,8 @@ static void __init ct_ca9x4_timer_init(void)
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
 	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), "ct-timer1");
-	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
+	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0,
+		"ct-timer0");
 }
 
 static struct sys_timer ct_ca9x4_timer = {
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 77d5db3..f6fecdd 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -66,7 +66,8 @@ static void __init v2m_timer_init(void)
 	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
 
 	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), "v2m-timer1");
-	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
+	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0,
+		"v2m-timer0");
 }
 
 static struct sys_timer v2m_timer = {
-- 
1.7.4.4
