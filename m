From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 25 Jul 2017 09:37:05 +0200
Subject: [PATCH v4 4/9] ARM: dts: at91: sama5d2: add classd nodes
In-Reply-To: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
Message-ID: <57ca6c418774e826584f0308d064dec8139c04d2.1500968090.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds nodes for the classd device and its generated clock.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 39 ++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 534ee6f..38d2216 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -505,6 +505,24 @@
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
@@ -906,7 +924,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>, <&audio_pll_pmc>;
 
 					sdmmc0_gclk: sdmmc0_gclk {
 						#clock-cells = <0>;
@@ -967,6 +985,12 @@
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
 
@@ -1444,6 +1468,19 @@
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
git-series 0.9.1
