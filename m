From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Sep 2013 19:53:44 +0200
Subject: [PATCH 11/26] ARM: dove: remove custom .init_time hook
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379526839-14798-12-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks. While at it, also remove some obsolete
includes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-dove/board-dt.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 49f72a8..ddb8663 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -10,17 +10,13 @@
 
 #include <linux/init.h>
 #include <linux/clk-provider.h>
-#include <linux/clocksource.h>
-#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/platform_data/usb-ehci-orion.h>
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/arch.h>
 #include <mach/dove.h>
 #include <mach/pm.h>
 #include <plat/common.h>
-#include <plat/irq.h>
 #include "common.h"
 
 /*
@@ -45,12 +41,6 @@ static void __init dove_legacy_clk_init(void)
 			 of_clk_get_from_provider(&clkspec));
 }
 
-static void __init dove_dt_time_init(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void __init dove_dt_init_early(void)
 {
 	mvebu_mbus_init("marvell,dove-mbus",
@@ -84,7 +74,6 @@ static const char * const dove_dt_board_compat[] = {
 DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
 	.map_io		= dove_map_io,
 	.init_early	= dove_dt_init_early,
-	.init_time	= dove_dt_time_init,
 	.init_machine	= dove_dt_init,
 	.restart	= dove_restart,
 	.dt_compat	= dove_dt_board_compat,
-- 
1.7.10.4
