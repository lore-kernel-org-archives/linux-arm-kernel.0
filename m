From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:39:46 +0530
Subject: [PATCH 31/39] ARM: OMAP2+: board omap3pandora: gpmc driver adaptation
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Message-ID: <84e89d05d2218d8c788a4bc92a81f7a45d66a8ab.1335873032.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 33d995d..25b2de6 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -57,6 +57,12 @@
 #define PANDORA_WIFI_NRESET_GPIO	23
 #define OMAP3_PANDORA_TS_GPIO		94
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static struct mtd_partition omap3pandora_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -607,8 +613,9 @@ static void __init omap3pandora_init(void)
 	omap_ads7846_init(1, OMAP3_PANDORA_TS_GPIO, 0, NULL);
 	usbhs_init(&usbhs_bdata);
 	usb_musb_init(NULL);
-	gpmc_nand_init(&pandora_nand_data);
-
+	*gpmc_device_data = gpmc_nand_init(&pandora_nand_data);
+	gpmc_data.num_device++;
+	omap_init_gpmc(&gpmc_data);
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-- 
1.7.10
