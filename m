From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Sep 2011 16:36:11 +0100
Subject: [RFC] Shrink sched_clock some more
Message-ID: <20110922153611.GC8072@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... by getting rid of the fixed-constant optimization, and moving the
update code into arch/arm/kernel/sched_clock.c.

Platforms now only have to supply a function to read the sched_clock
register, and some basic information such as the number of significant
bits and the tick rate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/sched_clock.h    |   98 +--------------------------------
 arch/arm/kernel/sched_clock.c         |   91 ++++++++++++++++++++++++++++--
 arch/arm/mach-ixp4xx/common.c         |   15 +----
 arch/arm/mach-mmp/time.c              |   15 +----
 arch/arm/mach-omap1/time.c            |   27 +--------
 arch/arm/mach-omap2/timer.c           |   21 +------
 arch/arm/mach-pxa/time.c              |   23 +-------
 arch/arm/mach-sa1100/time.c           |   27 +--------
 arch/arm/mach-tegra/timer.c           |   23 +-------
 arch/arm/mach-u300/timer.c            |   22 +------
 arch/arm/plat-iop/time.c              |   15 +----
 arch/arm/plat-mxc/time.c              |   15 +----
 arch/arm/plat-nomadik/timer.c         |   25 +-------
 arch/arm/plat-omap/counter_32k.c      |   39 +------------
 arch/arm/plat-orion/time.c            |   16 +----
 arch/arm/plat-s5p/s5p-time.c          |   29 +---------
 arch/arm/plat-versatile/sched-clock.c |   26 +--------
 17 files changed, 131 insertions(+), 396 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index c8e6ddf..2026a0c 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -11,109 +11,13 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-struct clock_data {
-	u64 epoch_ns;
-	u32 epoch_cyc;
-	u32 epoch_cyc_copy;
-	u32 mult;
-	u32 shift;
-};
-
-#define DEFINE_CLOCK_DATA(name)	struct clock_data name
-
-static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
-{
-	return (cyc * mult) >> shift;
-}
-
-/*
- * Atomically update the sched_clock epoch.  Your update callback will
- * be called from a timer before the counter wraps - read the current
- * counter value, and call this function to safely move the epochs
- * forward.  Only use this from the update callback.
- */
-static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 mask)
-{
-	unsigned long flags;
-	u64 ns = cd->epoch_ns +
-		cyc_to_ns((cyc - cd->epoch_cyc) & mask, cd->mult, cd->shift);
-
-	/*
-	 * Write epoch_cyc and epoch_ns in a way that the update is
-	 * detectable in cyc_to_fixed_sched_clock().
-	 */
-	raw_local_irq_save(flags);
-	cd->epoch_cyc = cyc;
-	smp_wmb();
-	cd->epoch_ns = ns;
-	smp_wmb();
-	cd->epoch_cyc_copy = cyc;
-	raw_local_irq_restore(flags);
-}
-
-/*
- * If your clock rate is known at compile time, using this will allow
- * you to optimize the mult/shift loads away.  This is paired with
- * init_fixed_sched_clock() to ensure that your mult/shift are correct.
- */
-static inline unsigned long long cyc_to_fixed_sched_clock(struct clock_data *cd,
-	u32 cyc, u32 mask, u32 mult, u32 shift)
-{
-	u64 epoch_ns;
-	u32 epoch_cyc;
-
-	/*
-	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
-	 * ensuring that we always write epoch_cyc, epoch_ns and
-	 * epoch_cyc_copy in strict order, and read them in strict order.
-	 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
-	 * the middle of an update, and we should repeat the load.
-	 */
-	do {
-		epoch_cyc = cd->epoch_cyc;
-		smp_rmb();
-		epoch_ns = cd->epoch_ns;
-		smp_rmb();
-	} while (epoch_cyc != cd->epoch_cyc_copy);
-
-	return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, mult, shift);
-}
-
-/*
- * Otherwise, you need to use this, which will obtain the mult/shift
- * from the clock_data structure.  Use init_sched_clock() with this.
- */
-static inline unsigned long long cyc_to_sched_clock(struct clock_data *cd,
-	u32 cyc, u32 mask)
-{
-	return cyc_to_fixed_sched_clock(cd, cyc, mask, cd->mult, cd->shift);
-}
-
 /*
  * Initialize the clock data - calculate the appropriate multiplier
  * and shift.  Also setup a timer to ensure that the epoch is refreshed
  * at the appropriate time interval, which will call your update
  * handler.
  */
