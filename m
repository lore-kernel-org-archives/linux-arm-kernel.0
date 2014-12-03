From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:36:03 +0800
Subject: [PATCH 08/10] ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
In-Reply-To: <1417588565-26215-1-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
Message-ID: <1417588565-26215-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the micro-sd slot on the A80 Optimus Board, which is connected to
mmc0. This adds the card-detect gpio and enables mmc0.

This patch also adds a 3V fixed regulator, which is the default I/O
voltage level.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 506948f..02a4aa7 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -59,6 +59,16 @@
 	};
 
 	soc {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_optimus>;
+			vmmc-supply = <&reg_vcc3v0>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 18 0>; /* PH8 */
+			cd-inverted;
+			status = "okay";
+		};
+
 		pio: pinctrl at 06000800 {
 			i2c3_pins_a: i2c3 at 0 {
 				/* Enable internal pull-up */
@@ -72,6 +82,13 @@
 				allwinner,pull = <0>;
 			};
 
+			mmc0_cd_pin_optimus: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH18";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
 			uart4_pins_a: uart4 at 0 {
 				/* Enable internal pull-up */
 				allwinner,pull = <1>;
@@ -116,4 +133,11 @@
 			gpios = <&pio 7 0 0>;
 		};
 	};
+
+	reg_vcc3v0: vcc3v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v0";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+	};
 };
-- 
2.1.3
