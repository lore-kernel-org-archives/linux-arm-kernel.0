From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Fri, 5 May 2017 17:31:25 +0200
Subject: [PATCH v5 6/8] ARM: dts: stm32: Enable OV2640 camera support of
 STM32F429-EVAL board
In-Reply-To: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
References: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1493998287-5828-7-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable OV2640 camera support of STM32F429-EVAL board.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 2bb8a0f..95c33b1 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -48,6 +48,7 @@
 /dts-v1/;
 #include "stm32f429.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32429i-EVAL board";
@@ -66,6 +67,14 @@
 		serial0 = &usart1;
 	};
 
+	clocks {
+		clk_ext_camera: clk-ext-camera {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
+
 	soc {
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
@@ -146,6 +155,11 @@
 
 	port {
 		dcmi_0: endpoint {
+			remote-endpoint = <&ov2640_0>;
+			bus-width = <8>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			pclk-sample = <1>;
 		};
 	};
 };
@@ -155,6 +169,22 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	ov2640: camera at 30 {
+		compatible = "ovti,ov2640";
+		reg = <0x30>;
+		resetb-gpios = <&stmpegpio 2 GPIO_ACTIVE_HIGH>;
+		pwdn-gpios = <&stmpegpio 0 GPIO_ACTIVE_LOW>;
+		clocks = <&clk_ext_camera>;
+		clock-names = "xvclk";
+		status = "okay";
+
+		port {
+			ov2640_0: endpoint {
+				remote-endpoint = <&dcmi_0>;
+			};
+		};
+	};
+
 	stmpe1600: stmpe1600 at 42 {
 		compatible = "st,stmpe1600";
 		reg = <0x42>;
-- 
1.9.1