-void init_sched_clock(struct clock_data *, void (*)(void),
-	unsigned int, unsigned long);
-
-/*
- * Use this initialization function rather than init_sched_clock() if
- * you're using cyc_to_fixed_sched_clock, which will warn if your
- * constants are incorrect.
- */
-static inline void init_fixed_sched_clock(struct clock_data *cd,
-	void (*update)(void), unsigned int bits, unsigned long rate,
-	u32 mult, u32 shift)
-{
-	init_sched_clock(cd, update, bits, rate);
-	if (cd->mult != mult || cd->shift != shift) {
-		pr_crit("sched_clock: wrong multiply/shift: %u>>%u vs calculated %u>>%u\n"
-			"sched_clock: fix multiply/shift to avoid scheduler hiccups\n",
-			mult, shift, cd->mult, cd->shift);
-	}
-}
+void init_sched_clock(u32 (*)(void), unsigned int, unsigned long);
 
 extern void sched_clock_postinit(void);
 
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..dfee812 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -14,28 +14,107 @@
 
 #include <asm/sched_clock.h>
 
+struct clock_data {
+	u64 epoch_ns;
+	u32 epoch_cyc;
+	u32 epoch_cyc_copy;
+	u32 mult;
+	u32 shift;
+	u32 mask;
+};
+
 static void sched_clock_poll(unsigned long wrap_ticks);
 static DEFINE_TIMER(sched_clock_timer, sched_clock_poll, 0, 0);
-static void (*sched_clock_update_fn)(void);
+static u32 (*sched_clock_read_fn)(void);
+static struct clock_data sched_clock_data;
+
+static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
+{
+	return (cyc * mult) >> shift;
+}
+
+/*
+ * Atomically update the sched_clock epoch.  Your update callback will
+ * be called from a timer before the counter wraps - read the current
+ * counter value, and call this function to safely move the epochs
+ * forward.  Only use this from the update callback.
+ */
+static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 mask)
+{
+	unsigned long flags;
+	u64 ns = cd->epoch_ns +
+		cyc_to_ns((cyc - cd->epoch_cyc) & mask, cd->mult, cd->shift);
+
+	/*
+	 * Write epoch_cyc and epoch_ns in a way that the update is
+	 * detectable in cyc_to_sched_clock().
+	 */
+	raw_local_irq_save(flags);
+	cd->epoch_cyc = cyc;
+	smp_wmb();
+	cd->epoch_ns = ns;
+	smp_wmb();
+	cd->epoch_cyc_copy = cyc;
+	raw_local_irq_restore(flags);
+}
+
+static inline unsigned long long cyc_to_sched_clock(struct clock_data *cd,
+	u32 cyc, u32 mask)
+{
+	u64 epoch_ns;
+	u32 epoch_cyc;
+
+	/*
+	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
+	 * ensuring that we always write epoch_cyc, epoch_ns and
+	 * epoch_cyc_copy in strict order, and read them in strict order.
+	 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
+	 * the middle of an update, and we should repeat the load.
+	 */
+	do {
+		epoch_cyc = cd->epoch_cyc;
+		smp_rmb();
+		epoch_ns = cd->epoch_ns;
+		smp_rmb();
+	} while (epoch_cyc != cd->epoch_cyc_copy);
+
+	return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask,
+			cd->mult, cd->shift);
+}
 
 static void sched_clock_poll(unsigned long wrap_ticks)
 {
+	struct clock_data *cd = &sched_clock_data;
 	mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
-	sched_clock_update_fn();
+	update_sched_clock(cd, sched_clock_read_fn(), cd->mask);
 }
 
