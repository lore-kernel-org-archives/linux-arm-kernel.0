From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:45 +0100
Subject: [PATCH 9/9] ARM: sun5i: gr8: Use common sun5i DTSI
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f9e1a964b48561cb52b68cad690d35ea793c95d0.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the GR8 DTSI is duplicated with the common sun5i DTSI, and some of
the extra nodes defined there actually apply to all of the sun5i family.

Move those into the common DTSI so that all SoCs can benefit from it, and
include the sun5i DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts |   2 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts      |   2 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi         | 617 +-----------------------
 arch/arm/boot/dts/sun5i.dtsi             |  45 ++-
 4 files changed, 76 insertions(+), 590 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index 0cf0813d363a..e5eb46b500ae 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -220,7 +220,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>, <&uart1_cts_rts_pins_a>;
+	pinctrl-0 = <&uart1_pins_b>, <&uart1_cts_rts_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index 1a845af4d4db..ebd8388e2ba1 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -332,7 +332,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>, <&uart1_cts_rts_pins_a>;
+	pinctrl-0 = <&uart1_pins_b>, <&uart1_cts_rts_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/sun5i-gr8.dtsi
index cb9b2aaf7297..8921af3bf1ef 100644
--- a/arch/arm/boot/dts/sun5i-gr8.dtsi
+++ b/arch/arm/boot/dts/sun5i-gr8.dtsi
@@ -42,429 +42,20 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include "sun5i.dtsi"
+
 #include <dt-bindings/clock/sun5i-ccu.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/reset/sun5i-ccu.h>
 
 / {
-	interrupt-parent = <&intc>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu at 0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a8";
-			reg = <0x0>;
-			clocks = <&ccu CLK_CPU>;
-		};
-	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		osc24M: clk at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-			clock-output-names = "osc24M";
-		};
-
-		osc32k: clk at 0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-			clock-output-names = "osc32k";
-		};
-	};
-
 	display-engine {
 		compatible = "allwinner,sun5i-a13-display-engine";
 		allwinner,pipelines = <&fe0>;
 	};
 
 	soc at 01c00000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		sram-controller at 01c00000 {
-			compatible = "allwinner,sun4i-a10-sram-controller";
-			reg = <0x01c00000 0x30>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			sram_a: sram at 00000000 {
-				compatible = "mmio-sram";
-				reg = <0x00000000 0xc000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x00000000 0xc000>;
-			};
-
-			sram_d: sram at 00010000 {
-				compatible = "mmio-sram";
-				reg = <0x00010000 0x1000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x00010000 0x1000>;
-
-				otg_sram: sram-section at 0000 {
-					compatible = "allwinner,sun4i-a10-sram-d";
-					reg = <0x0000 0x1000>;
-					status = "disabled";
-				};
-			};
-		};
-
-		dma: dma-controller at 01c02000 {
-			compatible = "allwinner,sun4i-a10-dma";
-			reg = <0x01c02000 0x1000>;
-			interrupts = <27>;
-			clocks = <&ccu CLK_AHB_DMA>;
-			#dma-cells = <2>;
-		};
-
-		nfc: nand at 01c03000 {
-			compatible = "allwinner,sun4i-a10-nand";
-			reg = <0x01c03000 0x1000>;
-			interrupts = <37>;
-			clocks = <&ccu CLK_AHB_NAND>, <&ccu CLK_NAND>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
-			dma-names = "rxtx";
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi0: spi at 01c05000 {
-			compatible = "allwinner,sun4i-a10-spi";
-			reg = <0x01c05000 0x1000>;
-			interrupts = <10>;
-			clocks = <&ccu CLK_AHB_SPI0>, <&ccu CLK_SPI0>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
-			       <&dma SUN4I_DMA_DEDICATED 26>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi1: spi at 01c06000 {
-			compatible = "allwinner,sun4i-a10-spi";
-			reg = <0x01c06000 0x1000>;
-			interrupts = <11>;
-			clocks = <&ccu CLK_AHB_SPI1>, <&ccu CLK_SPI1>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
-			       <&dma SUN4I_DMA_DEDICATED 8>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		tve0: tv-encoder at 01c0a000 {
-			compatible = "allwinner,sun4i-a10-tv-encoder";
-			reg = <0x01c0a000 0x1000>;
-			clocks = <&ccu CLK_AHB_TVE>;
-			resets = <&ccu RST_TVE>;
-			status = "disabled";
-
-			port {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				tve0_in_tcon0: endpoint at 0 {
-					reg = <0>;
-					remote-endpoint = <&tcon0_out_tve0>;
-				};
-			};
-		};
-
-		tcon0: lcd-controller at 01c0c000 {
-			compatible = "allwinner,sun5i-a13-tcon";
-			reg = <0x01c0c000 0x1000>;
-			interrupts = <44>;
-			resets = <&ccu RST_LCD>;
-			reset-names = "lcd";
-			clocks = <&ccu CLK_AHB_LCD>,
-				 <&ccu CLK_TCON_CH0>,
-				 <&ccu CLK_TCON_CH1>;
-			clock-names = "ahb",
-				      "tcon-ch0",
-				      "tcon-ch1";
-			clock-output-names = "tcon-pixel-clock";
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				tcon0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					tcon0_in_be0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&be0_out_tcon0>;
-					};
-				};
-
-				tcon0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					tcon0_out_tve0: endpoint at 1 {
-						reg = <1>;
-						remote-endpoint = <&tve0_in_tcon0>;
-					};
-				};
-			};
-		};
-
-		mmc0: mmc at 01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c0f000 0x1000>;
-			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
-			clock-names = "ahb", "mmc";
-			interrupts = <32>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc1: mmc at 01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c10000 0x1000>;
-			clocks = <&ccu CLK_AHB_MMC1>, <&ccu CLK_MMC1>;
-			clock-names = "ahb", "mmc";
-			interrupts = <33>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc2: mmc at 01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c11000 0x1000>;
-			clocks = <&ccu CLK_AHB_MMC2>, <&ccu CLK_MMC2>;
-			clock-names = "ahb", "mmc";
-			interrupts = <34>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		usb_otg: usb at 01c13000 {
-			compatible = "allwinner,sun4i-a10-musb";
-			reg = <0x01c13000 0x0400>;
-			clocks = <&ccu CLK_AHB_OTG>;
-			interrupts = <38>;
-			interrupt-names = "mc";
-			phys = <&usbphy 0>;
-			phy-names = "usb";
-			extcon = <&usbphy 0>;
-			allwinner,sram = <&otg_sram 1>;
-			status = "disabled";
-
-			dr_mode = "otg";
-		};
-
-		usbphy: phy at 01c13400 {
-			#phy-cells = <1>;
-			compatible = "allwinner,sun5i-a13-usb-phy";
-			reg = <0x01c13400 0x10 0x01c14800 0x4>;
-			reg-names = "phy_ctrl", "pmu1";
-			clocks = <&ccu CLK_USB_PHY0>;
-			clock-names = "usb_phy";
-			resets = <&ccu RST_USB_PHY0>, <&ccu RST_USB_PHY1>;
-			reset-names = "usb0_reset", "usb1_reset";
-			status = "disabled";
-		};
-
-		ehci0: usb at 01c14000 {
-			compatible = "allwinner,sun5i-a13-ehci", "generic-ehci";
-			reg = <0x01c14000 0x100>;
-			interrupts = <39>;
-			clocks = <&ccu CLK_AHB_EHCI>;
-			phys = <&usbphy 1>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
-		ohci0: usb at 01c14400 {
-			compatible = "allwinner,sun5i-a13-ohci", "generic-ohci";
-			reg = <0x01c14400 0x100>;
-			interrupts = <40>;
-			clocks = <&ccu CLK_USB_OHCI>, <&ccu CLK_AHB_OHCI>;
-			phys = <&usbphy 1>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
-		spi2: spi at 01c17000 {
-			compatible = "allwinner,sun4i-a10-spi";
-			reg = <0x01c17000 0x1000>;
-			interrupts = <12>;
-			clocks = <&ccu CLK_AHB_SPI2>, <&ccu CLK_SPI2>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
-			       <&dma SUN4I_DMA_DEDICATED 28>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		ccu: clock at 01c20000 {
-			compatible = "nextthing,gr8-ccu";
-			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
-			clock-names = "hosc", "losc";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-a10-ic";
-			reg = <0x01c20400 0x400>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-		};
-
-		pio: pinctrl at 01c20800 {
-			compatible = "nextthing,gr8-pinctrl";
-			reg = <0x01c20800 0x400>;
-			interrupts = <28>;
-			clocks = <&ccu CLK_APB0_PIO>;
-			gpio-controller;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			#gpio-cells = <3>;
-
-			i2c0_pins_a: i2c0 at 0 {
-				pins = "PB0", "PB1";
-				function = "i2c0";
-			};
-
-			i2c1_pins_a: i2c1 at 0 {
-				pins = "PB15", "PB16";
-				function = "i2c1";
-			};
-
-			i2c2_pins_a: i2c2 at 0 {
-				pins = "PB17", "PB18";
-				function = "i2c2";
-			};
-
-			i2s0_data_pins_a: i2s0-data at 0 {
-				pins = "PB6", "PB7", "PB8", "PB9";
-				function = "i2s0";
-			};
-
-			i2s0_mclk_pins_a: i2s0-mclk at 0 {
-				pins = "PB5";
-				function = "i2s0";
-			};
-
-			ir0_rx_pins_a: ir0 at 0 {
-				pins = "PB4";
-				function = "ir0";
-			};
-
-			lcd_rgb666_pins: lcd-rgb666 at 0 {
-				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
-						 "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
-						 "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
-						 "PD24", "PD25", "PD26", "PD27";
-				function = "lcd0";
-			};
-
-			mmc0_pins_a: mmc0 at 0 {
-				pins = "PF0", "PF1", "PF2", "PF3",
-						 "PF4", "PF5";
-				function = "mmc0";
-				drive-strength = <30>;
-			};
-
-			nand_pins_a: nand-base0 at 0 {
-				pins = "PC0", "PC1", "PC2",
-						"PC5", "PC8", "PC9", "PC10",
-						"PC11", "PC12", "PC13", "PC14",
-						"PC15";
-				function = "nand0";
-			};
-
-			nand_cs0_pins_a: nand-cs at 0 {
-				pins = "PC4";
-				function = "nand0";
-			};
-
-			nand_rb0_pins_a: nand-rb at 0 {
-				pins = "PC6";
-				function = "nand0";
-			};
-
-			pwm0_pins_a: pwm0 at 0 {
-				pins = "PB2";
-				function = "pwm0";
-			};
-
-			pwm1_pins: pwm1 {
-				pins = "PG13";
-				function = "pwm1";
-			};
-
-			spdif_tx_pins_a: spdif at 0 {
-				pins = "PB10";
-				function = "spdif";
-				bias-pull-up;
-			};
-
-			uart1_pins_a: uart1 at 1 {
-				pins = "PG3", "PG4";
-				function = "uart1";
-			};
-
-			uart1_cts_rts_pins_a: uart1-cts-rts at 0 {
-				pins = "PG5", "PG6";
-				function = "uart1";
-			};
-
-			uart2_pins_a: uart2 at 1 {
-				pins = "PD2", "PD3";
-				function = "uart2";
-			};
-
-			uart2_cts_rts_pins_a: uart2-cts-rts at 0 {
-				pins = "PD4", "PD5";
-				function = "uart2";
-			};
-
-			uart3_pins_a: uart3 at 1 {
-				pins = "PG9", "PG10";
-				function = "uart3";
-			};
-
-			uart3_cts_rts_pins_a: uart3-cts-rts at 0 {
-				pins = "PG11", "PG12";
-				function = "uart3";
-			};
-		};
-
 		pwm: pwm at 01c20e00 {
 			compatible = "allwinner,sun5i-a10s-pwm";
 			reg = <0x01c20e00 0xc>;
@@ -473,18 +64,6 @@
 			status = "disabled";
 		};
 
-		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-a10-timer";
-			reg = <0x01c20c00 0x90>;
-			interrupts = <22>;
-			clocks = <&ccu CLK_HOSC>;
-		};
-
-		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sun4i-a10-wdt";
-			reg = <0x01c20c90 0x10>;
-		};
-
 		spdif: spdif at 01c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-spdif";
@@ -498,15 +77,6 @@
 			status = "disabled";
 		};
 
