From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Apr 2014 14:41:41 +0800
Subject: [PATCH 7/7] ARM: sun7i: cubietruck: enable bluetooth module
In-Reply-To: <1397544101-18135-1-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
Message-ID: <1397544101-18135-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The Bluetooth
part is a BCM20710 device connected to UART2 in the A20 SoC.

The IC requires a 32.768 KHz low power clock input for proper
auto-detection of the main clock, and an enable signal via GPIO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index cb25d3c..767c8e1 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -61,6 +61,13 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			bt_pwr_pin_cubietruck: bt_pwr_pin at 0 {
+				allwinner,pins = "PH18";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 01c28000 {
@@ -69,6 +76,12 @@
 			status = "okay";
 		};
 
+		uart2: serial at 01c28800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins_a>;
+			status = "okay";
+		};
+
 		i2c0: i2c at 01c2ac00 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
@@ -139,4 +152,16 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	rfkill_bt {
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pwr_pin_cubietruck>, <&clk_out_a_pins_a>;
+		clocks = <&clk_out_a>;
+		clock-frequency = <32768>;
+		gpios = <&pio 7 18 0>; /* PH18 */
+		gpio-names = "reset";
+		rfkill-name = "bt";
+		rfkill-type = <2>;
+	};
 };
-- 
1.9.1
