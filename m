From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 22:58:17 +0100
Subject: [PATCH 14/17] ARM: at91: rework initialization for sama5 based boards
In-Reply-To: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421359100-8930-15-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed useless .map_io for sama5d3 and .init_early by moving
at91_dt_initialize() to sama5*_dt_device_init()

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/sama5d3.c | 9 ++-------
 arch/arm/mach-at91/sama5d4.c | 3 ++-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
index 6f73a34cb7e4..752d1612ff1f 100644
--- a/arch/arm/mach-at91/sama5d3.c
+++ b/arch/arm/mach-at91/sama5d3.c
@@ -7,20 +7,17 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/init.h>
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <mach/sama5d3.h>
-#include <mach/cpu.h>
 
 #include "generic.h"
 
 static void __init sama5_dt_device_init(void)
 {
 	at91_sam9260_pm_init();
+	at91_dt_initialize();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -31,8 +28,6 @@ static const char *sama5_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
 	/* Maintainer: Atmel */
-	.map_io		= at91_map_io,
-	.init_early	= at91_dt_initialize,
 	.init_machine	= sama5_dt_device_init,
 	.dt_compat	= sama5_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/sama5d4.c b/arch/arm/mach-at91/sama5d4.c
index 87c71afedb57..2f1ee08dc49f 100644
--- a/arch/arm/mach-at91/sama5d4.c
+++ b/arch/arm/mach-at91/sama5d4.c
@@ -52,6 +52,8 @@ static void __init sama5d4_map_io(void)
 static void __init sama5d4_dt_device_init(void)
 {
 	at91_sam9260_pm_init();
+	at91_dt_initialize();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -63,7 +65,6 @@ static const char *sama5_alt_dt_board_compat[] __initconst = {
 DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5 (Device Tree)")
 	/* Maintainer: Atmel */
 	.map_io		= sama5d4_map_io,
-	.init_early	= at91_dt_initialize,
 	.init_machine	= sama5d4_dt_device_init,
 	.dt_compat	= sama5_alt_dt_board_compat,
 	.l2c_aux_mask	= ~0UL,
-- 
2.1.0
