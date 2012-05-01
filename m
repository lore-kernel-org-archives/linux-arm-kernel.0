From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:52:21 +0530
Subject: [PATCH v4 24/39] ARM: OMAP2+: board 3430sdp: gpmc driver adaptation
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Message-ID: <e00849b862393d44ff8a322c1a5513cb472d8248.1335874494.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 367a466..cea5ca5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -59,6 +59,12 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
+static struct gpmc_device_pdata *gpmc_device_data[4];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -444,7 +450,11 @@ static void __init board_smc91x_init(void)
 	else
 		board_smc91x_data.gpio_irq = 29;
 
-	gpmc_smc91x_init(&board_smc91x_data);
+	*gpmc_cur = gpmc_smc91x_init(&board_smc91x_data);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #else
@@ -621,7 +631,10 @@ static void __init omap_3430sdp_init(void)
 	omap_sdrc_init(hyb18m512160af6_sdrc_params, NULL);
 	usb_musb_init(NULL);
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0, NULL);
+	gpmc_data.num_device += board_flash_init(sdp_flash_partitions,
+					chip_sel_3430, 0, gpmc_cur) - gpmc_cur;
+	omap_init_gpmc(&gpmc_data);
+
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usbhs_init(&usbhs_bdata);
-- 
1.7.10
