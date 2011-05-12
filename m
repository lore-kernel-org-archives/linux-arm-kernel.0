From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 May 2011 13:47:10 +0100
Subject: [PATCH 08/13 v2] clocksource: convert ARM 32-bit down counting
	clocksources
In-Reply-To: <E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
Message-ID: <20110512124710.GE1356@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert SP804, MXC, Nomadik and Orion 32-bit down-counting clocksources
to generic mmio clocksource infrastructure.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

This is v2 of this patch, which adds Catalin to the Cc for timer-sp.c
as ARM platforms are impacted by this change, and fixes a build problem
with timer-sp.c.

 arch/arm/Kconfig              |    2 ++
 arch/arm/common/timer-sp.c    |   30 ++++++------------------------
 arch/arm/plat-mxc/epit.c      |   18 ++----------------
 arch/arm/plat-nomadik/Kconfig |    1 +
 arch/arm/plat-nomadik/timer.c |   31 +++----------------------------
 arch/arm/plat-orion/time.c    |   21 ++-------------------
 6 files changed, 16 insertions(+), 87 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9aa5514..0a05a57 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1042,6 +1042,7 @@ config PLAT_IOP
 
 config PLAT_ORION
 	bool
+	select CLKSRC_MMIO
 	select HAVE_SCHED_CLOCK
 
 config PLAT_PXA
@@ -1052,6 +1053,7 @@ config PLAT_VERSATILE
 
 config ARM_TIMER_SP804
 	bool
+	select CLKSRC_MMIO
 
 source arch/arm/mm/Kconfig
 
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 6ef3342..445b05e 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -32,35 +32,17 @@
 #define TIMER_FREQ_KHZ	(1000)
 #define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
 
-static void __iomem *clksrc_base;
-
-static cycle_t sp804_read(struct clocksource *cs)
-{
-	return ~readl(clksrc_base + TIMER_VALUE);
-}
-
-static struct clocksource clocksource_sp804 = {
-	.name		= "timer3",
-	.rating		= 200,
-	.read		= sp804_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 void __init sp804_clocksource_init(void __iomem *base)
 {
-	struct clocksource *cs = &clocksource_sp804;
-
-	clksrc_base = base;
-
 	/* setup timer 0 as free-running clocksource */
-	writel(0, clksrc_base + TIMER_CTRL);
-	writel(0xffffffff, clksrc_base + TIMER_LOAD);
-	writel(0xffffffff, clksrc_base + TIMER_VALUE);
+	writel(0, base + TIMER_CTRL);
+	writel(0xffffffff, base + TIMER_LOAD);
+	writel(0xffffffff, base + TIMER_VALUE);
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		clksrc_base + TIMER_CTRL);
+		base + TIMER_CTRL);
 
-	clocksource_register_khz(cs, TIMER_FREQ_KHZ);
+	clocksource_mmio_init(base + TIMER_VALUE, "timer3",
+		TIMER_FREQ_KHZ * 1000, 200, 32, clocksource_mmio_readl_down);
 }
 
 
diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/plat-mxc/epit.c
index d69d343..d3467f8 100644
--- a/arch/arm/plat-mxc/epit.c
+++ b/arch/arm/plat-mxc/epit.c
@@ -83,26 +83,12 @@ static void epit_irq_acknowledge(void)
 	__raw_writel(EPITSR_OCIF, timer_base + EPITSR);
 }
 
-static cycle_t epit_read(struct clocksource *cs)
-{
-	return 0 - __raw_readl(timer_base + EPITCNR);
-}
-
-static struct clocksource clocksource_epit = {
-	.name		= "epit",
-	.rating		= 200,
-	.read		= epit_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static int __init epit_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	clocksource_register_hz(&clocksource_epit, c);
-
-	return 0;
+	return clocksource_mmio_init(timer_base + EPITCNR, "epit", c, 200, 32,
+			clocksource_mmio_readl_down);
 }
 
 /* clock event */
diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index 187f4e8..18296ee 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -5,6 +5,7 @@
 config PLAT_NOMADIK
 	bool
 	depends on ARCH_NOMADIK || ARCH_U8500
+	select CLKSRC_MMIO
 	default y
 	help
 	  Common platform code for Nomadik and other ST-Ericsson
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 4172340..ef74e15 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -26,29 +26,6 @@
 void __iomem *mtu_base; /* Assigned by machine code */
 
 /*
- * Kernel assumes that sched_clock can be called early
- * but the MTU may not yet be initialized.
- */
-static cycle_t nmdk_read_timer_dummy(struct clocksource *cs)
-{
-	return 0;
-}
-
-/* clocksource: MTU decrements, so we negate the value being read. */
-static cycle_t nmdk_read_timer(struct clocksource *cs)
-{
-	return -readl(mtu_base + MTU_VAL(0));
-}
-
-static struct clocksource nmdk_clksrc = {
-	.name		= "mtu_0",
-	.rating		= 200,
-	.read		= nmdk_read_timer_dummy,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-/*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
  * better resolution when scheduling the kernel.
@@ -172,12 +149,10 @@ void __init nmdk_timer_init(void)
 	writel(0, mtu_base + MTU_BGLR(0));
 	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
 
-	/* Now the clock source is ready */
-	nmdk_clksrc.read = nmdk_read_timer;
-
-	if (clocksource_register_hz(&nmdk_clksrc, rate))
+	if (clocksource_mmio_init(mtu_base + MTU_VAL(0), "mtu_0",
+			rate, 200, 32, clocksource_mmio_readl_down))
 		pr_err("timer: failed to initialize clock source %s\n",
-		       nmdk_clksrc.name);
+		       "mtu_0");
 
 	init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
 
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 742b032..69a6136 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -81,24 +81,6 @@ static void __init setup_sched_clock(unsigned long tclk)
 }
 
 /*
- * Clocksource handling.
- */
-static cycle_t orion_clksrc_read(struct clocksource *cs)
-{
-	return 0xffffffff - readl(timer_base + TIMER0_VAL_OFF);
-}
-
-static struct clocksource orion_clksrc = {
-	.name		= "orion_clocksource",
-	.rating		= 300,
-	.read		= orion_clksrc_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-
-
-/*
  * Clockevent handling.
  */
 static int
@@ -247,7 +229,8 @@ orion_time_init(u32 _bridge_base, u32 _bridge_timer1_clr_mask,
 	writel(u & ~BRIDGE_INT_TIMER0, bridge_base + BRIDGE_MASK_OFF);
 	u = readl(timer_base + TIMER_CTRL_OFF);
 	writel(u | TIMER0_EN | TIMER0_RELOAD_EN, timer_base + TIMER_CTRL_OFF);
-	clocksource_register_hz(&orion_clksrc, tclk);
+	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF, "orion_clocksource",
+		tclk, 300, 32, clocksource_mmio_readl_down);
 
 	/*
 	 * Setup clockevent timer (interrupt-driven).
-- 
1.7.4.4
