From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 22:58:16 +0100
Subject: [PATCH 13/17] ARM: at91: rework initialization for sam9 based boards
In-Reply-To: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421359100-8930-14-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove useless .map_io and .init_early by moving at91_dt_initialize() to
sam9*_dt_device_init(). Also rename board-dt-sam9.c to at91sam9.c

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Makefile                        |  4 +---
 arch/arm/mach-at91/{board-dt-sam9.c => at91sam9.c} | 16 ++--------------
 2 files changed, 3 insertions(+), 17 deletions(-)
 rename arch/arm/mach-at91/{board-dt-sam9.c => at91sam9.c} (76%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 76d6d869bf4e..27b503defe80 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -8,12 +8,10 @@ obj-$(CONFIG_SOC_AT91SAM9)	+= sam9_smc.o
 
 # CPU-specific support
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o
+obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAMA5D3)	+= sama5d3.o
 obj-$(CONFIG_SOC_SAMA5D4)	+= sama5d4.o
 
-# AT91SAM board with device-tree
-obj-$(CONFIG_SOC_AT91SAM9) += board-dt-sam9.o
-
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/at91sam9.c
similarity index 76%
rename from arch/arm/mach-at91/board-dt-sam9.c
rename to arch/arm/mach-at91/at91sam9.c
index 6f90201dbd47..8b890644d6f0 100644
--- a/arch/arm/mach-at91/board-dt-sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -7,20 +7,10 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/clk-provider.h>
 
-#include <asm/setup.h>
-#include <asm/irq.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
 #include <asm/system_misc.h>
 
 #include "generic.h"
@@ -29,6 +19,7 @@ static void __init sam9_dt_device_init(void)
 {
 	arm_pm_idle = at91sam9_idle;
 	at91_sam9260_pm_init();
+	at91_dt_initialize();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
@@ -40,8 +31,6 @@ static const char *at91_dt_board_compat[] __initdata = {
 
 DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	/* Maintainer: Atmel */
-	.map_io		= at91_map_io,
-	.init_early	= at91_dt_initialize,
 	.init_machine	= sam9_dt_device_init,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
@@ -50,6 +39,7 @@ static void __init sam9g45_dt_device_init(void)
 {
 	arm_pm_idle = at91sam9_idle;
 	at91_sam9g45_pm_init();
+	at91_dt_initialize();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
@@ -61,8 +51,6 @@ static const char *at91_9g45_board_compat[] __initconst = {
 
 DT_MACHINE_START(at91sam9g45_dt, "Atmel AT91SAM9G45")
 	/* Maintainer: Atmel */
-	.map_io		= at91_map_io,
-	.init_early	= at91_dt_initialize,
 	.init_machine	= sam9g45_dt_device_init,
 	.dt_compat	= at91_9g45_board_compat,
 MACHINE_END
-- 
2.1.0
