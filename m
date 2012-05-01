From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:39:53 +0530
Subject: [PATCH 32/39] ARM: OMAP2+: board omap3stalker: gpmc driver adaptation
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Message-ID: <35ff5cf81c4a3049d8de3112b1a403c04e62916f.1335873032.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3stalker.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 4dffc95..5e92d54 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -56,6 +56,12 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>
 
@@ -74,7 +80,11 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
 static inline void __init omap3stalker_init_eth(void)
 {
 	omap_mux_init_gpio(19, OMAP_PIN_INPUT_PULLUP);
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	*gpmc_device_data = gpmc_smsc911x_init(&smsc911x_cfg);
+	if (*gpmc_device_data)
+		gpmc_data.num_device++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #else
@@ -443,6 +453,7 @@ static void __init omap3_stalker_init(void)
 	omap_mux_init_gpio(18, OMAP_PIN_INPUT_PULLUP);
 
 	omap3stalker_init_eth();
+	omap_init_gpmc(&gpmc_data);
 	omap3_stalker_display_init();
 /* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdr_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.10
