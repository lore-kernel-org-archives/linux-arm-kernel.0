From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Nov 2015 15:19:09 +0200
Subject: [PATCH 08/14] ARM: am437x: cm-t43: dts: add eMMC support
In-Reply-To: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448371155-17307-9-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the CompuLab cm-t43 configurations comes with on-board eMMC as
primary storage, residing on the mmc2 interface. Add it to the device tree.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 70d5c20..5ca4160 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -26,6 +26,16 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	vmmc_3v3: fixedregulator-v3_3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		enable-active-high;
+	};
+
 };
 
 &am43xx_pinmux {
@@ -45,6 +55,21 @@
 		>;
 	};
 
+	emmc_pins: emmc_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad8.mmc1_dat0 */
+			AM4372_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad9.mmc1_dat1 */
+			AM4372_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad10.mmc1_dat2 */
+			AM4372_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad11.mmc1_dat3 */
+			AM4372_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad12.mmc1_dat4 */
+			AM4372_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad13.mmc1_dat5 */
+			AM4372_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad14.mmc1_dat6 */
+			AM4372_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad15.mmc1_dat7 */
+			AM4372_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM4372_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+		>;
+	};
+
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
 			AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0) /* spi0_sclk.spi0_sclk */
@@ -271,6 +296,15 @@
 	status = "okay";
 };
 
+&mmc2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_pins>;
+	vmmc-supply = <&vmmc_3v3>;
+	bus-width = <8>;
+	ti,non-removable;
+};
+
 &spi0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.9.1
