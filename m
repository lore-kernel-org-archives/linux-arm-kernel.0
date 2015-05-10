From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 10 May 2015 12:16:21 +0530
Subject: [PATCH 4/6] ARM: dts: sunxi: add common sun8i dtsi
In-Reply-To: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1431240383-12763-5-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

added the common sun8i.dtsi and "allwinner,sun8i" compatible for common
sun8i features, I've referred the h3 dtsi by Jens Kuske.
accordingly modified the sun8i-a23.dtsi and a23 dts.

I don't have a23 device, however, dts got compiled.

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts |   6 +-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts   |   6 +-
 arch/arm/boot/dts/sun8i-a23.dtsi              | 432 +----------------------
 arch/arm/boot/dts/sun8i.dtsi                  | 481 ++++++++++++++++++++++++++
 4 files changed, 486 insertions(+), 439 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i.dtsi

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
index dd31c53..b3f19e7 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
@@ -16,10 +16,6 @@
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- *     You should have received a copy of the GNU General Public
- *     License along with this file; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
  *
  * Or, alternatively,
  *
@@ -55,5 +51,5 @@
 
 / {
 	model = "Ippo Q8H Dual Core Tablet (v1.2)";
-	compatible = "ippo,q8h-v1.2", "allwinner,sun8i-a23";
+	compatible = "ippo,q8h-v1.2", "allwinner,sun8i", "allwinner,sun8i-a23";
 };
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index f5658d1..5db4010 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -18,10 +18,6 @@
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- *     You should have received a copy of the GNU General Public
- *     License along with this file; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
  *
  * Or, alternatively,
  *
@@ -57,7 +53,7 @@
 
 / {
 	model = "Ippo Q8H Dual Core Tablet (v5)";
-	compatible = "ippo,q8h-v5", "allwinner,sun8i-a23";
+	compatible = "ippo,q8h-v5", "allwinner,sun8i", "allwinner,sun8i-a23";
 
 	aliases {
 		serial0 = &r_uart;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 6d6eda3..c17be9e 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -18,10 +18,6 @@
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- *     You should have received a copy of the GNU General Public
- *     License along with this file; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
  *
  * Or, alternatively,
  *
@@ -47,41 +43,11 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+#include "sun8i.dtsi"
 
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
 	cpus {
-		enable-method = "allwinner,sun8i-a23";
+		enable-method = "allwinner,sun8i";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -103,32 +69,6 @@
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
 		/* dummy clock until actually implemented */
 		pll5: pll5_clk {
 			#clock-cells = <0>;
@@ -137,29 +77,6 @@
 			clock-output-names = "pll5";
 		};
 
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
 		axi: axi_clk at 01c20050 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-axi-clk";
@@ -168,22 +85,6 @@
 			clock-output-names = "axi";
 		};
 
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
 		ahb1_gates: clk at 01c20060 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun8i-a23-ahb1-gates-clk";
@@ -228,36 +129,6 @@
 					"apb2_uart3", "apb2_uart4";
 		};
 
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
@@ -268,11 +139,6 @@
 	};
 
 	soc at 01c00000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun8i-a23-dma";
 			reg = <0x01c02000 0x1000>;
@@ -282,75 +148,12 @@
 			#dma-cells = <1>;
 		};
 
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
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun8i-a23-pinctrl";
-			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 5>;
-			gpio-controller;
-			interrupt-controller;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#gpio-cells = <3>;
+
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PF2", "PF4";
@@ -359,20 +162,6 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
-				allwinner,function = "mmc0";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			mmc1_pins_a: mmc1 at 0 {
-				allwinner,pins = "PG0","PG1","PG2","PG3","PG4","PG5";
-				allwinner,function = "mmc1";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PH2", "PH3";
 				allwinner,function = "i2c0";
@@ -395,38 +184,6 @@
 			};
 		};
 
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
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
@@ -434,58 +191,6 @@
 			status = "disabled";
 		};
 
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
 		uart4: serial at 01c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
