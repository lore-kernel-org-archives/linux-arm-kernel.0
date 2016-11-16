From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Nov 2016 23:42:32 +0800
Subject: [PATCH v4 2/2] ARM: dts: sun6i: hummingbird-a31: Enable display
 output through VGA bridge
In-Reply-To: <20161116154232.872-1-wens@csie.org>
References: <20161116154232.872-1-wens@csie.org>
Message-ID: <20161116154232.872-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 board has a VGA DAC which converts RGB output
from the LCD interface to VGA analog signals.

Add nodes for the VGA DAC, its power supply, and enable this part
of the display pipeline.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 67 +++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 62287bd2aeb5..b168d6df2b30 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -63,6 +63,60 @@
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
@@ -253,6 +307,19 @@
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
2.10.2
