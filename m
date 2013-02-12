From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 12 Feb 2013 18:12:52 +0000
Subject: sp804 DT initialization
In-Reply-To: <5115312E.1040307@gmail.com>
References: <5115312E.1040307@gmail.com>
Message-ID: <1360692772.4045.87.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-08 at 17:09 +0000, Rob Herring wrote:
> I'm trying to move the sp804 timer init to DT based init using
> CLKSRC_OF. 

Cool, it would make my life much easier :-)

> The challenge is how do we match each timer to be used as
> clksrc, clkevt, or sched_clock. Ideally we would have h/w based
> properties of the timers such that we could select which one to use just
> based on properties. I'm trying to avoid the use of aliases or linux
> specific properties. OMAP timers are an example of describing the h/w
> properties of timers to drive their selection.

What I finally came up with is the current v2m.c "solution" and patch
below (I'll post it together with a SP810 sort-of-driver for 3.10)...

Effectively I just grab either of the two available motherboard SP804s
and provide the current code with a clock derived from the tree.

> sched_clock selection - What's the reason to use the 24MHz counter vs.
> the sp804 on the ARM boards? Is it purely based on the higher frequency
> and having more accuracy? Would this be universally true? 

I think it was selected because of 1) the higher frequency and 2) the
fact that it is there, no mater what, no configuration required.

> We could make
> setup_sched_clock replace it's current counter with a new one if the new
> one is higher frequency.

Hmm... It is being replaced with the architected timer, isn't it?

> sp804 selection - The versatile and realview boards use timer 0 for
> clkevt and timer 3 for clksrc. AFAICT searching thru kernel and mail
> list history, timer 0 was always used and timer 3 use is arbitrary when
> clksrc support was added by Kevin. Timer 1 could be used as the clksrc,
> or timer 2 and 3 could be used. Some platforms like highbank don't have
> an interrupt for the 2nd timer, so that would have to be accounted for
> in the selection process. Bottom line is it should not matter which ones
> get used by the kernel, right?

Yes, this is my feeling exactly. Provided that one describes what clocks
determine the rates (which could be more complex that I'd guess, due to
possible relations between PCLK, TIMCLK and TIMCLKENx) and how the
interrupt is wired up, everything should Just Work (TM).

Cheers!

Pawel

8<-----
>From 524087cc76d3ea415752b231f37d9bf91cf35154 Mon Sep 17 00:00:00 2001
From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 29 Jan 2013 12:25:28 +0000
Subject: [PATCH] ARM: sp804: Use explicitly specified clock if possible

This patch allows platform code to explicitly specify
a clock to be used as SP804's input, in particular to
obtain such information from the platform's Device Tree.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/common/timer-sp.c               |   14 ++++++++------
 arch/arm/include/asm/hardware/timer-sp.h |   15 +++++++++------
 arch/arm/mach-highbank/highbank.c        |    5 +++--
 arch/arm/mach-integrator/integrator_cp.c |    8 ++++----
 arch/arm/mach-realview/core.c            |    4 ++--
 arch/arm/mach-versatile/core.c           |    4 ++--
 arch/arm/mach-vexpress/v2m.c             |   13 ++++++++-----
 7 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 9d2d3ba..2c64c4b 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -29,13 +29,14 @@
 #include <asm/sched_clock.h>
 #include <asm/hardware/arm_timer.h>
 
-static long __init sp804_get_clock_rate(const char *name)
+static long __init sp804_get_clock_rate(struct clk *clk,
+		const char *name)
 {
-	struct clk *clk;
 	long rate;
 	int err;
 
-	clk = clk_get_sys("sp804", name);
+	if (!clk)
+		clk = clk_get_sys("sp804", name);
 	if (IS_ERR(clk)) {
 		pr_err("sp804: %s clock not found: %d\n", name,
 			(int)PTR_ERR(clk));
@@ -77,9 +78,10 @@ static u32 sp804_read(void)
 
 void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     const char *name,
+						     struct clk *clk,
 						     int use_sched_clock)
 {
-	long rate = sp804_get_clock_rate(name);
+	long rate = sp804_get_clock_rate(clk, name);
 
 	if (rate < 0)
 		return;
@@ -172,10 +174,10 @@ static struct irqaction sp804_timer_irq = {
 };
 
 void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
-	const char *name)
+	const char *name, struct clk *clk)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
-	long rate = sp804_get_clock_rate(name);
+	long rate = sp804_get_clock_rate(clk, name);
 
 	if (rate < 0)
 		return;
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index 2dd9d3f..4cba3e6 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -1,15 +1,18 @@
 void __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					      const char *, int);
+					      const char *, struct clk *, int);
 
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
+static inline void sp804_clocksource_init(void __iomem *base, const char *name,
+					  struct clk *clk)
 {
-	__sp804_clocksource_and_sched_clock_init(base, name, 0);
+	__sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
 }
 
 static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
