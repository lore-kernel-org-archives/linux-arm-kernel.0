From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  4 Jul 2017 13:59:22 +0200
Subject: [PATCH v2 4/9] ARM: dts: at91: sama5d2: add classd nodes
In-Reply-To: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
Message-ID: <20170704115927.32662-5-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds nodes for the classd device and its generated clock.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index cc06da394366..a564cd1ba327 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -494,6 +494,24 @@
 					clocks = <&plla>;
 				};
 
+				audio_pll_frac: audiopll_fracck {
+					compatible = "atmel,sama5d2-clk-audio-pll-frac";
+					#clock-cells = <0>;
+					clocks = <&main>;
+				};
+
+				audio_pll_pad: audiopll_padck {
+					compatible = "atmel,sama5d2-clk-audio-pll-pad";
+					#clock-cells = <0>;
+					clocks = <&audio_pll_frac>;
+				};
+
+				audio_pll_pmc: audiopll_pmcck {
+					compatible = "atmel,sama5d2-clk-audio-pll-pmc";
+					#clock-cells = <0>;
+					clocks = <&audio_pll_frac>;
+				};
+
 				utmi: utmick {
 					compatible = "atmel,at91sam9x5-clk-utmi";
 					#clock-cells = <0>;
@@ -895,7 +913,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>, <&audio_pll_pmc>;
 
 					sdmmc0_gclk: sdmmc0_gclk {
 						#clock-cells = <0>;
@@ -951,6 +969,12 @@
 						reg = <57>;
 						atmel,clk-output-range = <0 80000000>;
 					};
+
+					classd_gclk: classd_gclk {
+						#clock-cells = <0>;
+						reg = <59>;
+						atmel,clk-output-range = <0 100000000>;
+					};
 				};
 			};
 
@@ -1406,6 +1430,19 @@
 				status = "okay";
 			};
 
+			classd: classd at fc048000 {
+				compatible = "atmel,sama5d2-classd";
+				reg = <0xfc048000 0x100>;
+				interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(47))>;
+				dma-names = "tx";
+				clocks = <&classd_clk>, <&classd_gclk>;
+				clock-names = "pclk", "gclk";
+				status = "disabled";
+			};
+
 			can1: can at fc050000 {
 				compatible = "bosch,m_can";
 				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
-- 
2.11.0
