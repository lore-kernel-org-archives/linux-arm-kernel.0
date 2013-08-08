From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  8 Aug 2013 08:32:29 -0300
Subject: [PATCH v2 3/6] clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
In-Reply-To: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1375961552-12967-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is almost cosmetic: we achieve a bit of consistency with
other clocksource drivers by using the CLOCKSOURCE_OF_DECLARE
macro for the boilerplate code.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c      |  4 ++--
 drivers/clocksource/time-armada-370-xp.c |  7 +++----
 include/linux/time-armada-370-xp.h       | 16 ----------------
 3 files changed, 5 insertions(+), 22 deletions(-)
 delete mode 100644 include/linux/time-armada-370-xp.h

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 97cbb80..4ea03ad 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -18,7 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
-#include <linux/time-armada-370-xp.h>
+#include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -69,7 +69,7 @@ static void __init armada_370_xp_mbus_init(void)
 static void __init armada_370_xp_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
-	armada_370_xp_timer_init();
+	clocksource_of_init();
 	coherency_init();
 	armada_370_xp_mbus_init();
 #ifdef CONFIG_CACHE_L2X0
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index bbb727c..a781dce 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -30,7 +30,6 @@
 #include <linux/module.h>
 #include <linux/sched_clock.h>
 #include <linux/percpu.h>
-#include <linux/time-armada-370-xp.h>
 
 /*
  * Timer block registers.
@@ -219,13 +218,11 @@ static struct notifier_block armada_370_xp_timer_cpu_nb = {
 	.notifier_call = armada_370_xp_timer_cpu_notify,
 };
 
-void __init armada_370_xp_timer_init(void)
+static void __init armada_370_xp_timer_init(struct device_node *np)
 {
 	u32 clr = 0, set = 0;
-	struct device_node *np;
 	int res;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-timer");
 	timer_base = of_iomap(np, 0);
 	WARN_ON(!timer_base);
 	local_base = of_iomap(np, 1);
@@ -289,3 +286,5 @@ void __init armada_370_xp_timer_init(void)
 	if (!res)
 		armada_370_xp_timer_setup(this_cpu_ptr(armada_370_xp_evt));
 }
+CLOCKSOURCE_OF_DECLARE(armada_370_xp, "marvell,armada-370-xp-timer",
+		       armada_370_xp_timer_init);
diff --git a/include/linux/time-armada-370-xp.h b/include/linux/time-armada-370-xp.h
deleted file mode 100644
index 6fb0856..0000000
--- a/include/linux/time-armada-370-xp.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Marvell Armada 370/XP SoC timer handling.
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- * Gregory CLEMENT <gregory.clement@free-electrons.com>
- * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- */
-#ifndef __TIME_ARMADA_370_XPPRCMU_H
-#define __TIME_ARMADA_370_XPPRCMU_H
-
-void armada_370_xp_timer_init(void);
-
-#endif
-- 
1.8.1.5
