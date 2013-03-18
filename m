From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:59:35 +0900
Subject: [PATCH 08/13] ARM: shmobile: SDHI and MMCIF interfaces to
 kzm9g-reference
In-Reply-To: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607980-22153-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add SDHI0 and SDHI2 interfaces to kzm9g-reference. With no pinctrl DT
support we cannot use GPIO card-detection and regulator switching.
Also update the MMCIF DT node to use all 8 data lines and avoid
redundant information in DT.

Cc: Laurent Pinchart <laurent.pinchart+renesas at ideasonboard.com
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
[ horms+renesas at verge.net.au: Updated for pinmux changes by Laurent Pinchart ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   42 ++++++++++++++++++++++--
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   36 ++++++++++++++++++++
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 06f52f9..7fad4b9 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -27,15 +27,51 @@
 		reg = <0x41000000 0x1e800000>;
 	};
 
-	fixedregulator1v8: fixedregulator at 0 {
+	reg_1p8v: regulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_2p8v: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	sdhi0: sdhi at 0xee100000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee100000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 83 4
+				0 84 4
+				0 85 4>;
+		vmmc-supply = <&reg_2p8v>;
+		bus-width = <4>;
+		toshiba,mmc-has-idle-wait;
+	};
+
+	sdhi2: sdhi at 0xee140000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee140000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 104 4
+				0 105 4>;
+		vmmc-supply = <&reg_2p8v>;
+		bus-width = <4>;
+		broken-cd;
+		toshiba,mmc-wrprotect-disable;
+		toshiba,mmc-has-idle-wait;
 	};
 };
 
 &mmcif {
-	vmmc-supply = <&fixedregulator1v8>;
-	vqmmc-supply = <&fixedregulator1v8>;
+	bus-width = <8>;
+	vmmc-supply = <&reg_1p8v>;
 };
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index add537c..3056698 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -28,19 +28,48 @@
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static unsigned long pin_pullup_conf[] = {
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
+};
+
 static const struct pinctrl_map kzm_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_1", "i2c3"),
+	/* MMCIF */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_data8_0", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_ctrl_0", "mmc0"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				    "PORT279", pin_pullup_conf),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				      "mmc0_data8_0", pin_pullup_conf),
+	/* SCIFA4 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
 				  "scifa4_data", "scifa4"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
 				  "scifa4_ctrl", "scifa4"),
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_wp", "sdhi0"),
+	/* SDHI2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh73a0",
+				  "sdhi2_data4", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh73a0",
+				  "sdhi2_ctrl", "sdhi2"),
 };
 
 static void __init kzm_init(void)
@@ -49,6 +78,13 @@ static void __init kzm_init(void)
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 	sh73a0_pinmux_init();
 
+	/* enable SD */
+	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
+	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+
+	gpio_request(GPIO_FN_SDHICLK2,		NULL);
+	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.10.4