-void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
+unsigned long long notrace sched_clock(void)
+{
+	struct clock_data *cd = &sched_clock_data;
+	u32 cyc = 0;
+
+	if (sched_clock_read_fn)
+		cyc = sched_clock_read_fn();
+
+	return cyc_to_sched_clock(cd, cyc, cd->mask);
+}
+
+void __init init_sched_clock(u32 (*read)(void),
 	unsigned int clock_bits, unsigned long rate)
 {
+	struct clock_data *cd = &sched_clock_data;
 	unsigned long r, w;
 	u64 res, wrap;
 	char r_unit;
 
-	sched_clock_update_fn = update;
+	sched_clock_read_fn = read;
 
 	/* calculate the mult/shift to convert counter ticks to ns. */
 	clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC, 0);
 
+	cd->mask = (1ULL << clock_bits) - 1;
+
 	r = rate;
 	if (r >= 4000000) {
 		r /= 1000000;
@@ -46,7 +125,7 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
 	}
 
 	/* calculate how many ns until we wrap */
-	wrap = cyc_to_ns((1ULL << clock_bits) - 1, cd->mult, cd->shift);
+	wrap = cyc_to_ns(cd->mask, cd->mult, cd->shift);
 	do_div(wrap, NSEC_PER_MSEC);
 	w = wrap;
 
@@ -60,7 +139,7 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
 	 * sets the initial epoch.
 	 */
 	sched_clock_timer.data = msecs_to_jiffies(w - (w / 10));
-	update();
+	update_sched_clock(cd, read(), cd->mask);
 
 	/*
 	 * Ensure that sched_clock() starts off at 0ns
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0777257..2951db0 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -402,18 +402,9 @@ void __init ixp4xx_sys_init(void)
 /*
  * sched_clock()
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace ixp4xx_sched_clock_read(void)
 {
-	u32 cyc = *IXP4XX_OSTS;
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace ixp4xx_update_sched_clock(void)
-{
-	u32 cyc = *IXP4XX_OSTS;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return *IXP4XX_OSTS;
 }
 
 /*
@@ -429,7 +420,7 @@ unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
+	init_sched_clock(ixp4xx_sched_clock_read, 32, ixp4xx_timer_freq);
 
 	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
 			ixp4xx_clocksource_read);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 4e91ee6..11f2bf1 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -42,8 +42,6 @@
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
  */
@@ -59,16 +57,9 @@ static inline uint32_t timer_read(void)
 	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(1));
 }
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace mmp_sched_clock_read(void)
 {
-	u32 cyc = timer_read();
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace mmp_update_sched_clock(void)
-{
-	u32 cyc = timer_read();
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return timer_read();
 }
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id)
@@ -201,7 +192,7 @@ void __init timer_init(int irq)
 {
 	timer_config();
 
-	init_sched_clock(&cd, mmp_update_sched_clock, 32, CLOCK_TICK_RATE);
+	init_sched_clock(mmp_sched_clock_read, 32, CLOCK_TICK_RATE);
 
 	ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt.shift);
 	ckevt.max_delta_ns = clockevent_delta2ns(MAX_DELTA, &ckevt);
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a183777..e6df086 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -190,30 +190,9 @@ static __init void omap_init_mpu_timer(unsigned long rate)
  * ---------------------------------------------------------------------------
  */
 
