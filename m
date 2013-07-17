From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 17:51:44 +0200
Subject: [PATCH v2 28/42] ARM: at91/dt: move at91rm9200 SoC to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374076304-20371-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91rm9200 clocks in at91rm9200 device tree.
Add references to the appropriate clocks in each peripheral.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi |  231 +++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 92b9e21..5596b1f 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -79,6 +79,204 @@
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
+					output = <80000000 160000000
+						  150000000 180000000>;
+					out = <0 2>;
+				};
+
+				pllb: pllbck {
+					compatible = "atmel,at91rm9200-clk-pll";
+					#clock-cells = <0>;
+					clocks = <&main>;
+					id = <1>;
+					input = <1000000 32000000>;
+					output = <80000000 160000000
+						  150000000 180000000>;
+					out = <0 2>;
+				};
+
+				mck: masterck {
+					compatible = "atmel,at91rm9200-clk-master";
+					#clock-cells = <0>;
+					clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
+					output = <0 80000000>;
+					divisors = <1 2 3 4>;
+				};
+
+				usb: usbck {
+					compatible = "atmel,at91rm9200-clk-usb";
+					#clock-cells = <0>;
+					clocks = <&pllb>;
+					divisors = <1 2 0 0>;
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
+					udpck at 1 {
+						id = <1>;
+					};
+
+					uhpck at 4 {
+						id = <4>;
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
+					pioC_clk at 4 {
+						id = <4>;
+					};
+
+					pioD_clk at 5 {
+						id = <5>;
+					};
+
+					usart0_clk at 6 {
+						id = <6>;
+					};
+
+					usart1_clk at 7 {
+						id = <7>;
+					};
+
+					usart2_clk at 8 {
+						id = <8>;
+					};
+
+					usart3_clk at 9 {
+						id = <9>;
+					};
+
+					mci_clk at 10 {
+						id = <10>;
+					};
+
+					udc_clk at 11 {
+						id = <11>;
+					};
+
+					twi_clk at 12 {
+						id = <12>;
+					};
+
+					spi_clk at 13 {
+						id = <13>;
+					};
+
+					ssc0_clk at 14 {
+						id = <14>;
+					};
+
+					ssc1_clk at 15 {
+						id = <15>;
+					};
+
+					ssc2_clk at 16 {
+						id = <16>;
+					};
+
+					tc0_clk at 17 {
+						id = <17>;
+					};
+
+					tc1_clk at 18 {
+						id = <18>;
+					};
+
+					tc2_clk at 19 {
+						id = <19>;
+					};
+
+					tc3_clk at 20 {
+						id = <20>;
+					};
+
+					tc4_clk at 21 {
+						id = <21>;
+					};
+
+					tc5_clk at 22 {
+						id = <22>;
+					};
+
+					ohci_clk at 23 {
+						id = <23>;
+					};
+
+					pclk at 24 {
+						id = <24>;
+					};
+				};
 			};
 
 			st: timer at fffffd00 {
@@ -93,6 +291,8 @@
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
 					      18 IRQ_TYPE_LEVEL_HIGH 0
 					      19 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&periph 17>, <&periph 18>, <&periph 19>;
+				clock-names = "t0_clk", "t1_clk", "t2_clk";
 			};
 
 			tcb1: timer at fffa4000 {
@@ -101,6 +301,8 @@
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0
 					      21 IRQ_TYPE_LEVEL_HIGH 0
 					      22 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&periph 20>, <&periph 21>, <&periph 22>;
+				clock-names = "t0_clk", "t1_clk", "t2_clk";
 			};
 
 			i2c0: i2c at fffb8000 {
@@ -111,6 +313,7 @@
 				pinctrl-0 = <&pinctrl_twi>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 12>;
 				status = "disabled";
 			};
 
@@ -120,6 +323,8 @@
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 10>;
+				clock-names = "mci_clk";
 				status = "disabled";
 			};
 
@@ -129,6 +334,8 @@
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+				clocks = <&periph 14>;
+				clock-names = "pclk";
 				status = "disable";
 			};
 
@@ -138,6 +345,8 @@
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
+				clocks = <&periph 15>;
+				clock-names = "pclk";
 				status = "disable";
 			};
 
@@ -147,6 +356,8 @@
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc2_tx &pinctrl_ssc2_rx>;
+				clocks = <&periph 16>;
+				clock-names = "pclk";
 				status = "disable";
 			};
 
@@ -157,6 +368,8 @@
 				phy-mode = "rmii";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
+				clocks = <&periph 24>, <&periph 24>;
+				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
 
@@ -495,6 +708,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 2>;
 				};
 
 				pioB: gpio at fffff600 {
@@ -505,6 +719,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 3>;
 				};
 
 				pioC: gpio at fffff800 {
@@ -515,6 +730,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 4>;
 				};
 
 				pioD: gpio at fffffa00 {
@@ -525,6 +741,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 5>;
 				};
 			};
 
@@ -534,6 +751,8 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
+				clocks = <&mck>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -545,6 +764,8 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
+				clocks = <&periph 6>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -556,6 +777,8 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
+				clocks = <&periph 7>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -567,6 +790,8 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart2>;
+				clocks = <&periph 8>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -578,6 +803,8 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart3>;
+				clocks = <&periph 9>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -585,6 +812,8 @@
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffb0000 0x4000>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 2>;
+				clocks = <&periph 11>, <&system 1>;
+				clock-names = "udc_clk", "udpck";
 				status = "disabled";
 			};
 
@@ -621,6 +850,8 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00300000 0x100000>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&usb>, <&periph 23>, <&periph 23>, <&system 4>;
+			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5
