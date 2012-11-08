From: stano@meduna.org (Stanislav Meduna)
Date: Thu, 08 Nov 2012 23:45:45 +0100
Subject: [PATCH] ARM: mxs: Setup scheduler clock
In-Reply-To: <20121106134630.GD27643@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
 <20121106134630.GD27643@S2100-06.ap.freescale.net>
Message-ID: <509C3619.30701@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

OK, as the problem with 16-bit fast ticking timer looks to
be more complicated, I'd like to submit the patch for the 32-bit
ones.

Thanks
-- 
                                    Stano

-------------- next part --------------
>From 74092cc0217a5bab6f80ee07aa188a54f5792634 Mon Sep 17 00:00:00 2001
From: Stanislav Meduna <stano@meduna.org>
Date: Mon, 8 Nov 2012 23:39:14 +0100
Subject: [PATCH] ARM: mxs: Setup scheduler clock

Setup scheduler clock on ARM MXS platforms with a 32-bit timrot
such as MX.28. This allows the scheduler to use sub-jiffy resolution.

The corresponding change for 16-bit v1 timrots is not possible
at the moment due to rounding issues with clock values wrapping
faster than once per several seconds in the common ARM platform code.

Signed-off-by: Stanislav Meduna <stano@meduna.org>
---
 arch/arm/mach-mxs/timer.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index 564a632..4b6e36c 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 
 #include <asm/mach/time.h>
+#include <asm/sched_clock.h>
 #include <mach/mxs.h>
 #include <mach/common.h>
 
@@ -230,15 +231,22 @@ static struct clocksource clocksource_mxs = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static u32 notrace mxs_read_sched_clock_v2(void)
+{
+	return ~readl_relaxed(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1));
+}
+
 static int __init mxs_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
 	if (timrot_is_v1())
 		clocksource_register_hz(&clocksource_mxs, c);
-	else
+	else {
 		clocksource_mmio_init(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1),
 			"mxs_timer", c, 200, 32, clocksource_mmio_readl_down);
+		setup_sched_clock(mxs_read_sched_clock_v2, 32, c);
+	}
 
 	return 0;
 }
-- 
1.7.0.4
