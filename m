From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:17 +0900
Subject: [PATCH 5/9] ARM: shmobile: kzm9g: Populate platform devices from
 device tree
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360726161-16072-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Call of_platform_populate() at machine initialization time to populate
platform devices. Remove the explicit pinmux initialization as the PFC
device will be instantiated from the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 2b529d2..b89a9a8 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -30,6 +30,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
+#include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
@@ -601,23 +602,23 @@ static struct platform_device *kzm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
 				  "fsia_mclk_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
 				  "fsia_sclk_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
 				  "fsia_data_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
 				  "fsia_data_out", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "e6050000.pfc",
 				  "i2c3_1", "i2c3"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
 				  "scifa4_data", "scifa4"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
 				  "scifa4_ctrl", "scifa4"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
 				  "lcd_data24", "lcd"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
 				  "lcd_sync", "lcd"),
 };
 
@@ -684,7 +685,7 @@ static void __init kzm_init(void)
 
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 
-	sh73a0_pinmux_init();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* CS4 for SMSC/USB */
 	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
-- 
1.7.10.4
