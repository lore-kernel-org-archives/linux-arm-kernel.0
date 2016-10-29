From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 29 Oct 2016 19:06:11 +0800
Subject: [PATCH v3 2/2] ARM: dts: sun6i: hummingbird-a31: Enable display
 output through VGA bridge
In-Reply-To: <20161029110611.28951-1-wens@csie.org>
References: <20161029110611.28951-1-wens@csie.org>
Message-ID: <20161029110611.28951-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 board has a VGA DAC which converts RGB output
from the LCD interface to VGA analog signals.

Add nodes for the VGA DAC, its power supply, and enable this part
of the display pipeline.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 76 +++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 9a74637f677f..1ab28b2108fe 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -63,6 +63,62 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	vga-connector {
+		compatible = "vga-connector";
+
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_dac_out>;
+			};
+		};
+	};
+
+	vga-dac {
+		compatible = "dumb-vga-dac";
+		vdd-supply = <&reg_vga_3v3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				vga_dac_in: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&tcon0_out_vga>;
+				};
+			};
+
+			port at 1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				vga_dac_out: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vga_con_in>;
+				};
+			};
+		};
+	};
+
+	reg_vga_3v3: vga_3v3_regulator {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vga_3v3_enable_pin_hummingbird>;
+		regulator-name = "vga-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 7 25 GPIO_ACTIVE_HIGH>; /* PH25 */
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
@@ -166,6 +222,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
+	vga_3v3_enable_pin_hummingbird: vga_3v3_enable_pin {
+		allwinner,pins = "PH25";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	wifi_reset_pin_hummingbird: wifi_reset_pin at 0 {
 		allwinner,pins = "PG10";
 		allwinner,function = "gpio_out";
@@ -245,6 +308,19 @@
 	status = "okay";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb888_pins>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_vga: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&vga_dac_in>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.9.3
