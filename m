From: j.weitzel@phytec.de (Jan Weitzel)
Date: Thu, 17 Mar 2011 13:44:30 +0100
Subject: [PATCH 2/2] ARM: mxc: Add sched_clock to mxc platform
In-Reply-To: <1300365870-26193-1-git-send-email-j.weitzel@phytec.de>
References: <1300365870-26193-1-git-send-email-j.weitzel@phytec.de>
Message-ID: <1300365870-26193-2-git-send-email-j.weitzel@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sched_clock using cyc_to_sched_clock and update_sched_clock
with HAVE_SCHED_CLOCK
tested on iMX27 and iMX35

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/Kconfig         |    1 +
 arch/arm/plat-mxc/time.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 26d45e5..076e307 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -356,6 +356,7 @@ config ARCH_MXC
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select HAVE_SCHED_CLOCK
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 0142e4b..2237ff8 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -27,6 +27,7 @@
 #include <linux/clk.h>
 
 #include <mach/hardware.h>
+#include <asm/sched_clock.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
 
@@ -128,6 +129,20 @@ static struct clocksource clocksource_mxc = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static DEFINE_CLOCK_DATA(cd);
+unsigned long long notrace sched_clock(void)
+{
+	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
+
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+static void notrace mxc_update_sched_clock(void)
+{
+	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
+	update_sched_clock(&cd, cyc, (u32)~0);
+}
+
 static int __init mxc_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
@@ -137,6 +152,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 	else
 		clocksource_mxc.read = mx1_2_get_cycles;
 
+	init_sched_clock(&cd, mxc_update_sched_clock, 32, c);
 	clocksource_register_hz(&clocksource_mxc, c);
 
 	return 0;
-- 
1.7.0.4
