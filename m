From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 05:51:55 -0700
Subject: [patch 07/16] arm: omap: Use clocksource based sched_clock
In-Reply-To: <alpine.LFD.2.02.1104291420240.3005@ionos>
References: <20110423205036.795894921@linutronix.de>
	<20110423205132.221790438@linutronix.de>
	<20110429115744.GZ3755@atomide.com>
	<alpine.LFD.2.02.1104291420240.3005@ionos>
Message-ID: <20110429125155.GA3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [110429 05:25]:
> 
> The generic sched_clock implementation returns a jiffies based value
> as long as there is no clocksource registered. But the above does not
> fail in sched_clock() it fails in read_persistent_clock() which does
> 
>         last_cycles = cycles;
>         cycles = clocksource_32k.read(&clocksource_32k);
> 
> So the following change causes this:
> 
> -     .read           = omap_32k_read_dummy,

Ah right.
 
> Which leads to the question why you have a read_persistent_clock() at
> all if it always reads 0 via omap_32k_read_dummy ? Or is this meant
> just for the resume case? Then the above and the removal of
> omap_32k_read_dummy() needs to be undone.

The omap_32k_read_dummy needs to return 0 until the clocks are
enabled and the right read function is selected. The .read gets
then set in omap_init_clocksource_32k.

It would be nice to handle that in a generic way though,
I would assume the same issue exists for other platforms too.

Updated version of your patch below, it now boots on both
omap1 and omap2+.

Regards,

Tony


From: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] arm: omap: Use clocksource based sched_clock

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -49,7 +49,6 @@
 #include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/irq.h>
-#include <asm/sched_clock.h>
 
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
@@ -203,7 +202,7 @@ static struct irqaction omap_mpu_timer2_irq = {
 	.handler	= omap_mpu_timer2_interrupt,
 };
 
-static cycle_t mpu_read(struct clocksource *cs)
+static cycle_t notrace mpu_read(struct clocksource *cs)
 {
 	return ~omap_mpu_timer_read(1);
 }
@@ -213,35 +212,9 @@ static struct clocksource clocksource_mpu = {
 	.rating		= 300,
 	.read		= mpu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SCHED_CLOCK,
 };
 
-static DEFINE_CLOCK_DATA(cd);
-
-static inline unsigned long long notrace _omap_mpu_sched_clock(void)
-{
-	u32 cyc = mpu_read(&clocksource_mpu);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-#ifndef CONFIG_OMAP_32K_TIMER
-unsigned long long notrace sched_clock(void)
-{
-	return _omap_mpu_sched_clock();
-}
-#else
-static unsigned long long notrace omap_mpu_sched_clock(void)
-{
-	return _omap_mpu_sched_clock();
-}
-#endif
-
-static void notrace mpu_update_sched_clock(void)
-{
-	u32 cyc = mpu_read(&clocksource_mpu);
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
 static void __init omap_init_clocksource(unsigned long rate)
 {
 	static char err[] __initdata = KERN_ERR
@@ -249,7 +222,6 @@ static void __init omap_init_clocksource(unsigned long rate)
 
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
 	omap_mpu_timer_start(1, ~0, 1);
-	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
 
 	if (clocksource_register_hz(&clocksource_mpu, rate))
 		printk(err, clocksource_mpu.name);
@@ -279,30 +251,6 @@ static inline void omap_mpu_timer_init(void)
 }
 #endif	/* CONFIG_OMAP_MPU_TIMER */
 
-#if defined(CONFIG_OMAP_MPU_TIMER) && defined(CONFIG_OMAP_32K_TIMER)
-static unsigned long long (*preferred_sched_clock)(void);
-
-unsigned long long notrace sched_clock(void)
-{
-	if (!preferred_sched_clock)
-		return 0;
-
-	return preferred_sched_clock();
-}
-
-static inline void preferred_sched_clock_init(bool use_32k_sched_clock)
-{
-	if (use_32k_sched_clock)
-		preferred_sched_clock = omap_32k_sched_clock;
-	else
-		preferred_sched_clock = omap_mpu_sched_clock;
-}
-#else
-static inline void preferred_sched_clock_init(bool use_32k_sched_clcok)
-{
-}
-#endif
-
 static inline int omap_32k_timer_usable(void)
 {
 	int res = false;
@@ -324,12 +272,8 @@ static inline int omap_32k_timer_usable(void)
  */
 static void __init omap_timer_init(void)
 {
-	if (omap_32k_timer_usable()) {
-		preferred_sched_clock_init(1);
-	} else {
+	if (!omap_32k_timer_usable())
 		omap_mpu_timer_init();
-		preferred_sched_clock_init(0);
-	}
 }
 
 struct sys_timer omap_timer = {
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -39,7 +39,6 @@
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
-#include <asm/sched_clock.h>
 #include <plat/common.h>
 #include <plat/omap_hwmod.h>
 
@@ -196,9 +195,8 @@ static void __init omap2_gp_clocksource_init(void)
 /*
  * clocksource
  */
-static DEFINE_CLOCK_DATA(cd);
 static struct omap_dm_timer *gpt_clocksource;
-static cycle_t clocksource_read_cycles(struct clocksource *cs)
+static cycle_t notrace clocksource_read_cycles(struct clocksource *cs)
 {
 	return (cycle_t)omap_dm_timer_read_counter(gpt_clocksource);
 }
@@ -208,18 +206,9 @@ static struct clocksource clocksource_gpt = {
 	.rating		= 300,
 	.read		= clocksource_read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SCHED_CLOCK,
 };
 
-static void notrace dmtimer_update_sched_clock(void)
-{
-	u32 cyc;
-
-	cyc = omap_dm_timer_read_counter(gpt_clocksource);
-
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
 /* Setup free-running counter for clocksource */
 static void __init omap2_gp_clocksource_init(void)
 {
@@ -240,8 +229,6 @@ static void __init omap2_gp_clocksource_init(void)
 
 	omap_dm_timer_set_load_start(gpt, 1, 0);
 
-	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, tick_rate);
-
 	if (clocksource_register_hz(&clocksource_gpt, tick_rate))
 		printk(err2, clocksource_gpt.name);
 }
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -19,8 +19,6 @@
 #include <linux/io.h>
 #include <linux/sched.h>
 
-#include <asm/sched_clock.h>
-
 #include <plat/common.h>
 #include <plat/board.h>
 
@@ -38,17 +36,10 @@
 
 #include <linux/clocksource.h>
 
-/*
- * offset_32k holds the init time counter value. It is then subtracted
- * from every counter read to achieve a counter that counts time from the
- * kernel boot (needed for sched_clock()).
- */
-static u32 offset_32k __read_mostly;
-
 #ifdef CONFIG_ARCH_OMAP16XX
 static cycle_t notrace omap16xx_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
+	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED);
 }
 #else
 #define omap16xx_32k_read	NULL
@@ -57,7 +48,7 @@ static cycle_t notrace omap16xx_32k_read(struct clocksource *cs)
 #ifdef CONFIG_SOC_OMAP2420
 static cycle_t notrace omap2420_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
+	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10);
 }
 #else
 #define omap2420_32k_read	NULL
