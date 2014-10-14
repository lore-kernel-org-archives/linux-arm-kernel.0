From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:15 +0200
Subject: [PATCH 8/8] ARM: realview: add MMCI to the PB1176 DTS
In-Reply-To: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
References: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1413291855-499-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the MMC/SD card reader (MMCI) block to the
RealView PB1176 DTS file. Add a special MCLK derived clock
and a fixed regulator to represent the 3.3V rail hardwired
to the MMC reader on the board.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index c292295ac1e3..ff26c7ed8c41 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -22,6 +22,7 @@
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 / {
@@ -43,6 +44,15 @@
 		reg = <0x00000000 0x08000000>;
 	};
 
+	/* The voltage to the MMC card is hardwired at 3.3V */
+	vmmc: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+        };
+
 	xtal24mhz: xtal24mhz at 24M {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -57,6 +67,14 @@
 		clocks = <&xtal24mhz>;
 	};
 
+	mclk: mclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
 	kmiclk: kmiclk at 24M {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -288,6 +306,24 @@
 		compatible = "simple-bus";
 		ranges;
 
+		fpga_mci: mmcsd at 10005000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x10005000 0x1000>;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>,
+					<0 2 IRQ_TYPE_LEVEL_HIGH>;
+			/* Due to frequent FIFO overruns, use just 500 kHz */
+			max-frequency = <500000>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			clocks = <&mclk>, <&pclk>;
+			clock-names = "mclk", "apb_pclk";
+			vmmc-supply = <&vmmc>;
+			cd-gpios = <&fpga_gpio1 0 GPIO_ACTIVE_LOW>;
+			wp-gpios = <&fpga_gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+
 		fpga_kmi0: kmi at 10006000 {
 			compatible = "arm,pl050", "arm,primecell";
 			reg = <0x10006000 0x1000>;
-- 
1.9.3
