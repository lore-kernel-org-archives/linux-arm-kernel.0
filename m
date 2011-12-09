From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Dec 2011 15:33:53 +0000
Subject: [PATCH v4] ARM: sched_clock: allow sched_clock to be selected at
 runtime
Message-ID: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sched_clock() is yet another blocker on the road to the single
image. This patch implements an idea by Russell King:

http://www.spinics.net/lists/linux-omap/msg49561.html

Instead of asking the platform to implement both sched_clock()
itself and the rollover callback, simply register a read()
function, and let the ARM code care about sched_clock() itself,
the conversion to ns and the rollover. sched_clock() uses
this read() function as an indirection to the platform code.
If the platform doesn't provide a read(), the code falls back
to the jiffy counter (just like the default sched_clock).

This allow some simplifications and possibly some footprint gain
when multiple platforms are compiled in. Among the drawbacks,
the removal of the *_fixed_sched_clock optimization which could
negatively impact some platforms (sa1100, tegra, versatile
and omap).

Tested on 11MPCore, OMAP4 and Tegra.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jamie Iles <jamie@jamieiles.com>
Tested-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
I'm reposting this patch with the hope that it (or Russell's
alternative patch http://patchwork.ozlabs.org/patch/115961/)
will get merged in 3.3. It doesn't look intrusive enough to be
left on the side of the road for yet another cycle...

Based on RMK's devel-stable as of Dec 9th.

>From v3:
- Converted picoxcell
- Some minor cleanup

>From v2:
- Removed the read_sched_clock test from sched_clock() and move
  the jiffies code to its own function, as suggested by Nicolas Pitre.
  WARN_ON are added to ensure that setup_sched_clock() is not called
  in an unsafe context and that we only override the default once.

>From v1:
- Added 'notrace' to all _read_sched_lock() functions, fixing
  the ftrace problem reported by Jamie Iles
- Removed useless #include <linux/sched.h> from touched files
- Made omap_32k_read_sched_clock() static

 arch/arm/include/asm/sched_clock.h       |  108 +---------------------------
 arch/arm/kernel/sched_clock.c            |  118 ++++++++++++++++++++++++++---
 arch/arm/mach-ixp4xx/common.c            |   16 +---
 arch/arm/mach-mmp/time.c                 |   16 +---
 arch/arm/mach-omap1/time.c               |   58 +--------------
 arch/arm/mach-omap2/timer.c              |   20 +----
 arch/arm/mach-picoxcell/time.c           |   17 +----
 arch/arm/mach-pxa/time.c                 |   15 +---
 arch/arm/mach-sa1100/time.c              |   28 +------
 arch/arm/mach-tegra/timer.c              |   24 +-----
 arch/arm/mach-u300/timer.c               |   15 +---
 arch/arm/plat-iop/time.c                 |   16 +---
 arch/arm/plat-mxc/time.c                 |   15 +---
 arch/arm/plat-nomadik/timer.c            |   20 +----
 arch/arm/plat-omap/counter_32k.c         |   40 +---------
 arch/arm/plat-omap/include/plat/common.h |    1 -
 arch/arm/plat-orion/time.c               |   21 +-----
 arch/arm/plat-s5p/s5p-time.c             |   19 +----
 arch/arm/plat-versatile/sched-clock.c    |   29 ++------
 19 files changed, 161 insertions(+), 435 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index c8e6ddf..e3f7572 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -8,113 +8,7 @@
 #ifndef ASM_SCHED_CLOCK
 #define ASM_SCHED_CLOCK
 
-#include <linux/kernel.h>
-#include <linux/types.h>
-
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
-/*
- * Initialize the clock data - calculate the appropriate multiplier
- * and shift.  Also setup a timer to ensure that the epoch is refreshed
- * at the appropriate time interval, which will call your update
- * handler.
- */
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
-
 extern void sched_clock_postinit(void);
+extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
 
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..12ab17f 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -14,61 +14,153 @@
 
 #include <asm/sched_clock.h>
 