-		ir0: ir at 01c21800 {
-			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&ccu CLK_APB0_IR>, <&ccu CLK_IR>;
-			clock-names = "apb", "ir";
-			interrupts = <5>;
-			reg = <0x01c21800 0x40>;
-			status = "disabled";
-		};
-
 		i2s0: i2s at 01c22400 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-i2s";
@@ -519,168 +89,39 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
+	};
+};
 
-		lradc: lradc at 01c22800 {
-			compatible = "allwinner,sun4i-a10-lradc-keys";
-			reg = <0x01c22800 0x100>;
-			interrupts = <31>;
-			status = "disabled";
-		};
-
-		codec: codec at 01c22c00 {
-			#sound-dai-cells = <0>;
-			compatible = "allwinner,sun4i-a10-codec";
-			reg = <0x01c22c00 0x40>;
-			interrupts = <30>;
-			clocks = <&ccu CLK_APB0_CODEC>, <&ccu CLK_CODEC>;
-			clock-names = "apb", "codec";
-			dmas = <&dma SUN4I_DMA_NORMAL 19>,
-			       <&dma SUN4I_DMA_NORMAL 19>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun5i-a13-ts";
-			reg = <0x01c25000 0x100>;
-			interrupts = <29>;
-			#thermal-sensor-cells = <0>;
-		};
-
-		uart1: serial at 01c28400 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28400 0x400>;
-			interrupts = <2>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_APB1_UART1>;
-			status = "disabled";
-		};
-
-		uart2: serial at 01c28800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28800 0x400>;
-			interrupts = <3>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_APB1_UART2>;
-			status = "disabled";
-		};
-
-		uart3: serial at 01c28c00 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28c00 0x400>;
-			interrupts = <4>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_APB1_UART3>;
-			status = "disabled";
-		};
-
-		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-a10-i2c";
-			reg = <0x01c2ac00 0x400>;
-			interrupts = <7>;
-			clocks = <&ccu CLK_APB1_I2C0>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-a10-i2c";
-			reg = <0x01c2b000 0x400>;
-			interrupts = <8>;
-			clocks = <&ccu CLK_APB1_I2C1>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-a10-i2c";
-			reg = <0x01c2b400 0x400>;
-			interrupts = <9>;
-			clocks = <&ccu CLK_APB1_I2C2>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		timer at 01c60000 {
-			compatible = "allwinner,sun5i-a13-hstimer";
-			reg = <0x01c60000 0x1000>;
-			interrupts = <82>, <83>;
-			clocks = <&ccu CLK_AHB_HSTIMER>;
-		};
-
-		fe0: display-frontend at 01e00000 {
-			compatible = "allwinner,sun5i-a13-display-frontend";
-			reg = <0x01e00000 0x20000>;
-			interrupts = <47>;
-			clocks = <&ccu CLK_AHB_DE_FE>, <&ccu CLK_DE_FE>,
-				 <&ccu CLK_DRAM_DE_FE>;
-			clock-names = "ahb", "mod",
-				      "ram";
-			resets = <&ccu RST_DE_FE>;
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fe0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					fe0_out_be0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&be0_in_fe0>;
-					};
-				};
-			};
-		};
-
-		be0: display-backend at 01e60000 {
-			compatible = "allwinner,sun5i-a13-display-backend";
-			reg = <0x01e60000 0x10000>;
-			clocks = <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
-				 <&ccu CLK_DRAM_DE_BE>;
-			clock-names = "ahb", "mod",
-				      "ram";
-			resets = <&ccu RST_DE_BE>;
-			status = "disabled";
+&ccu {
+	compatible = "nextthing,gr8-ccu";
+};
 
-			assigned-clocks = <&ccu CLK_DE_BE>;
-			assigned-clock-rates = <300000000>;
+&pio {
+	compatible = "nextthing,gr8-pinctrl";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+	i2s0_data_pins_a: i2s0-data at 0 {
+		pins = "PB6", "PB7", "PB8", "PB9";
+		function = "i2s0";
+	};
 
-				be0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
+	i2s0_mclk_pins_a: i2s0-mclk at 0 {
+		pins = "PB5";
+		function = "i2s0";
+	};
 
-					be0_in_fe0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&fe0_out_be0>;
-					};
-				};
+	pwm1_pins: pwm1 {
+		pins = "PG13";
+		function = "pwm1";
+	};
 
