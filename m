From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:12:47 +0100
Subject: [Patch v3 16/23] ARM: MVEBU: Let kirkwood use the system controller
 for restart
In-Reply-To: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392819174-11634-17-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu system controller already supports restarting orion
systems. Remove all the C code which will be replaced by the system
controller.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2
Split the patch into two, DT goes into a new patch
---
 arch/arm/mach-mvebu/kirkwood.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 6e754a38f418..4c7bbec11b1a 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -27,6 +27,7 @@
 #include <plat/common.h>
 #include <plat/pcie.h>
 #include "kirkwood-pm.h"
+#include "common.h"
 
 static struct resource kirkwood_cpufreq_resources[] = {
 	[0] = {
@@ -68,23 +69,6 @@ static void __init kirkwood_cpuidle_init(void)
 	platform_device_register(&kirkwood_cpuidle);
 }
 
-/* Temporary here since mach-mvebu has a function we can use */
-static void kirkwood_restart(enum reboot_mode mode, const char *cmd)
-{
-	/*
-	 * Enable soft reset to assert RSTOUTn.
-	 */
-	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
-
-	/*
-	 * Assert soft reset.
-	 */
-	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
-
-	while (1)
-		;
-}
-
 #define MV643XX_ETH_MAC_ADDR_LOW	0x0414
 #define MV643XX_ETH_MAC_ADDR_HIGH	0x0418
 
@@ -204,6 +188,6 @@ static const char * const kirkwood_dt_board_compat[] = {
 DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
 	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
 	.init_machine	= kirkwood_dt_init,
-	.restart	= kirkwood_restart,
+	.restart	= mvebu_restart,
 	.dt_compat	= kirkwood_dt_board_compat,
 MACHINE_END
-- 
1.8.5.3
