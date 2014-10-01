From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  1 Oct 2014 16:53:07 +0200
Subject: [PATCH v7 10/11] ARM: at91/dt: add LCD panel description to
 sama5d3xdm.dtsi
In-Reply-To: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1412175188-28278-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Add LCD panel related nodes (backlight, regulators and panel) to sama5d3
Display Module dtsi.

Reference LCD pin muxing used by sama5d3xek boards.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xdm.dtsi | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
index 035ab72..91975eb 100644
--- a/arch/arm/boot/dts/sama5d3xdm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xdm.dtsi
@@ -36,6 +36,64 @@
 					};
 				};
 			};
+
+			hlcdc: hlcdc at f0030000 {
+				hlcdc-display-controller {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888_alt>;
+
+					port at 0 {
+						hlcdc_panel_output: endpoint at 0 {
+							reg = <0>;
+							remote-endpoint = <&panel_input>;
+						};
+					};
+				};
+			};
+		};
+	};
+
+	bl_reg: backlight_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight-power-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		status = "disabled";
+	};
+
+	panel_reg: panel_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-power-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		status = "disabled";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&hlcdc_pwm 0 50000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		power-supply = <&bl_reg>;
+		status = "disabled";
+	};
+
+	panel: panel {
+		compatible = "foxlink,fl500wvr00-a0t", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&panel_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		port at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&hlcdc_panel_output>;
+			};
 		};
 	};
 };
-- 
1.9.1
