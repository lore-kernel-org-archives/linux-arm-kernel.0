From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 13 Jan 2015 19:46:21 +0100
Subject: [PATCH v2 5/5] ARM: at91/dt: define a dumb irq demultiplexer chip
 connected on irq1
In-Reply-To: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1421174781-4340-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ is multiplexing several peripheral IRQs, but there's no way to
properly demultiplex those IRQs.
Use a dumb irq demux chip to achieve this demultiplexing operation.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index dd1313c..debe8d2 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -10,7 +10,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
-#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/atmel-aic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
 
@@ -89,6 +89,7 @@
 				atmel,external-irqs = <29 30 31>;
 			};
 
+
 			ramc0: ramc at ffffea00 {
 				compatible = "atmel,at91sam9260-sdramc";
 				reg = <0xffffea00 0x200>;
@@ -97,7 +98,7 @@
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9260-pmc";
 				reg = <0xfffffc00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&dumb_irq1_demux AIC_IRQ1_PMC>;
 				interrupt-controller;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -364,7 +365,7 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&dumb_irq1_demux AIC_IRQ1_PIT>;
 				clocks = <&mck>;
 			};
 
@@ -750,7 +751,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&dumb_irq1_demux AIC_IRQ1_DBGU>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&mck>;
@@ -959,7 +960,7 @@
 			rtc at fffffd20 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&dumb_irq1_demux AIC_IRQ1_RTT>;
 				clocks = <&clk32k>;
 				status = "disabled";
 			};
@@ -967,7 +968,7 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts-extended = <&dumb_irq1_demux AIC_IRQ1_WATCHDOG>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1010,6 +1011,19 @@
 		};
 	};
 
+	dumb_irq1_demux: dumb-irq-demux at 1 {
+		compatible = "irqchip-dumb-demux";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		irqs = <(AIC_IRQ_MASK(AIC_IRQ1_PMC) |
+			 AIC_IRQ_MASK(AIC_IRQ1_PIT) |
+			 AIC_IRQ_MASK(AIC_IRQ1_DBGU) |
+			 AIC_IRQ_MASK(AIC_IRQ1_RTT) |
+			 AIC_IRQ_MASK(AIC_IRQ1_WATCHDOG) |
+			 AIC_IRQ_MASK(AIC_IRQ1_RSTC))>;
+	};
+
 	i2c at 0 {
 		compatible = "i2c-gpio";
 		gpios = <&pioA 23 GPIO_ACTIVE_HIGH /* sda */
-- 
1.9.1
