From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 28 Nov 2016 13:15:27 +0100
Subject: [PATCH v2 1/2] ARM: dts: da850-lcdk: add the dumb-vga-dac node
In-Reply-To: <1480335328-4010-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480335328-4010-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480335328-4010-2-git-send-email-bgolaszewski@baylibre.com>
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
index 711b9ad..d864f11 100644
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
@@ -235,3 +282,14 @@
 &memctrl {
 	status = "okay";
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
index 4070619..5f4ba2e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -454,6 +454,23 @@
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
