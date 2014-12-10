From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 10 Dec 2014 16:37:25 +0800
Subject: [PATCH RFC 12/15] ARM: dts: imx6qdl-sabresd: Add support for TRULY
 TFT480800-16-E MIPI DSI panel
In-Reply-To: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1418200648-32656-13-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TRULY TFT480800-16-E panel is driven by the Himax HX8369A driver IC.
The driver IC supports several display/control interface modes, including
the MIPI DSI video mode and command mode.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index baf2f00..483aa5f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -482,6 +482,13 @@
 				MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 			>;
 		};
+
+		pinctrl_mipi_panel: mipipanelgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11 0x1b0b0
+				MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x1b0b0
+			>;
+		};
 	};
 
 	gpio_leds {
@@ -518,6 +525,40 @@
 	};
 };
 
+&mipi_dsi {
+	status = "okay";
+
+	panel at 0 {
+		compatible = "himax,hx8369a-dsi";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mipi_panel>;
+		reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+		reset-delay = <120>;
+		bs2-gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
+		data-lanes = <2>;
+		panel-width-mm = <45>;
+		panel-height-mm = <76>;
+		bs = <10>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing1>;
+			timing1: truly-tft480800-16-e {
+				clock-frequency = <26400000>;
+				hactive = <480>;
+				vactive = <800>;
+				hfront-porch = <8>;
+				hback-porch = <8>;
+				hsync-len = <8>;
+				vfront-porch = <6>;
+				vback-porch = <6>;
+				vsync-len = <6>;
+			};
+		};
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
-- 
2.1.0
