From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:18 +0900
Subject: [PATCH 6/9] ARM: shmobile: kzm9g: reference: Populate platform
 devices from device tree
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360726161-16072-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call of_platform_populate() at machine initialization time to populate
platform devices. Remove the explicit pinmux initialization as the PFC
device will be instantiated from the device tree.

This change is for the kzm9g reference DT implementation and is in keeping
with a similar change for the default kzm9g implementation made by Laurent
Pinchart.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   12 ++++++++++++
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    7 ++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 06f52f9..9901caf 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -35,6 +35,18 @@
 	};
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
+&gpio {
+	i2c3_pins: pfc_i2c3_pins {
+		renesas,pins = "i2c3_1";
+		renesas,function = "i2c3";
+	};
+};
+
 &mmcif {
 	vmmc-supply = <&fixedregulator1v8>;
 	vqmmc-supply = <&fixedregulator1v8>;
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 7282048..625e337 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -34,11 +34,9 @@
 #include <asm/mach/arch.h>
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
-				  "i2c3_1", "i2c3"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
 				  "scifa4_data", "scifa4"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
 				  "scifa4_ctrl", "scifa4"),
 };
 
@@ -46,7 +44,6 @@ static void __init kzm_init(void)
 {
 	sh73a0_add_standard_devices_dt();
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
-	sh73a0_pinmux_init();
 
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0,		NULL);
-- 
1.7.10.4
