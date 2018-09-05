From: stefan@agner.ch (Stefan Agner)
Date: Tue,  4 Sep 2018 22:21:12 -0700
Subject: [PATCH 5/6] ARM: dts: imx6qdl-apalis: add VGA support
In-Reply-To: <20180905052113.21262-1-stefan@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
Message-ID: <20180905052113.21262-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Apalis iMX6 modules use a simple DAC using resistor ladders
to convert parallel RGB to VGA. Add support for this output using
the dump VGA driver.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6q-apalis-eval.dts | 28 +++++++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi   | 52 +++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 707ac9a46115..ae07b3a105ef 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -140,6 +140,16 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_bridge_out>;
+			};
+		};
+	};
 };
 
 &backlight {
@@ -281,6 +291,24 @@
 	status = "okay";
 };
 
+&vgabridge {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+
+			vga_bridge_out: endpoint {
+				remote-endpoint = <&vga_con_in>;
+			};
+		};
+	};
+};
+
+&vgadisplay {
+	status = "okay";
+};
+
 &iomuxc {
 	/*
 	 * Mux the Apalis GPIOs
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 05f07ea3e8c8..e8d0407e3e18 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -138,6 +138,54 @@
 		spdif-out;
 		status = "disabled";
 	};
+
+	vgabridge: bridge {
+		compatible = "dumb-vga-dac";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		de-active = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				vga_bridge_in: endpoint {
+					remote-endpoint = <&vga_display_out>;
+				};
+			};
+		};
+	};
+
+	vgadisplay: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb565";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu2_vdac>;
+		status = "disabled";
+
+		port at 0 {
+			reg = <0>;
+
+			vga_display_in: endpoint {
+				remote-endpoint = <&ipu2_di0_disp0>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			vga_display_out: endpoint {
+				remote-endpoint = <&vga_bridge_in>;
+			};
+		};
+	};
+
 };
 
 &audmux {
@@ -373,6 +421,10 @@
 	status = "disabled";
 };
 
+&ipu2_di0_disp0 {
+	remote-endpoint = <&vga_display_in>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.18.0
