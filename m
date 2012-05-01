From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:51:55 +0530
Subject: [PATCH v4 20/39] ARM: OMAP2+: board omap3beagle: gpmc driver
 adaptation
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Message-ID: <35e950e9302ff6baec9c88224ca395cad620a022.1335874494.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 671ac1c..74bc7f6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -517,8 +517,16 @@ static void __init beagle_opp_init(void)
 	return;
 }
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static void __init omap3_beagle_init(void)
 {
+	struct omap_nand_platform_data *nand_data;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 
@@ -543,9 +551,17 @@ static void __init omap3_beagle_init(void)
 
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
-	board_nand_init(omap3beagle_nand_partitions,
+	nand_data = board_nand_init(omap3beagle_nand_partitions,
 		ARRAY_SIZE(omap3beagle_nand_partitions), GPMC_CS_NUM,
 		NAND_BUSWIDTH_16, NULL);
+	if (nand_data != NULL) {
+		*gpmc_device_data = gpmc_nand_init(nand_data);
+		if (*gpmc_device_data)
+			gpmc_data.num_device++;
+	} else
+		pr_err("error: %s: nand init\n", __func__);
+
+	omap_init_gpmc(&gpmc_data);
 
 	/* Ensure msecure is mux'd to be able to set the RTC. */
 	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
-- 
1.7.10
