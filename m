From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 16 Sep 2014 19:35:20 +0300
Subject: [PATCH 2/4] ARM: dts: cm-t54: add Startek LCD support
In-Reply-To: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1410885322-5928-3-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for Startek KD050C LCD 800x480 panel.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-cm-t54.dts |   44 ++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 9cb40d6..588cc2a 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -70,8 +70,41 @@
 	aliases {
 		display0 = &hdmi0;
 		display1 = &dvi0;
+		display2 = &lcd0;
 	};
 
+	lcd0: display {
+                compatible = "startek,startek-kd050c", "panel-dpi";
+                label = "lcd";
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&lcd_pins>;
+
+                enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
+
+                panel-timing {
+                        clock-frequency = <33000000>;
+                        hactive = <800>;
+                        vactive = <480>;
+                        hfront-porch = <40>;
+                        hback-porch = <40>;
+                        hsync-len = <43>;
+                        vback-porch = <29>;
+                        vfront-porch = <13>;
+                        vsync-len = <3>;
+                        hsync-active = <0>;
+                        vsync-active = <0>;
+                        de-active = <1>;
+                        pixelclk-active = <1>;
+                };
+
+                port {
+                        lcd_in: endpoint {
+                                remote-endpoint = <&dpi_lcd_out>;
+                        };
+                };
+        };
+
 	hdmi0: connector at 0 {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -223,6 +256,12 @@
 		>;
 	};
 
+	lcd_pins: pinmux_lcd_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x0172, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* timer11_pwm_evt.gpio8_227 */
+		>;
+	};
+
 	hdmi_conn_pins: pinmux_hdmi_conn_pins {
 		pinctrl-single,pins = <
 			OMAP5_IOPAD(0x013e, PIN_INPUT | MUX_MODE6) /* hdmi_hpd.gpio7_193 */
@@ -546,6 +585,11 @@
 			remote-endpoint = <&tfp410_in>;
 			data-lines = <24>;
 		};
+
+		dpi_lcd_out: endpoint at 1 {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
 	};
 };
 
-- 
1.7.5.4
