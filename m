From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 1 May 2012 17:39:32 +0530
Subject: [PATCH 29/39] ARM: OMAP2+: board n8x0: gpmc driver adaptation
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Message-ID: <afbabad89b7e0b303cbd6c92dd8661531041e390.1335873032.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-n8x0.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 94f6077..d3d866a 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -36,6 +36,7 @@
 #include <plat/onenand.h>
 #include <plat/mmc.h>
 #include <plat/serial.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -45,6 +46,13 @@
 #define TUSB6010_GPIO_ENABLE	0
 #define TUSB6010_DMACHAN	0x3f
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_USB_MUSB_TUSB6010) || defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
 /*
  * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
@@ -114,10 +122,12 @@ static void __init n8x0_usb_init(void)
 	}
 	tusb_set_power(0);
 
-	ret = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
+	*gpmc_cur = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
 					TUSB6010_ASYNC_CS, TUSB6010_SYNC_CS,
 					TUSB6010_GPIO_INT, TUSB6010_DMACHAN);
-	if (ret != 0)
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
 		goto err;
 
 	printk(announce);
@@ -785,7 +795,9 @@ static void __init n8x0_init_machine(void)
 					ARRAY_SIZE(n810_i2c_board_info_2));
 	board_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	gpmc_onenand_init(board_onenand_data);
+	*gpmc_cur++ = gpmc_onenand_init(board_onenand_data);
+	gpmc_data.num_device++;
+	omap_init_gpmc(&gpmc_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
 }
-- 
1.7.10
