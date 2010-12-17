From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:50:15 +0000
Subject: [PATCH 35/40] ARM: iop: convert sched_clock() to use new
	infrastructure
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYpD-0006ju-G0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert iop platforms to use the new sched_clock() infrastructure for
extending 32bit counters to full 64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig         |    1 +
 arch/arm/plat-iop/time.c |   14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d5bd266..58e2fe3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -992,6 +992,7 @@ config ARCH_ACORN
 config PLAT_IOP
 	bool
 	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
 
 config PLAT_ORION
 	bool
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 0c6da54..405fc09 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -50,15 +50,21 @@ static struct clocksource iop_clocksource = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static DEFINE_CLOCK_DATA(cd);
+
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
 unsigned long long notrace sched_clock(void)
 {
-	cycle_t cyc = iop_clocksource_read(NULL);
-	struct clocksource *cs = &iop_clocksource;
+	u32 cyc = 0xffffffffu - read_tcr1();
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
 
-	return clocksource_cyc2ns(cyc, cs->mult, cs->shift);
+static void notrace iop_update_sched_clock(void)
+{
+	u32 cyc = 0xffffffffu - read_tcr1();
+	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 /*
@@ -143,6 +149,8 @@ void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
 
+	init_sched_clock(&cd, iop_update_sched_clock, 32, tick_rate);
+
 	ticks_per_jiffy = DIV_ROUND_CLOSEST(tick_rate, HZ);
 	iop_tick_rate = tick_rate;
 
-- 
1.6.2.5