@@ -66,7 +57,7 @@ static cycle_t notrace omap2420_32k_read(struct clocksource *cs)
 #ifdef CONFIG_SOC_OMAP2430
 static cycle_t notrace omap2430_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
+	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10);
 }
 #else
 #define omap2430_32k_read	NULL
@@ -75,7 +66,7 @@ static cycle_t notrace omap2430_32k_read(struct clocksource *cs)
 #ifdef CONFIG_ARCH_OMAP3
 static cycle_t notrace omap34xx_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
+	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10);
 }
 #else
 #define omap34xx_32k_read	NULL
@@ -84,7 +75,7 @@ static cycle_t notrace omap34xx_32k_read(struct clocksource *cs)
 #ifdef CONFIG_ARCH_OMAP4
 static cycle_t notrace omap44xx_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
+	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10);
 }
 #else
 #define omap44xx_32k_read	NULL
@@ -104,46 +95,9 @@ static struct clocksource clocksource_32k = {
 	.rating		= 250,
 	.read		= omap_32k_read_dummy,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SCHED_CLOCK,
 };
 
-/*
- * Returns current time from boot in nsecs. It's OK for this to wrap
- * around for now, as it's just a relative time stamp.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 32768, NSEC_PER_SEC, 60).
- * This gives a resolution of about 30us and a wrap period of about 36hrs.
- */
-#define SC_MULT		4000000000u
-#define SC_SHIFT	17
-
-static inline unsigned long long notrace _omap_32k_sched_clock(void)
-{
-	u32 cyc = clocksource_32k.read(&clocksource_32k);
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-#ifndef CONFIG_OMAP_MPU_TIMER
-unsigned long long notrace sched_clock(void)
-{
-	return _omap_32k_sched_clock();
-}
-#else
-unsigned long long notrace omap_32k_sched_clock(void)
-{
-	return _omap_32k_sched_clock();
-}
-#endif
-
-static void notrace omap_update_sched_clock(void)
-{
-	u32 cyc = clocksource_32k.read(&clocksource_32k);
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
 /**
  * read_persistent_clock -  Return time from a persistent clock.
  *
@@ -195,13 +149,8 @@ int __init omap_init_clocksource_32k(void)
 		if (!IS_ERR(sync_32k_ick))
 			clk_enable(sync_32k_ick);
 
-		offset_32k = clocksource_32k.read(&clocksource_32k);
-
 		if (clocksource_register_hz(&clocksource_32k, 32768))
 			printk(err, clocksource_32k.name);
-
-		init_fixed_sched_clock(&cd, omap_update_sched_clock, 32,
-				       32768, SC_MULT, SC_SHIFT);
 	}
 	return 0;
 }
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -289,7 +289,7 @@ static spinlock_t dm_timer_lock;
  * is encoded in reg. Note that in posted mode write pending bit must be
  * checked. Otherwise a read of a non completed write will produce an error.
  */
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
+static inline u32 notrace omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
 	if (timer->posted)
 		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
@@ -700,7 +700,7 @@ void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
-unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
+unsigned int notrace omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -37,7 +37,6 @@ extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
-extern unsigned long long notrace omap_32k_sched_clock(void);
 
 extern void omap_reserve(void);
 
