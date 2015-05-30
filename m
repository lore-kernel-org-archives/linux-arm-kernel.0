From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 30 May 2015 16:55:03 +0200
Subject: [PATCH v2 3/6] ARM: dts: sun8i: Add sun8i-a23-a33 dtsi
In-Reply-To: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1432997706-20172-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vishnu Patekar <vishnupatekar0510@gmail.com>

Rename sun8i-a23.dtsi to sun8i-a23-a33.dtsi as the base dtsi for the A33
is 99% the same and add a new sun8i-a23.dtsi including sun8i-a23-a33.dtsi
and setting the few things not shared with the A33 (mbus-clk, pio
compatible and interrupts).

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a sun8i-a23-a33.dtsi to share between a23 and a33, rather then a
 sun8i.dtsi to share between a23, a33 and h3, since the reset and clock
 bits of the h3 are different, meaning that we also need different clock
 and reset entries for all the peripheral blocks making sharing
 unpractical
---
 .../dts/{sun8i-a23.dtsi => sun8i-a23-a33.dtsi}     |  18 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                   | 576 +--------------------
 2 files changed, 9 insertions(+), 585 deletions(-)
 copy arch/arm/boot/dts/{sun8i-a23.dtsi => sun8i-a23-a33.dtsi} (97%)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
similarity index 97%
copy from arch/arm/boot/dts/sun8i-a23.dtsi
copy to arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7297f96..c73d1d1 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -93,10 +93,6 @@
 		};
 	};
 
-	memory {
-		reg = <0x40000000 0x40000000>;
-	};
-
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -252,14 +248,6 @@
 					     "mmc2_output",
 					     "mmc2_sample";
 		};
-
-		mbus_clk: clk at 01c2015c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-mbus-clk";
-			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
-			clock-output-names = "mbus";
-		};
 	};
 
 	soc at 01c00000 {
@@ -335,11 +323,9 @@
 		};
 
 		pio: pinctrl at 01c20800 {
-			compatible = "allwinner,sun8i-a23-pinctrl";
+			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c20800 0x400>;
-			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			/* interrupts get set in SoC specific dtsi file */
 			clocks = <&apb1_gates 5>;
 			gpio-controller;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 7297f96..8698f7a 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -42,217 +42,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+#include "sun8i-a23-a33.dtsi"
 
 / {
-	interrupt-parent = <&gic>;
-
-	chosen {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		framebuffer at 0 {
-			compatible = "allwinner,simple-framebuffer",
-				     "simple-framebuffer";
-			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll6 0>;
-			status = "disabled";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-		clock-frequency = <24000000>;
-		arm,cpu-registers-not-fw-configured;
-	};
-
-	cpus {
-		enable-method = "allwinner,sun8i-a23";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu at 0 {
-			compatible = "arm,cortex-a7";
-			device_type = "cpu";
-			reg = <0>;
-		};
-
-		cpu at 1 {
-			compatible = "arm,cortex-a7";
-			device_type = "cpu";
-			reg = <1>;
-		};
-	};
-
 	memory {
 		reg = <0x40000000 0x40000000>;
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		osc24M: osc24M_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-			clock-output-names = "osc24M";
-		};
-
-		osc32k: osc32k_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-			clock-output-names = "osc32k";
-		};
-
-		pll1: clk at 01c20000 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-pll1-clk";
-			reg = <0x01c20000 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll1";
-		};
-
-		/* dummy clock until actually implemented */
-		pll5: pll5_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-			clock-output-names = "pll5";
-		};
-
-		pll6: clk at 01c20028 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun6i-a31-pll6-clk";
-			reg = <0x01c20028 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll6", "pll6x2";
-		};
-
-		cpu: cpu_clk at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-cpu-clk";
-			reg = <0x01c20050 0x4>;
-
-			/*
-			 * PLL1 is listed twice here.
-			 * While it looks suspicious, it's actually documented
-			 * that way both in the datasheet and in the code from
-			 * Allwinner.
-			 */
-			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
-			clock-output-names = "cpu";
-		};
-
-		axi: axi_clk at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-axi-clk";
-			reg = <0x01c20050 0x4>;
-			clocks = <&cpu>;
-			clock-output-names = "axi";
-		};
-
-		ahb1: ahb1_clk at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-ahb1-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
-			clock-output-names = "ahb1";
-		};
-
-		apb1: apb1_clk at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb0-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&ahb1>;
-			clock-output-names = "apb1";
-		};
-
-		ahb1_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-a23-ahb1-gates-clk";
-			reg = <0x01c20060 0x8>;
-			clocks = <&ahb1>;
-			clock-output-names = "ahb1_mipidsi", "ahb1_dma",
-					"ahb1_mmc0", "ahb1_mmc1", "ahb1_mmc2",
-					"ahb1_nand", "ahb1_sdram",
-					"ahb1_hstimer", "ahb1_spi0",
-					"ahb1_spi1", "ahb1_otg", "ahb1_ehci",
-					"ahb1_ohci", "ahb1_ve", "ahb1_lcd",
-					"ahb1_csi", "ahb1_be",	"ahb1_fe",
-					"ahb1_gpu", "ahb1_spinlock",
-					"ahb1_drc";
-		};
-
-		apb1_gates: clk at 01c20068 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-a23-apb1-gates-clk";
-			reg = <0x01c20068 0x4>;
-			clocks = <&apb1>;
-			clock-output-names = "apb1_codec", "apb1_pio",
-					"apb1_daudio0",	"apb1_daudio1";
-		};
-
-		apb2: clk at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
-			clock-output-names = "apb2";
-		};
-
-		apb2_gates: clk at 01c2006c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-a23-apb2-gates-clk";
-			reg = <0x01c2006c 0x4>;
-			clocks = <&apb2>;
-			clock-output-names = "apb2_i2c0", "apb2_i2c1",
-					"apb2_i2c2", "apb2_uart0",
-					"apb2_uart1", "apb2_uart2",
-					"apb2_uart3", "apb2_uart4";
-		};
-
-		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc0",
-					     "mmc0_output",
-					     "mmc0_sample";
-		};
-
-		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc1",
-					     "mmc1_output",
-					     "mmc1_sample";
-		};
-
-		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc2",
-					     "mmc2_output",
-					     "mmc2_sample";
-		};
-
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
@@ -261,370 +58,11 @@
 			clock-output-names = "mbus";
 		};
 	};
