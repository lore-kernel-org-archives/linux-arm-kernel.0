From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:39:24 +0530
Subject: [PATCH 28/39] ARM: OMAP2+: board ldp: gpmc driver adaptation
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Message-ID: <49f92dddb82efaa48cc40ec9451f0c051b6e311d.1335873032.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index b76f28d..1ebc024 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -43,6 +43,7 @@
 #include <asm/delay.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smsc911x.h>
+#include <plat/nand.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
@@ -58,6 +59,13 @@
 #define DEBUG_BASE		0x08000000
 #define LDP_ETHR_START		DEBUG_BASE
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_1),
 	KEY(1, 0, KEY_2),
@@ -180,7 +188,9 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
 
 static inline void __init ldp_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	*gpmc_cur = gpmc_smsc911x_init(&smsc911x_cfg);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
 }
 
 /* LCD */
@@ -418,6 +428,8 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 
 static void __init omap_ldp_init(void)
 {
+	struct omap_nand_platform_data *nand_data;
+
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	ldp_init_smsc911x();
@@ -427,8 +439,16 @@ static void __init omap_ldp_init(void)
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	usb_musb_init(NULL);
-	board_nand_init(ldp_nand_partitions, ARRAY_SIZE(ldp_nand_partitions),
-				ZOOM_NAND_CS, 0, nand_default_timings);
+
+	nand_data = board_nand_init(ldp_nand_partitions,
+			ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS,
+			0, nand_default_timings);
+	if (nand_data != NULL) {
+		*gpmc_cur++ = gpmc_nand_init(nand_data);
+		gpmc_data.num_device++;
+	}
+
+	omap_init_gpmc(&gpmc_data);
 
 	omap_hsmmc_init(mmc);
 	ldp_display_init();
-- 
1.7.10
