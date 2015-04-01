From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:46 +0200
Subject: [PATCH RFC v2 12/12] ARM: dts: rockchip: add vga encoder and enable
 lvds on rk3288-firefly
In-Reply-To: <1427882986-19110-1-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
Message-ID: <1427882986-19110-13-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sda7123 simple vga encoder, connect it to the vop outputs
and enable the lvds controller with the correct settings.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 68 +++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index b54dd78..2cce2a9 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -159,6 +159,51 @@
 		regulator-always-on;
 		vin-supply = <&vcc_5v>;
 	};
+
+	sda7123: vga-encoder {
+		compatible = "adi,adv7123";
+		psave-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sda7123_in: endpoint at 0 {
+					remote-endpoint = <&lvds_out>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sda7123_out: endpoint at 0 {
+					remote-endpoint = <&vga_connector_in>;
+				};
+			};
+		};
+	};
+
+	vga: vga-connector {
+		compatible = "vga-connector";
+		label = "vga";
+
+		ddc-i2c-bus = <&i2c4>;
+
+		port {
+			vga_connector_in: endpoint {
+				remote-endpoint = <&sda7123_out>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -347,6 +392,29 @@
 	status = "okay";
 };
 
+&lvds {
+	avdd1v0-supply = <&vdd10_lcd>;
+	avdd1v8-supply = <&vcc18_lcd>;
+	avdd3v3-supply = <&vcca_33>;
+	rockchip,data-mapping = "jeida";
+	rockchip,data-width = <24>;
+	rockchip,output = "rgb";
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lvds_out: endpoint at 0 {
+				remote-endpoint = <&sda7123_in>;
+			};
+		};
+	};
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
-- 
2.1.4
