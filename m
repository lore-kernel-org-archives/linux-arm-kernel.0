From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 15 Jun 2015 18:27:17 +0800
Subject: [PATCH 1/2] ARM: at91: dts: add isi & ov2640 dt nodes for
 at91sam9m10g45ek board
Message-ID: <1434364038-8117-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the link for atmel-isi and ov2640 sensor node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/at91sam9g45.dtsi     |  4 +++
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d260ba7..e707613 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1070,6 +1070,10 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_isi>;
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
