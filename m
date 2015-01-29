From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 29 Jan 2015 11:33:40 +0100
Subject: [PATCH v4 5/5] ARM: at91/dt: define a virtual irq demultiplexer chip
 connected on irq1
In-Reply-To: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1422527620-8308-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ1 is multiplexing several peripheral IRQs, but there's no way to
properly demultiplex those IRQs.
Use a virtual irq demux chip to achieve this demultiplexing operation.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 20 +++++++++++++++++---
 arch/arm/boot/dts/at91sam9260.dtsi | 26 +++++++++++++++++++++-----
 arch/arm/boot/dts/at91sam9261.dtsi | 26 +++++++++++++++++++++-----
 arch/arm/boot/dts/at91sam9263.dtsi | 29 +++++++++++++++++++++++------
 arch/arm/boot/dts/at91sam9g45.dtsi | 29 +++++++++++++++++++++++------
 arch/arm/boot/dts/at91sam9n12.dtsi | 25 +++++++++++++++++++++----
 arch/arm/boot/dts/at91sam9rl.dtsi  | 29 +++++++++++++++++++++++------
 arch/arm/boot/dts/at91sam9x5.dtsi  | 26 +++++++++++++++++++++-----
 8 files changed, 170 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 6c97d4a..c5f673b 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -94,7 +94,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91rm9200-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -353,7 +353,7 @@
 			st: timer at fffffd00 {
 				compatible = "atmel,at91rm9200-st";
 				reg = <0xfffffd00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 			};
 
 			tcb0: timer at fffa0000 {
@@ -820,7 +820,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -944,4 +944,18 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: ST
+		 * 2: DBGU
+		 */
+		irqs = <0x7>;
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index dd1313c..bf7a6a2 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -97,7 +97,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9260-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -364,7 +364,7 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 				clocks = <&mck>;
 			};
 
@@ -750,7 +750,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -959,7 +959,7 @@
 			rtc at fffffd20 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 3>;
 				clocks = <&clk32k>;
 				status = "disabled";
 			};
@@ -967,7 +967,7 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 4>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1010,6 +1010,22 @@
 		};
 	};
 
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: PIT
+		 * 2: DBGU
+		 * 3: RTT
+		 * 4: WATCHDOG
+		 */
+		irqs = <0x1f>;
+	};
+
 	i2c at 0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 23 GPIO_ACTIVE_HIGH /* sda */
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index cdb9ed6..6eaa5f6 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -272,7 +272,7 @@
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -564,7 +564,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91rm9200-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -824,14 +824,14 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 				clocks = <&mck>;
 			};
 
 			rtc at fffffd20 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 3>;
 				clocks = <&slow_xtal>;
 				status = "disabled";
 			};
@@ -839,7 +839,7 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 4>;
 				status = "disabled";
 			};
 
@@ -864,4 +864,20 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: ST
+		 * 2: DBGU
+		 * 3: RTT
+		 * 4: WATCHDOG
+		 */
+		irqs = <0x1f>;
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index e8c6c60..70986b5 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -85,7 +85,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91rm9200-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -359,7 +359,7 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 				clocks = <&mck>;
 			};
 
@@ -744,7 +744,7 @@
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -870,7 +870,7 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 4>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -927,7 +927,7 @@
 			rtc at fffffd20 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 3>;
 				clocks = <&slow_xtal>;
 				status = "disabled";
 			};
@@ -935,7 +935,7 @@
 			rtc at fffffd50 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd50 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 5>;
 				clocks = <&slow_xtal>;
 				status = "disabled";
 			};
@@ -998,4 +998,21 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: PIT
+		 * 2: DBGU
+		 * 3: RTT1
+		 * 4: WATCHDOG
+		 * 5: RTT2
+		 */
+		irqs = <0x3f>;
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2a8da8a..487400d 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -111,7 +111,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9g45-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -387,7 +387,7 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 				clocks = <&mck>;
 			};
 
@@ -890,7 +890,7 @@
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -1107,7 +1107,7 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 4>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1234,7 +1234,7 @@
 			rtc at fffffd20 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 3>;
 				clocks = <&clk32k>;
 				status = "disabled";
 			};
@@ -1242,7 +1242,7 @@
 			rtc at fffffdb0 {
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffdb0 0x30>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 5>;
 				status = "disabled";
 			};
 
@@ -1316,4 +1316,21 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: PIT
+		 * 2: DBGU
+		 * 3: RTT
+		 * 4: WATCHDOG
+		 * 5: RTC
+		 */
+		irqs = <0x3f>;
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 68eb9ad..6067040 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -94,7 +94,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9n12-pmc";
 				reg = <0xfffffc00 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -376,7 +376,7 @@
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 				clocks = <&mck>;
 			};
 
@@ -754,7 +754,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -885,7 +885,8 @@
 			watchdog at fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 4>;
+				interrupts-extended = <&virt_irq1_demux 4>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -948,4 +949,20 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: PIT
+		 * 2: DBGU
+		 * 3: RTC
+		 * 4: WATCHDOG
+		 */
+		irqs = <0x1f>;
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 7242437..becd94a 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -374,7 +374,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -811,7 +811,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9g45-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1023,14 +1023,14 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 				clocks = <&mck>;
 			};
 
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 4>;
 				status = "disabled";
 			};
 
@@ -1063,14 +1063,14 @@
 			rtc at fffffeb0 {
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffeb0 0x40>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 5>;
 				status = "disabled";
 			};
 
 			rtc at fffffd20 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 3>;
 				clocks = <&clk32k>;
 				status = "disabled";
 			};
@@ -1110,4 +1110,21 @@
 		pinctrl-0 = <&pinctrl_i2c_gpio1>;
 		status = "disabled";
 	};
+
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: PIT
+		 * 2: DBGU
+		 * 3: RTT
+		 * 4: WATCHDOG
+		 * 5: RTC
+		 */
+		irqs = <0x3f>;
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index bbb3ba6..d4bc3cc 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -102,7 +102,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9x5-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 0>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -381,7 +381,7 @@
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 1>;
 				clocks = <&mck>;
 			};
 
@@ -857,7 +857,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(8)>,
@@ -1121,7 +1121,7 @@
 			watchdog at fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 4>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1132,7 +1132,7 @@
 			rtc at fffffeb0 {
 				compatible = "atmel,at91sam9x5-rtc";
 				reg = <0xfffffeb0 0x40>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&virt_irq1_demux 3>;
 				status = "disabled";
 			};
 
@@ -1231,4 +1231,20 @@
 		pinctrl-0 = <&pinctrl_i2c_gpio2>;
 		status = "disabled";
 	};
+
+	virt_irq1_demux: virt-irq-demux at 1 {
+		compatible = "virtual,irq-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		/*
+		 * Interrupt lines:
+		 * 0: PMC
+		 * 1: PIT
+		 * 2: DBGU
+		 * 3: RTC
+		 * 4: WATCHDOG
+		 */
+		irqs = <0x1f>;
+	};
 };
-- 
1.9.1
