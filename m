From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 18:02:05 +0200
Subject: [PATCH v2 32/42] ARM: at91/dt: move at91sam9n12 SoC to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374076925-20580-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9n12 clocks in at91sam9n12 device tree.
Add references to the appropriate clocks in each peripheral.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi |  251 ++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bb7f564..a12ad9f 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -76,6 +76,224 @@
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
+					input = <2000000 32000000>;
+					output = <74500000 800000000
+						  69500000 750000000
+						  64500000 700000000
+						  59500000 650000000
+						  54500000 600000000
+						  49500000 550000000
+						  44500000 500000000
+						  40000000 450000000>;
+					out = <0 1 2 3 0 1 2 3>;
+					icpll = <0 0 0 0 1 1 1 1>;
+				};
+
+				pllb: pllbck {
+					compatible = "atmel,at91rm9200-clk-pll";
+					#clock-cells = <0>;
+					clocks = <&main>;
+					id = <1>;
+					input = <2000000 32000000>;
+					output = <74500000 800000000
+						  69500000 750000000
+						  64500000 700000000
+						  59500000 650000000
+						  54500000 600000000
+						  49500000 550000000
+						  44500000 500000000
+						  40000000 450000000>;
+					out = <0 1 2 3 0 1 2 3>;
+					icpll = <0 0 0 0 1 1 1 1>;
+				};
+
+				plladiv: plladivck {
+					compatible = "atmel,at91sam9x5-clk-plldiv";
+					#clock-cells = <0>;
+					clocks = <&plla>;
+				};
+
+				mck: masterck {
+					compatible = "atmel,at91sam9x5-clk-master";
+					#clock-cells = <0>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&pllb>;
+					output = <0 133000000>;
+					divisors = <1 2 4 3>;
+				};
+
+				usb: usbck {
+					compatible = "atmel,at91sam9x5-clk-usb";
+					#clock-cells = <0>;
+					clocks = <&pllb>;
+					usbs0-unused;
+				};
+
+				prog: progck {
+					compatible = "atmel,at91rm9200-clk-programmable";
+					#clock-cells = <1>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&pllb>, <&mck>;
+
+					prog0 at 0 {
+						id = <0>;
+					};
+
+					prog1 at 1 {
+						id = <1>;
+					};
+				};
+
+				system: systemck {
+					compatible = "atmel,at91rm9200-clk-system";
+					#clock-cells = <1>;
+
+					ddrck at 2 {
+						id = <2>;
+					};
+
+					lcdck at 3 {
+						id = <3>;
+					};
+
+					uhpck at 6 {
+						id = <6>;
+					};
+
+					udpck at 7 {
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
+				};
+
+				periph: periphck {
+					compatible = "atmel,at91rm9200-clk-peripheral";
+					#clock-cells = <1>;
+					clocks = <&mck>;
+
+					pioAB_clk at 2 {
+						id = <2>;
+					};
+
+					pioCD_clk at 3 {
+						id = <3>;
+					};
+
+					fuse_clk at 4 {
+						id = <4>;
+					};
+
+					usart0_clk at 5 {
+						id = <5>;
+					};
+
+					usart1_clk at 6 {
+						id = <6>;
+					};
+
+					usart2_clk at 7 {
+						id = <7>;
+					};
+
+					usart3_clk at 8 {
+						id = <8>;
+					};
+
+					twi0_ck at 9 {
+						id = <9>;
+					};
+
+					twi1_ck at 10 {
+						id = <10>;
+					};
+
+					hsmci_clk at 12 {
+						id = <12>;
+					};
+
+					spi0_clk at 13 {
+						id = <13>;
+					};
+
+					spi1_clk at 14 {
+						id = <14>;
+					};
+
+					uart0_clk at 15 {
+						id = <15>;
+					};
+
+					uart1_clk at 16 {
+						id = <16>;
+					};
+
+					tcb_clk at 17 {
+						id = <17>;
+					};
+
+					pwm_clk at 18 {
+						id = <18>;
+					};
+
+					adc_clk at 19 {
+						id = <19>;
+					};
+
+					dma_clk at 20 {
+						id = <20>;
+					};
+
+					uhp_clk at 22 {
+						id = <22>;
+					};
+
+					udc_clk at 23 {
+						id = <23>;
+					};
+
+					lcdc_clk at 25 {
+						id = <25>;
+					};
+
+					sha_clk at 27 {
+						id = <27>;
+					};
+
+					ssc_clk at 28 {
+						id = <28>;
+					};
+
+					aes_clk at 29 {
+						id = <29>;
+					};
+
+					trng_clk at 30 {
+						id = <30>;
+					};
+				};
 			};
 
 			rstc at fffffe00 {
@@ -87,6 +305,7 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&mck>;
 			};
 
 			shdwc at fffffe10 {
@@ -102,6 +321,8 @@
 				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 12>;
+				clock-names = "mci_clk";
 				status = "disabled";
 			};
 
@@ -109,12 +330,16 @@
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&periph 17>;
+				clock-names = "t0_clk";
 			};
 
 			tcb1: timer at f800c000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf800c000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&periph 17>;
+				clock-names = "t0_clk";
 			};
 
 			dma: dma-controller at ffffec00 {
@@ -122,6 +347,8 @@
 				reg = <0xffffec00 0x200>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
+				clocks = <&periph 20>;
+				clock-names = "dma_clk";
 			};
 
 			pinctrl at fffff400 {
@@ -375,6 +602,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 2>;
 				};
 
 				pioB: gpio at fffff600 {
@@ -385,6 +613,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 2>;
 				};
 
 				pioC: gpio at fffff800 {
@@ -395,6 +624,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 3>;
 				};
 
 				pioD: gpio at fffffa00 {
@@ -405,6 +635,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					clocks = <&periph 3>;
 				};
 			};
 
@@ -414,6 +645,8 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
+				clocks = <&mck>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -423,6 +656,8 @@
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+				clocks = <&periph 28>;
+				clock-names = "pclk";
 				status = "disabled";
 			};
 
@@ -432,6 +667,8 @@
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
+				clocks = <&periph 5>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -441,6 +678,8 @@
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
+				clocks = <&periph 6>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -450,6 +689,8 @@
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
+				clocks = <&periph 7>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -459,6 +700,8 @@
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
+				clocks = <&periph 8>;
+				clock-names = "usart";
 				status = "disabled";
 			};
 
@@ -471,6 +714,7 @@
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 9>;
 				status = "disabled";
 			};
 
@@ -483,6 +727,7 @@
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				clocks = <&periph 10>;
 				status = "disabled";
 			};
 
@@ -497,6 +742,8 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
+				clocks = <&periph 13>;
+				clock-names = "spi_clk";
 				status = "disabled";
 			};
 
@@ -511,6 +758,8 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
+				clocks = <&periph 14>;
+				clock-names = "spi_clk";
 				status = "disabled";
 			};
 
@@ -546,6 +795,8 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x00100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&usb>, <&periph 22>, <&periph 22>, <&system 6>;
+			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5
