From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 06:51:21 +0200
Subject: [PATCH 1/5] ARM: remove dependency of platform code on
	CLOCK_TICK_RATE / LATCH defines
Message-ID: <20101020045121.GX12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the things preventing building an ARM multiplatform kernel
image is the fact that CLOCK_TICK_RATE (and as a consequence, LATCH)
is defined differently for each platform.

CLOCK_TICK_RATE is mostly unused beyond some usage in the various
ARM platform support code directories themselves (and a couple of
bogus uses elsewhere, such as in drivers/input/joystick/analog.c).

Therefore, for those ARM platforms that use their own definition
of CLOCK_TICK_RATE (for example, in their timer setup code), copy
the definition of CLOCK_TICK_RATE into the platform code, renaming
it to TICK_RATE in the process.

Also, for those ARM platforms that use the LATCH define (which is
derived from CLOCK_TICK_RATE), give them a private definition, named
TIMER_LATCH, based on the now locally defined TICK_RATE.

This gets rid of platform code dependencies on mach/timex.h's
CLOCK_TICK_RATE definition, and allows killing all mach/timex.h in
a subsequent patch.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/common/time-acorn.c         |   15 +++++++++------
 arch/arm/mach-aaec2000/core.c        |    9 ++++++---
 arch/arm/mach-at91/at91rm9200_time.c |    8 +++++---
 arch/arm/mach-at91/at91x40.c         |    3 ++-
 arch/arm/mach-clps711x/time.c        |   14 ++++++++++----
 arch/arm/mach-ep93xx/core.c          |    3 ++-
 arch/arm/mach-h720x/common.c         |    4 +++-
 arch/arm/mach-h720x/cpu-h7201.c      |    4 +++-
 arch/arm/mach-h720x/cpu-h7202.c      |    3 ++-
 arch/arm/mach-h720x/time.h           |    2 ++
 arch/arm/mach-ixp23xx/core.c         |   15 +++++++++------
 arch/arm/mach-ixp4xx/common.c        |   11 ++++++++++-
 arch/arm/mach-ks8695/time.c          |   11 +++++++----
 arch/arm/mach-mmp/time.c             |   12 +++++++++---
 arch/arm/mach-netx/time.c            |   11 +++++++----
 arch/arm/mach-pnx4008/time.c         |   11 +++++++----
 arch/arm/mach-sa1100/time.c          |    7 +++++--
 arch/arm/mach-u300/timer.c           |    3 ++-
 18 files changed, 100 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/mach-h720x/time.h

diff --git a/arch/arm/common/time-acorn.c b/arch/arm/common/time-acorn.c
index deeed56..40d258e 100644
--- a/arch/arm/common/time-acorn.c
+++ b/arch/arm/common/time-acorn.c
@@ -24,6 +24,9 @@
 
 #include <asm/mach/time.h>
 
+#define TICK_RATE		2000000
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
+
 unsigned long ioc_timer_gettimeoffset(void)
 {
 	unsigned int count1, count2, status;
@@ -46,23 +49,23 @@ unsigned long ioc_timer_gettimeoffset(void)
 		 * and count2.
 		 */
 		if (status & (1 << 5))
-			offset -= LATCH;
+			offset -= TIMER_LATCH;
 	} else if (count2 > count1) {
 		/*
 		 * We have just had another interrupt between reading
 		 * count1 and count2.
 		 */
-		offset -= LATCH;
+		offset -= TIMER_LATCH;
 	}
 
-	offset = (LATCH - offset) * (tick_nsec / 1000);
-	return (offset + LATCH/2) / LATCH;
+	offset = (TIMER_LATCH - offset) * (tick_nsec / 1000);
+	return (offset + TIMER_LATCH/2) / TIMER_LATCH;
 }
 
 void __init ioctime_init(void)
 {
-	ioc_writeb(LATCH & 255, IOC_T0LTCHL);
-	ioc_writeb(LATCH >> 8, IOC_T0LTCHH);
+	ioc_writeb(TIMER_LATCH & 255, IOC_T0LTCHL);
+	ioc_writeb(TIMER_LATCH >> 8, IOC_T0LTCHH);
 	ioc_writeb(0, IOC_T0GO);
 }
 
