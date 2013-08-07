From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  7 Aug 2013 20:52:32 -0300
Subject: [PATCH 1/5] clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
In-Reply-To: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1375919556-24104-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is almost cosmetic: we achieve a bit of consistency with
other clocksource drivers by using the CLOCKSOURCE_OF_DECLARE
macro for the boilerplate code.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c      |  4 ++--
 drivers/clocksource/time-armada-370-xp.c |  6 +++---
 include/linux/time-armada-370-xp.h       | 18 ------------------
 3 files changed, 5 insertions(+), 23 deletions(-)
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
index 1b04b7e..5ee4329 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -210,13 +210,11 @@ static struct local_timer_ops armada_370_xp_local_timer_ops = {
 	.stop	=  armada_370_xp_timer_stop,
 };
 
-void __init armada_370_xp_timer_init(void)
+static void __init armada_370_xp_timer_init(struct device_node *np)
 {
 	u32 u;
-	struct device_node *np;
 	int res;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-timer");
 	timer_base = of_iomap(np, 0);
 	WARN_ON(!timer_base);
 	local_base = of_iomap(np, 1);
@@ -299,3 +297,5 @@ void __init armada_370_xp_timer_init(void)
 #endif
 	}
 }
+CLOCKSOURCE_OF_DECLARE(armada_370_xp, "marvell,armada-370-xp-timer",
+		       armada_370_xp_timer_init);
diff --git a/include/linux/time-armada-370-xp.h b/include/linux/time-armada-370-xp.h
deleted file mode 100644
index dfdfdc0..0000000
--- a/include/linux/time-armada-370-xp.h
+++ /dev/null
@@ -1,18 +0,0 @@
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
-#include <linux/init.h>
-
-void __init armada_370_xp_timer_init(void);
-
-#endif
-- 
1.8.1.5
