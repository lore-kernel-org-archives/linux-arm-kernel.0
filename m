From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 26 Sep 2013 11:54:18 +0200
Subject: [PATCH v2 3/4] ARM: STi: Supply I2C configuration to STiH415 SoC
Message-ID: <1380189258-5872-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies I2C configuration to STiH415 SoC.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih415-pinctrl.dtsi |   36 ++++++++++++++++++
 arch/arm/boot/dts/stih415.dtsi         |   65 ++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts/stih415-pinctrl.dtsi
index 1d322b2..e56449d 100644
--- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -86,6 +86,24 @@
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
@@ -143,6 +161,24 @@
 				reg		= <0x7000 0x100>;
 				st,bank-name	= "PIO12";
 			};
+
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
diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index 74ab8de..12598c5 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -9,6 +9,7 @@
 #include "stih41x.dtsi"
 #include "stih415-clock.dtsi"
 #include "stih415-pinctrl.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
 
 	L2: cache-controller {
@@ -83,5 +84,69 @@
 			pinctrl-names 	= "default";
 			pinctrl-0	= <&pinctrl_sbc_serial1>;
 		};
+
+		i2c at fed40000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfed40000 0x110>;
+			interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLKS_ICN_REG_0>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_i2c0_default>;
+			st,glitches;
+			st,glitch-clk	= <500>;
+			st,glitch-dat	= <500>;
+
+			status		= "disabled";
+		};
+
+		i2c at fed41000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfed41000 0x110>;
+			interrupts	=  <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLKS_ICN_REG_0>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_i2c1_default>;
+			st,glitches;
+			st,glitch-clk	= <500>;
+			st,glitch-dat	= <500>;
+
+			status		= "disabled";
+		};
+
+		i2c at fe540000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfe540000 0x110>;
+			interrupts	=  <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLK_SYSIN>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_sbc_i2c0_default>;
+			st,glitches;
+			st,glitch-clk	= <500>;
+			st,glitch-dat	= <500>;
+
+			status		= "disabled";
+		};
+
+		i2c at fe541000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfe541000 0x110>;
+			interrupts	=  <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLK_SYSIN>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_sbc_i2c1_default>;
+			st,glitches;
+			st,glitch-clk	= <500>;
+			st,glitch-dat	= <500>;
+
+			status		= "disabled";
+		};
 	};
 };
-- 
1.7.9.5
