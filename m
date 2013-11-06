From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed,  6 Nov 2013 09:25:13 +0100
Subject: [PATCH v6 2/4] ARM: STi: Supply I2C configuration to STiH416 SoC
In-Reply-To: <1383726315-27534-1-git-send-email-maxime.coquelin@st.com>
References: <1383726315-27534-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1383726315-27534-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies I2C configuration to STiH416 SoC.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi |   35 +++++++++++++++++++++
 arch/arm/boot/dts/stih416.dtsi         |   53 ++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index 0f246c9..b29ff4b 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -97,6 +97,24 @@
 					};
 				};
 			};
+
+			sbc_i2c0 {
+				pinctrl_sbc_i2c0_default: sbc_i2c0-default {
+					st,pins {
+						sda = <&PIO4 6 ALT1 BIDIR>;
+						scl = <&PIO4 5 ALT1 BIDIR>;
+					};
+				};
+			};
+
+			sbc_i2c1 {
+				pinctrl_sbc_i2c1_default: sbc_i2c1-default {
+					st,pins {
+						sda = <&PIO3 2 ALT2 BIDIR>;
+						scl = <&PIO3 1 ALT2 BIDIR>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front {
@@ -175,6 +193,23 @@
 				};
 			};
 
+			i2c0 {
+				pinctrl_i2c0_default: i2c0-default {
+					st,pins {
+						sda = <&PIO9 3 ALT1 BIDIR>;
+						scl = <&PIO9 2 ALT1 BIDIR>;
+					};
+				};
+			};
+
+			i2c1 {
+				pinctrl_i2c1_default: i2c1-default {
+					st,pins {
+						sda = <&PIO12 1 ALT1 BIDIR>;
+						scl = <&PIO12 0 ALT1 BIDIR>;
+					};
+				};
+			};
 		};
 
 		pin-controller-rear {
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 1a0326e..b7ab47b 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -9,6 +9,7 @@
 #include "stih41x.dtsi"
 #include "stih416-clock.dtsi"
 #include "stih416-pinctrl.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
 	L2: cache-controller {
 		compatible = "arm,pl310-cache";
@@ -92,5 +93,57 @@
 			pinctrl-0 	= <&pinctrl_sbc_serial1>;
 			clocks          = <&CLK_SYSIN>;
 		};
+
+		i2c at fed40000 {
+			compatible	= "st,comms-ssc4-i2c";
+			reg		= <0xfed40000 0x110>;
+			interrupts	= <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks		= <&CLK_S_ICN_REG_0>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_i2c0_default>;
+
+			status		= "disabled";
+		};
+
+		i2c at fed41000 {
+			compatible	= "st,comms-ssc4-i2c";
+			reg		= <0xfed41000 0x110>;
+			interrupts	= <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks		= <&CLK_S_ICN_REG_0>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_i2c1_default>;
+
+			status		= "disabled";
+		};
+
+		i2c at fe540000 {
+			compatible	= "st,comms-ssc4-i2c";
+			reg		= <0xfe540000 0x110>;
+			interrupts	= <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+			clocks		= <&CLK_SYSIN>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_sbc_i2c0_default>;
+
+			status		= "disabled";
+		};
+
+		i2c at fe541000 {
+			compatible	= "st,comms-ssc4-i2c";
+			reg		= <0xfe541000 0x110>;
+			interrupts	= <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			clocks		= <&CLK_SYSIN>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_sbc_i2c1_default>;
+
+			status		= "disabled";
+		};
 	};
 };
-- 
1.7.9.5
