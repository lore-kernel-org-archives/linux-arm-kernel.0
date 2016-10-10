From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Oct 2016 11:05:41 +0200
Subject: [PATCH v7 1/3] ARM: sun5i: a13-olinuxino: Enable VGA bridge
In-Reply-To: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
References: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
Message-ID: <be91fd9937a4479e5cf6f54106334aa4f812d69e.1476090316.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have support for the VGA bridges using our DRM driver, enable
the display engine for the Olimex A13-Olinuxino.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 54 ++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index b3c234c65ea1..bb7210e0e4a9 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -72,6 +72,47 @@
 			default-state = "on";
 		};
 	};
+
+	bridge {
+		compatible = "dumb-vga-dac";
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
git-series 0.8.10
