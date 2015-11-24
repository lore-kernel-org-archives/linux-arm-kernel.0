From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Nov 2015 15:19:14 +0200
Subject: [PATCH 13/14] ARM: am437x: cm-t43: dts: add support for mmc1
In-Reply-To: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448371155-17307-14-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SBC-T43 the mmc1 interface is connected to an SD-Card slot.
Add the necessary muxing and configuration to the device tree.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
 arch/arm/boot/dts/am437x-sbc-t43.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
index 7394aa1..b2c42d9 100644
--- a/arch/arm/boot/dts/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -7,6 +7,7 @@
  */
 
 #include "am437x-cm-t43.dts"
+#include "compulab-sb-som.dtsi"
 
 / {
 	model = "CompuLab CM-T43 on SB-SOM-T43";
@@ -14,6 +15,19 @@
 };
 
 &am43xx_pinmux {
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc0_clk.mmc0_clk */
+			AM4372_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
+			AM4372_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
+			AM4372_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
+			AM4372_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
+			AM4372_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
+			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM4372_IOPAD(0x964, PIN_INPUT | MUX_MODE7) /* ecap0_in_pwm0_out.gpio0_7 */
+		>;
+	};
+
 	uart0_pins_default: uart0_pins_default {
 		pinctrl-single,pins = <
 			AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0)
@@ -75,6 +89,16 @@
 	pinctrl-0 = <&i2c2_pins>;
 };
 
+&mmc1 {
+	status = "okay";
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&vsb_3v3>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_default>;
-- 
1.9.1
