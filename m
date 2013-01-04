From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  3 Jan 2013 20:55:27 -0700
Subject: [PATCH] ARM: bcm2835: make use of CLKSRC_OF
Message-ID: <1357271727-2065-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using CLKSRC_OF enables deletion of the SoC-specific header
bcm2835_timer.h, replacing the custom function bcm2835_timer_init() with
the standardized automatic clocksource_of_init().

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
This is based on my arm-timer-rework branch, for which I'll send a pull
request to arm-soc tomorrow.

 arch/arm/Kconfig                    |    1 +
 arch/arm/mach-bcm2835/bcm2835.c     |    4 ++--
 drivers/clocksource/bcm2835_timer.c |    5 +++--
 include/linux/bcm2835_timer.h       |   22 ----------------------
 4 files changed, 6 insertions(+), 26 deletions(-)
 delete mode 100644 include/linux/bcm2835_timer.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91f8d78..2d274df 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -345,6 +345,7 @@ config ARCH_BCM2835
 	select ARM_ERRATA_411920
 	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
+	select CLKSRC_OF
 	select COMMON_CLK
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index 1a446a1..6f57859 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -17,8 +17,8 @@
 #include <linux/irqchip/bcm2835.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/bcm2835_timer.h>
 #include <linux/clk/bcm2835.h>
+#include <linux/clocksource.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -132,7 +132,7 @@ DT_MACHINE_START(BCM2835, "BCM2835")
 	.init_irq = bcm2835_init_irq,
 	.handle_irq = bcm2835_handle_irq,
 	.init_machine = bcm2835_init,
-	.init_time = bcm2835_timer_init,
+	.init_time = clocksource_of_init,
 	.restart = bcm2835_restart,
 	.dt_compat = bcm2835_compat
 MACHINE_END
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 7f796d8f..50c68fe 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -16,7 +16,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/bcm2835_timer.h>
 #include <linux/bitops.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
@@ -101,7 +100,7 @@ static struct of_device_id bcm2835_time_match[] __initconst = {
 	{}
 };
 
-void __init bcm2835_timer_init(void)
+static void __init bcm2835_timer_init(void)
 {
 	struct device_node *node;
 	void __iomem *base;
@@ -155,3 +154,5 @@ void __init bcm2835_timer_init(void)
 
 	pr_info("bcm2835: system timer (irq = %d)\n", irq);
 }
+CLOCKSOURCE_OF_DECLARE(bcm2835, "brcm,bcm2835-system-timer",
+			bcm2835_timer_init);
diff --git a/include/linux/bcm2835_timer.h b/include/linux/bcm2835_timer.h
deleted file mode 100644
index ca17aa8..0000000
--- a/include/linux/bcm2835_timer.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright 2012 Simon Arlott
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __BCM2835_TIMER_H
-#define __BCM2835_TIMER_H
-
-#include <asm/mach/time.h>
-
-extern void bcm2835_timer_init(void);
-
-#endif
-- 
1.7.10.4
