From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:15 -0500
Subject: [PATCH v2 05/13] ARM: highbank: use OF init for sp804 timer
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove the highbank specific setup for the sp804 timer now that
clocksource_of_init will do it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 758150e..e7df2dd 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -32,8 +32,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
-#include <asm/hardware/arm_timer.h>
-#include <asm/hardware/timer-sp.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -90,33 +88,16 @@ static void __init highbank_init_irq(void)
 #endif
 }
 
-static struct clk_lookup lookup = {
-	.dev_id = "sp804",
-	.con_id = NULL,
-};
-
 static void __init highbank_timer_init(void)
 {
-	int irq;
 	struct device_node *np;
-	void __iomem *timer_base;
 
 	/* Map system registers */
 	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
 	sregs_base = of_iomap(np, 0);
 	WARN_ON(!sregs_base);
 
-	np = of_find_compatible_node(NULL, NULL, "arm,sp804");
-	timer_base = of_iomap(np, 0);
-	WARN_ON(!timer_base);
-	irq = irq_of_parse_and_map(np, 0);
-
 	of_clk_init(NULL);
-	lookup.clk = of_clk_get(np, 0);
-	clkdev_add(&lookup);
-
-	sp804_clocksource_and_sched_clock_init(timer_base + 0x20, "timer1");
-	sp804_clockevents_init(timer_base, irq, "timer0");
 
 	clocksource_of_init();
 }
-- 
1.7.10.4
