From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 09:29:49 +0000
Subject: [PATCH 07/13] ARM: u300: convert sched_clock() to use new
	infrastructure
In-Reply-To: <20101216092527.GL9937@n2100.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTA9l-00079g-AA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert u300 to use the new sched_clock() infrastructure for extending
32bit counters to full 64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig           |    1 +
 arch/arm/mach-u300/timer.c |   17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ec7b027..d5bd266 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -790,6 +790,7 @@ config ARCH_U300
 	bool "ST-Ericsson U300 Series"
 	depends on MMU
 	select CPU_ARM926T
+	select HAVE_SCHED_CLOCK
 	select HAVE_TCM
 	select ARM_AMBA
 	select ARM_VIC
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 377ff7f..42b9f5c 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -21,6 +21,7 @@
 #include <mach/hardware.h>
 
 /* Generic stuff */
+#include <asm/sched_clock.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -352,12 +353,18 @@ static struct clocksource clocksource_u300_1mhz = {
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by OMAP implementation.)
  */
+static DEFINE_CLOCK_DATA(cd);
+
 unsigned long long notrace sched_clock(void)
 {
-	return clocksource_cyc2ns(clocksource_u300_1mhz.read(
-				  &clocksource_u300_1mhz),
-				  clocksource_u300_1mhz.mult,
-				  clocksource_u300_1mhz.shift);
+	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+static void notrace u300_update_sched_clock(void)
+{
+	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
+	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 
@@ -375,6 +382,8 @@ static void __init u300_timer_init(void)
 	clk_enable(clk);
 	rate = clk_get_rate(clk);
 
+	init_sched_clock(&cd, u300_update_sched_clock, 32, rate);
+
 	/*
 	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
 	 * Example usage in cnh1601578 cpu subsystem pd_timer_app.c
-- 
1.6.2.5
