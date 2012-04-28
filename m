From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 Apr 2012 13:45:45 +0100
Subject: [PATCH] ARM: move read_{boot,
 persistent}_clock to the architecture level
Message-ID: <1335617145-24649-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment, read_persistent_clock is implemented at the
platform level, which makes it impossible to compile these
platforms in a single kernel.

Implement these two functions at the architecture level, and
provide a thin registration interface for both read_boot_clock
and read_persistent_clock. The two affected platforms (OMAP and
Tegra) are converted at the same time.

Compile tested only.

Reported-by: Jeff Ohlstein <johlstei@codeaurora.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/mach/time.h |    5 +++++
 arch/arm/kernel/time.c           |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/timer.c      |    5 +++--
 arch/arm/plat-omap/counter_32k.c |    6 ++++--
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index f73c908..6ca945f 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -42,4 +42,9 @@ struct sys_timer {
 
 extern void timer_tick(void);
 
+struct timespec;
+typedef void (*clock_access_fn)(struct timespec *);
+extern int register_persistent_clock(clock_access_fn read_boot,
+				     clock_access_fn read_persistent);
+
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index fe31b22..af2afb0 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -110,6 +110,42 @@ void timer_tick(void)
 }
 #endif
 
+static void dummy_clock_access(struct timespec *ts)
+{
+	ts->tv_sec = 0;
+	ts->tv_nsec = 0;
+}
+
+static clock_access_fn __read_persistent_clock = dummy_clock_access;
+static clock_access_fn __read_boot_clock = dummy_clock_access;;
+
+void read_persistent_clock(struct timespec *ts)
+{
+	__read_persistent_clock(ts);
+}
+
+void read_boot_clock(struct timespec *ts)
+{
+	__read_boot_clock(ts);
+}
+
+int __init register_persistent_clock(clock_access_fn read_boot,
+				     clock_access_fn read_persistent)
+{
+	/* Only allow the clockaccess functions to be registered once */
+	if (__read_persistent_clock == dummy_clock_access &&
+	    __read_boot_clock == dummy_clock_access) {
+		if (read_boot)
+			__read_boot_clock = read_boot;
+		if (read_persistent)
+			__read_persistent_clock = read_persistent;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 #if defined(CONFIG_PM) && !defined(CONFIG_GENERIC_CLOCKEVENTS)
 static int timer_suspend(void)
 {
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 1eed8d4..315672c 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -124,7 +124,7 @@ static u64 tegra_rtc_read_ms(void)
 }
 
 /*
- * read_persistent_clock -  Return time from a persistent clock.
+ * tegra_read_persistent_clock -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
@@ -133,7 +133,7 @@ static u64 tegra_rtc_read_ms(void)
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-void read_persistent_clock(struct timespec *ts)
+static void tegra_read_persistent_clock(struct timespec *ts)
 {
 	u64 delta;
 	struct timespec *tsp = &persistent_ts;
@@ -243,6 +243,7 @@ static void __init tegra_init_timer(void)
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_register_device(&tegra_clockevent);
 	tegra_twd_init();
+	register_persistent_clock(NULL, tegra_read_persistent_clock);
 }
 
 struct sys_timer tegra_timer = {
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5068fe5..44ae077 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/clocksource.h>
 
+#include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
 #include <plat/hardware.h>
@@ -43,7 +44,7 @@ static u32 notrace omap_32k_read_sched_clock(void)
 }
 
 /**
- * read_persistent_clock -  Return time from a persistent clock.
+ * omap_read_persistent_clock -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
@@ -52,7 +53,7 @@ static u32 notrace omap_32k_read_sched_clock(void)
 static struct timespec persistent_ts;
 static cycles_t cycles, last_cycles;
 static unsigned int persistent_mult, persistent_shift;
-void read_persistent_clock(struct timespec *ts)
+static void omap_read_persistent_clock(struct timespec *ts)
 {
 	unsigned long long nsecs;
 	cycles_t delta;
@@ -116,6 +117,7 @@ int __init omap_init_clocksource_32k(void)
 			printk(err, "32k_counter");
 
 		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
+		register_persistent_clock(NULL, omap_read_persistent_clock);
 	}
 	return 0;
 }
-- 
1.7.10
