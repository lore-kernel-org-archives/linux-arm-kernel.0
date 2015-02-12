From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 12 Feb 2015 16:06:24 +0800
Subject: [PATCH 2/4] ARM: at91: at91sam9x5ek/dts: add ov2640 support
In-Reply-To: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
References: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1423728386-24544-3-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the camera sensor ov2640 dt support. And connect sensor to isi node
as well.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/at91sam9x5ek.dtsi | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index bd16bd3..b633b0f 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -66,9 +66,47 @@
 					compatible = "wm8731";
 					reg = <0x1a>;
 				};
+
+				ov2640: camera at 0x30 {
+					compatible = "ovti,ov2640";
+					reg = <0x30>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_pck0_as_isi_mck &pinctrl_sensor_power &pinctrl_sensor_reset>;
+					resetb-gpios = <&pioA 7 GPIO_ACTIVE_LOW>;
+					pwdn-gpios = <&pioA 13 GPIO_ACTIVE_HIGH>;
+					clocks = <&pck0>;
+					clock-names = "xvclk";
+					assigned-clocks = <&pck0>;
+					assigned-clock-rates = <25000000>;
+					status = "disabled";
+
+					port {
+						ov2640_0: endpoint {
+							remote-endpoint = <&isi_0>;
+							bus-width = <8>;
+						};
+					};
+				};
 			};
 
 			pinctrl at fffff400 {
+				camera_sensor {
+					pinctrl_pck0_as_isi_mck: pck0_as_isi_mck-0 {
+						atmel,pins =
+							<AT91_PIOC 15 AT91_PERIPH_C AT91_PINCTRL_NONE>;			/* PC15 periph C ISI_MCK */
+					};
+
+					pinctrl_sensor_reset: sensor_reset-0 {
+						atmel,pins =
+							<AT91_PIOA 7 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;		/* PA7 gpio */
+					};
+
+					pinctrl_sensor_power: sensor_power-0 {
+						atmel,pins =
+							<AT91_PIOA 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;		/* PA13 gpio */
+					};
+				};
+
 				mmc0 {
 					pinctrl_board_mmc0: mmc0-board {
 						atmel,pins =
@@ -122,6 +160,16 @@
 		usb1: ehci at 00700000 {
 			status = "okay";
 		};
+
+		isi: isi at f8048000 {
+			status = "disabled";
+			port {
+				isi_0: endpoint at 0 {
+					remote-endpoint = <&ov2640_0>;
+					bus-width = <8>;
+				};
+			};
+		};
 	};
 
 	sound {
-- 
1.9.1
