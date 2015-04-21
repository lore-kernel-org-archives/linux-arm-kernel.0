From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:49 -0700
Subject: [PATCH 2/9] ARM: BCM2835: Split peripheral definitions off to a
 common include.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2836 dts will inherit all of this, because it shares the same
peripherals as 2835.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835.dtsi        | 155 +--------------------------------
 arch/arm/boot/dts/bcm283x-common.dtsi | 159 ++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 154 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-common.dtsi

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 4d4c129..bdf9993 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
 #include "skeleton.dtsi"
+#include "bcm283x-common.dtsi"
 
 / {
 	compatible = "brcm,bcm2835";
@@ -23,162 +24,8 @@
 			clock-frequency = <1000000>;
 		};
 
-		dma: dma at 7e007000 {
-			compatible = "brcm,bcm2835-dma";
-			reg = <0x7e007000 0xf00>;
-			interrupts = <1 16>,
-				     <1 17>,
-				     <1 18>,
-				     <1 19>,
-				     <1 20>,
-				     <1 21>,
-				     <1 22>,
-				     <1 23>,
-				     <1 24>,
-				     <1 25>,
-				     <1 26>,
-				     <1 27>,
-				     <1 28>;
-
-			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x7f35>;
-		};
-
-		intc: interrupt-controller at 7e00b200 {
-			compatible = "brcm,bcm2835-armctrl-ic";
-			reg = <0x7e00b200 0x200>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		watchdog at 7e100000 {
-			compatible = "brcm,bcm2835-pm-wdt";
-			reg = <0x7e100000 0x28>;
-		};
-
-		rng at 7e104000 {
-			compatible = "brcm,bcm2835-rng";
-			reg = <0x7e104000 0x10>;
-		};
-
-		gpio: gpio at 7e200000 {
-			compatible = "brcm,bcm2835-gpio";
-			reg = <0x7e200000 0xb4>;
-			/*
-			 * The GPIO IP block is designed for 3 banks of GPIOs.
-			 * Each bank has a GPIO interrupt for itself.
-			 * There is an overall "any bank" interrupt.
-			 * In order, these are GIC interrupts 17, 18, 19, 20.
-			 * Since the BCM2835 only has 2 banks, the 2nd bank
-			 * interrupt output appears to be mirrored onto the
-			 * 3rd bank's interrupt signal.
-			 * So, a bank0 interrupt shows up on 17, 20, and
-			 * a bank1 interrupt shows up on 18, 19, 20!
-			 */
-			interrupts = <2 17>, <2 18>, <2 19>, <2 20>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		uart at 7e201000 {
-			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
-			reg = <0x7e201000 0x1000>;
-			interrupts = <2 25>;
-			clock-frequency = <3000000>;
-			arm,primecell-periphid = <0x00241011>;
-		};
-
-		i2s: i2s at 7e203000 {
-			compatible = "brcm,bcm2835-i2s";
-			reg = <0x7e203000 0x20>,
-			      <0x7e101098 0x02>;
-
-			dmas = <&dma 2>,
-			       <&dma 3>;
-			dma-names = "tx", "rx";
-			status = "disabled";
-		};
-
-		spi: spi at 7e204000 {
-			compatible = "brcm,bcm2835-spi";
-			reg = <0x7e204000 0x1000>;
-			interrupts = <2 22>;
-			clocks = <&clk_spi>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c0: i2c at 7e205000 {
-			compatible = "brcm,bcm2835-i2c";
-			reg = <0x7e205000 0x1000>;
-			interrupts = <2 21>;
-			clocks = <&clk_i2c>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		sdhci: sdhci at 7e300000 {
-			compatible = "brcm,bcm2835-sdhci";
-			reg = <0x7e300000 0x100>;
-			interrupts = <2 30>;
-			clocks = <&clk_mmc>;
-			status = "disabled";
-		};
-
-		i2c1: i2c at 7e804000 {
-			compatible = "brcm,bcm2835-i2c";
-			reg = <0x7e804000 0x1000>;
-			interrupts = <2 21>;
-			clocks = <&clk_i2c>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		usb at 7e980000 {
-			compatible = "brcm,bcm2835-usb";
-			reg = <0x7e980000 0x10000>;
-			interrupts = <1 9>;
-		};
-
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
 	};
-
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk_mmc: clock at 0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-output-names = "mmc";
-			clock-frequency = <100000000>;
-		};
-
-		clk_i2c: clock at 1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			#clock-cells = <0>;
-			clock-output-names = "i2c";
-			clock-frequency = <250000000>;
-		};
-
-		clk_spi: clock at 2 {
-			compatible = "fixed-clock";
-			reg = <2>;
-			#clock-cells = <0>;
-			clock-output-names = "spi";
-			clock-frequency = <250000000>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/bcm283x-common.dtsi b/arch/arm/boot/dts/bcm283x-common.dtsi
new file mode 100644
index 0000000..c15e309
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-common.dtsi
@@ -0,0 +1,159 @@
+/include/ "skeleton.dtsi"
+
+/ {
+	soc {
+		dma: dma at 7e007000 {
+			compatible = "brcm,bcm2835-dma";
+			reg = <0x7e007000 0xf00>;
+			interrupts = <1 16>,
+				     <1 17>,
+				     <1 18>,
+				     <1 19>,
+				     <1 20>,
+				     <1 21>,
+				     <1 22>,
+				     <1 23>,
+				     <1 24>,
+				     <1 25>,
+				     <1 26>,
+				     <1 27>,
+				     <1 28>;
+
+			#dma-cells = <1>;
+			brcm,dma-channel-mask = <0x7f35>;
+		};
+
+		intc: interrupt-controller at 7e00b200 {
+			compatible = "brcm,bcm2835-armctrl-ic";
+			reg = <0x7e00b200 0x200>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		watchdog at 7e100000 {
+			compatible = "brcm,bcm2835-pm-wdt";
+			reg = <0x7e100000 0x28>;
+		};
+
+		rng at 7e104000 {
+			compatible = "brcm,bcm2835-rng";
+			reg = <0x7e104000 0x10>;
+		};
+
+		gpio: gpio at 7e200000 {
+			compatible = "brcm,bcm2835-gpio";
+			reg = <0x7e200000 0xb4>;
+			/*
+			 * The GPIO IP block is designed for 3 banks of GPIOs.
+			 * Each bank has a GPIO interrupt for itself.
+			 * There is an overall "any bank" interrupt.
+			 * In order, these are GIC interrupts 17, 18, 19, 20.
+			 * Since the BCM2835 only has 2 banks, the 2nd bank
+			 * interrupt output appears to be mirrored onto the
+			 * 3rd bank's interrupt signal.
+			 * So, a bank0 interrupt shows up on 17, 20, and
+			 * a bank1 interrupt shows up on 18, 19, 20!
+			 */
+			interrupts = <2 17>, <2 18>, <2 19>, <2 20>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		uart at 7e201000 {
+			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
+			reg = <0x7e201000 0x1000>;
+			interrupts = <2 25>;
+			clock-frequency = <3000000>;
+			arm,primecell-periphid = <0x00241011>;
+		};
+
+		i2s: i2s at 7e203000 {
+			compatible = "brcm,bcm2835-i2s";
+			reg = <0x7e203000 0x20>,
+			      <0x7e101098 0x02>;
+
+			dmas = <&dma 2>,
+			       <&dma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi: spi at 7e204000 {
+			compatible = "brcm,bcm2835-spi";
+			reg = <0x7e204000 0x1000>;
+			interrupts = <2 22>;
+			clocks = <&clk_spi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c0: i2c at 7e205000 {
+			compatible = "brcm,bcm2835-i2c";
+			reg = <0x7e205000 0x1000>;
+			interrupts = <2 21>;
+			clocks = <&clk_i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		sdhci: sdhci at 7e300000 {
+			compatible = "brcm,bcm2835-sdhci";
+			reg = <0x7e300000 0x100>;
+			interrupts = <2 30>;
+			clocks = <&clk_mmc>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 7e804000 {
+			compatible = "brcm,bcm2835-i2c";
+			reg = <0x7e804000 0x1000>;
+			interrupts = <2 21>;
+			clocks = <&clk_i2c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		usb at 7e980000 {
+			compatible = "brcm,bcm2835-usb";
+			reg = <0x7e980000 0x10000>;
+			interrupts = <1 9>;
+		};
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk_mmc: clock at 0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc";
+			clock-frequency = <100000000>;
+		};
+
+		clk_i2c: clock at 1 {
+			compatible = "fixed-clock";
+			reg = <1>;
+			#clock-cells = <0>;
+			clock-output-names = "i2c";
+			clock-frequency = <250000000>;
+		};
+
+		clk_spi: clock at 2 {
+			compatible = "fixed-clock";
+			reg = <2>;
+			#clock-cells = <0>;
+			clock-output-names = "spi";
+			clock-frequency = <250000000>;
+		};
+	};
+};
-- 
2.1.4