+							  const char *name,
+							  struct clk *clk)
 {
-	__sp804_clocksource_and_sched_clock_init(base, name, 1);
+	__sp804_clocksource_and_sched_clock_init(base, name, clk, 1);
 }
 
-void sp804_clockevents_init(void __iomem *, unsigned int, const char *);
+void sp804_clockevents_init(void __iomem *, unsigned int, const char *,
+			    struct clk *);
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 981dc1e..36048e4 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -120,8 +120,9 @@ static void __init highbank_timer_init(void)
 	lookup.clk = of_clk_get(np, 0);
 	clkdev_add(&lookup);
 
-	sp804_clocksource_and_sched_clock_init(timer_base + 0x20, "timer1");
-	sp804_clockevents_init(timer_base, irq, "timer0");
+	sp804_clocksource_and_sched_clock_init(timer_base + 0x20, "timer1",
+			NULL);
+	sp804_clockevents_init(timer_base, irq, "timer0", NULL);
 
 	twd_local_timer_of_register();
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 7322838..57cf158 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -268,7 +268,7 @@ static void __init intcp_timer_init_of(void)
 	if (WARN_ON(!base))
 		return;
 	writel(0, base + TIMER_CTRL);
-	sp804_clocksource_init(base, node->name);
+	sp804_clocksource_init(base, node->name, NULL);
 
 	err = of_property_read_string(of_aliases,
 				"arm,timer-secondary", &path);
@@ -280,7 +280,7 @@ static void __init intcp_timer_init_of(void)
 		return;
 	irq = irq_of_parse_and_map(node, 0);
 	writel(0, base + TIMER_CTRL);
-	sp804_clockevents_init(base, irq, node->name);
+	sp804_clockevents_init(base, irq, node->name, NULL);
 }
 
 static struct sys_timer cp_of_timer = {
@@ -518,8 +518,8 @@ static void __init intcp_timer_init(void)
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER2_VA_BASE, "timer2");
-	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1, "timer1");
+	sp804_clocksource_init(TIMER2_VA_BASE, "timer2", NULL);
+	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1, "timer1", NULL);
 }
 
 static struct sys_timer cp_timer = {
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 6824674..e50369d 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -364,8 +364,8 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer2_va_base + TIMER_CTRL);
 	writel(0, timer3_va_base + TIMER_CTRL);
 
-	sp804_clocksource_init(timer3_va_base, "timer3");
-	sp804_clockevents_init(timer0_va_base, timer_irq, "timer0");
+	sp804_clocksource_init(timer3_va_base, "timer3", NULL);
+	sp804_clockevents_init(timer0_va_base, timer_irq, "timer0", NULL);
 }
 
 /*
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 5d59294..1ddc3a4 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -794,8 +794,8 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
-	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, "timer0");
+	sp804_clocksource_init(TIMER3_VA_BASE, "timer3", NULL);
+	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, "timer0", NULL);
 }
 
 struct sys_timer versatile_timer = {
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 011661a..ac3d71b 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -56,7 +56,8 @@ static struct map_desc v2m_io_desc[] __initdata = {
 	},
 };
 
-static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
+static void __init v2m_sp804_init(void __iomem *base, unsigned int irq,
+		struct clk *clk1, struct clk *clk2)
 {
 	if (WARN_ON(!base || irq == NO_IRQ))
 		return;
@@ -64,8 +65,8 @@ static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
 	writel(0, base + TIMER_1_BASE + TIMER_CTRL);
 	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(base + TIMER_2_BASE, "v2m-timer1");
-	sp804_clockevents_init(base + TIMER_1_BASE, irq, "v2m-timer0");
+	sp804_clocksource_init(base + TIMER_2_BASE, "v2m-timer1", clk2);
+	sp804_clockevents_init(base + TIMER_1_BASE, irq, "v2m-timer0", clk1);
 }
 
 
@@ -288,7 +289,7 @@ static struct amba_device *v2m_amba_devs[] __initdata = {
 static void __init v2m_timer_init(void)
 {
 	vexpress_clk_init(ioremap(V2M_SYSCTL, SZ_4K));
-	v2m_sp804_init(ioremap(V2M_TIMER01, SZ_4K), IRQ_V2M_TIMER0);
+	v2m_sp804_init(ioremap(V2M_TIMER01, SZ_4K), IRQ_V2M_TIMER0, NULL, NULL);
 }
 
 static struct sys_timer v2m_timer = {
@@ -457,7 +458,9 @@ static void __init v2m_dt_timer_init(void)
 		pr_info("Using SP804 '%s' as a clock & events source\n",
 				node->full_name);
 		v2m_sp804_init(of_iomap(node, 0),
-				irq_of_parse_and_map(node, 0));
+				irq_of_parse_and_map(node, 0),
+				of_clk_get_by_name(node, "timclken1"),
+				of_clk_get_by_name(node, "timclken2"));
 	}
 
 	if (arch_timer_of_register() != 0)
-- 
1.7.10.4