+struct clock_data {
+	u64 epoch_ns;
+	u32 epoch_cyc;
+	u32 epoch_cyc_copy;
+	u32 mult;
+	u32 shift;
+};
+
 static void sched_clock_poll(unsigned long wrap_ticks);
 static DEFINE_TIMER(sched_clock_timer, sched_clock_poll, 0, 0);
-static void (*sched_clock_update_fn)(void);
+
+static struct clock_data cd = {
+	.mult	= NSEC_PER_SEC / HZ,
+};
+
+static u32 __read_mostly sched_clock_mask = 0xffffffff;
+
+static u32 notrace jiffy_sched_clock_read(void)
+{
+	return (u32)(jiffies - INITIAL_JIFFIES);
+}
+
+static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
+
+static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
+{
+	return (cyc * mult) >> shift;
+}
+
+static unsigned long long cyc_to_sched_clock(u32 cyc, u32 mask)
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
+		epoch_cyc = cd.epoch_cyc;
+		smp_rmb();
+		epoch_ns = cd.epoch_ns;
+		smp_rmb();
+	} while (epoch_cyc != cd.epoch_cyc_copy);
+
+	return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, cd.mult, cd.shift);
+}
+
+/*
+ * Atomically update the sched_clock epoch.
+ */
+static void notrace update_sched_clock(void)
+{
+	unsigned long flags;
+	u32 cyc;
+	u64 ns;
+
+	cyc = read_sched_clock();
+	ns = cd.epoch_ns +
+		cyc_to_ns((cyc - cd.epoch_cyc) & sched_clock_mask,
+			  cd.mult, cd.shift);
+	/*
+	 * Write epoch_cyc and epoch_ns in a way that the update is
+	 * detectable in cyc_to_fixed_sched_clock().
+	 */
+	raw_local_irq_save(flags);
+	cd.epoch_cyc = cyc;
+	smp_wmb();
+	cd.epoch_ns = ns;
+	smp_wmb();
+	cd.epoch_cyc_copy = cyc;
+	raw_local_irq_restore(flags);
+}
 
 static void sched_clock_poll(unsigned long wrap_ticks)
 {
 	mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
-	sched_clock_update_fn();
+	update_sched_clock();
 }
 
-void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
-	unsigned int clock_bits, unsigned long rate)
+void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 {
 	unsigned long r, w;
 	u64 res, wrap;
 	char r_unit;
 
-	sched_clock_update_fn = update;
+	BUG_ON(bits > 32);
+	WARN_ON(!irqs_disabled());
+	WARN_ON(read_sched_clock != jiffy_sched_clock_read);
+	read_sched_clock = read;
+	sched_clock_mask = (1 << bits) - 1;
 
 	/* calculate the mult/shift to convert counter ticks to ns. */
-	clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC, 0);
+	clocks_calc_mult_shift(&cd.mult, &cd.shift, rate, NSEC_PER_SEC, 0);
 
 	r = rate;
 	if (r >= 4000000) {
 		r /= 1000000;
 		r_unit = 'M';
-	} else {
+	} else if (r >= 1000) {
 		r /= 1000;
 		r_unit = 'k';
-	}
+	} else
+		r_unit = ' ';
 
 	/* calculate how many ns until we wrap */
-	wrap = cyc_to_ns((1ULL << clock_bits) - 1, cd->mult, cd->shift);
+	wrap = cyc_to_ns((1ULL << bits) - 1, cd.mult, cd.shift);
 	do_div(wrap, NSEC_PER_MSEC);
 	w = wrap;
 
 	/* calculate the ns resolution of this counter */
-	res = cyc_to_ns(1ULL, cd->mult, cd->shift);
+	res = cyc_to_ns(1ULL, cd.mult, cd.shift);
 	pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lums\n",
-		clock_bits, r, r_unit, res, w);
+		bits, r, r_unit, res, w);
 
 	/*
 	 * Start the timer to keep sched_clock() properly updated and
 	 * sets the initial epoch.
 	 */
 	sched_clock_timer.data = msecs_to_jiffies(w - (w / 10));
