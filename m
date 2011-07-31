From: l.pinguin@gmail.com (Remy Bohmer)
Date: Sun, 31 Jul 2011 17:03:13 +0200
Subject: [PATCH] Add sched_clock to AT91 TCB clocksource driver
Message-ID: <1312124593-6088-1-git-send-email-linux@bohmer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On AT91 there is no architecture specific sched_clock() implementation,
so the default fallback is used. This fallback uses the jiffie counter
as sched_clock().
There is NO standard clocksource available that is accurate enough,
except the TC-based clocksource implementation. Therefor this
implementation is used as base for the sched_clock(). This clocksource
offers sub-millisecond time-stamping. (< 200 ns)

Signed-off-by: Remy Bohmer <linux@bohmer.net>
---
 arch/arm/Kconfig                 |    1 +
 arch/arm/kernel/sched_clock.c    |    7 +++++++
 drivers/clocksource/tcb_clksrc.c |   23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..e0563a7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -296,6 +296,7 @@ config ARCH_AT91
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select ARM_PATCH_PHYS_VIRT if MMU
+	select HAVE_SCHED_CLOCK if ATMEL_TCB_CLKSRC
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..f9028e4 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -20,6 +20,13 @@ static void (*sched_clock_update_fn)(void);
 
 static void sched_clock_poll(unsigned long wrap_ticks)
 {
+	/*
+	 * The sched_clock_update_fn may be initialised AFTER first call to
+	 * time_init()
+	 */
+	if (unlikely(!sched_clock_update_fn))
+		return;
+
 	mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
 	sched_clock_update_fn();
 }
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 79c47e8..d6069b3 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/atmel_tc.h>
 
+#include <asm/sched_clock.h>
 
 /*
  * We're configured to use a specific TC block, one that's not hooked
@@ -210,6 +211,23 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 
 #endif
 
+static DEFINE_CLOCK_DATA(cd);
+
+unsigned long long notrace sched_clock(void)
+{
+	if (likely(tcaddr)) {
+		cycle_t cyc = tc_get_cycles(&clksrc);
+		return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	}
+	return 0;
+}
+
+static void notrace tcb_update_sched_clock(void)
+{
+	cycle_t cyc = tc_get_cycles(&clksrc);
+	update_sched_clock(&cd, cyc, (u32)~0);
+}
+
 static int __init tcb_clksrc_init(void)
 {
 	static char bootinfo[] __initdata
@@ -297,6 +315,11 @@ static int __init tcb_clksrc_init(void)
 	/* channel 2:  periodic and oneshot timer support */
 	setup_clkevents(tc, clk32k_divisor_idx);
 
+	/* Now prepare the sched_clock support */
+	init_sched_clock(&cd, tcb_update_sched_clock, 32, divided_rate);
+	sched_clock_postinit();
+
 	return 0;
 }
 arch_initcall(tcb_clksrc_init);
+
-- 
1.7.4.1
