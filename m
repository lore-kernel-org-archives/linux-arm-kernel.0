From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 6 Dec 2016 11:55:59 +0100
Subject: [RFC PATCH 2/3] ARM: dts: at91: sama5d2: add classd nodes
In-Reply-To: <cover.1481021115.git.nicolas.ferre@atmel.com>
References: <cover.1481021115.git.nicolas.ferre@atmel.com>
Message-ID: <d3c9b635eced4e76f3c167f2869a32febe473aba.1481021115.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds nodes for the classd device and its generated clock.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ceb9783ff7e1..d6b8d59a913b 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -447,6 +447,24 @@
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
@@ -836,7 +854,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>, <&audio_pll_pmc>;
 
 					sdmmc0_gclk: sdmmc0_gclk {
 						#clock-cells = <0>;
@@ -880,6 +898,12 @@
 						#clock-cells = <0>;
 						reg = <55>;
 					};
+
+					classd_gclk: classd_gclk {
+						#clock-cells = <0>;
+						reg = <59>;
+						atmel,clk-output-range = <0 100000000>;
+					};
 				};
 			};
 
@@ -1279,6 +1303,19 @@
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
+				clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
+				clock-names = "pclk", "gclk", "aclk";
+				status = "disabled";
+			};
+
 			chipid at fc069000 {
 				compatible = "atmel,sama5d2-chipid";
 				reg = <0xfc069000 0x8>;
-- 
2.9.0