diff --git a/arch/arm/mach-aaec2000/core.c b/arch/arm/mach-aaec2000/core.c
index 3ef6833..9b306f5 100644
--- a/arch/arm/mach-aaec2000/core.c
+++ b/arch/arm/mach-aaec2000/core.c
@@ -33,6 +33,9 @@
 
 #include "core.h"
 
+#define TICK_RATE		508000
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
+
 /*
  * Common I/O mapping:
  *
@@ -118,10 +121,10 @@ static unsigned long aaec2000_gettimeoffset(void)
 	ticks_to_match = TIMER1_LOAD - TIMER1_VAL;
 
 	/* We need elapsed ticks since last match */
-	elapsed = LATCH - ticks_to_match;
+	elapsed = TIMER_LATCH - ticks_to_match;
 
 	/* Now, convert them to usec */
-	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
+	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/TIMER_LATCH;
 
 	return usec;
 }
@@ -151,7 +154,7 @@ static void __init aaec2000_timer_init(void)
 	/* We have somehow to generate a 100Hz clock.
 	 * We then use the 508KHz timer in periodic mode.
 	 */
-	TIMER1_LOAD = LATCH;
+	TIMER1_LOAD = TIMER_LATCH;
 	TIMER1_CLEAR = 1; /* Clear interrupt */
 
 	setup_irq(INT_TMR1_OFL, &aaec2000_timer_irq);
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 2500f41..3cea713 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -28,6 +28,8 @@
 
 #include <mach/at91_st.h>
 
+#define TIMER_LATCH		((AT91_SLOW_CLOCK + HZ/2) / HZ)
+
 static unsigned long last_crtr;
 static u32 irqmask;
 static struct clock_event_device clkevt;
