From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 29 Apr 2016 22:20:49 +0200
Subject: [PATCH] ARM: dts: imx6: apalis: parallel lcd display support on ixora
Message-ID: <1461961249-3792-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add parallel LCD display support for the EDT ET057090DHU 5.7" LCD TFT
panel.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 4b533cb..8e67ca2 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -80,6 +80,47 @@
 		};
 	};
 
+	lcd_display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
+		status = "okay";
+
+		port at 0 {
+			reg = <0>;
+
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp1>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
+
+	panel: panel {
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 */
+		compatible = "edt,et057090dhu";
+		backlight = <&backlight>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -169,6 +210,10 @@
 	};
 };
 
+&ipu1_di0_disp1 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
 &ldb {
 	status = "okay";
 };
-- 
2.5.5