-	update();
+	update_sched_clock();
 
 	/*
 	 * Ensure that sched_clock() starts off at 0ns
 	 */
-	cd->epoch_ns = 0;
+	cd.epoch_ns = 0;
+
+	pr_debug("Registered %pF as sched_clock source\n", read);
+}
+
+unsigned long long notrace sched_clock(void)
+{
+	u32 cyc = read_sched_clock();
+	return cyc_to_sched_clock(cyc, sched_clock_mask);
 }
 
 void __init sched_clock_postinit(void)
 {
+	/*
+	 * If no sched_clock function has been provided at that point,
+	 * make it the final one one.
+	 */
+	if (read_sched_clock == jiffy_sched_clock_read)
+		setup_sched_clock(jiffy_sched_clock_read, 32, HZ);	
+
 	sched_clock_poll(sched_clock_timer.data);
 }
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index b86a005..c1b12f9 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -17,7 +17,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/serial.h>
-#include <linux/sched.h>
 #include <linux/tty.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -403,18 +402,9 @@ void __init ixp4xx_sys_init(void)
 /*
  * sched_clock()
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace ixp4xx_read_sched_clock(void)
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
@@ -430,7 +420,7 @@ unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
+	setup_sched_clock(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
 
 	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
 			ixp4xx_clocksource_read);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 4e91ee6..71fc4ee 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -25,7 +25,6 @@
 
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/sched.h>
 
 #include <asm/sched_clock.h>
 #include <mach/addr-map.h>
@@ -42,8 +41,6 @@
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
  */
@@ -59,16 +56,9 @@ static inline uint32_t timer_read(void)
 	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(1));
 }
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace mmp_read_sched_clock(void)
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
@@ -201,7 +191,7 @@ void __init timer_init(int irq)
 {
 	timer_config();
 
-	init_sched_clock(&cd, mmp_update_sched_clock, 32, CLOCK_TICK_RATE);
+	setup_sched_clock(mmp_read_sched_clock, 32, CLOCK_TICK_RATE);
 
 	ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt.shift);
 	ckevt.max_delta_ns = clockevent_delta2ns(MAX_DELTA, &ckevt);
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 485a21d..b8faffa 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -37,7 +37,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -190,30 +189,9 @@ static __init void omap_init_mpu_timer(unsigned long rate)
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
+static u32 notrace omap_mpu_read_sched_clock(void)
 {
-	u32 cyc = ~omap_mpu_timer_read(1);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return ~omap_mpu_timer_read(1);
 }
 
 static void __init omap_init_clocksource(unsigned long rate)
@@ -223,7 +201,7 @@ static void __init omap_init_clocksource(unsigned long rate)
 			"%s: can't register clocksource!\n";
 
 	omap_mpu_timer_start(1, ~0, 1);
-	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
+	setup_sched_clock(omap_mpu_read_sched_clock, 32, rate);
 
 	if (clocksource_mmio_init(&timer->read_tim, "mpu_timer2", rate,
 			300, 32, clocksource_mmio_readl_down))
