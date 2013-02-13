From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:21 +0900
Subject: [PATCH 9/9] ARM: shmobile: kzm9g: Move pinctrl mappings to device tree
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360726161-16072-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the pinctrl mappings in board code by device tree mappings.
Reference the mapping as the default pin controller state to apply it at
boot time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts   |   10 ++++++++++
 arch/arm/mach-shmobile/board-kzm9g.c |   24 ------------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 203efb8..ba321c2 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -36,3 +36,13 @@
 		};
 	};
 };
+
+&gpio {
+	pinctrl-0 = <&lcd_pins>;
+	pinctrl-names = "default";
+
+	lcd_pins: pfc_lcd_pins {
+		renesas,pins = "lcd_data24", "lcd_sync";
+		renesas,function = "lcd";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index b89a9a8..949ef36 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -31,7 +31,6 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -601,27 +600,6 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&fsi_ak4648_device,
 };
 
-static const struct pinctrl_map kzm_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
-				  "fsia_mclk_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
-				  "fsia_sclk_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
-				  "fsia_data_in", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "e6050000.pfc",
-				  "fsia_data_out", "fsia"),
-	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "e6050000.pfc",
-				  "i2c3_1", "i2c3"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
-				  "scifa4_data", "scifa4"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
-				  "scifa4_ctrl", "scifa4"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
-				  "lcd_data24", "lcd"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
-				  "lcd_sync", "lcd"),
-};
-
 /*
  * FIXME
  *
@@ -683,8 +661,6 @@ static void __init kzm_init(void)
 				     ARRAY_SIZE(fixed2v8_power_consumers), 2800000);
 	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
-	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* CS4 for SMSC/USB */
-- 
1.7.10.4
