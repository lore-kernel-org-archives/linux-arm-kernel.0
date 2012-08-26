From: marex@denx.de (Marek Vasut)
Date: Sun, 26 Aug 2012 14:59:31 +0200
Subject: [PATCH V3] ARM: mxs: Update DENX M28 machine and dts file
Message-ID: <1345985971-12061-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the mach-mxs machine by removing the enet_clkout(). The new
revision of the board doesn't need that. Also, update the DTS file
with all the new drivers pulled in the mainline recently, that is,
SPI, LRADC, USB.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-m28evk.dts |   79 +++++++++++++++++++++++++++++++++---
 arch/arm/mach-mxs/mach-mxs.c       |    1 -
 2 files changed, 73 insertions(+), 7 deletions(-)

V2: Move the usbphy overcurrent definition to include file.
V3: Fixed regulator issue is now ... fixed.

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index ac3eff9..8118b64 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -23,6 +23,8 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			gpmi-nand at 8000c000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
 				status = "okay";
@@ -62,9 +64,27 @@
 					     &mmc0_sck_cfg>;
 				bus-width = <8>;
 				wp-gpios = <&gpio3 10 1>;
+				vmmc-supply = <&reg_vddio_sd0>;
 				status = "okay";
 			};
 
+			ssp2: ssp at 80014000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+
+				flash: m25p80 at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "m25p80";
+					spi-max-frequency = <40000000>;
+					reg = <0>;
+				};
+			};
+
 			pinctrl at 80018000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
@@ -72,8 +92,11 @@
 				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
+						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
 						0x30a3 /* MX28_PAD_AUART2_CTS__GPIO_3_10 */
 						0x30b3 /* MX28_PAD_AUART2_RTS__GPIO_3_11 */
+						0x30c3 /* MX28_PAD_AUART3_RX__GPIO_3_12 */
+						0x30d3 /* MX28_PAD_AUART3_TX__GPIO_3_13 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
@@ -129,6 +152,7 @@
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
+				clock-frequency = <400000>;
 				status = "okay";
 
 				sgtl5000: codec at 0a {
@@ -151,32 +175,51 @@
 				};
 			};
 
+			lradc at 80050000 {
+				status = "okay";
+			};
+
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
 				status = "okay";
 			};
 
-			auart0: serial at 8006a000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&auart0_2pins_a>;
+			usbphy0: usbphy at 8007c000 {
 				status = "okay";
 			};
 
-			auart3: serial at 80070000 {
+			usbphy1: usbphy at 8007e000 {
+				status = "okay";
+			};
+
+			auart0: serial at 8006a000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&auart3_pins_a>;
+				pinctrl-0 = <&auart0_2pins_a>;
 				status = "okay";
 			};
 		};
 	};
 
 	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			vbus-supply = <&reg_usb0_vbus>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usbphy0_pins_a>;
+			status = "okay";
+		};
+
+		usb1: usb at 80090000 {
+			vbus-supply = <&reg_usb1_vbus>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usbphy1_pins_a>;
+			status = "okay";
+		};
+
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio3 11 0>;
 			status = "okay";
 		};
 
@@ -198,6 +241,30 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		reg_vddio_sd0: vddio-sd0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 28 0>;
+		};
+
+		reg_usb0_vbus: usb0_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb0_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 12 0>;
+		};
+
+		reg_usb1_vbus: usb1_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 13 0>;
+		};
 	};
 
 	sound {
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 3b0d9c6..5cbb637 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -288,7 +288,6 @@ static void __init imx28_evk_post_init(void)
 
 static void __init m28evk_init(void)
 {
-	enable_clk_enet_out();
 	update_fec_mac_prop(OUI_DENX);
 
 	mxsfb_pdata.mode_list = m28evk_video_modes;
-- 
1.7.10.4
