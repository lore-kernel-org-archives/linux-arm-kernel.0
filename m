From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 7 Mar 2017 10:30:04 +0800
Subject: [PATCH] ARM: dts: at91: sama5d2: add m_can nodes
Message-ID: <20170307023004.31424-1-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes to support the Controller Area Network(M_CAN) on SAMA5D2.

As said in SAMA5D2 datasheet, the CAN clock is recommended to use
frequencies of 20, 40 or 80 MHz. To achieve these frequencies,
PMC GCLK3 must select the UPLLCK(480 MHz) as source clock and
divide by 24, 12, or 6. So, the "assigned-clock-rates" property
has three options: 20000000, 40000000, and 80000000.
The "assigned-clock-parents" property should be referred to utmi
fixedly.

The MSBs [bits 31:16] of the CAN Message RAM for CAN0 and CAN1 are
default configured in 0x00200000. To avoid conflict with SRAM map
for pm, change them to 0x00210000 in the AT91Bootstrap via setting
the CAN Memories Address-based Register(SFR_CAN) of SFR.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 24 +++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 56 +++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 9f7f8a7d8ff9..2f19b08dc226 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -257,6 +257,12 @@
 				status = "okay";
 			};
 
+			can0: can at f8054000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_can0_default>;
+				status = "okay";
+			};
+
 			uart3: serial at fc008000 {
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -321,6 +327,18 @@
 					bias-disable;
 				};
 
+				pinctrl_can0_default: can0_default {
+					pinmux = <PIN_PC10__CANTX0>,
+						 <PIN_PC11__CANRX0>;
+					bias-disable;
+				};
+
+				pinctrl_can1_default: can1_default {
+					pinmux = <PIN_PC26__CANTX1>,
+						 <PIN_PC27__CANRX1>;
+					bias-disable;
+				};
+
 				pinctrl_charger_chglev: charger_chglev {
 					pinmux = <PIN_PA12__GPIO>;
 					bias-disable;
@@ -468,6 +486,12 @@
 				};
 
 			};
+
+			can1: can at fc050000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_can1_default>;
+				status = "okay";
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 22332be72140..d2febea79cfb 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -762,6 +762,18 @@
 						atmel,clk-output-range = <0 83000000>;
 					};
 
+					can0_clk: can0_clk {
+						#clock-cells = <0>;
+						reg = <56>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					can1_clk: can1_clk {
+						#clock-cells = <0>;
+						reg = <57>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
 					classd_clk: classd_clk {
 						#clock-cells = <0>;
 						reg = <59>;
@@ -890,6 +902,18 @@
 						#clock-cells = <0>;
 						reg = <55>;
 					};
+
+					can0_gclk: can0_gclk {
+						#clock-cells = <0>;
+						reg = <56>;
+						atmel,clk-output-range = <0 80000000>;
+					};
+
+					can1_gclk: can1_gclk {
+						#clock-cells = <0>;
+						reg = <57>;
+						atmel,clk-output-range = <0 80000000>;
+					};
 				};
 			};
 
@@ -1144,6 +1168,22 @@
 				clocks = <&clk32k>;
 			};
 
+			can0: can at f8054000 {
+				compatible = "bosch,m_can";
+				reg = <0xf8054000 0x4000>, <0x210000 0x4000>;
+				reg-names = "m_can", "message_ram";
+				interrupts = <56 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <64 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupt-names = "int0", "int1";
+				clocks = <&can0_clk>, <&can0_gclk>;
+				clock-names = "hclk", "cclk";
+				assigned-clocks = <&can0_gclk>;
+				assigned-clock-parents = <&utmi>;
+				assigned-clock-rates = <40000000>;
+				bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
+				status = "disabled";
+			};
+
 			spi1: spi at fc000000 {
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xfc000000 0x100>;
@@ -1305,6 +1345,22 @@
 				status = "okay";
 			};
 
+			can1: can at fc050000 {
+				compatible = "bosch,m_can";
+				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
+				reg-names = "m_can", "message_ram";
+				interrupts = <57 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <65 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupt-names = "int0", "int1";
+				clocks = <&can1_clk>, <&can1_gclk>;
+				clock-names = "hclk", "cclk";
+				assigned-clocks = <&can1_gclk>;
+				assigned-clock-parents = <&utmi>;
+				assigned-clock-rates = <40000000>;
+				bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
+				status = "disabled";
+			};
+
 			chipid at fc069000 {
 				compatible = "atmel,sama5d2-chipid";
 				reg = <0xfc069000 0x8>;
-- 
2.11.0
