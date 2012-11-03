From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  3 Nov 2012 16:59:07 +0100
Subject: [PATCH 1/2] ARM: dts: cfa10036: Use pinctrl for power led
In-Reply-To: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1351958348-7327-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The leds-gpio driver recently got pinctrl support, so setup the power
led gpio muxing through pinctrl.

This avoids the warning:
leds-gpio leds.X: pins are not configured from the driver

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 816cae9..8760b87 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -22,6 +22,18 @@
 
 	apb at 80000000 {
 		apbh at 80000000 {
+			pinctrl at 80018000 {
+				led_pins_cfa10036: leds-10036 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3043 /* MX28_PAD_AUART1_RX__GPIO_3_4 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
@@ -62,6 +74,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_cfa10036>;
 
 		power {
 			gpios = <&gpio3 4 1>;
-- 
1.7.9.5
