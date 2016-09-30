From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Sep 2016 14:13:50 +0200
Subject: [PATCH v4 3/5] ARM: sun5i: a13-olinuxino: Enable VGA bridge
In-Reply-To: <20160930121352.30184-1-maxime.ripard@free-electrons.com>
References: <20160930121352.30184-1-maxime.ripard@free-electrons.com>
Message-ID: <20160930121352.30184-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have support for the VGA bridges using our DRM driver, enable
the display engine for the Olimex A13-Olinuxino.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index b3c234c65ea1..01ce7ea9032d 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -72,6 +72,47 @@
 			default-state = "on";
 		};
 	};
+
+	bridge {
+		compatible = "rgb-to-vga-bridge";
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
+					remote-endpoint = <&tcon0_out_vga>;
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
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_bridge_out>;
+			};
+		};
+	};
+};
+
+&be0 {
+	status = "okay";
 };
 
 &ehci0 {
@@ -211,6 +252,19 @@
 	status = "okay";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_vga: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&vga_bridge_in>;
+	};
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins_b>;
-- 
2.9.3
