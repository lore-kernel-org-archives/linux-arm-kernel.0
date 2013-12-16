From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Dec 2013 20:12:03 +0100
Subject: [PATCH 2/2] ARM: device trees for Energy Micro's EFM32 Cortex-M3 SoCs
In-Reply-To: <20131216190953.GB14866@pengutronix.de>
References: <20131216190953.GB14866@pengutronix.de>
Message-ID: <1387221123-6794-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/armv7-m.dtsi       |  18 ++++
 arch/arm/boot/dts/efm32gg-dk3750.dts |  86 ++++++++++++++++++
 arch/arm/boot/dts/efm32gg.dtsi       | 172 +++++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+)
 create mode 100644 arch/arm/boot/dts/armv7-m.dtsi
 create mode 100644 arch/arm/boot/dts/efm32gg-dk3750.dts
 create mode 100644 arch/arm/boot/dts/efm32gg.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..e4a0bea 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
 	dove-d2plug.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
+dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
new file mode 100644
index 0000000..5a660d0
--- /dev/null
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -0,0 +1,18 @@
+#include "skeleton.dtsi"
+
+/ {
+	nvic: nv-interrupt-controller  {
+		compatible = "arm,armv7m-nvic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xe000e100 0xc00>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&nvic>;
+		ranges;
+	};
+};
diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
new file mode 100644
index 0000000..aa5c0f6
--- /dev/null
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -0,0 +1,86 @@
+/*
+ * Device tree for EFM32GG-DK3750 development board.
+ *
+ * Documentation available from
+ * http://www.silabs.com/Support%20Documents/TechnicalDocs/efm32gg-dk3750-ug.pdf
+ */
+
+/dts-v1/;
+#include "efm32gg.dtsi"
+
+/ {
+	model = "Energy Micro Giant Gecko Development Kit";
+	compatible = "efm32,dk3750";
+
+	chosen {
+		bootargs = "console=ttyefm4,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk uclinux.physaddr=0x8c400000 root=/dev/mtdblock0";
+	};
+
+	memory {
+		reg = <0x88000000 0x400000>;
+	};
+
+	soc {
+		adc at 40002000 {
+			status = "ok";
+		};
+
+		i2c at 4000a000 {
+			location = <3>;
+			status = "ok";
+
+			temp at 48 {
+				compatible = "st,stds75";
+				reg = <0x48>;
+			};
+
+			eeprom at 50 {
+				compatible = "microchip,24c02";
+				reg = <0x50>;
+				pagesize = <16>;
+			};
+		};
+
+		spi0: spi at 4000c000 { /* USART0 */
+			cs-gpios = <&gpio 68 1>; // E4
+			location = <1>;
+			status = "ok";
+
+			microsd at 0 {
+				compatible = "mmc-spi-slot";
+				spi-max-frequency = <100000>;
+				voltage-ranges = <3200 3400>;
+				broken-cd;
+				reg = <0>;
+			};
+		};
+
+		spi1: spi at 4000c400 { /* USART1 */
+			cs-gpios = <&gpio 51 1>; // D3
+			location = <1>;
+			status = "ok";
+
+			ks8851 at 0 {
+				compatible = "ks8851";
+				spi-max-frequency = <6000000>;
+				reg = <0>;
+				interrupt-parent = <&boardfpga>;
+				interrupts = <4>;
+			};
+		};
+
+		uart4: uart at 4000e400 { /* UART1 */
+			location = <2>;
+			status = "ok";
+		};
+
+		boardfpga: boardfpga {
+			compatible = "efm32board";
+			reg = <0x80000000 0x400>;
+			irq-gpios = <&gpio 64 1>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/efm32gg.dtsi b/arch/arm/boot/dts/efm32gg.dtsi
new file mode 100644
index 0000000..a342ab0
--- /dev/null
+++ b/arch/arm/boot/dts/efm32gg.dtsi
@@ -0,0 +1,172 @@
+/*
+ * Device tree for Energy Micro EFM32 Giant Gecko SoC.
+ *
+ * Documentation available from
+ * http://www.silabs.com/Support%20Documents/TechnicalDocs/EFM32GG-RM.pdf
+ */
+#include "armv7-m.dtsi"
+#include "dt-bindings/clock/efm32-cmu.h"
+
+/ {
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+	};
+
+	soc {
+		adc: adc at 40002000 {
+			compatible = "efm32,adc";
+			reg = <0x40002000 0x400>;
+			interrupts = <7>;
+			clocks = <&cmu clk_HFPERCLKADC0>;
+			status = "disabled";
+		};
+
+		gpio: gpio at 40006000 {
+			compatible = "efm32,gpio";
+			reg = <0x40006000 0x1000>;
+			interrupts = <1 11>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			clocks = <&cmu clk_HFPERCLKGPIO>;
+			status = "ok";
+		};
+
+		i2c0: i2c at 4000a000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,i2c";
+			reg = <0x4000a000 0x400>;
+			interrupts = <9>;
+			clocks = <&cmu clk_HFPERCLKI2C0>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 4000a400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,i2c";
+			reg = <0x4000a400 0x400>;
+			interrupts = <10>;
+			clocks = <&cmu clk_HFPERCLKI2C1>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		spi0: spi at 4000c000 { /* USART0 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,spi";
+			reg = <0x4000c000 0x400>;
+			interrupts = <3 4>;
+			clocks = <&cmu clk_HFPERCLKUSART0>;
+			status = "disabled";
+		};
+
+		spi1: spi at 4000c400 { /* USART1 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,spi";
+			reg = <0x4000c400 0x400>;
+			interrupts = <15 16>;
+			clocks = <&cmu clk_HFPERCLKUSART1>;
+			status = "disabled";
+		};
+
+		spi2: spi at 40x4000c800 { /* USART2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,spi";
+			reg = <0x4000c800 0x400>;
+			interrupts = <18 19>;
+			clocks = <&cmu clk_HFPERCLKUSART2>;
+			status = "disabled";
+		};
+
+		uart0: uart at 4000c000 { /* USART0 */
+			compatible = "efm32,uart";
+			reg = <0x4000c000 0x400>;
+			interrupts = <3 4>;
+			clocks = <&cmu clk_HFPERCLKUSART0>;
+			status = "disabled";
+		};
+
+		uart1: uart at 4000c400 { /* USART1 */
+			compatible = "efm32,uart";
+			reg = <0x4000c400 0x400>;
+			interrupts = <15 16>;
+			clocks = <&cmu clk_HFPERCLKUSART1>;
+			status = "disabled";
+		};
+
+		uart2: uart at 40x4000c800 { /* USART2 */
+			compatible = "efm32,uart";
+			reg = <0x4000c800 0x400>;
+			interrupts = <18 19>;
+			clocks = <&cmu clk_HFPERCLKUSART2>;
+			status = "disabled";
+		};
+
+		uart3: uart at 4000e000 { /* UART0 */
+			compatible = "efm32,uart";
+			reg = <0x4000e000 0x400>;
+			interrupts = <20 21>;
+			clocks = <&cmu clk_HFPERCLKUART0>;
+			status = "disabled";
+		};
+
+		uart4: uart at 4000e400 { /* UART1 */
+			compatible = "efm32,uart";
+			reg = <0x4000e400 0x400>;
+			interrupts = <22 23>;
+			clocks = <&cmu clk_HFPERCLKUART1>;
+			status = "disabled";
+		};
+
+		timer0: timer at 40010000 {
+			compatible = "efm32,timer";
+			reg = <0x40010000 0x400>;
+			interrupts = <2>;
+			clocks = <&cmu clk_HFPERCLKTIMER0>;
+		};
+
+		timer1: timer at 40010400 {
+			compatible = "efm32,timer";
+			reg = <0x40010400 0x400>;
+			interrupts = <12>;
+			clocks = <&cmu clk_HFPERCLKTIMER1>;
+		};
+
+		timer2: timer at 40010800 {
+			compatible = "efm32,timer";
+			reg = <0x40010800 0x400>;
+			interrupts = <13>;
+			clocks = <&cmu clk_HFPERCLKTIMER2>;
+		};
+
+		timer3: timer at 40010c00 {
+			compatible = "efm32,timer";
+			reg = <0x40010c00 0x400>;
+			interrupts = <14>;
+			clocks = <&cmu clk_HFPERCLKTIMER3>;
+		};
+
+		cmu: cmu at 400c8000 {
+			compatible = "efm32gg,cmu";
+			reg = <0x400c8000 0x400>;
+			interrupts = <32>;
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
1.8.4.4
