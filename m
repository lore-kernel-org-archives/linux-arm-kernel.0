From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 13 Dec 2016 11:09:18 +0100
Subject: [PATCH v7 4/5] ARM: dts: da850-lcdk: add the vga-bridge node
In-Reply-To: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1481623759-12786-5-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the vga-bridge node to the board DT together with corresponding
ports and vga connector. This allows to retrieve the edid info from
the display automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index afcb482..1ae2260 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -51,6 +51,45 @@
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
+				reg = <0>;
+
+				vga_bridge_in: endpoint {
+					remote-endpoint = <&lcdc_out_vga>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				vga_bridge_out: endpoint {
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
@@ -236,3 +275,15 @@
 &memctrl {
 	status = "okay";
 };
+
+&lcdc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_pins>;
+
+	port {
+		lcdc_out_vga: endpoint {
+			remote-endpoint = <&vga_bridge_in>;
+		};
+	};
+};
-- 
2.9.3
