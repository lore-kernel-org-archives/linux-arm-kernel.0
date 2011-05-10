From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 08:29:38 +0100
Subject: [PATCH 07/13] clocksource: convert ARM 32-bit up counting clocksources
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Message-ID: <E1QJhNy-0000yl-V0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ixp4xx, lpc32xx, mxc, netx, pxa, sa1100, tcc8k, tegra and u300
to use the generic mmio clocksource recently introduced.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig              |    9 +++++++++
 arch/arm/mach-ixp4xx/common.c |   16 ++--------------
 arch/arm/mach-lpc32xx/timer.c |   17 +++--------------
 arch/arm/mach-netx/time.c     |   16 ++--------------
 arch/arm/mach-pxa/time.c      |   17 ++---------------
 arch/arm/mach-sa1100/time.c   |   16 ++--------------
 arch/arm/mach-tcc8k/time.c    |   16 ++--------------
 arch/arm/mach-tegra/timer.c   |   16 ++--------------
 arch/arm/mach-u300/timer.c    |   18 +++---------------
 arch/arm/plat-mxc/time.c      |   38 +++++++-------------------------------
 10 files changed, 34 insertions(+), 145 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..9aa5514 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -366,6 +366,7 @@ config ARCH_MXC
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select HAVE_SCHED_CLOCK
 	help
 	  Support for Freescale MXC/iMX-based family of processors
@@ -390,6 +391,7 @@ config ARCH_STMP3XXX
 
 config ARCH_NETX
 	bool "Hilscher NetX based"
+	select CLKSRC_MMIO
 	select CPU_ARM926T
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
@@ -457,6 +459,7 @@ config ARCH_IXP2000
 config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	depends on MMU
+	select CLKSRC_MMIO
 	select CPU_XSCALE
 	select GENERIC_GPIO
 	select GENERIC_CLOCKEVENTS
@@ -497,6 +500,7 @@ config ARCH_LOKI
 
 config ARCH_LPC32XX
 	bool "NXP LPC32XX"
+	select CLKSRC_MMIO
 	select CPU_ARM926T
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_IDE
@@ -592,6 +596,7 @@ config ARCH_NUC93X
 config ARCH_TEGRA
 	bool "NVIDIA Tegra"
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
@@ -617,6 +622,7 @@ config ARCH_PXA
 	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
@@ -667,6 +673,7 @@ config ARCH_RPC
 
 config ARCH_SA1100
 	bool "SA1100-based"
+	select CLKSRC_MMIO
 	select CPU_SA1100
 	select ISA
 	select ARCH_SPARSEMEM_ENABLE
@@ -803,6 +810,7 @@ config ARCH_SHARK
 
 config ARCH_TCC_926
 	bool "Telechips TCC ARM926-based systems"
+	select CLKSRC_MMIO
 	select CPU_ARM926T
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
@@ -813,6 +821,7 @@ config ARCH_TCC_926
 config ARCH_U300
 	bool "ST-Ericsson U300 Series"
 	depends on MMU
+	select CLKSRC_MMIO
 	select CPU_ARM926T
 	select HAVE_SCHED_CLOCK
 	select HAVE_TCM
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index ed19bc3..74ed81a 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -419,26 +419,14 @@ static void notrace ixp4xx_update_sched_clock(void)
 /*
  * clocksource
  */
-static cycle_t ixp4xx_get_cycles(struct clocksource *cs)
-{
-	return *IXP4XX_OSTS;
-}
-
-static struct clocksource clocksource_ixp4xx = {
-	.name 		= "OSTS",
-	.rating		= 200,
-	.read		= ixp4xx_get_cycles,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
 	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
 
-	clocksource_register_hz(&clocksource_ixp4xx, ixp4xx_timer_freq);
+	clocksource_mmio_init(&IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
+			clocksource_mmio_readl_up);
 }
 
 /*
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 6162ac3..b42c909 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -31,19 +31,6 @@
 #include <mach/platform.h>
 #include "common.h"
 
-static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
-{
-	return (cycle_t)__raw_readl(LCP32XX_TIMER_TC(LPC32XX_TIMER1_BASE));
-}
-
-static struct clocksource lpc32xx_clksrc = {
-	.name	= "lpc32xx_clksrc",
-	.rating	= 300,
-	.read	= lpc32xx_clksrc_read,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static int lpc32xx_clkevt_next_event(unsigned long delta,
     struct clock_event_device *dev)
 {
@@ -170,7 +157,9 @@ static void __init lpc32xx_timer_init(void)
 	__raw_writel(0, LCP32XX_TIMER_MCR(LPC32XX_TIMER1_BASE));
 	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
 		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
-	clocksource_register_hz(&lpc32xx_clksrc, clkrate);
+
+	clocksource_mmio_init(LCP32XX_TIMER_TC(LPC32XX_TIMER1_BASE),
+		"lpc32xx_clksrc", clkrate, 300, 32, clocksource_mmio_readl_up);
 }
 
 struct sys_timer lpc32xx_timer = {
diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index f12f22d..e24c141 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -104,19 +104,6 @@ static struct irqaction netx_timer_irq = {
 	.handler	= netx_timer_interrupt,
 };
 
-cycle_t netx_get_cycles(struct clocksource *cs)
-{
-	return readl(NETX_GPIO_COUNTER_CURRENT(TIMER_CLOCKSOURCE));
-}
-
-static struct clocksource clocksource_netx = {
-	.name		= "netx_timer",
-	.rating		= 200,
-	.read		= netx_get_cycles,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 /*
  * Set up timer interrupt
  */
