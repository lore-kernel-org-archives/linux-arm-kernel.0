From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 17 Dec 2014 16:45:23 +0000
Subject: [PATCH 4/8] ARM: STi: DT: STiH407: Add Device Tree node for the LPC
In-Reply-To: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1418834727-1602-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On current ST platforms the LPC controls a number of functions.  This
patch enables support for the LPC Watchdog and LPC RTC devices on LPC1
and LPC2 respectively.

Signed-off-by: David Paris <david.paris@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index f539627a..97cc125 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -8,6 +8,7 @@
  */
 #include "stih407-clock.dtsi"
 #include "stih407-pinctrl.dtsi"
+#include <dt-bindings/mfd/st-lpc.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -259,5 +260,24 @@
 
 			status = "disabled";
 		};
+
+		/* Watchdog and Real-Time Clock */
+		lpc at 8787000 {
+			compatible = "st,stih407-lpc";
+			reg = <0x8787000 0x1000>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clk_s_d3_flexgen CLK_LPC_0>;
+			timeout-sec = <120>;
+			st,syscfg = <&syscfg_core>;
+			st,lpc-mode = <ST_LPC_MODE_WDT>;
+		};
+
+		lpc at 8788000 {
+			compatible = "st,stih407-lpc";
+			reg = <0x8788000 0x1000>;
+			interrupts = <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
+			st,lpc-mode = <ST_LPC_MODE_RTC>;
+		};
 	};
 };
-- 
1.9.1
