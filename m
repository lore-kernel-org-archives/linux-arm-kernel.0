From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  4 Mar 2015 12:20:12 +0100
Subject: [PATCH] ARM: at91: remove ksz8081 phy fixup registration for
 sama5d4ek board
Message-ID: <1425468012-17274-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2b0ba96cea60 ("net: phy: micrel: disable NAND-tree for KSZ8021,
KSZ8031, KSZ8051, KSZ8081") automated the NAND-tree mode deactivation
process, thus making this phy fixup useless.
Remove it along with the associated headers inclusion.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/sama5.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 03dcb44..23d067a 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -11,13 +11,10 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/gpio.h>
-#include <linux/micrel_phy.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/phy.h>
 #include <linux/clk-provider.h>
-#include <linux/phy.h>
 
 #include <mach/hardware.h>
 
@@ -29,25 +26,8 @@
 
 #include "generic.h"
 
-static int ksz8081_phy_fixup(struct phy_device *phy)
-{
-	int value;
-
-	value = phy_read(phy, 0x16);
-	value &= ~0x20;
-	phy_write(phy, 0x16, value);
-
-	return 0;
-}
-
 static void __init sama5_dt_device_init(void)
 {
-	if (of_machine_is_compatible("atmel,sama5d4ek") &&
-	   IS_ENABLED(CONFIG_PHYLIB)) {
-		phy_register_fixup_for_id("fc028000.etherne:00",
-						ksz8081_phy_fixup);
-	}
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	at91sam9x5_pm_init();
 }
-- 
1.9.1