-static DEFINE_CLOCK_DATA(cd);
-
-static inline unsigned long long notrace _omap_mpu_sched_clock(void)
-{
-	u32 cyc = ~omap_mpu_timer_read(1);
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
+static u32 notrace omap_mpu_sched_clock_read(void)
 {
-	u32 cyc = ~omap_mpu_timer_read(1);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return = ~omap_mpu_timer_read(1);
 }
 
 static void __init omap_init_clocksource(unsigned long rate)
@@ -223,7 +202,7 @@ static void __init omap_init_clocksource(unsigned long rate)
 			"%s: can't register clocksource!\n";
 
 	omap_mpu_timer_start(1, ~0, 1);
-	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
+	init_sched_clock(omap_mpu_sched_clock_read, 32, rate);
 
 	if (clocksource_mmio_init(&timer->read_tim, "mpu_timer2", rate,
 			300, 32, clocksource_mmio_readl_down))
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cf1de7d..a0d4199 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -248,7 +248,6 @@ static struct omap_dm_timer clksrc;
 /*
  * clocksource
  */
-static DEFINE_CLOCK_DATA(cd);
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
 	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
@@ -262,23 +261,9 @@ static struct clocksource clocksource_gpt = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void notrace dmtimer_update_sched_clock(void)
+static u32 notrace dmtimer_sched_clock_read(void)
 {
-	u32 cyc;
-
-	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
-
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = 0;
-
-	if (clksrc.reserved)
-		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
-
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return __omap_dm_timer_read_counter(clksrc.io_base, 1);
 }
 
 /* Setup free-running counter for clocksource */
@@ -295,7 +280,7 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 
 	__omap_dm_timer_load_start(clksrc.io_base,
 			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
-	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
+	init_sched_clock(dmtimer_sched_clock_read, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index de68470..ff0b1a6 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -24,26 +24,9 @@
 #include <asm/sched_clock.h>
 #include <mach/regs-ost.h>
 
-/*
- * This is PXA's sched_clock implementation. This has a resolution
- * of at least 308 ns and a maximum value of 208 days.
- *
- * The return value is guaranteed to be monotonic in that range as
- * long as there is always less than 582 seconds between successive
- * calls to sched_clock() which should always be the case in practice.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = OSCR;
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace pxa_update_sched_clock(void)
+static u32 notrace pxa_sched_clock_read(void)
 {
-	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return OSCR;
 }
 
 
@@ -119,7 +102,7 @@ static void __init pxa_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	init_sched_clock(&cd, pxa_update_sched_clock, 32, clock_tick_rate);
+	init_sched_clock(pxa_sched_clock_read, 32, clock_tick_rate);
 
 	clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
 	ckevt_pxa_osmr0.max_delta_ns =
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index fa66024..ebaa64e 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -20,29 +20,9 @@
 #include <asm/sched_clock.h>
 #include <mach/hardware.h>
 
-/*
- * This is the SA11x0 sched_clock implementation.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 3.6864MHz,
- * NSEC_PER_SEC, 60).
- * This gives a resolution of about 271ns and a wrap period of about 19min.
- */
-#define SC_MULT		2275555556u
-#define SC_SHIFT	23
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = OSCR;
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-static void notrace sa1100_update_sched_clock(void)
+static u32 notrace sa1100_sched_clock_read(void)
 {
-	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return OSCR;
 }
 
 #define MIN_OSCR_DELTA 2
@@ -109,8 +89,7 @@ static void __init sa1100_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	init_fixed_sched_clock(&cd, sa1100_update_sched_clock, 32,
-			       3686400, SC_MULT, SC_SHIFT);
+	init_sched_clock(sa1100_sched_clock_read, 32, 3686400);
 
 	clockevents_calc_mult_shift(&ckevt_sa1100_osmr0, 3686400, 4);
 	ckevt_sa1100_osmr0.max_delta_ns =
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 9035042..fdf1e12 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -106,25 +106,9 @@ static struct clock_event_device tegra_clockevent = {
 	.set_mode	= tegra_timer_set_mode,
 };
 
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 1MHz, NSEC_PER_SEC, 60).
- * This gives a resolution of about 1us and a wrap period of about 1h11min.
- */
-#define SC_MULT		4194304000u
-#define SC_SHIFT	22
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = timer_readl(TIMERUS_CNTR_1US);
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-static void notrace tegra_update_sched_clock(void)
+static u32 notrace tegra_sched_clock_read(void)
 {
-	u32 cyc = timer_readl(TIMERUS_CNTR_1US);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return timer_readl(TIMERUS_CNTR_1US);
 }
 
 /*
@@ -218,8 +202,7 @@ static void __init tegra_init_timer(void)
 		WARN(1, "Unknown clock rate");
 	}
 
-	init_fixed_sched_clock(&cd, tegra_update_sched_clock, 32,
-			       1000000, SC_MULT, SC_SHIFT);
+	init_sched_clock(tegra_sched_clock_read, 32, 1000000);
 
 	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 5f51bde..2301f71 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -330,25 +330,9 @@ static struct irqaction u300_timer_irq = {
 	.handler	= u300_timer_interrupt,
 };
 
-/*
- * Override the global weak sched_clock symbol with this
- * local implementation which uses the clocksource to get some
- * better resolution when scheduling the kernel. We accept that
- * this wraps around for now, since it is just a relative time
- * stamp. (Inspired by OMAP implementation.)
- */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace u300_update_sched_clock(void)
+static u32 notrace u300_sched_clock_read(void)
 {
-	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
 }
 
 
@@ -366,7 +350,7 @@ static void __init u300_timer_init(void)
 	clk_enable(clk);
 	rate = clk_get_rate(clk);
 
-	init_sched_clock(&cd, u300_update_sched_clock, 32, rate);
+	init_sched_clock(u300_sched_clock_read, 32, rate);
 
 	/*
 	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 7cdc516..b038636 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -51,21 +51,12 @@ static struct clocksource iop_clocksource = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = 0xffffffffu - read_tcr1();
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace iop_update_sched_clock(void)
+static u32 notrace iop_sched_clock_read(void)
 {
-	u32 cyc = 0xffffffffu - read_tcr1();
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return cyc = 0xffffffffu - read_tcr1();
 }
 
 /*
@@ -151,7 +142,7 @@ void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
 
-	init_sched_clock(&cd, iop_update_sched_clock, 32, tick_rate);
+	init_sched_clock(iop_sched_clock_read, 32, tick_rate);
 
 	ticks_per_jiffy = DIV_ROUND_CLOSEST(tick_rate, HZ);
 	iop_tick_rate = tick_rate;
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..b74f721 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -108,18 +108,9 @@ static void gpt_irq_acknowledge(void)
 
 static void __iomem *sched_clock_reg;
 
-static DEFINE_CLOCK_DATA(cd);
-unsigned long long notrace sched_clock(void)
+static u32 notrace mxc_sched_clock_read(void)
 {
-	cycle_t cyc = sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
-
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace mxc_update_sched_clock(void)
-{
-	cycle_t cyc = sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return __raw_readl(sched_clock_reg);
 }
 
 static int __init mxc_clocksource_init(struct clk *timer_clk)
@@ -129,7 +120,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 
 	sched_clock_reg = reg;
 
-	init_sched_clock(&cd, mxc_update_sched_clock, 32, c);
+	init_sched_clock(mxc_sched_clock_read, 32, c);
 	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
 			clocksource_mmio_readl_up);
 }
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index ef74e15..6e38ed1 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -25,28 +25,9 @@
 
 void __iomem *mtu_base; /* Assigned by machine code */
 
-/*
- * Override the global weak sched_clock symbol with this
- * local implementation which uses the clocksource to get some
- * better resolution when scheduling the kernel.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc;
-
-	if (unlikely(!mtu_base))
-		return 0;
-
-	cyc = -readl(mtu_base + MTU_VAL(0));
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace nomadik_update_sched_clock(void)
+static u32 notrace nomadik_sched_clock_read(void)
 {
-	u32 cyc = -readl(mtu_base + MTU_VAL(0));
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return -readl(mtu_base + MTU_VAL(0));
 }
 
 /* Clockevent device: use one-shot mode */
@@ -154,7 +135,7 @@ void __init nmdk_timer_init(void)
 		pr_err("timer: failed to initialize clock source %s\n",
 		       "mtu_0");
 
-	init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
+	init_sched_clock(nomadik_sched_clock_read, 32, rate);
 
 	/* Timer 1 is used for events */
 
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index a6cbb71..1faa7ce 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -37,41 +37,9 @@ static void __iomem *timer_32k_base;
 
 #define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
 
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
-	u32 cyc = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-#if defined(CONFIG_OMAP_32K_TIMER) && !defined(CONFIG_OMAP_MPU_TIMER)
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
+static inline u32 notrace omap_32k_sched_clock_read(void)
 {
-	u32 cyc = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return __raw_readl(timer_32k_base);
 }
 
 /**
@@ -147,8 +115,7 @@ int __init omap_init_clocksource_32k(void)
 					  clocksource_mmio_readl_up))
 			printk(err, "32k_counter");
 
-		init_fixed_sched_clock(&cd, omap_update_sched_clock, 32,
-				       32768, SC_MULT, SC_SHIFT);
+		init_sched_clock(omap_32k_sched_clock_read, 32, 32768);
 	}
 	return 0;
 }
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 69a6136..34e8224 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -60,24 +60,14 @@ static u32 ticks_per_jiffy;
  * Orion's sched_clock implementation. It has a resolution of
  * at least 7.5ns (133MHz TCLK).
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-
-static void notrace orion_update_sched_clock(void)
+static u32 notrace orion_sched_clock_read(void)
 {
-	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return = ~readl(timer_base + TIMER0_VAL_OFF);
 }
 
 static void __init setup_sched_clock(unsigned long tclk)
 {
-	init_sched_clock(&cd, orion_update_sched_clock, 32, tclk);
+	init_sched_clock(orion_sched_clock_read, 32, tclk);
 }
 
 /*
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index c833e7b..6fc1121 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -314,33 +314,10 @@ static void __iomem *s5p_timer_reg(void)
 	return S3C_TIMERREG(offset);
 }
 
-/*
- * Override the global weak sched_clock symbol with this
- * local implementation which uses the clocksource to get some
- * better resolution when scheduling the kernel. We accept that
- * this wraps around for now, since it is just a relative time
- * stamp. (Inspired by U300 implementation.)
- */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace s5p_sched_clock_read(void)
 {
 	void __iomem *reg = s5p_timer_reg();
-
-	if (!reg)
-		return 0;
-
-	return cyc_to_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
-}
-
-static void notrace s5p_update_sched_clock(void)
-{
-	void __iomem *reg = s5p_timer_reg();
-
-	if (!reg)
-		return;
-
-	update_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
+	return ~__raw_readl(reg);
 }
 
 static void __init s5p_clocksource_init(void)
@@ -358,7 +335,7 @@ static void __init s5p_clocksource_init(void)
 	s5p_time_setup(timer_source.source_id, TCNT_MAX);
 	s5p_time_start(timer_source.source_id, PERIODIC);
 
-	init_sched_clock(&cd, s5p_update_sched_clock, 32, clock_rate);
+	init_sched_clock(s5p_sched_clock_read, 32, clock_rate);
 
 	if (clocksource_mmio_init(s5p_timer_reg(), "s5p_clocksource_timer",
 			clock_rate, 250, 32, clocksource_mmio_readl_down))
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index 3d6a4c2..d9d5ba4 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -24,35 +24,15 @@
 #include <asm/sched_clock.h>
 #include <plat/sched_clock.h>
 
-static DEFINE_CLOCK_DATA(cd);
 static void __iomem *ctr;
 
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 24MHz, NSEC_PER_SEC, 60).
- * This gives a resolution of about 41ns and a wrap period of about 178s.
- */
-#define SC_MULT		2796202667u
-#define SC_SHIFT	26
-
-unsigned long long notrace sched_clock(void)
-{
-	if (ctr) {
-		u32 cyc = readl(ctr);
-		return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0,
-						SC_MULT, SC_SHIFT);
-	} else
-		return 0;
-}
-
-static void notrace versatile_update_sched_clock(void)
+static u32 notrace versatile_sched_clock_read(void)
 {
-	u32 cyc = readl(ctr);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return readl(ctr);
 }
 
 void __init versatile_sched_clock_init(void __iomem *reg, unsigned long rate)
 {
 	ctr = reg;
-	init_fixed_sched_clock(&cd, versatile_update_sched_clock,
-			       32, rate, SC_MULT, SC_SHIFT);
+	init_sched_clock(versatile_sched_clock_read, 32, rate);
 }
