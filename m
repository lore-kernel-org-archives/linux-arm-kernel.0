From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 22:27:51 +0100
Subject: [PATCH 1/2] ARM: ux500: decomission the non-DT MTU init sequence
Message-ID: <1384896471-9384-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MTU is now only initialized using the native clocksource
device tree matching.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/timer.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index ca60bbd9361b..1a9051b6f932 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -10,7 +10,6 @@
 #include <linux/clocksource.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/platform_data/clocksource-nomadik-mtu.h>
 
 #include <asm/smp_twd.h>
 
@@ -44,17 +43,14 @@ const static struct of_device_id prcmu_timer_of_match[] __initconst = {
 
 void __init ux500_timer_init(void)
 {
-	void __iomem *mtu_timer_base;
 	void __iomem *prcmu_timer_base;
 	void __iomem *tmp_base;
 	struct device_node *np;
 
-	if (cpu_is_u8500_family() || cpu_is_ux540_family()) {
-		mtu_timer_base = __io_address(U8500_MTU0_BASE);
+	if (cpu_is_u8500_family() || cpu_is_ux540_family())
 		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
-	} else {
+	else
 		ux500_unknown_soc();
-	}
 
 	np = of_find_matching_node(NULL, prcmu_timer_of_match);
 	if (!np)
@@ -67,26 +63,6 @@ void __init ux500_timer_init(void)
 	prcmu_timer_base = tmp_base;
 
 dt_fail:
-	/* Doing it the old fashioned way. */
-
-	/*
-	 * Here we register the timerblocks active in the system.
-	 * Localtimers (twd) is started when both cpu is up and running.
-	 * MTU register a clocksource, clockevent and sched_clock.
-	 * Since the MTU is located in the VAPE power domain
-	 * it will be cleared in sleep which makes it unsuitable.
-	 * We however need it as a timer tick (clockevent)
-	 * during boot to calibrate delay until twd is started.
-	 * RTC-RTT have problems as timer tick during boot since it is
-	 * depending on delay which is not yet calibrated. RTC-RTT is in the
-	 * always-on powerdomain and is used as clockevent instead of twd when
-	 * sleeping.
-	 * The PRCMU timer 4 register a clocksource and
-	 * sched_clock with higher rating then MTU since is always-on.
-	 *
-	 */
-	if (!of_have_populated_dt())
-		nmdk_timer_init(mtu_timer_base, IRQ_MTU0);
 	clksrc_dbx500_prcmu_init(prcmu_timer_base);
 	ux500_twd_init();
 }
-- 
1.8.3.1
