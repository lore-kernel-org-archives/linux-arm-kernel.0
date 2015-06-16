From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 16 Jun 2015 18:08:34 +0800
Subject: [PATCH v2 1/2] ARM: at91: dts: add isi & ov2640 dt nodes for
 at91sam9m10g45ek board
Message-ID: <1434449315-9243-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First we group the isi data pins, and for now we only use 0~7 data pins
with HSYNC and VSYNC.
Also add the link for atmel-isi and ov2640 sensor node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

Changes in v2:
- group the isi data pin.
- remove the isi_mck pin from pinctrl-isi as it will used by camera
  sensor.

 arch/arm/boot/dts/at91sam9g45.dtsi     | 48 +++++++++++++++++++++-------------
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 45 +++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d260ba7..f6220d6 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -498,23 +498,31 @@
 				};
 
 				isi {
-					pinctrl_isi: isi-0 {
-						atmel,pins = <AT91_PIOB 8 AT91_PERIPH_B AT91_PINCTRL_NONE /* D8 */
-							      AT91_PIOB 9 AT91_PERIPH_B AT91_PINCTRL_NONE /* D9 */
-							      AT91_PIOB 10 AT91_PERIPH_B AT91_PINCTRL_NONE /* D10 */
-							      AT91_PIOB 11 AT91_PERIPH_B AT91_PINCTRL_NONE /* D11 */
-							      AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE /* D0 */
-							      AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_NONE /* D1 */
-							      AT91_PIOB 22 AT91_PERIPH_A AT91_PINCTRL_NONE /* D2 */
-							      AT91_PIOB 23 AT91_PERIPH_A AT91_PINCTRL_NONE /* D3 */
-							      AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_NONE /* D4 */
-							      AT91_PIOB 25 AT91_PERIPH_A AT91_PINCTRL_NONE /* D5 */
-							      AT91_PIOB 26 AT91_PERIPH_A AT91_PINCTRL_NONE /* D6 */
-							      AT91_PIOB 27 AT91_PERIPH_A AT91_PINCTRL_NONE /* D7 */
-							      AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_NONE /* PCK */
-							      AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_NONE /* VSYNC */
-							      AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_NONE /* HSYNC */
-							      AT91_PIOB 31 AT91_PERIPH_A AT91_PINCTRL_NONE /* MCK */>;
+					pinctrl_isi_data_0_7: isi-0-data-0-7 {
+						atmel,pins =
+							<AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE /* D0 */
+							AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_NONE /* D1 */
+							AT91_PIOB 22 AT91_PERIPH_A AT91_PINCTRL_NONE /* D2 */
+							AT91_PIOB 23 AT91_PERIPH_A AT91_PINCTRL_NONE /* D3 */
+							AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_NONE /* D4 */
+							AT91_PIOB 25 AT91_PERIPH_A AT91_PINCTRL_NONE /* D5 */
+							AT91_PIOB 26 AT91_PERIPH_A AT91_PINCTRL_NONE /* D6 */
+							AT91_PIOB 27 AT91_PERIPH_A AT91_PINCTRL_NONE /* D7 */
+							AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_NONE /* PCK */
+							AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_NONE /* VSYNC */
+							AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_NONE>; /* HSYNC */
+					};
+
+					pinctrl_isi_data_8_9: isi-0-data-8-9 {
+						atmel,pins =
+							<AT91_PIOB 8 AT91_PERIPH_B AT91_PINCTRL_NONE /* D8 */
+							AT91_PIOB 9 AT91_PERIPH_B AT91_PINCTRL_NONE>; /* D9 */
+					};
+
+					pinctrl_isi_data_10_11: isi-0-data-10-11 {
+						atmel,pins =
+							<AT91_PIOB 10 AT91_PERIPH_B AT91_PINCTRL_NONE /* D10 */
+							AT91_PIOB 11 AT91_PERIPH_B AT91_PINCTRL_NONE>; /* D11 */
 					};
 				};
 
@@ -1068,8 +1076,12 @@
 				clocks = <&isi_clk>;
 				clock-names = "isi_clk";
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_isi>;
+				pinctrl-0 = <&pinctrl_isi_data_0_7>;
 				status = "disabled";
+				port {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 			};
 
 			pwm0: pwm at fffb8000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 1375d33..5062e18 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -63,6 +63,25 @@
 
 			i2c0: i2c at fff84000 {
 				status = "okay";
+				ov2640: camera at 30 {
+					compatible = "ovti,ov2640";
+					reg = <0x30>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_pck1_as_isi_mck &pinctrl_sensor_power &pinctrl_sensor_reset>;
+					resetb-gpios = <&pioD 12 GPIO_ACTIVE_LOW>;
+					pwdn-gpios = <&pioD 13 GPIO_ACTIVE_HIGH>;
+					clocks = <&pck1>;
+					clock-names = "xvclk";
+					assigned-clocks = <&pck1>;
+					assigned-clock-rates = <25000000>;
+
+					port {
+						ov2640_0: endpoint {
+							remote-endpoint = <&isi_0>;
+							bus-width = <8>;
+						};
+					};
+				};
 			};
 
 			i2c1: i2c at fff88000 {
@@ -101,6 +120,22 @@
 			};
 
 			pinctrl at fffff200 {
+				camera_sensor {
+					pinctrl_pck1_as_isi_mck: pck1_as_isi_mck-0 {
+						atmel,pins =
+							<AT91_PIOB 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_sensor_reset: sensor_reset-0 {
+						atmel,pins =
+							<AT91_PIOD 12 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_sensor_power: sensor_power-0 {
+						atmel,pins =
+							<AT91_PIOD 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+				};
 				mmc0 {
 					pinctrl_board_mmc0: mmc0-board {
 						atmel,pins =
@@ -155,6 +190,16 @@
 				status = "okay";
 			};
 
+			isi at fffb4000 {
+				status = "okay";
+				port {
+					isi_0: endpoint {
+						remote-endpoint = <&ov2640_0>;
+						bus-width = <8>;
+					};
+				};
+			};
+
 			pwm0: pwm at fffb8000 {
 				status = "okay";
 
-- 
1.9.1