@@ -254,30 +232,6 @@ static inline void omap_mpu_timer_init(void)
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
@@ -299,12 +253,8 @@ static inline int omap_32k_timer_usable(void)
  */
 static void __init omap1_timer_init(void)
 {
-	if (omap_32k_timer_usable()) {
-		preferred_sched_clock_init(1);
-	} else {
+	if (!omap_32k_timer_usable())
 		omap_mpu_timer_init();
-		preferred_sched_clock_init(0);
-	}
 }
 
 struct sys_timer omap1_timer = {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 9edcd52..6eeff0e 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -254,7 +254,6 @@ static struct omap_dm_timer clksrc;
 /*
  * clocksource
  */
-static DEFINE_CLOCK_DATA(cd);
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
 	return (cycle_t)__omap_dm_timer_read_counter(&clksrc, 1);
@@ -268,23 +267,12 @@ static struct clocksource clocksource_gpt = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void notrace dmtimer_update_sched_clock(void)
+static u32 notrace dmtimer_read_sched_clock(void)
 {
-	u32 cyc;
-
-	cyc = __omap_dm_timer_read_counter(&clksrc, 1);
-
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = 0;
-
 	if (clksrc.reserved)
-		cyc = __omap_dm_timer_read_counter(&clksrc, 1);
+		return __omap_dm_timer_read_counter(clksrc.io_base, 1);
 
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return 0;
 }
 
 /* Setup free-running counter for clocksource */
@@ -301,7 +289,7 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 
 	__omap_dm_timer_load_start(&clksrc,
 			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
-	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
+	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
diff --git a/arch/arm/mach-picoxcell/time.c b/arch/arm/mach-picoxcell/time.c
index 90a554f..6c89cf8 100644
--- a/arch/arm/mach-picoxcell/time.c
+++ b/arch/arm/mach-picoxcell/time.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/sched.h>
 
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
@@ -66,21 +65,11 @@ static void picoxcell_add_clocksource(struct device_node *source_timer)
 	dw_apb_clocksource_register(cs);
 }
 
-static DEFINE_CLOCK_DATA(cd);
 static void __iomem *sched_io_base;
 
-unsigned long long notrace sched_clock(void)
+unsigned u32 notrace picoxcell_read_sched_clock(void)
 {
-	cycle_t cyc = sched_io_base ? __raw_readl(sched_io_base) : 0;
-
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace picoxcell_update_sched_clock(void)
-{
-	cycle_t cyc = sched_io_base ? __raw_readl(sched_io_base) : 0;
-
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return __raw_readl(sched_io_base);
 }
 
 static const struct of_device_id picoxcell_rtc_ids[] __initconst = {
@@ -100,7 +89,7 @@ static void picoxcell_init_sched_clock(void)
 	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
 	of_node_put(sched_timer);
 
-	init_sched_clock(&cd, picoxcell_update_sched_clock, 32, rate);
+	setup_sched_clock(picoxcell_read_sched_clock, 32, rate);
 }
 
 static const struct of_device_id picoxcell_timer_ids[] __initconst = {
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index de68470..b503049 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
-#include <linux/sched.h>
 
 #include <asm/div64.h>
 #include <asm/mach/irq.h>
@@ -32,18 +31,10 @@
  * long as there is always less than 582 seconds between successive
  * calls to sched_clock() which should always be the case in practice.
  */
-static DEFINE_CLOCK_DATA(cd);
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace pxa_read_sched_clock(void)
 {
-	u32 cyc = OSCR;
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace pxa_update_sched_clock(void)
-{
-	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return OSCR;
 }
 
 
@@ -119,7 +110,7 @@ static void __init pxa_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	init_sched_clock(&cd, pxa_update_sched_clock, 32, clock_tick_rate);
+	setup_sched_clock(pxa_read_sched_clock, 32, clock_tick_rate);
 
 	clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
 	ckevt_pxa_osmr0.max_delta_ns =
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index fa66024..1ee6d4c 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/sched.h>	/* just for sched_clock() - funny that */
 #include <linux/timex.h>
 #include <linux/clockchips.h>
 
@@ -20,29 +19,9 @@
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
+static u32 notrace sa100_read_sched_clock(void)
 {
-	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return OSCR;
 }
 
 #define MIN_OSCR_DELTA 2
@@ -109,8 +88,7 @@ static void __init sa1100_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	init_fixed_sched_clock(&cd, sa1100_update_sched_clock, 32,
-			       3686400, SC_MULT, SC_SHIFT);
+	setup_sched_clock(sa1100_read_sched_clock, 32, 3686400);
 
 	clockevents_calc_mult_shift(&ckevt_sa1100_osmr0, 3686400, 4);
 	ckevt_sa1100_osmr0.max_delta_ns =
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index e2272d2..732c724 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -19,7 +19,6 @@
 
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -106,25 +105,9 @@ static struct clock_event_device tegra_clockevent = {
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
+static u32 notrace tegra_read_sched_clock(void)
 {
-	u32 cyc = timer_readl(TIMERUS_CNTR_1US);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return timer_readl(TIMERUS_CNTR_1US);
 }
 
 /*
@@ -218,8 +201,7 @@ static void __init tegra_init_timer(void)
 		WARN(1, "Unknown clock rate");
 	}
 
-	init_fixed_sched_clock(&cd, tegra_update_sched_clock, 32,
-			       1000000, SC_MULT, SC_SHIFT);
+	setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
 
 	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 5f51bde..bc1c789 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -9,7 +9,6 @@
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
 #include <linux/interrupt.h>
-#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/clockchips.h>
@@ -337,18 +336,10 @@ static struct irqaction u300_timer_irq = {
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by OMAP implementation.)
  */
-static DEFINE_CLOCK_DATA(cd);
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace u300_read_sched_clock(void)
 {
-	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace u300_update_sched_clock(void)
-{
-	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
 }
 
 
@@ -366,7 +357,7 @@ static void __init u300_timer_init(void)
 	clk_enable(clk);
 	rate = clk_get_rate(clk);
 
-	init_sched_clock(&cd, u300_update_sched_clock, 32, rate);
+	setup_sched_clock(u300_read_sched_clock, 32, rate);
 
 	/*
 	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 568dd02..cbfbbe4 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -18,7 +18,6 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/timex.h>
-#include <linux/sched.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -52,21 +51,12 @@ static struct clocksource iop_clocksource = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-unsigned long long notrace sched_clock(void)
+static u32 notrace iop_read_sched_clock(void)
 {
-	u32 cyc = 0xffffffffu - read_tcr1();
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace iop_update_sched_clock(void)
-{
-	u32 cyc = 0xffffffffu - read_tcr1();
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return 0xffffffffu - read_tcr1();
 }
 
 /*
@@ -152,7 +142,7 @@ void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
 
-	init_sched_clock(&cd, iop_update_sched_clock, 32, tick_rate);
+	setup_sched_clock(iop_read_sched_clock, 32, tick_rate);
 
 	ticks_per_jiffy = DIV_ROUND_CLOSEST(tick_rate, HZ);
 	iop_tick_rate = tick_rate;
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..1c96cdb 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -108,18 +108,9 @@ static void gpt_irq_acknowledge(void)
 
 static void __iomem *sched_clock_reg;
 
-static DEFINE_CLOCK_DATA(cd);
-unsigned long long notrace sched_clock(void)
+static u32 notrace mxc_read_sched_clock(void)
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
+	return sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
 }
 
 static int __init mxc_clocksource_init(struct clk *timer_clk)
@@ -129,7 +120,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 
 	sched_clock_reg = reg;
 
-	init_sched_clock(&cd, mxc_update_sched_clock, 32, c);
+	setup_sched_clock(mxc_read_sched_clock, 32, c);
 	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
 			clocksource_mmio_readl_up);
 }
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 30b6433..ad1b45b 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
-#include <linux/sched.h>
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
@@ -79,23 +78,12 @@ void __iomem *mtu_base; /* Assigned by machine code */
  * local implementation which uses the clocksource to get some
  * better resolution when scheduling the kernel.
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace nomadik_read_sched_clock(void)
 {
-	u32 cyc;
-
 	if (unlikely(!mtu_base))
 		return 0;
 
-	cyc = -readl(mtu_base + MTU_VAL(0));
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace nomadik_update_sched_clock(void)
-{
-	u32 cyc = -readl(mtu_base + MTU_VAL(0));
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return -readl(mtu_base + MTU_VAL(0));
 }
 #endif
 
@@ -231,9 +219,11 @@ void __init nmdk_timer_init(void)
 			rate, 200, 32, clocksource_mmio_readl_down))
 		pr_err("timer: failed to initialize clock source %s\n",
 		       "mtu_0");
+
 #ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
-	init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
+	setup_sched_clock(nomadik_read_sched_clock, 32, rate);
 #endif
+
 	/* Timer 1 is used for events */
 
 	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index a6cbb71..5f0f229 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/sched.h>
 #include <linux/clocksource.h>
 
 #include <asm/sched_clock.h>
@@ -37,41 +36,9 @@ static void __iomem *timer_32k_base;
 
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
+static u32 notrace omap_32k_read_sched_clock(void)
 {
-	u32 cyc = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
 }
 
 /**
@@ -147,8 +114,7 @@ int __init omap_init_clocksource_32k(void)
 					  clocksource_mmio_readl_up))
 			printk(err, "32k_counter");
 
-		init_fixed_sched_clock(&cd, omap_update_sched_clock, 32,
-				       32768, SC_MULT, SC_SHIFT);
+		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
 	}
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 257f977..b4d7ec3 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -31,7 +31,6 @@
 #include <plat/omap_hwmod.h>
 
 extern int __init omap_init_clocksource_32k(void);
-extern unsigned long long notrace omap_32k_sched_clock(void);
 
 extern void omap_reserve(void);
 extern int omap_dss_reset(struct omap_hwmod *);
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 69a6136..1ed8d13 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -60,24 +59,10 @@ static u32 ticks_per_jiffy;
  * Orion's sched_clock implementation. It has a resolution of
  * at least 7.5ns (133MHz TCLK).
  */
-static DEFINE_CLOCK_DATA(cd);
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace orion_read_sched_clock(void)
 {
-	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-
-static void notrace orion_update_sched_clock(void)
-{
-	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void __init setup_sched_clock(unsigned long tclk)
-{
-	init_sched_clock(&cd, orion_update_sched_clock, 32, tclk);
+	return ~readl(timer_base + TIMER0_VAL_OFF);
 }
 
 /*
@@ -217,7 +202,7 @@ orion_time_init(u32 _bridge_base, u32 _bridge_timer1_clr_mask,
 	/*
 	 * Set scale and timer for sched_clock.
 	 */
-	setup_sched_clock(tclk);
+	setup_sched_clock(orion_read_sched_clock, 32, tclk);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index c833e7b..566341b 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
@@ -321,26 +320,14 @@ static void __iomem *s5p_timer_reg(void)
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by U300 implementation.)
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
-{
-	void __iomem *reg = s5p_timer_reg();
-
-	if (!reg)
-		return 0;
-
-	return cyc_to_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
-}
-
-static void notrace s5p_update_sched_clock(void)
+static u32 notrace s5p_read_sched_clock(void)
 {
 	void __iomem *reg = s5p_timer_reg();
 
 	if (!reg)
 		return;
 
-	update_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
+	return ~__raw_readl(reg);
 }
 
 static void __init s5p_clocksource_init(void)
@@ -358,7 +345,7 @@ static void __init s5p_clocksource_init(void)
 	s5p_time_setup(timer_source.source_id, TCNT_MAX);
 	s5p_time_start(timer_source.source_id, PERIODIC);
 
-	init_sched_clock(&cd, s5p_update_sched_clock, 32, clock_rate);
+	setup_sched_clock(s5p_read_sched_clock, 32, clock_rate);
 
 	if (clocksource_mmio_init(s5p_timer_reg(), "s5p_clocksource_timer",
 			clock_rate, 250, 32, clocksource_mmio_readl_down))
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index 3d6a4c2..b33b74c 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -18,41 +18,24 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/sched.h>
 
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
+static u32 notrace versatile_read_sched_clock(void)
 {
-	if (ctr) {
-		u32 cyc = readl(ctr);
-		return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0,
-						SC_MULT, SC_SHIFT);
-	} else
-		return 0;
-}
+	if (ctr)
+		return readl(ctr);
 
-static void notrace versatile_update_sched_clock(void)
-{
-	u32 cyc = readl(ctr);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return 0;
 }
 
 void __init versatile_sched_clock_init(void __iomem *reg, unsigned long rate)
 {
 	ctr = reg;
-	init_fixed_sched_clock(&cd, versatile_update_sched_clock,
-			       32, rate, SC_MULT, SC_SHIFT);
+	setup_sched_clock(versatile_read_sched_clock, 32, rate);
 }
-- 
1.7.0.4