@@ -150,7 +137,8 @@ static void __init netx_timer_init(void)
 	writel(NETX_GPIO_COUNTER_CTRL_RUN,
 			NETX_GPIO_COUNTER_CTRL(TIMER_CLOCKSOURCE));
 
-	clocksource_register_hz(&clocksource_netx, CLOCK_TICK_RATE);
+	clocksource_mmio_init(NETX_GPIO_COUNTER_CURRENT(TIMER_CLOCKSOURCE),
+		"netx_timer", CLOCK_TICK_RATE, 200, 32, clocksource_mmio_readl_up);
 
 	netx_clockevent.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
 			netx_clockevent.shift);
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index 428da3f..de68470 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -105,19 +105,6 @@ static struct clock_event_device ckevt_pxa_osmr0 = {
 	.set_mode	= pxa_osmr0_set_mode,
 };
 
-static cycle_t pxa_read_oscr(struct clocksource *cs)
-{
-	return OSCR;
-}
-
-static struct clocksource cksrc_pxa_oscr0 = {
-	.name           = "oscr0",
-	.rating         = 200,
-	.read           = pxa_read_oscr,
-	.mask           = CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static struct irqaction pxa_ost0_irq = {
 	.name		= "ost0",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
@@ -134,7 +121,6 @@ static void __init pxa_timer_init(void)
 
 	init_sched_clock(&cd, pxa_update_sched_clock, 32, clock_tick_rate);
 
-	clocksource_calc_mult_shift(&cksrc_pxa_oscr0, clock_tick_rate, 4);
 	clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
 	ckevt_pxa_osmr0.max_delta_ns =
 		clockevent_delta2ns(0x7fffffff, &ckevt_pxa_osmr0);
@@ -144,7 +130,8 @@ static void __init pxa_timer_init(void)
 
 	setup_irq(IRQ_OST0, &pxa_ost0_irq);
 
-	clocksource_register_hz(&cksrc_pxa_oscr0, clock_tick_rate);
+	clocksource_mmio_init(&OSCR, "oscr0", clock_tick_rate, 200, 32,
+		clocksource_mmio_readl_up);
 	clockevents_register_device(&ckevt_pxa_osmr0);
 }
 
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 51c0529..fa66024 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -97,19 +97,6 @@ static struct clock_event_device ckevt_sa1100_osmr0 = {
 	.set_mode	= sa1100_osmr0_set_mode,
 };
 
-static cycle_t sa1100_read_oscr(struct clocksource *s)
-{
-	return OSCR;
-}
-
-static struct clocksource cksrc_sa1100_oscr = {
-	.name		= "oscr",
-	.rating		= 200,
-	.read		= sa1100_read_oscr,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static struct irqaction sa1100_timer_irq = {
 	.name		= "ost0",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
@@ -134,7 +121,8 @@ static void __init sa1100_timer_init(void)
 
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 
-	clocksource_register_hz(&cksrc_sa1100_oscr, CLOCK_TICK_RATE);
+	clocksource_mmio_init(&OSCR, "oscr", CLOCK_TICK_RATE, 200, 32,
+		clocksource_mmio_readl_up);
 	clockevents_register_device(&ckevt_sa1100_osmr0);
 }
 
diff --git a/arch/arm/mach-tcc8k/time.c b/arch/arm/mach-tcc8k/time.c
index e0a8d60..a96babe 100644
--- a/arch/arm/mach-tcc8k/time.c
+++ b/arch/arm/mach-tcc8k/time.c
@@ -25,19 +25,6 @@
 
 static void __iomem *timer_base;
 
-static cycle_t tcc_get_cycles(struct clocksource *cs)
-{
-	return __raw_readl(timer_base + TC32MCNT_OFFS);
-}
-
-static struct clocksource clocksource_tcc = {
-	.name		= "tcc_tc32",
-	.rating		= 200,
-	.read		= tcc_get_cycles,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static int tcc_set_next_event(unsigned long evt,
 			      struct clock_event_device *unused)
 {
@@ -102,7 +89,8 @@ static int __init tcc_clockevent_init(struct clk *clock)
 {
 	unsigned int c = clk_get_rate(clock);
 
-	clocksource_register_hz(&clocksource_tcc, c);
+	clocksource_mmio_init(timer_base + TC32MCNT_OFFS, "tcc_tc32", c,
+		200, 32, clocksource_mmio_readl_up);
 
 	clockevent_tcc.mult = div_sc(c, NSEC_PER_SEC,
 					clockevent_tcc.shift);
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 0fcb1eb..9035042 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -98,11 +98,6 @@ static void tegra_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
-static cycle_t tegra_clocksource_read(struct clocksource *cs)
-{
-	return timer_readl(TIMERUS_CNTR_1US);
-}
-
 static struct clock_event_device tegra_clockevent = {
 	.name		= "timer0",
 	.rating		= 300,
@@ -111,14 +106,6 @@ static struct clock_event_device tegra_clockevent = {
 	.set_mode	= tegra_timer_set_mode,
 };
 
-static struct clocksource tegra_clocksource = {
-	.name	= "timer_us",
-	.rating	= 300,
-	.read	= tegra_clocksource_read,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static DEFINE_CLOCK_DATA(cd);
 
 /*
@@ -234,7 +221,8 @@ static void __init tegra_init_timer(void)
 	init_fixed_sched_clock(&cd, tegra_update_sched_clock, 32,
 			       1000000, SC_MULT, SC_SHIFT);
 
-	if (clocksource_register_hz(&tegra_clocksource, 1000000)) {
+	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
+		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
 		printk(KERN_ERR "Failed to register clocksource\n");
 		BUG();
 	}
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 3ec58bd..891cf44 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -333,20 +333,6 @@ static struct irqaction u300_timer_irq = {
 	.handler        = u300_timer_interrupt,
 };
 
-/* Use general purpose timer 2 as clock source */
-static cycle_t u300_get_cycles(struct clocksource *cs)
-{
-	return (cycles_t) readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-}
-
-static struct clocksource clocksource_u300_1mhz = {
-	.name           = "GPT2",
-	.rating         = 300, /* Reasonably fast and accurate clock source */
-	.read           = u300_get_cycles,
-	.mask           = CLOCKSOURCE_MASK(32), /* 32 bits */
-	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -422,7 +408,9 @@ static void __init u300_timer_init(void)
 	writel(U300_TIMER_APP_EGPT2_TIMER_ENABLE,
 		U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT2);
 
-	if (clocksource_register_hz(&clocksource_u300_1mhz, rate))
+	/* Use general purpose timer 2 as clock source */
+	if (clocksource_mmio_init(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC,
+			"GPT2", rate, 300, 32, clocksource_mmio_readl_up))
 		printk(KERN_ERR "timer: failed to initialize clock "
 		       "source %s\n", clocksource_u300_1mhz.name);
 
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 2237ff8..e4ac94a 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -106,56 +106,32 @@ static void gpt_irq_acknowledge(void)
 		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
 }
 
-static cycle_t dummy_get_cycles(struct clocksource *cs)
-{
-	return 0;
-}
-
-static cycle_t mx1_2_get_cycles(struct clocksource *cs)
-{
-	return __raw_readl(timer_base + MX1_2_TCN);
-}
-
-static cycle_t v2_get_cycles(struct clocksource *cs)
-{
-	return __raw_readl(timer_base + V2_TCN);
-}
-
-static struct clocksource clocksource_mxc = {
-	.name 		= "mxc_timer1",
-	.rating		= 200,
-	.read		= dummy_get_cycles,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
+static void __iomem *sched_clock_reg;
 
 static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
-	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
+	cycle_t cyc = sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
 
 	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
 
 static void notrace mxc_update_sched_clock(void)
 {
-	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
+	cycle_t cyc = sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 static int __init mxc_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
+	void __iomem *reg = timer_base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
 
-	if (timer_is_v2())
-		clocksource_mxc.read = v2_get_cycles;
-	else
-		clocksource_mxc.read = mx1_2_get_cycles;
+	sched_clock_reg = reg;
 
 	init_sched_clock(&cd, mxc_update_sched_clock, 32, c);
-	clocksource_register_hz(&clocksource_mxc, c);
-
-	return 0;
+	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
+			clocksource_mmio_readl_up);
 }
 
 /* clock event */
-- 
1.7.4.4
