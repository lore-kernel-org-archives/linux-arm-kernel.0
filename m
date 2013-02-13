From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:20 +0900
Subject: [PATCH 8/9] ARM: shmobile: armadillo: Move pinctrl mappings to device
 tree
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360726161-16072-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the pinctrl mappings in board code by device tree mappings.
Reference the mapping as the default pin controller state to apply it at
boot time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts  |   10 ++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |   12 ------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index a8e7bd9..f324405 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -20,3 +20,13 @@
 		reg = <0x40000000 0x20000000>;
 	};
 };
+
+&gpio {
+	pinctrl-0 = <&lcd0_pins>;
+	pinctrl-names = "default";
+
+	lcd0_pins: pfc_lcd0_pins {
+		renesas,pins = "lcd0_data24_0", "lcd0_lclk_0", "lcd0_sync";
+		renesas,function = "lcd0";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index a10e644..e5dfaeb 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -29,7 +29,6 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
-#include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
@@ -916,15 +915,6 @@ static struct platform_device *eva_devices[] __initdata = {
 	&i2c_gpio_device,
 };
 
-static const struct pinctrl_map eva_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
-				  "lcd0_data24_0", "lcd0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
-				  "lcd0_lclk_1", "lcd0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
-				  "lcd0_sync", "lcd0"),
-};
-
 static void __init eva_clock_init(void)
 {
 	struct clk *system	= clk_get(NULL, "system_clk");
@@ -972,8 +962,6 @@ static void __init eva_init(void)
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
-	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	r8a7740_meram_workaround();
-- 
1.7.10.4
