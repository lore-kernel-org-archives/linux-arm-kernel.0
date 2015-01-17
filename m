From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Jan 2015 13:19:32 +0800
Subject: [PATCH v4 7/9] ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
In-Reply-To: <1421471974-32719-1-git-send-email-wens@csie.org>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
Message-ID: <1421471974-32719-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the micro-sd slot on the A80 Optimus Board, which is connected to
mmc0. This adds the card-detect gpio and enables mmc0.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index d4f3866a8d0b..5c9505a724d4 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -49,6 +49,7 @@
 
 /dts-v1/;
 #include "sun9i-a80.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
@@ -100,6 +101,23 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	mmc0_cd_pin_optimus: mmc0_cd_pin at 0 {
+		allwinner,pins = "PH18";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_optimus>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH8 */
+	cd-inverted;
+	status = "okay";
 };
 
 &uart0 {
-- 
2.1.4
