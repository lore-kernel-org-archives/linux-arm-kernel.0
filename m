From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:24 +0200
Subject: [PATCH 3/9] ARM: at91/dt: add at91sam9x5-ek Display Module dtsi
In-Reply-To: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438383510-10521-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

All the at91sam9x5-ek share the share display module, add a dtsi to
describe it.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5dm.dtsi | 74 +++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91sam9x5dm.dtsi

diff --git a/arch/arm/boot/dts/at91sam9x5dm.dtsi b/arch/arm/boot/dts/at91sam9x5dm.dtsi
new file mode 100644
index 000000000000..31676f1b6e31
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9x5dm.dtsi
@@ -0,0 +1,74 @@
+/*
+ * at91sam9x5dm.dtsi - Device Tree file for SAM9x5 display module
+ *
+ *  Copyright (C) 2014 Atmel,
+ *                2014 Free Electrons
+ *
+ *  Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/ {
+	ahb {
+		apb {
+			hlcdc: hlcdc at f8038000 {
+				hlcdc-display-controller {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
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
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&hlcdc_pwm 0 50000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		power-supply = <&bl_reg>;
+		status = "disabled";
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
+		};
+	};
+
+	panel_reg: panel_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-power-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		status = "disabled";
+	};
+};
-- 
2.1.4