+};
 
-	soc at 01c00000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		dma: dma-controller at 01c02000 {
-			compatible = "allwinner,sun8i-a23-dma";
-			reg = <0x01c02000 0x1000>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 6>;
-			resets = <&ahb1_rst 6>;
-			#dma-cells = <1>;
-		};
-
-		mmc0: mmc at 01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb1_gates 8>,
-				 <&mmc0_clk 0>,
-				 <&mmc0_clk 1>,
-				 <&mmc0_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			resets = <&ahb1_rst 8>;
-			reset-names = "ahb";
-			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc1: mmc at 01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb1_gates 9>,
-				 <&mmc1_clk 0>,
-				 <&mmc1_clk 1>,
-				 <&mmc1_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			resets = <&ahb1_rst 9>;
-			reset-names = "ahb";
-			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc2: mmc at 01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb1_gates 10>,
-				 <&mmc2_clk 0>,
-				 <&mmc2_clk 1>,
-				 <&mmc2_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			resets = <&ahb1_rst 10>;
-			reset-names = "ahb";
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		pio: pinctrl at 01c20800 {
-			compatible = "allwinner,sun8i-a23-pinctrl";
-			reg = <0x01c20800 0x400>;
-			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 5>;
-			gpio-controller;
-			interrupt-controller;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#gpio-cells = <3>;
-
-			uart0_pins_a: uart0 at 0 {
-				allwinner,pins = "PF2", "PF4";
-				allwinner,function = "uart0";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0", "PF1", "PF2",
-						 "PF3", "PF4", "PF5";
-				allwinner,function = "mmc0";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			mmc1_pins_a: mmc1 at 0 {
-				allwinner,pins = "PG0", "PG1", "PG2",
-						 "PG3", "PG4", "PG5";
-				allwinner,function = "mmc1";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			i2c0_pins_a: i2c0 at 0 {
-				allwinner,pins = "PH2", "PH3";
-				allwinner,function = "i2c0";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			i2c1_pins_a: i2c1 at 0 {
-				allwinner,pins = "PH4", "PH5";
-				allwinner,function = "i2c1";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			i2c2_pins_a: i2c2 at 0 {
-				allwinner,pins = "PE12", "PE13";
-				allwinner,function = "i2c2";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-
-		ahb1_rst: reset at 01c202c0 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x01c202c0 0xc>;
-		};
-
-		apb1_rst: reset at 01c202d0 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x01c202d0 0x4>;
-		};
-
-		apb2_rst: reset at 01c202d8 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x01c202d8 0x4>;
-		};
-
-		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-a10-timer";
-			reg = <0x01c20c00 0xa0>;
-			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc24M>;
-		};
-
-		wdt0: watchdog at 01c20ca0 {
-			compatible = "allwinner,sun6i-a31-wdt";
-			reg = <0x01c20ca0 0x20>;
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		lradc: lradc at 01c22800 {
-			compatible = "allwinner,sun4i-a10-lradc-keys";
-			reg = <0x01c22800 0x100>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		uart0: serial at 01c28000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28000 0x400>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb2_gates 16>;
-			resets = <&apb2_rst 16>;
-			dmas = <&dma 6>, <&dma 6>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		uart1: serial at 01c28400 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28400 0x400>;
-			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb2_gates 17>;
-			resets = <&apb2_rst 17>;
-			dmas = <&dma 7>, <&dma 7>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		uart2: serial at 01c28800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28800 0x400>;
-			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb2_gates 18>;
-			resets = <&apb2_rst 18>;
-			dmas = <&dma 8>, <&dma 8>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		uart3: serial at 01c28c00 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28c00 0x400>;
-			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb2_gates 19>;
-			resets = <&apb2_rst 19>;
-			dmas = <&dma 9>, <&dma 9>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		uart4: serial at 01c29000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c29000 0x400>;
-			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb2_gates 20>;
-			resets = <&apb2_rst 20>;
-			dmas = <&dma 10>, <&dma 10>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun6i-a31-i2c";
-			reg = <0x01c2ac00 0x400>;
-			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 0>;
-			resets = <&apb2_rst 0>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun6i-a31-i2c";
-			reg = <0x01c2b000 0x400>;
-			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 1>;
-			resets = <&apb2_rst 1>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun6i-a31-i2c";
-			reg = <0x01c2b400 0x400>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 2>;
-			resets = <&apb2_rst 2>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		gic: interrupt-controller at 01c81000 {
-			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
-			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
-			      <0x01c84000 0x2000>,
-			      <0x01c86000 0x2000>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
-		rtc: rtc at 01f00000 {
-			compatible = "allwinner,sun6i-a31-rtc";
-			reg = <0x01f00000 0x54>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		prcm at 01f01400 {
-			compatible = "allwinner,sun8i-a23-prcm";
-			reg = <0x01f01400 0x200>;
-
-			ar100: ar100_clk {
-				compatible = "fixed-factor-clock";
-				#clock-cells = <0>;
-				clock-div = <1>;
-				clock-mult = <1>;
-				clocks = <&osc24M>;
-				clock-output-names = "ar100";
-			};
-
-			ahb0: ahb0_clk {
-				compatible = "fixed-factor-clock";
-				#clock-cells = <0>;
-				clock-div = <1>;
-				clock-mult = <1>;
-				clocks = <&ar100>;
-				clock-output-names = "ahb0";
-			};
-
-			apb0: apb0_clk {
-				compatible = "allwinner,sun8i-a23-apb0-clk";
-				#clock-cells = <0>;
-				clocks = <&ahb0>;
-				clock-output-names = "apb0";
-			};
-
-			apb0_gates: apb0_gates_clk {
-				compatible = "allwinner,sun8i-a23-apb0-gates-clk";
-				#clock-cells = <1>;
-				clocks = <&apb0>;
-				clock-output-names = "apb0_pio", "apb0_timer",
-						"apb0_rsb", "apb0_uart",
-						"apb0_i2c";
-			};
-
-			apb0_rst: apb0_rst {
-				compatible = "allwinner,sun6i-a31-clock-reset";
-				#reset-cells = <1>;
-			};
-		};
-
-		cpucfg at 01f01c00 {
-			compatible = "allwinner,sun8i-a23-cpuconfig";
-			reg = <0x01f01c00 0x300>;
-		};
-
-		r_uart: serial at 01f02800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01f02800 0x400>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb0_gates 4>;
-			resets = <&apb0_rst 4>;
-			status = "disabled";
-		};
-
-		r_pio: pinctrl at 01f02c00 {
-			compatible = "allwinner,sun8i-a23-r-pinctrl";
-			reg = <0x01f02c00 0x400>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb0_gates 0>;
-			resets = <&apb0_rst 0>;
-			gpio-controller;
-			interrupt-controller;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#gpio-cells = <3>;
-
-			r_uart_pins_a: r_uart at 0 {
-				allwinner,pins = "PL2", "PL3";
-				allwinner,function = "s_uart";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-	};
+&pio {
+	compatible = "allwinner,sun8i-a23-pinctrl";
+	interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
2.4.1
