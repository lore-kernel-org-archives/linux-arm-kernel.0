From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 10:16:17 +0100
Subject: [PATCH 01/16] ARM: Remove dependency of plat-orion time code on
	mach directory includes.
In-Reply-To: <alpine.LFD.2.00.1012142121560.10437@xanadu.home>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020228.GT15575@mail.wantstofly.org>
	<alpine.LFD.2.00.1012142121560.10437@xanadu.home>
Message-ID: <20101215091617.GL15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 09:44:14PM -0500, Nicolas Pitre wrote:

> > This patch makes the various mach dirs that use the plat-orion time
> > code pass in timer and bridge addresses explicitly, instead of having
> > plat-orion get those values by including a mach dir include file --
> > the latter mechanism is problematic if you want to support multiple
> > ARM platforms in the same kernel image.
> > 
> > Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> [...]
> > @@ -57,8 +71,11 @@ static unsigned long tclk2ns_scale;
> >  
> >  unsigned long long sched_clock(void)
> >  {
> > -	unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
> > -	return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
> > +	unsigned long val;
> > +
> > +	val = ~readl(timer_base + TIMER0_VAL_OFF);
> > +
> > +	return (cnt32_to_63(val) * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
> >  }
> 
> This is wrong.
> 
> The implementation of cnt32_to_63() looks like this:
> 
> #define cnt32_to_63(cnt_lo) \
> ({ \
>         static u32 __m_cnt_hi; \
>         union cnt32_to_63 __x; \
>         __x.hi = __m_cnt_hi; \
>         smp_rmb(); \
>         __x.lo = (cnt_lo); \
> [...]
> 
> Notice the smp_rmb() _before_ the cnt_lo argument is evaluated, and 
> _after_ __m_cnt_hi is retrieved. Tthis ordering is important for the 
> lockless algorithm used here, otherwise a racing thread could make the 
> hardware counter look like it went backward, or that it actually jumped 
> ahead almost one full period.  If you are caching the hardware counter 
> value in a variable then you are defeating the algorithm.
> 
> I realize that this constraint is not properly documented in 
> cnt32_to_63.h so I should fix that.

OK, I see.  Thanks for the explanation.

This version fixes that up.


commit 6903327da544a86415e35c9cc31e93c3c41f70c1
Author: Lennert Buytenhek <buytenh@wantstofly.org>
Date:   Fri Oct 15 16:50:26 2010 +0200

    ARM: Remove dependency of plat-orion time code on mach directory includes.
    
    This patch makes the various mach dirs that use the plat-orion time
    code pass in timer and bridge addresses explicitly, instead of having
    plat-orion get those values by including a mach dir include file --
    the latter mechanism is problematic if you want to support multiple
    ARM platforms in the same kernel image.
    
    Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index f7a1258..83817ed 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -67,6 +67,8 @@ static struct map_desc dove_io_desc[] __initdata = {
 void __init dove_map_io(void)
 {
 	iotable_init(dove_io_desc, ARRAY_SIZE(dove_io_desc));
+
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 /*****************************************************************************
@@ -540,7 +542,8 @@ static int get_tclk(void)
 
 static void dove_timer_init(void)
 {
-	orion_time_init(IRQ_DOVE_BRIDGE, get_tclk());
+	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+			IRQ_DOVE_BRIDGE, get_tclk());
 }
 
 struct sys_timer dove_timer = {
diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
index 214a4c3..226949d 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -26,10 +26,6 @@
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
 #define  SOFT_RESET		0x00000001
 
-#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
-#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
-#define  BRIDGE_INT_TIMER0	0x0002
-#define  BRIDGE_INT_TIMER1	0x0004
 #define  BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 3688123..d67740f 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -60,6 +60,8 @@ static struct map_desc kirkwood_io_desc[] __initdata = {
 void __init kirkwood_map_io(void)
 {
 	iotable_init(kirkwood_io_desc, ARRAY_SIZE(kirkwood_io_desc));
+
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 /*
@@ -864,7 +866,9 @@ int __init kirkwood_find_tclk(void)
 static void __init kirkwood_timer_init(void)
 {
 	kirkwood_tclk = kirkwood_find_tclk();
-	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
+
+	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+			IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
 }
 
 struct sys_timer kirkwood_timer = {
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index aff0e13..957bd79 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -29,9 +29,6 @@
 #define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
 #define WDT_INT_REQ		0x0008
 
-#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
-#define BRIDGE_INT_TIMER0	0x0002
-#define BRIDGE_INT_TIMER1	0x0004
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
diff --git a/arch/arm/mach-loki/common.c b/arch/arm/mach-loki/common.c
index 818f19d..9206671 100644
--- a/arch/arm/mach-loki/common.c
+++ b/arch/arm/mach-loki/common.c
@@ -18,6 +18,7 @@
 #include <asm/timex.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <mach/bridge-regs.h>
 #include <mach/loki.h>
 #include <plat/orion_nand.h>
 #include <plat/time.h>
@@ -38,6 +39,8 @@ static struct map_desc loki_io_desc[] __initdata = {
 void __init loki_map_io(void)
 {
 	iotable_init(loki_io_desc, ARRAY_SIZE(loki_io_desc));
+
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 
@@ -292,7 +295,8 @@ void __init loki_uart1_init(void)
  ****************************************************************************/
 static void loki_timer_init(void)
 {
-	orion_time_init(IRQ_LOKI_BRIDGE, LOKI_TCLK);
+	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+			IRQ_LOKI_BRIDGE, LOKI_TCLK);
 }
 
 struct sys_timer loki_timer = {
diff --git a/arch/arm/mach-loki/include/mach/bridge-regs.h b/arch/arm/mach-loki/include/mach/bridge-regs.h
index a3fabf7..fd87732 100644
--- a/arch/arm/mach-loki/include/mach/bridge-regs.h
+++ b/arch/arm/mach-loki/include/mach/bridge-regs.h
@@ -17,11 +17,6 @@
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
 #define SOFT_RESET		0x00000001
 
-#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
-
-#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
-#define BRIDGE_INT_TIMER0	0x0002
-#define BRIDGE_INT_TIMER1	0x0004
 #define BRIDGE_INT_TIMER1_CLR	0x0004
 
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 08465eb..64a97bc 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -162,6 +162,8 @@ void __init mv78xx0_map_io(void)
 	mv78xx0_io_desc[0].pfn = __phys_to_pfn(phys);
 
 	iotable_init(mv78xx0_io_desc, ARRAY_SIZE(mv78xx0_io_desc));
+
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 
@@ -820,7 +822,8 @@ void __init mv78xx0_uart3_init(void)
  ****************************************************************************/
 static void mv78xx0_timer_init(void)
 {
-	orion_time_init(IRQ_MV78XX0_TIMER_1, get_tclk());
+	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+			IRQ_MV78XX0_TIMER_1, get_tclk());
 }
 
 struct sys_timer mv78xx0_timer = {
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
index 2d14c4f..c64dbb9 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
@@ -20,10 +20,6 @@
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
 #define SOFT_RESET		0x00000001
 
-#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE | 0x0110)
-#define BRIDGE_MASK		(BRIDGE_VIRT_BASE | 0x0114)
-#define BRIDGE_INT_TIMER0	0x0002
-#define BRIDGE_INT_TIMER1	0x0004
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 8dc2c76..74ac68c 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -26,6 +26,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <mach/bridge-regs.h>
 #include <mach/hardware.h>
 #include <mach/orion5x.h>
 #include <plat/ehci-orion.h>
@@ -65,6 +66,8 @@ static struct map_desc orion5x_io_desc[] __initdata = {
 void __init orion5x_map_io(void)
 {
 	iotable_init(orion5x_io_desc, ARRAY_SIZE(orion5x_io_desc));
+
+	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
 
@@ -616,7 +619,9 @@ int __init orion5x_find_tclk(void)
 static void orion5x_timer_init(void)
 {
 	orion5x_tclk = orion5x_find_tclk();
-	orion_time_init(IRQ_ORION5X_BRIDGE, orion5x_tclk);
+
+	orion_time_init(ORION5X_BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
+			IRQ_ORION5X_BRIDGE, orion5x_tclk);
 }
 
 struct sys_timer orion5x_timer = {
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index 5c9744c..96484bc 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -22,14 +22,12 @@
 
 #define CPU_SOFT_RESET		(ORION5X_BRIDGE_VIRT_BASE | 0x10c)
 
+#define BRIDGE_CAUSE		(ORION5X_BRIDGE_VIRT_BASE | 0x110)
+
 #define POWER_MNG_CTRL_REG	(ORION5X_BRIDGE_VIRT_BASE | 0x11C)
 
-#define BRIDGE_CAUSE		(ORION5X_BRIDGE_VIRT_BASE | 0x110)
 #define WDT_INT_REQ		0x0008
 
-#define BRIDGE_MASK		(ORION5X_BRIDGE_VIRT_BASE | 0x114)
-#define BRIDGE_INT_TIMER0	0x0002
-#define BRIDGE_INT_TIMER1	0x0004
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
 #define MAIN_IRQ_CAUSE		(ORION5X_BRIDGE_VIRT_BASE | 0x200)
diff --git a/arch/arm/plat-orion/include/plat/time.h b/arch/arm/plat-orion/include/plat/time.h
index c06ca35..7ed6aa9 100644
--- a/arch/arm/plat-orion/include/plat/time.h
+++ b/arch/arm/plat-orion/include/plat/time.h
@@ -11,7 +11,10 @@
 #ifndef __PLAT_TIME_H
 #define __PLAT_TIME_H
 
-void orion_time_init(unsigned int irq, unsigned int tclk);
+void orion_time_set_base(u32 _timer_base);
+
+void orion_time_init(u32 bridge_base, u32 bridge_timer1_clr_mask,
+		     unsigned int irq, unsigned int tclk);
 
 
 #endif
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 715a301..3633524 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -18,28 +18,42 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <asm/mach/time.h>
-#include <mach/bridge-regs.h>
-#include <mach/hardware.h>
 
 /*
- * Number of timer ticks per jiffy.
+ * MBus bridge block registers.
  */
-static u32 ticks_per_jiffy;
+#define BRIDGE_CAUSE_OFF	0x0110
+#define BRIDGE_MASK_OFF		0x0114
+#define  BRIDGE_INT_TIMER0	 0x0002
+#define  BRIDGE_INT_TIMER1	 0x0004
 
 
 /*
  * Timer block registers.
  */
-#define TIMER_CTRL		(TIMER_VIRT_BASE + 0x0000)
-#define  TIMER0_EN		0x0001
-#define  TIMER0_RELOAD_EN	0x0002
-#define  TIMER1_EN		0x0004
-#define  TIMER1_RELOAD_EN	0x0008
-#define TIMER0_RELOAD		(TIMER_VIRT_BASE + 0x0010)
-#define TIMER0_VAL		(TIMER_VIRT_BASE + 0x0014)
-#define TIMER1_RELOAD		(TIMER_VIRT_BASE + 0x0018)
-#define TIMER1_VAL		(TIMER_VIRT_BASE + 0x001c)
+#define TIMER_CTRL_OFF		0x0000
+#define  TIMER0_EN		 0x0001
+#define  TIMER0_RELOAD_EN	 0x0002
+#define  TIMER1_EN		 0x0004
+#define  TIMER1_RELOAD_EN	 0x0008
+#define TIMER0_RELOAD_OFF	0x0010
+#define TIMER0_VAL_OFF		0x0014
+#define TIMER1_RELOAD_OFF	0x0018
+#define TIMER1_VAL_OFF		0x001c
+
+
+/*
+ * SoC-specific data.
+ */
+static void __iomem *bridge_base;
+static u32 bridge_timer1_clr_mask;
+static void __iomem *timer_base;
+
+
+/*
+ * Number of timer ticks per jiffy.
+ */
+static u32 ticks_per_jiffy;
 
 
 /*
@@ -57,7 +71,7 @@ static unsigned long tclk2ns_scale;
 
 unsigned long long sched_clock(void)
 {
-	unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
+	unsigned long long v = cnt32_to_63(~readl(timer_base + TIMER0_VAL_OFF));
 	return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
 }
 
@@ -78,6 +92,7 @@ static void __init setup_sched_clock(unsigned long tclk)
 	v <<= TCLK2NS_SCALE_FACTOR;
 	v += tclk/2;
 	do_div(v, tclk);
+
 	/*
 	 * We want an even value to automatically clear the top bit
 	 * returned by cnt32_to_63() without an additional run time
@@ -97,7 +112,7 @@ static void __init setup_sched_clock(unsigned long tclk)
  */
 static cycle_t orion_clksrc_read(struct clocksource *cs)
 {
-	return 0xffffffff - readl(TIMER0_VAL);
+	return 0xffffffff - readl(timer_base + TIMER0_VAL_OFF);
 }
 
 static struct clocksource orion_clksrc = {
@@ -128,23 +143,23 @@ orion_clkevt_next_event(unsigned long delta, struct clock_event_device *dev)
 	/*
 	 * Clear and enable clockevent timer interrupt.
 	 */
-	writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
+	writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
 
-	u = readl(BRIDGE_MASK);
+	u = readl(bridge_base + BRIDGE_MASK_OFF);
 	u |= BRIDGE_INT_TIMER1;
-	writel(u, BRIDGE_MASK);
+	writel(u, bridge_base + BRIDGE_MASK_OFF);
 
 	/*
 	 * Setup new clockevent timer value.
 	 */
-	writel(delta, TIMER1_VAL);
+	writel(delta, timer_base + TIMER1_VAL_OFF);
 
 	/*
 	 * Enable the timer.
 	 */
-	u = readl(TIMER_CTRL);
+	u = readl(timer_base + TIMER_CTRL_OFF);
 	u = (u & ~TIMER1_RELOAD_EN) | TIMER1_EN;
-	writel(u, TIMER_CTRL);
+	writel(u, timer_base + TIMER_CTRL_OFF);
 
 	local_irq_restore(flags);
 
@@ -162,37 +177,38 @@ orion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 		/*
 		 * Setup timer to fire@1/HZ intervals.
 		 */
-		writel(ticks_per_jiffy - 1, TIMER1_RELOAD);
-		writel(ticks_per_jiffy - 1, TIMER1_VAL);
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
 
 		/*
 		 * Enable timer interrupt.
 		 */
-		u = readl(BRIDGE_MASK);
-		writel(u | BRIDGE_INT_TIMER1, BRIDGE_MASK);
+		u = readl(bridge_base + BRIDGE_MASK_OFF);
+		writel(u | BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
 
 		/*
 		 * Enable timer.
 		 */
-		u = readl(TIMER_CTRL);
-		writel(u | TIMER1_EN | TIMER1_RELOAD_EN, TIMER_CTRL);
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u | TIMER1_EN | TIMER1_RELOAD_EN,
+		       timer_base + TIMER_CTRL_OFF);
 	} else {
 		/*
 		 * Disable timer.
 		 */
-		u = readl(TIMER_CTRL);
-		writel(u & ~TIMER1_EN, TIMER_CTRL);
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
 
 		/*
 		 * Disable timer interrupt.
 		 */
-		u = readl(BRIDGE_MASK);
-		writel(u & ~BRIDGE_INT_TIMER1, BRIDGE_MASK);
+		u = readl(bridge_base + BRIDGE_MASK_OFF);
+		writel(u & ~BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
 
 		/*
 		 * ACK pending timer interrupt.
 		 */
-		writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
+		writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
 
 	}
 	local_irq_restore(flags);
@@ -212,7 +228,7 @@ static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
 	/*
 	 * ACK timer interrupt and call event handler.
 	 */
-	writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
+	writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
 	orion_clkevt.event_handler(&orion_clkevt);
 
 	return IRQ_HANDLED;
@@ -224,32 +240,46 @@ static struct irqaction orion_timer_irq = {
 	.handler	= orion_timer_interrupt
 };
 
-void __init orion_time_init(unsigned int irq, unsigned int tclk)
+void __init
+orion_time_set_base(u32 _timer_base)
+{
+	timer_base = (void __iomem *)_timer_base;
+}
+
+void __init
+orion_time_init(u32 _bridge_base, u32 _bridge_timer1_clr_mask,
+		unsigned int irq, unsigned int tclk)
 {
 	u32 u;
 
+	/*
+	 * Set SoC-specific data.
+	 */
+	bridge_base = (void __iomem *)_bridge_base;
+	bridge_timer1_clr_mask = _bridge_timer1_clr_mask;
+
 	ticks_per_jiffy = (tclk + HZ/2) / HZ;
 
 	/*
-	 * Set scale and timer for sched_clock
+	 * Set scale and timer for sched_clock.
 	 */
 	setup_sched_clock(tclk);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
-	 * disabled.)
+	 * disabled).
 	 */
-	writel(0xffffffff, TIMER0_VAL);
-	writel(0xffffffff, TIMER0_RELOAD);
-	u = readl(BRIDGE_MASK);
-	writel(u & ~BRIDGE_INT_TIMER0, BRIDGE_MASK);
-	u = readl(TIMER_CTRL);
-	writel(u | TIMER0_EN | TIMER0_RELOAD_EN, TIMER_CTRL);
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+	u = readl(bridge_base + BRIDGE_MASK_OFF);
+	writel(u & ~BRIDGE_INT_TIMER0, bridge_base + BRIDGE_MASK_OFF);
+	u = readl(timer_base + TIMER_CTRL_OFF);
+	writel(u | TIMER0_EN | TIMER0_RELOAD_EN, timer_base + TIMER_CTRL_OFF);
 	orion_clksrc.mult = clocksource_hz2mult(tclk, orion_clksrc.shift);
 	clocksource_register(&orion_clksrc);
 
 	/*
-	 * Setup clockevent timer (interrupt-driven.)
+	 * Setup clockevent timer (interrupt-driven).
 	 */
 	setup_irq(irq, &orion_timer_irq);
 	orion_clkevt.mult = div_sc(tclk, NSEC_PER_SEC, orion_clkevt.shift);