@@ -498,136 +203,5 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
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
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i.dtsi b/arch/arm/boot/dts/sun8i.dtsi
new file mode 100644
index 0000000..cf481e5
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i.dtsi
@@ -0,0 +1,481 @@
+/*
+ * Copyright 2014 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "skeleton.dtsi"
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	interrupt-parent = <&gic>;
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer at 0 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0";
+			clocks = <&pll6 0>;
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <24000000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		osc24M: osc24M_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
+		};
+
+		osc32k: osc32k_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
+		};
+
+		pll1: clk at 01c20000 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun8i-a23-pll1-clk";
+			reg = <0x01c20000 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll1";
+		};
+
+		pll6: clk at 01c20028 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun6i-a31-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6", "pll6x2";
+		};
+
+		cpu: cpu_clk at 01c20050 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-cpu-clk";
+			reg = <0x01c20050 0x4>;
+
+			/*
+			 * PLL1 is listed twice here.
+			 * While it looks suspicious, it's actually documented
+			 * that way both in the datasheet and in the code from
+			 * Allwinner.
+			 */
+			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
+			clock-output-names = "cpu";
+		};
+
+
+		ahb1: ahb1_clk at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-ahb1-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
+			clock-output-names = "ahb1";
+		};
+
+		apb1: apb1_clk at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-apb0-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&ahb1>;
+			clock-output-names = "apb1";
+		};
+
+		mmc0_clk: clk at 01c20088 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6 0>;
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
+		};
+
+		mmc1_clk: clk at 01c2008c {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6 0>;
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
+		};
+
+		mmc2_clk: clk at 01c20090 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6 0>;
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
+		};
+
+	};
+
+	soc at 01c00000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb1_gates 8>,
+				 <&mmc0_clk 0>,
+				 <&mmc0_clk 1>,
+				 <&mmc0_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
+			resets = <&ahb1_rst 8>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb1_gates 9>,
+				 <&mmc1_clk 0>,
+				 <&mmc1_clk 1>,
+				 <&mmc1_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
+			resets = <&ahb1_rst 9>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb1_gates 10>,
+				 <&mmc2_clk 0>,
+				 <&mmc2_clk 1>,
+				 <&mmc2_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
+			resets = <&ahb1_rst 10>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		pio: pinctrl at 01c20800 {
+			reg = <0x01c20800 0x400>;
+			clocks = <&apb1_gates 5>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			mmc1_pins_a: mmc1 at 0 {
+				allwinner,pins = "PG0","PG1","PG2","PG3","PG4","PG5";
+				allwinner,function = "mmc1";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+		};
+
+		ahb1_rst: reset at 01c202c0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202c0 0xc>;
+		};
+
+		apb1_rst: reset at 01c202d0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d0 0x4>;
+		};
+
+		apb2_rst: reset at 01c202d8 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d8 0x4>;
+		};
+
+		timer at 01c20c00 {
+			compatible = "allwinner,sun4i-a10-timer";
+			reg = <0x01c20c00 0xa0>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
+		wdt0: watchdog at 01c20ca0 {
+			compatible = "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		uart0: serial at 01c28000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28000 0x400>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 16>;
+			resets = <&apb2_rst 16>;
+			dmas = <&dma 6>, <&dma 6>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart1: serial at 01c28400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28400 0x400>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 17>;
+			resets = <&apb2_rst 17>;
+			dmas = <&dma 7>, <&dma 7>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart2: serial at 01c28800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28800 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 18>;
+			resets = <&apb2_rst 18>;
+			dmas = <&dma 8>, <&dma 8>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart3: serial at 01c28c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28c00 0x400>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb2_gates 19>;
+			resets = <&apb2_rst 19>;
+			dmas = <&dma 9>, <&dma 9>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb2_gates 0>;
+			resets = <&apb2_rst 0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c at 01c2b000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb2_gates 1>;
+			resets = <&apb2_rst 1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c at 01c2b400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb2_gates 2>;
+			resets = <&apb2_rst 2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		gic: interrupt-controller at 01c81000 {
+			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
+			reg = <0x01c81000 0x1000>,
+			      <0x01c82000 0x1000>,
+			      <0x01c84000 0x2000>,
+			      <0x01c86000 0x2000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		rtc: rtc at 01f00000 {
+			compatible = "allwinner,sun6i-a31-rtc";
+			reg = <0x01f00000 0x54>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		prcm at 01f01400 {
+			compatible = "allwinner,sun8i-a23-prcm";
+			reg = <0x01f01400 0x200>;
+
+			ar100: ar100_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&osc24M>;
+				clock-output-names = "ar100";
+			};
+
+			ahb0: ahb0_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&ar100>;
+				clock-output-names = "ahb0";
+			};
+
+			apb0: apb0_clk {
+				compatible = "allwinner,sun8i-a23-apb0-clk";
+				#clock-cells = <0>;
+				clocks = <&ahb0>;
+				clock-output-names = "apb0";
+			};
+
+			apb0_gates: apb0_gates_clk {
+				compatible = "allwinner,sun8i-a23-apb0-gates-clk";
+				#clock-cells = <1>;
+				clocks = <&apb0>;
+				clock-output-names = "apb0_pio", "apb0_timer",
+						"apb0_rsb", "apb0_uart",
+						"apb0_i2c";
+			};
+
+			apb0_rst: apb0_rst {
+				compatible = "allwinner,sun6i-a31-clock-reset";
+				#reset-cells = <1>;
+			};
+		};
+
+		cpucfg at 01f01c00 {
+			compatible = "allwinner,sun8i-a23-cpuconfig";
+			reg = <0x01f01c00 0x300>;
+		};
+
+		r_uart: serial at 01f02800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01f02800 0x400>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&apb0_gates 4>;
+			resets = <&apb0_rst 4>;
+			status = "disabled";
+		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun8i-a23-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 0>;
+			resets = <&apb0_rst 0>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+
+			r_uart_pins_a: r_uart at 0 {
+				allwinner,pins = "PL2", "PL3";
+				allwinner,function = "s_uart";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+		};
+	};
+};
-- 
1.9.1
