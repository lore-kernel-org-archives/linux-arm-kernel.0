From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 15 Feb 2018 09:20:14 +0100
Subject: [PATCH 3/3] ARM: dts: stm32: Add display support on stm32f469-disco
In-Reply-To: <20180215082014.30383-1-philippe.cornu@st.com>
References: <20180215082014.30383-1-philippe.cornu@st.com>
Message-ID: <20180215082014.30383-4-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe CORNU <philippe.cornu@st.com>

Add display support on the stm32f469-disco board.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 51 ++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 7d53b794d27b..9bfb040e9909 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -46,7 +46,7 @@
  */
 
 /dts-v1/;
-#include "stm32f429.dtsi"
+#include "stm32f469.dtsi"
 #include "stm32f469-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
@@ -89,6 +89,55 @@
 	clock-frequency = <8000000>;
 };
 
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+			dsi_in: endpoint {
+				remote-endpoint = <&ltdc_out_dsi>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+			dsi_out: endpoint {
+				remote-endpoint = <&dsi_panel_in>;
+			};
+		};
+	};
+
+	panel-dsi at 0 {
+		compatible = "orisetech,otm8009a";
+		reg = <0>; /* dsi virtual channel (0..3) */
+		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
+		status = "okay";
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
+&ltdc {
+	dma-ranges;
+	status = "okay";
+
+	port {
+		ltdc_out_dsi: endpoint at 0 {
+			remote-endpoint = <&dsi_in>;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.15.1
