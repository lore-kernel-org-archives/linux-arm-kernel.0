From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Aug 2018 16:09:25 +0800
Subject: [PATCH 2/3] ARM: dts: sun8i: h3: Split out non-SoC-specific parts of
 Bananapi M2 Plus
In-Reply-To: <20180830080926.15027-1-wens@csie.org>
References: <20180830080926.15027-1-wens@csie.org>
Message-ID: <20180830080926.15027-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three more variants of the Bananapi M2 Plus have been introduced. One
with the H5 instead of the H3, another with the H2+ instead, and the
last with the H3 but with WiFi and eMMC removed.

All these variants use the same board. This patch splits out the
non-SoC-specific parts of the device tree, so that they can be shared
among all the variants. The original Bananapi M2 Plus has been renamed
to Bananapi M2 Plus H3.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 190 +-----------------
 ...2-plus.dts => sunxi-bananapi-m2-plus.dtsi} |   5 -
 2 files changed, 2 insertions(+), 193 deletions(-)
 copy arch/arm/boot/dts/{sun8i-h3-bananapi-m2-plus.dts => sunxi-bananapi-m2-plus.dtsi} (97%)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index bdda0d99128e..195a75da13f1 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -42,195 +42,9 @@
 
 /dts-v1/;
 #include "sun8i-h3.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
+#include "sunxi-bananapi-m2-plus.dtsi"
 
 / {
-	model = "Banana Pi BPI-M2-Plus";
+	model = "Banana Pi BPI-M2-Plus H3";
 	compatible = "sinovoip,bpi-m2-plus", "allwinner,sun8i-h3";
-
-	aliases {
-		ethernet0 = &emac;
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-
-		pwr_led {
-			label = "bananapi-m2-plus:red:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
-			default-state = "on";
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-
-		sw4 {
-			label = "power";
-			linux,code = <BTN_0>;
-			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	reg_gmac_3v3: gmac-3v3 {
-		      compatible = "regulator-fixed";
-		      regulator-name = "gmac-3v3";
-		      regulator-min-microvolt = <3300000>;
-		      regulator-max-microvolt = <3300000>;
-		      startup-delay-us = <100000>;
-		      enable-active-high;
-		      gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
-	};
-
-	wifi_pwrseq: wifi_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-	};
-};
-
-&de {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&ehci2 {
-	status = "okay";
-};
-
-&emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_rgmii_pins>;
-	phy-supply = <&reg_gmac_3v3>;
-	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
-
-	status = "okay";
-};
-
-&external_mdio {
-	ext_rgmii_phy: ethernet-phy at 1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-	};
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&ir {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
-	status = "okay";
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-	status = "okay";
-};
-
-&mmc1 {
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc3v3>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-
-	brcmf: wifi at 1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-		interrupt-parent = <&pio>;
-		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
-		interrupt-names = "host-wake";
-	};
-};
-
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_8bit_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc3v3>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&ohci2 {
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 3 11 GPIO_ACTIVE_HIGH>; /* PD11 */
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	/* USB host VBUS is on as long as VCC-IO is on */
-	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
similarity index 97%
copy from arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
copy to arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index bdda0d99128e..b3283aeb5b7d 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -40,17 +40,12 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/dts-v1/;
-#include "sun8i-h3.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 
 / {
-	model = "Banana Pi BPI-M2-Plus";
-	compatible = "sinovoip,bpi-m2-plus", "allwinner,sun8i-h3";
-
 	aliases {
 		ethernet0 = &emac;
 		serial0 = &uart0;
-- 
2.18.0
