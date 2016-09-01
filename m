From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 17:32:04 +0200
Subject: [PATCH 7/7] ARM: sun8i: sina33: Enable display
In-Reply-To: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
Message-ID: <20160901153204.11217-8-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the display pipeline with the associated 7" panel sold with the
SinA33.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index fef6abc0a703..1fa2b5a80ec2 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -61,6 +61,27 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	panel {
+		compatible = "sinlinx,sina33-lcd-7";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_panel>;
+			};
+		};
+	};
+};
+
+&de {
+	status = "okay";
 };
 
 &ehci0 {
@@ -207,6 +228,19 @@
 	regulator-name = "vcc-rtc";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&tcon0_rgb666_pins_a>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_panel: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_b>;
-- 
2.9.2
