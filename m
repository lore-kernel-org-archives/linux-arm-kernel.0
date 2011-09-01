From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:25:12 +0200
Subject: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular board
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897912-18178-8-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid conflict with the new board-omap3-dt.c file,
remove the .dt_compat entry from the beagle regular board
file.

Any DT work for OMAP3 will have to be done on the generic DT
board file to avoid breaking the legacy board support until
DT migration is done.

Based on orginal patch fropm Manju:
http://www.spinics.net/lists/linux-omap/msg55832.html

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a7923ca..2c358a2 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/of_platform.h>
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
@@ -388,9 +387,7 @@ static int __init omap3_beagle_i2c_init(void)
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
-#ifdef CONFIG_OF
 	omap_register_i2c_bus(2, 100, NULL, 0);
-#endif /* CONFIG_OF */
 	return 0;
 }
 
@@ -528,10 +525,6 @@ static void __init beagle_opp_init(void)
 
 static void __init omap3_beagle_init(void)
 {
-#ifdef CONFIG_OF
-	of_platform_prepare(NULL, NULL);
-#endif /* CONFIG_OF */
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 	omap3_beagle_i2c_init();
@@ -563,11 +556,6 @@ static void __init omap3_beagle_init(void)
 	beagle_opp_init();
 }
 
-static const char *omap3_beagle_dt_match[] __initdata = {
-	"ti,omap3-beagle",
-	NULL
-};
-
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.boot_params	= 0x80000100,
@@ -577,5 +565,4 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
-	.dt_compat	= omap3_beagle_dt_match,
 MACHINE_END
-- 
1.7.0.4
