From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 11:25:17 +0200
Subject: [PATCH 4/7] ARM: dts: at91: move isi definition to at91sam9g25ek
In-Reply-To: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468574720-24296-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ISI is only present on the at91sam9g25, move the definition to the
at91sam9g25ek board dts to avoid warnings.

Solves the following warning for other 9x5ek boards:
Warning (unit_address_vs_reg): Node /ahb/apb/isi at f8048000 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi | 33 ---------------------------------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 707fd4ea58f5..30bfd2e12cae 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -26,7 +26,24 @@
 
 			i2c0: i2c at f8010000 {
 				ov2640: camera at 0x30 {
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
 					status = "okay";
+
+					port {
+						ov2640_0: endpoint {
+							remote-endpoint = <&isi_0>;
+							bus-width = <8>;
+						};
+					};
 				};
 			};
 
@@ -37,6 +54,14 @@
 
 			isi: isi at f8048000 {
 				status = "okay";
+				port {
+					isi_0: endpoint at 0 {
+						remote-endpoint = <&ov2640_0>;
+						bus-width = <8>;
+						vsync-active = <1>;
+						hsync-active = <1>;
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 52425a4ca97e..696b8ba064a6 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -60,18 +60,6 @@
 				status = "okay";
 			};
 
-			isi: isi at f8048000 {
-				status = "disabled";
-				port {
-					isi_0: endpoint at 0 {
-						remote-endpoint = <&ov2640_0>;
-						bus-width = <8>;
-						vsync-active = <1>;
-						hsync-active = <1>;
-					};
-				};
-			};
-
 			i2c0: i2c at f8010000 {
 				status = "okay";
 
@@ -79,27 +67,6 @@
 					compatible = "wm8731";
 					reg = <0x1a>;
 				};
-
-				ov2640: camera at 0x30 {
-					compatible = "ovti,ov2640";
-					reg = <0x30>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_pck0_as_isi_mck &pinctrl_sensor_power &pinctrl_sensor_reset>;
-					resetb-gpios = <&pioA 7 GPIO_ACTIVE_LOW>;
-					pwdn-gpios = <&pioA 13 GPIO_ACTIVE_HIGH>;
-					clocks = <&pck0>;
-					clock-names = "xvclk";
-					assigned-clocks = <&pck0>;
-					assigned-clock-rates = <25000000>;
-					status = "disabled";
-
-					port {
-						ov2640_0: endpoint {
-							remote-endpoint = <&isi_0>;
-							bus-width = <8>;
-						};
-					};
-				};
 			};
 
 			adc0: adc at f804c000 {
-- 
2.8.1
