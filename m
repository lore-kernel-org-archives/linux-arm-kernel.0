From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 09:28:07 +0000
Subject: [PATCH 02/13] ARM: ixp4xx: convert sched_clock() to use new
	infrastructure
In-Reply-To: <20101216092527.GL9937@n2100.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTA87-00079L-IF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ixp4xx to use the new sched_clock() infrastructure for
extending 32bit counters to full 64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-ixp4xx/common.c |   31 ++++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ed7a0a7..6f58bce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -437,6 +437,7 @@ config ARCH_IXP4XX
 	select CPU_XSCALE
 	select GENERIC_GPIO
 	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
 	select DMABOUNCE if PCI
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index e0b91d8..4dbfcbb 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/irq.h>
+#include <asm/sched_clock.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -399,6 +400,23 @@ void __init ixp4xx_sys_init(void)
 }
 
 /*
+ * sched_clock()
+ */
+static DEFINE_CLOCK_DATA(cd);
+
+unsigned long long notrace sched_clock(void)
+{
+	u32 cyc = *IXP4XX_OSTS;
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+static void notrace ixp4xx_update_sched_clock(void)
+{
+	u32 cyc = *IXP4XX_OSTS;
+	update_sched_clock(&cd, cyc, (u32)~0);
+}
+
+/*
  * clocksource
  */
 static cycle_t ixp4xx_get_cycles(struct clocksource *cs)
@@ -418,18 +436,9 @@ unsigned long ixp4xx_timer_freq = FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-	clocksource_register_hz(&clocksource_ixp4xx, ixp4xx_timer_freq);
-}
-
-/*
- * sched_clock()
- */
-unsigned long long notrace sched_clock(void)
-{
-	cycle_t cyc = ixp4xx_get_cycles(NULL);
-	struct clocksource *cs = &clocksource_ixp4xx;
+	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
 
-	return clocksource_cyc2ns(cyc, cs->mult, cs->shift);
+	clocksource_register_hz(&clocksource_ixp4xx, ixp4xx_timer_freq);
 }
 
 /*
-- 
1.6.2.5
