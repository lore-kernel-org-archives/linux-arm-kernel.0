From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed,  7 Dec 2016 11:42:44 +0100
Subject: [PATCH v5 3/4] ARM: dts: da850-lcdk: add the vga-bridge node
In-Reply-To: <1481107365-24839-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481107365-24839-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1481107365-24839-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the vga-bridge node to the board DT together with corresponding
ports and vga connector. This allows to retrieve the edid info from
the display automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index afcb482..39602eb 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -51,6 +51,51 @@
 			system-clock-frequency = <24576000>;
 		};
 	};
+
+	vga-bridge {
+		compatible = "ti,ths8135";
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
+					remote-endpoint = <&lcdc_out_vga>;
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
@@ -236,3 +281,25 @@
 &memctrl {
 	status = "okay";
 };
+
+&lcdc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_pins>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		lcdc_out: port at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			lcdc_out_vga: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&vga_bridge_in>;
+			};
+		};
+	};
+};
-- 
2.9.3