-				be0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
+	spdif_tx_pins_a: spdif at 0 {
+		pins = "PB10";
+		function = "spdif";
+		bias-pull-up;
+	};
 
-					be0_out_tcon0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&tcon0_in_be0>;
-					};
-				};
-			};
-		};
+	uart1_cts_rts_pins_a: uart1-cts-rts at 0 {
+		pins = "PG5", "PG6";
+		function = "uart1";
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index c8e2253cac1d..14bd50169cbe 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -159,6 +159,19 @@
 			#dma-cells = <2>;
 		};
 
+		nfc: nand at 01c03000 {
+			compatible = "allwinner,sun4i-a10-nand";
+			reg = <0x01c03000 0x1000>;
+			interrupts = <37>;
+			clocks = <&ccu CLK_AHB_NAND>, <&ccu CLK_NAND>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
+			dma-names = "rxtx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
@@ -406,6 +419,11 @@
 				function = "i2c2";
 			};
 
+			ir0_rx_pins_a: ir0 at 0 {
+				pins = "PB4";
+				function = "ir0";
+			};
+
 			lcd_rgb565_pins: lcd_rgb565 at 0 {
 				pins = "PD3", "PD4", "PD5", "PD6", "PD7",
 						 "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
@@ -447,6 +465,24 @@
 				bias-pull-up;
 			};
 
+			nand_pins_a: nand-base0 at 0 {
+				pins = "PC0", "PC1", "PC2",
+				       "PC5", "PC8", "PC9", "PC10",
+				       "PC11", "PC12", "PC13", "PC14",
+				       "PC15";
+				function = "nand0";
+			};
+
+			nand_cs0_pins_a: nand-cs at 0 {
+				pins = "PC4";
+				function = "nand0";
+			};
+
+			nand_rb0_pins_a: nand-rb at 0 {
+				pins = "PC6";
+				function = "nand0";
+			};
+
 			pwm0_pins_a: pwm0 at 0 {
 				pins = "PB2";
 				function = "pwm0";
@@ -505,6 +541,15 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		ir0: ir at 01c21800 {
+			compatible = "allwinner,sun4i-a10-ir";
+			clocks = <&ccu CLK_APB0_IR>, <&ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			interrupts = <5>;
+			reg = <0x01c21800 0x40>;
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
git-series 0.8.11
