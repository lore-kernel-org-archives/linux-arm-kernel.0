From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 16 Oct 2015 15:04:44 +0200
Subject: [PATCH v2 1/8] ARM: at91/dt: sama5d2: add missing devices
In-Reply-To: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
References: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1445000691-12402-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Big update of the sama5d2.dtsi file since many patches have reached te
mainline:
- add generated clocks
- enable crypto devices
- add flexcom devices
- add tdes device
- add sdmmc devices

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 152 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index cc05cde..5afccbc 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -263,6 +263,24 @@
 			cache-level = <2>;
 		};
 
+		sdmmc0: sdio-host at a0000000 {
+			compatible = "atmel,sama5d2-sdhci";
+			reg = <0xa0000000 0x300>;
+			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
+			clock-names = "hclock", "multclk", "baseclk";
+			status = "disabled";
+		};
+
+		sdmmc1: sdio-host at b0000000 {
+			compatible = "atmel,sama5d2-sdhci";
+			reg = <0xb0000000 0x300>;
+			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&sdmmc1_hclk>, <&sdmmc1_gclk>, <&main>;
+			clock-names = "hclock", "multclk", "baseclk";
+			status = "disabled";
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -619,6 +637,18 @@
 						atmel,clk-output-range = <0 83000000>;
 					};
 
+					i2s0_clk: i2s0_clk {
+						#clock-cells = <0>;
+						reg = <54>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					i2s1_clk: i2s1_clk {
+						#clock-cells = <0>;
+						reg = <55>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
 					classd_clk: classd_clk {
 						#clock-cells = <0>;
 						reg = <59>;
@@ -697,6 +727,52 @@
 						reg = <53>;
 					};
 				};
+
+				gck {
+					compatible = "atmel,sama5d2-clk-generated";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					interrupt-parent = <&pmc>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+
+					sdmmc0_gclk: sdmmc0_gclk {
+						#clock-cells = <0>;
+						reg = <31>;
+					};
+
+					sdmmc1_gclk: sdmmc1_gclk {
+						#clock-cells = <0>;
+						reg = <32>;
+					};
+
+					tcb0_gclk: tcb0_gclk {
+						#clock-cells = <0>;
+						reg = <35>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					tcb1_gclk: tcb1_gclk {
+						#clock-cells = <0>;
+						reg = <36>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					pwm_gclk: pwm_gclk {
+						#clock-cells = <0>;
+						reg = <38>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
+					i2s0_gclk: i2s0_gclk {
+						#clock-cells = <0>;
+						reg = <54>;
+					};
+
+					i2s1_gclk: i2s1_gclk {
+						#clock-cells = <0>;
+						reg = <55>;
+					};
+				};
 			};
 
 			sha at f0028000 {
@@ -709,7 +785,7 @@
 				dma-names = "tx";
 				clocks = <&sha_clk>;
 				clock-names = "sha_clk";
-				status = "disabled";
+				status = "okay";
 			};
 
 			aes at f002c000 {
@@ -725,7 +801,7 @@
 				dma-names = "tx", "rx";
 				clocks = <&aes_clk>;
 				clock-names = "aes_clk";
-				status = "disabled";
+				status = "okay";
 			};
 
 			spi0: spi at f8000000 {
@@ -820,6 +896,32 @@
 				status = "disabled";
 			};
 
+			flx0: flexcom at f8034000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xf8034000 0x200>;
+				clocks = <&flx0_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xf8034000 0x800>;
+				status = "disabled";
+			};
+
+			flx1: flexcom at f8038000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xf8038000 0x200>;
+				clocks = <&flx1_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xf8038000 0x800>;
+				status = "disabled";
+			};
+
+			rstc at f8048000 {
+				compatible = "atmel,sama5d3-rstc";
+				reg = <0xf8048000 0x10>;
+				clocks = <&clk32k>;
+			};
+
 			pit: timer at f8048030 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xf8048030 0x10>;
@@ -897,6 +999,36 @@
 				status = "disabled";
 			};
 
+			flx2: flexcom at fc010000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc010000 0x200>;
+				clocks = <&flx2_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc010000 0x800>;
+				status = "disabled";
+			};
+
+			flx3: flexcom at fc014000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc014000 0x200>;
+				clocks = <&flx3_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc014000 0x800>;
+				status = "disabled";
+			};
+
+			flx4: flexcom at fc018000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc018000 0x200>;
+				clocks = <&flx4_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc018000 0x800>;
+				status = "disabled";
+			};
+
 			aic: interrupt-controller at fc020000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,sama5d2-aic";
@@ -935,6 +1067,22 @@
 				#gpio-cells = <2>;
 				clocks = <&pioA_clk>;
 			};
+
+			tdes at fc044000 {
+				compatible = "atmel,at91sam9g46-tdes";
+				reg = <0xfc044000 0x100>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(28))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(29))>;
+				dma-names = "tx", "rx";
+				clocks = <&tdes_clk>;
+				clock-names = "tdes_clk";
+				status = "okay";
+			};
 		};
 	};
 };
-- 
2.5.0
