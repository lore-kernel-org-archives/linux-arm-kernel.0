From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:23:06 +0800
Subject: [PATCH v3 14/14] ARM: dts: sun6i: Enable HDMI support on some
 A31/A31s devices
In-Reply-To: <20170929082306.16193-1-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
Message-ID: <20170929082306.16193-15-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the A31/A31s devices I own have some kind of HDMI connector wired
to the dedicated HDMI pins on the SoC:

  - A31 Hummingbird (standard HDMI connector, display already enabled)
  - Sinlinx SinA31s (standard HDMI connector)
  - MSI Primo81 tablet (micro HDMI connector)

Enable the display pipeline (if needed) and HDMI output for them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s-primo81.dts    | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts    | 25 +++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 9ecb5f0b3f83..19e382a11297 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -62,6 +62,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	vga-connector {
 		compatible = "vga-connector";
 
@@ -162,6 +173,16 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 4c10123509c4..0cdb38ab3377 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -52,17 +52,42 @@
 / {
 	model = "MSI Primo81 tablet";
 	compatible = "msi,primo81", "allwinner,sun6i-a31s";
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "c";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
 };
 
 &cpu0 {
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	/* rtl8188etv wifi is connected here */
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	/* pull-ups and device VDDIO use AXP221 DLDO3 */
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index b3d98222bd81..298476485bb4 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -53,6 +53,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -90,6 +101,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	/* USB 2.0 4 port hub IC */
 	status = "okay";
@@ -112,6 +127,16 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.14.2
