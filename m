From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 17:55:25 +0200
Subject: [PATCH v2 30/42] ARM: at91/dt: move at91sam9263 SoC to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374076525-20459-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9263 clocks in at91sam9263 device tree.
Add references to the appropriate clocks in each peripheral.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi |  237 ++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index d5bd65f..f4b0d3b 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -68,6 +68,208 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91rm9200-pmc";
 				reg = <0xfffffc00 0x100>;
+
+				clk32k: slck {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <32768>;
+				};
+
+				main: mainck {
+					compatible = "atmel,at91rm9200-clk-main", "fixed-clock";
+					#clock-cells = <0>;
+					clocks = <&clk32k>;
+				};
+
+				plla: pllack {
+					compatible = "atmel,at91rm9200-clk-pll";
+					#clock-cells = <0>;
+					clocks = <&main>;
+					id = <0>;
+					input = <1000000 32000000>;
+					output = <80000000 200000000
+						  190000000 240000000>;
+					out = <0 2>;
+				};
+
+				pllb: pllbck {
+					compatible = "atmel,at91rm9200-clk-pll";
+					#clock-cells = <0>;
+					clocks = <&main>;
+					id = <1>;
+					input = <1000000 32000000>;
+					output = <80000000 200000000
+						  190000000 240000000>;
+					out = <0 2>;
+				};
+
+				mck: masterck {
+					compatible = "atmel,at91rm9200-clk-master";
+					#clock-cells = <0>;
+					clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
+					output = <0 120000000>;
+					divisors = <1 2 4 0>;
+				};
+
+				usb: usbck {
+					compatible = "atmel,at91rm9200-clk-usb";
+					#clock-cells = <0>;
+					clocks = <&pllb>;
+					divisors = <1 2 4 0>;
+				};
+
+				prog: progck {
+					compatible = "atmel,at91rm9200-clk-programmable";
+					#clock-cells = <1>;
+					clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
+
+					prog0 at 0 {
+						id = <0>;
+					};
+
+					prog1 at 1 {
+						id = <1>;
+					};
+
+					prog2 at 2 {
+						id = <2>;
+					};
+
+					prog3 at 3 {
+						id = <3>;
+					};
+				};
+
+				system: systemck {
+					compatible = "atmel,at91rm9200-clk-system";
+					#clock-cells = <1>;
+
+					udpck at 6 {
+						id = <6>;
+					};
+
+					uhpck at 7 {
+						id = <7>;
+					};
+
+					pck0 at 8 {
+						id = <8>;
+					};
+
+					pck1 at 9 {
+						id = <9>;
+					};
+
+					pck2 at 10 {
+						id = <10>;
+					};
+
+					pck3 at 11 {
+						id = <11>;
+					};
+				};
+
+				periph: periphck {
+					compatible = "atmel,at91rm9200-clk-peripheral";
+					#clock-cells = <1>;
+					clocks = <&mck>;
+
+					pioA_clk at 2 {
+						id = <2>;
+					};
+
+					pioB_clk at 3 {
+						id = <3>;
+					};
+
+					pioCDE_clk at 4 {
+						id = <4>;
+					};
+
+					usart0_clk at 7 {
+						id = <7>;
+					};
+
+					usart1_clk at 8 {
+						id = <8>;
+					};
+
+					usart2_clk at 9 {
+						id = <9>;
+					};
+
+					mci0_clk at 10 {
+						id = <10>;
+					};
+
+					mci1_clk at 11 {
+						id = <11>;
+					};
+
+					can_clk at 12 {
+						id = <12>;
+					};
+
+					twi_clk at 13 {
+						id = <13>;
+					};
+
+					spi0_clk at 14 {
+						id = <14>;
+					};
+
+					spi1_clk at 15 {
+						id = <15>;
+					};
+
+					ssc0_clk at 16 {
+						id = <16>;
+					};
+
+					ssc1_clk at 17 {
+						id = <17>;
+					};
+
+					ac97_clk at 18 {
+						id = <18>;
+					};
+
+					tcb_clk at 19 {
+						id = <19>;
+					};
+
+					pwm_clk at 20 {
+						id = <20>;
+					};
+
+					pclk at 21 {
+						id = <21>;
+					};
+
+					2dge_clk at 23 {
+						id = <23>;
+					};
+
+					udc_clk at 24 {
+						id = <24>;
+					};
+
+					isi_clk at 25 {
+						id = <25>;
+					};
+
+					lcdc_clk at 26 {
+						id = <26>;
+					};
+
+					dma_clk at 27 {
+						id = <27>;
+					};
+
+					ohci_clk at 29 {
+						id = <29>;
+					};
+				};
 			};
 
 			ramc: ramc at ffffe200 {
@@ -80,12 +282,15 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&mck>;
 			};
 
 			tcb0: timer at fff7c000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfff7c000 0x100>;
 				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&periph 19>;
+				clock-names = "t0_clk";
 			};
 
 			rstc at fffffd00 {
@@ -374,6 +579,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 2>;
 				};
 
 				pioB: gpio at fffff400 {
@@ -384,6 +590,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 3>;
 				};
 
 				pioC: gpio at fffff600 {
@@ -394,6 +601,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 4>;
 				};
 
 				pioD: gpio at fffff800 {
@@ -404,6 +612,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 4>;
 				};
 
 				pioE: gpio at fffffa00 {
@@ -414,6 +623,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 4>;
 				};
 			};
 
@@ -423,6 +633,8 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
+				clocks = <&mck>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -434,6 +646,8 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
+				clocks = <&periph 7>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -445,6 +659,8 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
+				clocks = <&periph 8>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -456,6 +672,8 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
+				clocks = <&periph 9>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -465,6 +683,8 @@
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+				clocks = <&periph 16>;
+				clock-names = "pclk";
 				status = "disabled";
 			};
 
@@ -474,6 +694,8 @@
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
+				clocks = <&periph 17>;
+				clock-names = "pclk";
 				status = "disabled";
 			};
 
@@ -483,6 +705,8 @@
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
+				clocks = <&periph 21>, <&periph 21>;
+				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
 
@@ -490,6 +714,8 @@
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfff78000 0x4000>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 2>;
+				clocks = <&periph 24>, <&system 7>;
+				clock-names = "udc_clk", "udpck";
 				status = "disabled";
 			};
 
@@ -499,6 +725,7 @@
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 13>;
 				status = "disabled";
 			};
 
@@ -508,6 +735,8 @@
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 10>;
+				clock-names = "mci_clk";
 				status = "disabled";
 			};
 
@@ -517,6 +746,8 @@
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 11>;
+				clock-names = "mci_clk";
 				status = "disabled";
 			};
 
@@ -534,6 +765,8 @@
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
+				clocks = <&periph 14>;
+				clock-names = "spi_clk";
 				status = "disabled";
 			};
 
@@ -545,6 +778,8 @@
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
+				clocks = <&periph 15>;
+				clock-names = "spi_clk";
 				status = "disabled";
 			};
 		};
@@ -571,6 +806,8 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00a00000 0x100000>;
 			interrupts = <29 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&usb>, <&periph 29>, <&periph 29>, <&system 6>;
+			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5
