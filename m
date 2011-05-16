From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:31:16 +0100
Subject: [PATCH 17/19] clockevents: ARM sp804: obtain sp804 timer rate via clks
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1dU-0003EL-9p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows platforms to specify the rate of the SP804 clockevent via
the clk subsystem.  While ARM boards clock these at 1MHz, BCMRing also
has SP804 timers but are clocked at different rates.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/timer-sp.c        |   16 ++++++++--------
 arch/arm/mach-vexpress/ct-ca9x4.c |    4 ++++
 arch/arm/mach-vexpress/v2m.c      |    4 ++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index bf92afe..1707c92 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -28,12 +28,6 @@
 
 #include <asm/hardware/arm_timer.h>
 
-/*
- * These timers are currently always setup to be clocked at 1MHz.
- */
-#define TIMER_FREQ_KHZ	(1000)
-#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
-
 static long __init sp804_get_clock_rate(const char *name)
 {
 	struct clk *clk;
@@ -84,6 +78,7 @@ void __init sp804_clocksource_init(void __iomem *base, const char *name)
 
 
 static void __iomem *clkevt_base;
+static unsigned long clkevt_reload;
 
 /*
  * IRQ handler for the timer
@@ -109,7 +104,7 @@ static void sp804_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
+		writel(clkevt_reload, clkevt_base + TIMER_LOAD);
 		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 		break;
 
@@ -158,12 +153,17 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
+	long rate = sp804_get_clock_rate(name);
+
+	if (rate < 0)
+		return;
 
 	clkevt_base = base;
+	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
 
 	evt->name = name;
 	evt->irq = irq;
-	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
+	evt->mult = div_sc(rate, SEC_PER_MSEC, evt->shift);
 	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
 	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 2712133..2023a9e 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -152,6 +152,10 @@ static struct clk_lookup lookups[] = {
 		.clk		= &osc1_clk,
 	}, {	/* SP804 timers */
 		.dev_id		= "sp804",
+		.con_id		= "ct-timer0",
+		.clk		= &ct_sp804_clk,
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
 		.con_id		= "ct-timer1",
 		.clk		= &ct_sp804_clk,
 	},
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index f6fecdd..9d9d4af 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -370,6 +370,10 @@ static struct clk_lookup v2m_lookups[] = {
 		.clk		= &osc1_clk,
 	}, {	/* SP804 timers */
 		.dev_id		= "sp804",
+		.con_id		= "v2m-timer0",
+		.clk		= &v2m_sp804_clk,
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
 		.con_id		= "v2m-timer1",
 		.clk		= &v2m_sp804_clk,
 	},
-- 
1.7.4.4