@@ -74,8 +76,8 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 	if (sr & AT91_ST_PITS) {
 		u32	crtr = read_CRTR();
 
-		while (((crtr - last_crtr) & AT91_ST_CRTV) >= LATCH) {
-			last_crtr += LATCH;
+		while (((crtr - last_crtr) & AT91_ST_CRTV) >= TIMER_LATCH) {
+			last_crtr += TIMER_LATCH;
 			clkevt.event_handler(&clkevt);
 		}
 		return IRQ_HANDLED;
@@ -117,7 +119,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* PIT for periodic irqs; fixed rate of 1/HZ */
 		irqmask = AT91_ST_PITS;
-		at91_sys_write(AT91_ST_PIMR, LATCH);
+		at91_sys_write(AT91_ST_PIMR, TIMER_LATCH);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* ALM for oneshot irqs, set by next_event()
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index ad3ec85..e3dce6e 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -16,9 +16,10 @@
 #include <asm/mach/arch.h>
 #include <mach/at91x40.h>
 #include <mach/at91_st.h>
-#include <mach/timex.h>
 #include "generic.h"
 
+#define AT91X40_MASTER_CLOCK	40000000
+
 /*
  * Export the clock functions for the AT91X40. Some external code common
  * to all AT91 family parts relys on this, like the gpio and serial support.
diff --git a/arch/arm/mach-clps711x/time.c b/arch/arm/mach-clps711x/time.c
index d581ef0..cc36a6f 100644
--- a/arch/arm/mach-clps711x/time.c
+++ b/arch/arm/mach-clps711x/time.c
@@ -30,18 +30,24 @@
 
 #include <asm/mach/time.h>
 
+#define TICK_RATE		512000
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
+
 
 /*
  * gettimeoffset() returns time since last timer tick, in usecs.
  *
- * 'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
+ * 'TIMER_LATCH' is hwclock ticks per jiffy.
  * 'tick' is usecs per jiffy.
  */
 static unsigned long clps711x_gettimeoffset(void)
 {
 	unsigned long hwticks;
-	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
-	return (hwticks * (tick_nsec / 1000)) / LATCH;
+
+	/* since last underflow */
+	hwticks = TIMER_LATCH - (clps_readl(TC2D) & 0xffff);
+
+	return (hwticks * (tick_nsec / 1000)) / TIMER_LATCH;
 }
 
 /*
@@ -69,7 +75,7 @@ static void __init clps711x_timer_init(void)
 	syscon |= SYSCON1_TC2S | SYSCON1_TC2M;
 	clps_writel(syscon, SYSCON1);
 
-	clps_writel(LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
+	clps_writel(TIMER_LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
 
 	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 4cb55d3..3d6d015 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -111,7 +111,8 @@ void __init ep93xx_map_io(void)
 #define EP93XX_TIMER4_CLOCK		983040
 
 #define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
-#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
+#define TIMER4_TICKS_PER_JIFFY		\
+		DIV_ROUND_CLOSEST(EP93XX_TIMER4_CLOCK, HZ)
 
 static unsigned int last_jiffy_time;
 
diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
index bdb3f67..b732538 100644
--- a/arch/arm/mach-h720x/common.c
+++ b/arch/arm/mach-h720x/common.c
@@ -30,6 +30,8 @@
 
 #include <asm/mach/dma.h>
 
+#include "time.h"
+
 #if 0
 #define IRQDBG(args...) printk(args)
 #else
@@ -46,7 +48,7 @@ void __init arch_dma_init(dma_t *dma)
  */
 unsigned long h720x_gettimeoffset(void)
 {
-	return (CPU_REG (TIMER_VIRT, TM0_COUNT) * tick_usec) / LATCH;
+	return (CPU_REG (TIMER_VIRT, TM0_COUNT) * tick_usec) / TIMER_LATCH;
 }
 
 /*
diff --git a/arch/arm/mach-h720x/cpu-h7201.c b/arch/arm/mach-h720x/cpu-h7201.c
index 24df2a3..5db992a 100644
--- a/arch/arm/mach-h720x/cpu-h7201.c
+++ b/arch/arm/mach-h720x/cpu-h7201.c
@@ -23,6 +23,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include "common.h"
+#include "time.h"
+
 /*
  * Timer interrupt handler
  */
@@ -46,7 +48,7 @@ static struct irqaction h7201_timer_irq = {
  */
 void __init h7201_init_time(void)
 {
-	CPU_REG (TIMER_VIRT, TM0_PERIOD) = LATCH;
+	CPU_REG (TIMER_VIRT, TM0_PERIOD) = TIMER_LATCH;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_RESET;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_REPEAT | TM_START;
 	CPU_REG (TIMER_VIRT, TIMER_TOPCTRL) = ENABLE_TM0_INTR | TIMER_ENABLE_BIT;
diff --git a/arch/arm/mach-h720x/cpu-h7202.c b/arch/arm/mach-h720x/cpu-h7202.c
index fd33a19..8bcd1e0 100644
--- a/arch/arm/mach-h720x/cpu-h7202.c
+++ b/arch/arm/mach-h720x/cpu-h7202.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/serial_8250.h>
 #include "common.h"
+#include "time.h"
 
 static struct resource h7202ps2_resources[] = {
 	[0] = {
@@ -175,7 +176,7 @@ static struct irqaction h7202_timer_irq = {
  */
 void __init h7202_init_time(void)
 {
-	CPU_REG (TIMER_VIRT, TM0_PERIOD) = LATCH;
+	CPU_REG (TIMER_VIRT, TM0_PERIOD) = TIMER_LATCH;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_RESET;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_REPEAT | TM_START;
 	CPU_REG (TIMER_VIRT, TIMER_TOPCTRL) = ENABLE_TM0_INTR | TIMER_ENABLE_BIT;
diff --git a/arch/arm/mach-h720x/time.h b/arch/arm/mach-h720x/time.h
new file mode 100644
index 0000000..333e72c
--- /dev/null
+++ b/arch/arm/mach-h720x/time.h
@@ -0,0 +1,2 @@
+#define TICK_RATE		3686400
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index aa4c442..2b12375 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -43,6 +43,9 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/arch.h>
 
+#define TICK_RATE		75000000
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
+
 
 /*************************************************************************
  * Chip specific mappings shared by all IXP23xx systems
@@ -329,7 +332,7 @@ void __init ixp23xx_init_irq(void)
 /*************************************************************************
  * Timer-tick functions for IXP23xx
  *************************************************************************/
-#define CLOCK_TICKS_PER_USEC	(CLOCK_TICK_RATE / USEC_PER_SEC)
+#define CLOCK_TICKS_PER_USEC	(TICK_RATE / USEC_PER_SEC)
 
 static unsigned long next_jiffy_time;
 
@@ -338,7 +341,7 @@ ixp23xx_gettimeoffset(void)
 {
 	unsigned long elapsed;
 
-	elapsed = *IXP23XX_TIMER_CONT - (next_jiffy_time - LATCH);
+	elapsed = *IXP23XX_TIMER_CONT - (next_jiffy_time - TIMER_LATCH);
 
 	return elapsed / CLOCK_TICKS_PER_USEC;
 }
@@ -348,9 +351,9 @@ ixp23xx_timer_interrupt(int irq, void *dev_id)
 {
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP23XX_TIMER_STATUS = IXP23XX_TIMER1_INT_PEND;
-	while ((signed long)(*IXP23XX_TIMER_CONT - next_jiffy_time) >= LATCH) {
+	while ((signed long)(*IXP23XX_TIMER_CONT - next_jiffy_time) >= TIMER_LATCH) {
 		timer_tick();
-		next_jiffy_time += LATCH;
+		next_jiffy_time += TIMER_LATCH;
 	}
 
 	return IRQ_HANDLED;
@@ -369,10 +372,10 @@ void __init ixp23xx_init_timer(void)
 
 	/* Setup the Timer counter value */
 	*IXP23XX_TIMER1_RELOAD =
-		(LATCH & ~IXP23XX_TIMER_RELOAD_MASK) | IXP23XX_TIMER_ENABLE;
+		(TIMER_LATCH & ~IXP23XX_TIMER_RELOAD_MASK) | IXP23XX_TIMER_ENABLE;
 
 	*IXP23XX_TIMER_CONT = 0;
-	next_jiffy_time = LATCH;
+	next_jiffy_time = TIMER_LATCH;
 
 	/* Connect the interrupt handler and enable the interrupt */
 	setup_irq(IRQ_IXP23XX_TIMER1, &ixp23xx_timer_irq);
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0bce097..8393c34 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -40,6 +40,15 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+/*
+ * We use IXP425 General purpose timer for our timer needs, it runs at 
+ * 66.66... MHz. We do a convulted calculation of CLOCK_TICK_RATE b/c the
+ * timer register ignores the bottom 2 bits of the TIMER_LATCH value.
+ */
+#define FREQ		66666000
+#define TICK_RATE	(((FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
+#define TIMER_LATCH	((TICK_RATE + HZ/2) / HZ)
+
 static void __init ixp4xx_clocksource_init(void);
 static void __init ixp4xx_clockevent_init(void);
 static struct clock_event_device clockevent_ixp4xx;
@@ -457,7 +466,7 @@ static void ixp4xx_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		osrt = LATCH & ~IXP4XX_OST_RELOAD_MASK;
+		osrt = TIMER_LATCH & ~IXP4XX_OST_RELOAD_MASK;
  		opts = IXP4XX_OST_ENABLE;
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
index 69c072c..fabcbe7 100644
--- a/arch/arm/mach-ks8695/time.c
+++ b/arch/arm/mach-ks8695/time.c
@@ -30,9 +30,12 @@
 
 #include <mach/regs-timer.h>
 #include <mach/regs-irq.h>
+#include <mach/hardware.h>
 
 #include "generic.h"
 
+#define TIMER_LATCH            ((KS8695_CLOCK_RATE + HZ/2) / HZ)
+
 /*
  * Returns number of ms since last clock interrupt.  Note that interrupts
  * will have been disabled by do_gettimeoffset()
@@ -55,14 +58,14 @@ static unsigned long ks8695_gettimeoffset (void)
 	} while (elapsed > tick2);
 
 	/* Convert to number of ticks expired (not remaining) */
-	elapsed = (CLOCK_TICK_RATE / HZ) - elapsed;
+	elapsed = (KS8695_CLOCK_RATE / HZ) - elapsed;
 
 	/* Is interrupt pending?  If so, then timer has been reloaded already. */
 	if (intpending)
-		elapsed += (CLOCK_TICK_RATE / HZ);
+		elapsed += (KS8695_CLOCK_RATE / HZ);
 
 	/* Convert ticks to usecs */
-	return (unsigned long)(elapsed * (tick_nsec / 1000)) / LATCH;
+	return (unsigned long)(elapsed * (tick_nsec / 1000)) / TIMER_LATCH;
 }
 
 /*
@@ -82,7 +85,7 @@ static struct irqaction ks8695_timer_irq = {
 
 static void ks8695_timer_setup(void)
 {
-	unsigned long tmout = CLOCK_TICK_RATE / HZ;
+	unsigned long tmout = KS8695_CLOCK_RATE / HZ;
 	unsigned long tmcon;
 
 	/* disable timer1 */
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 6652819..47485ce 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -182,18 +182,24 @@ static struct irqaction timer_irq = {
 	.dev_id		= &ckevt,
 };
 
+#ifdef CONFIG_CPU_MMP2
+#define TICK_RATE		6500000
+#else
+#define TICK_RATE		3250000
+#endif
+
 void __init timer_init(int irq)
 {
 	timer_config();
 
-	set_tcr2ns_scale(CLOCK_TICK_RATE);
+	set_tcr2ns_scale(TICK_RATE);
 
-	ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt.shift);
+	ckevt.mult = div_sc(TICK_RATE, NSEC_PER_SEC, ckevt.shift);
 	ckevt.max_delta_ns = clockevent_delta2ns(MAX_DELTA, &ckevt);
 	ckevt.min_delta_ns = clockevent_delta2ns(MIN_DELTA, &ckevt);
 	ckevt.cpumask = cpumask_of(0);
 
-	cksrc.mult = clocksource_hz2mult(CLOCK_TICK_RATE, cksrc.shift);
+	cksrc.mult = clocksource_hz2mult(TICK_RATE, cksrc.shift);
 
 	setup_irq(irq, &timer_irq);
 
diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index 82801db..ae19afe 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -31,6 +31,9 @@
 #define TIMER_CLOCKEVENT 0
 #define TIMER_CLOCKSOURCE 1
 
+#define TICK_RATE		100000000
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
+
 static void netx_set_mode(enum clock_event_mode mode,
 		struct clock_event_device *clk)
 {
@@ -41,7 +44,7 @@ static void netx_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		writel(LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
+		writel(TIMER_LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
 		tmode = NETX_GPIO_COUNTER_CTRL_RST_EN |
 			NETX_GPIO_COUNTER_CTRL_IRQ_EN |
 			NETX_GPIO_COUNTER_CTRL_RUN;
@@ -129,7 +132,7 @@ static void __init netx_timer_init(void)
 	/* Reset the timer value to zero */
 	writel(0, NETX_GPIO_COUNTER_CURRENT(0));
 
-	writel(LATCH, NETX_GPIO_COUNTER_MAX(0));
+	writel(TIMER_LATCH, NETX_GPIO_COUNTER_MAX(0));
 
 	/* acknowledge interrupt */
 	writel(COUNTER_BIT(0), NETX_GPIO_IRQ);
@@ -152,10 +155,10 @@ static void __init netx_timer_init(void)
 			NETX_GPIO_COUNTER_CTRL(TIMER_CLOCKSOURCE));
 
 	clocksource_netx.mult =
-		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_netx.shift);
+		clocksource_hz2mult(100000000, clocksource_netx.shift);
 	clocksource_register(&clocksource_netx);
 
-	netx_clockevent.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
+	netx_clockevent.mult = div_sc(100000000, NSEC_PER_SEC,
 			netx_clockevent.shift);
 	netx_clockevent.max_delta_ns =
 		clockevent_delta2ns(0xfffffffe, &netx_clockevent);
diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index 0c8aad4..fff33dd 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -32,6 +32,9 @@
 
 #include "time.h"
 
+#define TICK_RATE		1000000
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
+
 /*! Note: all timers are UPCOUNTING */
 
 /*!
@@ -42,8 +45,8 @@ static unsigned long pnx4008_gettimeoffset(void)
 {
 	u32 ticks_to_match =
 	    __raw_readl(HSTIM_MATCH0) - __raw_readl(HSTIM_COUNTER);
-	u32 elapsed = LATCH - ticks_to_match;
-	return (elapsed * (tick_nsec / 1000)) / LATCH;
+	u32 elapsed = TIMER_LATCH - ticks_to_match;
+	return (elapsed * (tick_nsec / 1000)) / TIMER_LATCH;
 }
 
 /*!
@@ -61,7 +64,7 @@ static irqreturn_t pnx4008_timer_interrupt(int irq, void *dev_id)
 			 * for this interrupt handling longer than a normal
 			 * timer period
 			 */
-			__raw_writel(__raw_readl(HSTIM_MATCH0) + LATCH,
+			__raw_writel(__raw_readl(HSTIM_MATCH0) + TIMER_LATCH,
 				     HSTIM_MATCH0);
 			__raw_writel(MATCH0_INT, HSTIM_INT);	/* clear interrupt */
 
@@ -100,7 +103,7 @@ static __init void pnx4008_setup_timer(void)
 	__raw_writel(0, HSTIM_MCTRL);
 	__raw_writel(0, HSTIM_CCR);
 	__raw_writel(12, HSTIM_PMATCH);	/* scale down to 1 MHZ */
-	__raw_writel(LATCH, HSTIM_MATCH0);
+	__raw_writel(TIMER_LATCH, HSTIM_MATCH0);
 	__raw_writel(MR0_INT, HSTIM_MCTRL);
 
 	setup_irq(HSTIMER_INT, &pnx4008_timer_irq);
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 74b6e0e..6fb60dc 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -20,6 +20,9 @@
 
 #define MIN_OSCR_DELTA 2
 
+#define TICK_RATE		3686400
+#define TIMER_LATCH		((TICK_RATE + HZ/2) / HZ)
+
 static irqreturn_t sa1100_ost0_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *c = dev_id;
@@ -106,7 +109,7 @@ static void __init sa1100_timer_init(void)
 	ckevt_sa1100_osmr0.cpumask = cpumask_of(0);
 
 	cksrc_sa1100_oscr.mult =
-		clocksource_hz2mult(CLOCK_TICK_RATE, cksrc_sa1100_oscr.shift);
+		clocksource_hz2mult(TICK_RATE, cksrc_sa1100_oscr.shift);
 
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 
@@ -138,7 +141,7 @@ static void sa1100_timer_resume(void)
 	/*
 	 * OSMR0 is the system timer: make sure OSCR is sufficiently behind
 	 */
-	OSCR = OSMR0 - LATCH;
+	OSCR = OSMR0 - TIMER_LATCH;
 }
 #else
 #define sa1100_timer_suspend NULL
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 3fc4472..678abdb 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -185,7 +185,8 @@
 #define U300_TIMER_APP_CRC					(0x100)
 #define U300_TIMER_APP_CRC_CLOCK_REQUEST_ENABLE			(0x00000001)
 
-#define TICKS_PER_JIFFY ((CLOCK_TICK_RATE + (HZ/2)) / HZ)
+#define TICK_RATE		1000000
+#define TICKS_PER_JIFFY ((TICK_RATE + (HZ/2)) / HZ)
 #define US_PER_TICK ((1000000 + (HZ/2)) / HZ)
 
 /*
-- 
1.7.2.3
