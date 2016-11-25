From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 25 Nov 2016 10:11:53 +0100
Subject: [PATCH] ARM: da850-lcdk: add the dumb-vga-dac node
Message-ID: <1480065113-2443-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the dumb-vga-dac node to the board DT together with corresponding
ports and vga connector. This allows to retrieve the edid info from
the display automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 58 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 17 ++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..c5d3a2b 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -50,6 +50,53 @@
 			system-clock-frequency = <24576000>;
 		};
 	};
+
+	vga_bridge {
+		compatible = "dumb-vga-dac";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
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
+				vga_bridge_in: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&display_out_vga>;
+				};
+			};
+
+			port at 1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				vga_bridge_out: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vga_con_in>;
+				};
+			};
+		};
+	};
+
+	vga {
+		compatible = "vga-connector";
+
+		ddc-i2c-bus = <&i2c0>;
+
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_bridge_out>;
+			};
+		};
+	};
 };
 
 &pmx_core {
@@ -219,3 +266,14 @@
 		};
 	};
 };
+
+&display {
+	status = "okay";
+};
+
+&display_out {
+	display_out_vga: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&vga_bridge_in>;
+	};
+};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 36066fa..6ab8df1 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -442,6 +442,23 @@
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				display_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				display_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
 		};
 	};
 	aemif: aemif at 68000000 {
-- 
2.9.3
