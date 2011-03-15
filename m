From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:53 +0000
Subject: [RFC PATCHv2 10/20] ARM: Platform dependent sched_clock() override
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sched_clock being a (weak) global symbol, there can only be
a single implementation in the kernel, which may cause problems
on the rocky road towards supporting multiple architectures in
a single kernel image.

This patch adds a way of overriding the default sched_clock()
by extending the ARM sched_clock framework. The sched_clock()
call also becomes slightly more expensive (indirect function call).

VExpress support is updated to use that functionnality.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                      |    9 +++++++
 arch/arm/include/asm/sched_clock.h    |   41 +++++++++++++++++++++++++++++---
 arch/arm/kernel/sched_clock.c         |   23 +++++++++++++++++-
 arch/arm/plat-versatile/sched-clock.c |    7 +++--
 4 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 38ee56e..08b3ff2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -48,6 +48,14 @@ config SYS_SUPPORTS_APM_EMULATION
 config HAVE_SCHED_CLOCK
 	bool
 
+config ARCH_SCHED_CLOCK
+	bool
+	help
+	  Allow the default sched_clock() to be overloaded at runtime.
+	  Use this option if you build a kernel for a platform with
+	  multiplee sched_clock sources, one of which will be selected
+	  at runtime.
+
 config GENERIC_GPIO
 	bool
 
@@ -275,6 +283,7 @@ config ARCH_VEXPRESS
 	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
+	select ARCH_SCHED_CLOCK
 	select HAVE_CLK
 	select HAVE_PATA_PLATFORM
 	select ICST
diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index c8e6ddf..27ef05e 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -21,6 +21,17 @@ struct clock_data {
 
 #define DEFINE_CLOCK_DATA(name)	struct clock_data name
 
+#ifdef CONFIG_ARCH_SCHED_CLOCK
+#define __DEFINE_SCHED_CLOCK_ALIAS(name)
+#else
+#define __DEFINE_SCHED_CLOCK_ALIAS(name) \
+	unsigned long long sched_clock(void) __attribute__ ((alias (#name)));
+#endif
+
+#define DEFINE_SCHED_CLOCK_FUNC(name) \
+	__DEFINE_SCHED_CLOCK_ALIAS(name)	\
+	static unsigned long long notrace name(void)
+
 static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 {
 	return (cyc * mult) >> shift;
@@ -94,20 +105,35 @@ static inline unsigned long long cyc_to_sched_clock(struct clock_data *cd,
  * and shift.  Also setup a timer to ensure that the epoch is refreshed
  * at the appropriate time interval, which will call your update
  * handler.
+ *
+ * Use the _arch_ version if you want your sched_clock function to be
+ * selected at run time (if CONFIG_ARCH_SCHED_CLOCK is enabled).
  */
-void init_sched_clock(struct clock_data *, void (*)(void),
+void init_arch_sched_clock(struct clock_data *, void (*)(void),
+	unsigned long long (*)(void),
 	unsigned int, unsigned long);
 
+static inline void init_sched_clock(struct clock_data *cd,
+				    void (*update)(void),
+				    unsigned int bits, unsigned long rate)
+{
+	init_arch_sched_clock(cd, update, NULL, bits, rate);
+}
+
 /*
  * Use this initialization function rather than init_sched_clock() if
  * you're using cyc_to_fixed_sched_clock, which will warn if your
  * constants are incorrect.
+ *
+ * Use the _arch_ version if you want your sched_clock function to be
+ * selected at run time (if CONFIG_ARCH_SCHED_CLOCK is enabled).
  */
-static inline void init_fixed_sched_clock(struct clock_data *cd,
-	void (*update)(void), unsigned int bits, unsigned long rate,
+static inline void init_fixed_arch_sched_clock(struct clock_data *cd,
+	void (*update)(void), unsigned long long (*sched_clock_fn)(void),
+	unsigned int bits, unsigned long rate,
 	u32 mult, u32 shift)
 {
-	init_sched_clock(cd, update, bits, rate);
+	init_arch_sched_clock(cd, update, sched_clock_fn, bits, rate);
 	if (cd->mult != mult || cd->shift != shift) {
 		pr_crit("sched_clock: wrong multiply/shift: %u>>%u vs calculated %u>>%u\n"
 			"sched_clock: fix multiply/shift to avoid scheduler hiccups\n",
@@ -115,6 +141,13 @@ static inline void init_fixed_sched_clock(struct clock_data *cd,
 	}
 }
 
+static inline void init_fixed_sched_clock(struct clock_data *cd,
+	void (*update)(void), unsigned int bits, unsigned long rate,
+	u32 mult, u32 shift)
+{
+	init_fixed_arch_sched_clock(cd, update, NULL, bits, rate, mult, shift);
+}
+
 extern void sched_clock_postinit(void);
 
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..3c1d08b 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -18,13 +18,29 @@ static void sched_clock_poll(unsigned long wrap_ticks);
 static DEFINE_TIMER(sched_clock_timer, sched_clock_poll, 0, 0);
 static void (*sched_clock_update_fn)(void);
 
+#ifdef CONFIG_ARCH_SCHED_CLOCK
+static unsigned long long notrace default_sched_clock(void)
+{
+	return (unsigned long long)(jiffies - INITIAL_JIFFIES)
+					* (NSEC_PER_SEC / HZ);
+}
+
+static unsigned long long __read_mostly (*sched_clock_fn)(void) = default_sched_clock;
+
+unsigned long long notrace sched_clock(void)
+{
+	return sched_clock_fn();
+}
+#endif
+
 static void sched_clock_poll(unsigned long wrap_ticks)
 {
 	mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
 	sched_clock_update_fn();
 }
 
-void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
+void __init init_arch_sched_clock(struct clock_data *cd, void (*update)(void),
+	unsigned long long (*arch_sched_clock_fn)(void),
 	unsigned int clock_bits, unsigned long rate)
 {
 	unsigned long r, w;
@@ -33,6 +49,11 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
 
 	sched_clock_update_fn = update;
 
+#ifdef CONFIG_ARCH_SCHED_CLOCK
+	if (arch_sched_clock_fn)
+		sched_clock_fn = arch_sched_clock_fn;
+#endif
+
 	/* calculate the mult/shift to convert counter ticks to ns. */
 	clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC, 0);
 
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index 3d6a4c2..d6ebd0f 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -34,7 +34,7 @@ static void __iomem *ctr;
 #define SC_MULT		2796202667u
 #define SC_SHIFT	26
 
-unsigned long long notrace sched_clock(void)
+DEFINE_SCHED_CLOCK_FUNC(versatile_sched_clock)
 {
 	if (ctr) {
 		u32 cyc = readl(ctr);
@@ -53,6 +53,7 @@ static void notrace versatile_update_sched_clock(void)
 void __init versatile_sched_clock_init(void __iomem *reg, unsigned long rate)
 {
 	ctr = reg;
-	init_fixed_sched_clock(&cd, versatile_update_sched_clock,
-			       32, rate, SC_MULT, SC_SHIFT);
+	init_fixed_arch_sched_clock(&cd, versatile_update_sched_clock,
+				    versatile_sched_clock,
+				    32, rate, SC_MULT, SC_SHIFT);
 }
-- 
1.7.0.4
