From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Jan 2014 14:47:31 +0800
Subject: [PATCH RFC 6/6] ARM: sun7i: cubietruck: enable bluetooth module
In-Reply-To: <1389941251-32692-1-git-send-email-wens@csie.org>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
Message-ID: <1389941251-32692-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The
Bluetooth part is a BCM20710 device connected to UART2 in the
A20 SoC.

The IC also requires a 32.768 KHz low power clock input for
proper auto-detection of the main clock, and power enable and
wake signals via GPIO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index c8b3ea9..f172a8f 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -78,6 +78,20 @@
 					allwinner,drive = <0>;
 					allwinner,pull = <2>;
 			};
+
+			bt_pwr_pin: bt_pwr_pin at 0 {
+				allwinner,pins = "PH18";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			bt_wake_pin: bt_wake_pin at 0 {
+				allwinner,pins = "PH24";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 01c28000 {
@@ -86,6 +100,12 @@
 			status = "okay";
 		};
 
+		uart2: serial at 01c28800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins_a>;
+			status = "okay";
+		};
+
 		gmac: ethernet at 01c50000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&gmac_pins_rgmii>;
@@ -157,4 +177,21 @@
 			gpio = <&pio 7 3 0>;
 		};
 	};
+
+	rfkill-switches {
+		compatible = "simple-bus";
+		pinctrl-names = "default";
+
+		rfkill_bt {
+			compatible = "rfkill-gpio";
+			pinctrl-names = "default";
+			pinctrl-0 = <&bt_pwr_pin>, <&clk_out_a_pins>;
+			rfkill-name = "bt";
+			rfkill-type = <2>;
+			bt_shutdown-gpios = <0>, <&pio 7 18 0>; /* PH18 */
+			bt_reset-gpios = <&pio 7 24 0>; /* PH24 */
+			clocks = <&clk_out_a>;
+			clock-frequency = <32768>;
+		};
+	};
 };
-- 
1.8.5.2
