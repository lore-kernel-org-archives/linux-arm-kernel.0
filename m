From: yannick.fertre@st.com (Yannick Fertre)
Date: Tue, 28 Mar 2017 11:44:51 +0200
Subject: [PATCH v5 08/10] ARM: dts: stm32: Enable ltdc & simple panel on
 stm32f429-Eval board
In-Reply-To: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
References: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490694293-18358-9-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ltdc & enable am-480272h3tmqw-t01h panel.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index b30cf9a..083360b 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -124,6 +124,65 @@
 		clocks = <&rcc 0 STM32F4_AHB1_CLOCK(OTGHSULPI)>;
 		clock-names = "main_clk";
 	};
+
+	panel_rgb: panel-rgb {
+		compatible = "ampire,am-480272h3tmqw-t01h";
+		status = "okay";
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+};
+
+&pinctrl {
+	pinctrl_ltdc: ltdc at 0 {
+		pins {
+			pinmux = <STM32F429_PI12_FUNC_LCD_HSYNC>,
+				 <STM32F429_PI13_FUNC_LCD_VSYNC>,
+				 <STM32F429_PI14_FUNC_LCD_CLK>,
+				 <STM32F429_PI15_FUNC_LCD_R0>,
+				 <STM32F429_PJ0_FUNC_LCD_R1>,
+				 <STM32F429_PJ1_FUNC_LCD_R2>,
+				 <STM32F429_PJ2_FUNC_LCD_R3>,
+				 <STM32F429_PJ3_FUNC_LCD_R4>,
+				 <STM32F429_PJ4_FUNC_LCD_R5>,
+				 <STM32F429_PJ5_FUNC_LCD_R6>,
+				 <STM32F429_PJ6_FUNC_LCD_R7>,
+				 <STM32F429_PJ7_FUNC_LCD_G0>,
+				 <STM32F429_PJ8_FUNC_LCD_G1>,
+				 <STM32F429_PJ9_FUNC_LCD_G2>,
+				 <STM32F429_PJ10_FUNC_LCD_G3>,
+				 <STM32F429_PJ11_FUNC_LCD_G4>,
+				 <STM32F429_PJ12_FUNC_LCD_B0>,
+				 <STM32F429_PJ13_FUNC_LCD_B1>,
+				 <STM32F429_PJ14_FUNC_LCD_B2>,
+				 <STM32F429_PJ15_FUNC_LCD_B3>,
+				 <STM32F429_PK0_FUNC_LCD_G5>,
+				 <STM32F429_PK1_FUNC_LCD_G6>,
+				 <STM32F429_PK2_FUNC_LCD_G7>,
+				 <STM32F429_PK3_FUNC_LCD_B4>,
+				 <STM32F429_PK4_FUNC_LCD_B5>,
+				 <STM32F429_PK5_FUNC_LCD_B6>,
+				 <STM32F429_PK6_FUNC_LCD_B7>,
+				 <STM32F429_PK7_FUNC_LCD_DE>;
+			slew-rate = <2>;
+		};
+	};
+};
+
+&ltdc {
+	status = "okay";
+	pinctrl-0 = <&pinctrl_ltdc>;
+	pinctrl-names = "default";
+	dma-ranges;
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
 };
 
 &adc {
-- 
1.9.1
