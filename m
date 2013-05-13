From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 13 May 2013 14:07:03 +0300
Subject: [PATCH 4/6] ARM: tegra30: convert device tree files to use CLK defines
In-Reply-To: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
References: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1368443225-16978-5-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace magic number in tegra_car:

-               clocks = <&tegra_car 28>;
+               clocks = <&tegra_car CLK_HOST1X>;

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts  |   4 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi |   4 +-
 arch/arm/boot/dts/tegra30.dtsi        | 110 +++++++++++++++++++---------------
 3 files changed, 69 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 9f4b684..5f6dcff 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -413,7 +413,9 @@
 
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 
-		clocks = <&tegra_car 184>, <&tegra_car 185>, <&tegra_car 120>;
+		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+		       	 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA30_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 85f26ba..fc3ffd8 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -534,7 +534,9 @@
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2)
 			GPIO_ACTIVE_HIGH>;
 
-		clocks = <&tegra_car 184>, <&tegra_car 185>, <&tegra_car 120>;
+		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+		       	 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA30_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 329465a..fe1904e 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clk/tegra30-car.h>
 
 #include "skeleton.dtsi"
 
@@ -20,7 +21,7 @@
 		reg = <0x50000000 0x00024000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
-		clocks = <&tegra_car 28>;
+		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -31,35 +32,35 @@
 			compatible = "nvidia,tegra30-mpe";
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 60>;
+			clocks = <&tegra_car TEGRA30_CLK_MPE>;
 		};
 
 		vi {
 			compatible = "nvidia,tegra30-vi";
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 164>;
+			clocks = <&tegra_car TEGRA30_CLK_VI>;
 		};
 
 		epp {
 			compatible = "nvidia,tegra30-epp";
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 19>;
+			clocks = <&tegra_car TEGRA30_CLK_EPP>;
 		};
 
 		isp {
 			compatible = "nvidia,tegra30-isp";
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 23>;
+			clocks = <&tegra_car TEGRA30_CLK_ISP>;
 		};
 
 		gr2d {
 			compatible = "nvidia,tegra30-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 21>;
+			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
 		};
 
 		gr3d {
@@ -73,7 +74,8 @@
 			compatible = "nvidia,tegra30-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 27>, <&tegra_car 179>;
+			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
+			       	 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
 
 			rgb {
@@ -85,7 +87,8 @@
 			compatible = "nvidia,tegra30-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 26>, <&tegra_car 179>;
+			clocks = <&tegra_car TEGRA30_CLK_DISP2>,
+			       	 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
 
 			rgb {
@@ -97,7 +100,8 @@
 			compatible = "nvidia,tegra30-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 51>, <&tegra_car 189>;
+			clocks = <&tegra_car TEGRA30_CLK_HDMI>,
+			       	 <&tegra_car TEGRA30_CLK_PLL_D2_OUT0>;
 			clock-names = "hdmi", "parent";
 			status = "disabled";
 		};
@@ -106,14 +110,14 @@
 			compatible = "nvidia,tegra30-tvo";
 			reg = <0x542c0000 0x00040000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&tegra_car 169>;
+			clocks = <&tegra_car TEGRA30_CLK_TVO>;
 			status = "disabled";
 		};
 
 		dsi {
 			compatible = "nvidia,tegra30-dsi";
 			reg = <0x54300000 0x00040000>;
-			clocks = <&tegra_car 48>;
+			clocks = <&tegra_car TEGRA30_CLK_DSIA>;
 			status = "disabled";
 		};
 	};
@@ -123,7 +127,7 @@
 		reg = <0x50040600 0x20>;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		clocks = <&tegra_car 214>;
+		clocks = <&tegra_car TEGRA30_CLK_TWD>;
 	};
 
 	intc: interrupt-controller {
@@ -152,7 +156,7 @@
 			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 5>;
+		clocks = <&tegra_car TEGRA30_CLK_TIMER>;
 	};
 
 	tegra_car: clock {
@@ -196,7 +200,7 @@
 			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 34>;
+		clocks = <&tegra_car TEGRA30_CLK_APBDMA>;
 	};
 
 	ahb: ahb {
@@ -241,7 +245,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
-		clocks = <&tegra_car 6>;
+		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
 		status = "disabled";
 	};
 
@@ -251,7 +255,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
-		clocks = <&tegra_car 160>;
+		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
 		status = "disabled";
 	};
 
@@ -261,7 +265,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
-		clocks = <&tegra_car 55>;
+		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
 		status = "disabled";
 	};
 
@@ -271,7 +275,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
-		clocks = <&tegra_car 65>;
+		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
 		status = "disabled";
 	};
 
@@ -281,7 +285,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 20>;
-		clocks = <&tegra_car 66>;
+		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
 		status = "disabled";
 	};
 
@@ -289,7 +293,7 @@
 		compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
-		clocks = <&tegra_car 17>;
+		clocks = <&tegra_car TEGRA30_CLK_PWM>;
 		status = "disabled";
 	};
 
@@ -297,7 +301,7 @@
 		compatible = "nvidia,tegra30-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 4>;
+		clocks = <&tegra_car TEGRA30_CLK_RTC>;
 	};
 
 	i2c at 7000c000 {
@@ -306,7 +310,8 @@
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 12>, <&tegra_car 182>;
+		clocks = <&tegra_car TEGRA30_CLK_I2C1>,
+		       	 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
 		status = "disabled";
 	};
@@ -317,7 +322,8 @@
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 54>, <&tegra_car 182>;
+		clocks = <&tegra_car TEGRA30_CLK_I2C2>,
+		       	 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
 		status = "disabled";
 	};
@@ -328,7 +334,8 @@
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 67>, <&tegra_car 182>;
+		clocks = <&tegra_car TEGRA30_CLK_I2C3>,
+		       	 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
 		status = "disabled";
 	};
@@ -339,7 +346,8 @@
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 103>, <&tegra_car 182>;
+		clocks = <&tegra_car TEGRA30_CLK_I2C4>,
+		       	 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
 		status = "disabled";
 	};
@@ -350,7 +358,8 @@
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 47>, <&tegra_car 182>;
+		clocks = <&tegra_car TEGRA30_CLK_I2C5>,
+		       	 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
 		status = "disabled";
 	};
@@ -362,7 +371,7 @@
 		nvidia,dma-request-selector = <&apbdma 15>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 41>;
+		clocks = <&tegra_car TEGRA30_CLK_SBC1>;
 		status = "disabled";
 	};
 
@@ -373,7 +382,7 @@
 		nvidia,dma-request-selector = <&apbdma 16>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 44>;
+		clocks = <&tegra_car TEGRA30_CLK_SBC2>;
 		status = "disabled";
 	};
 
@@ -384,7 +393,7 @@
 		nvidia,dma-request-selector = <&apbdma 17>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 46>;
+		clocks = <&tegra_car TEGRA30_CLK_SBC3>;
 		status = "disabled";
 	};
 
@@ -395,7 +404,7 @@
 		nvidia,dma-request-selector = <&apbdma 18>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 68>;
+		clocks = <&tegra_car TEGRA30_CLK_SBC4>;
 		status = "disabled";
 	};
 
@@ -406,7 +415,7 @@
 		nvidia,dma-request-selector = <&apbdma 27>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 104>;
+		clocks = <&tegra_car TEGRA30_CLK_SBC5>;
 		status = "disabled";
 	};
 
@@ -417,7 +426,7 @@
 		nvidia,dma-request-selector = <&apbdma 28>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car 105>;
+		clocks = <&tegra_car TEGRA30_CLK_SBC6>;
 		status = "disabled";
 	};
 
@@ -425,14 +434,14 @@
 		compatible = "nvidia,tegra30-kbc", "nvidia,tegra20-kbc";
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 36>;
+		clocks = <&tegra_car TEGRA30_CLK_KBC>;
 		status = "disabled";
 	};
 
 	pmc {
 		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
-		clocks = <&tegra_car 218>, <&clk32k_in>;
+		clocks = <&tegra_car TEGRA30_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
 	};
 
@@ -461,10 +470,17 @@
 		       0x70080200 0x100>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 1>;
-		clocks = <&tegra_car 106>, <&tegra_car 107>, <&tegra_car 30>,
-			 <&tegra_car 11>, <&tegra_car 18>, <&tegra_car 101>,
-			 <&tegra_car 102>, <&tegra_car 108>, <&tegra_car 109>,
-			 <&tegra_car 110>, <&tegra_car 162>;
+		clocks = <&tegra_car TEGRA30_CLK_D_AUDIO>,
+		       	 <&tegra_car TEGRA30_CLK_APBIF>,
+			 <&tegra_car TEGRA30_CLK_I2S0>,
+			 <&tegra_car TEGRA30_CLK_I2S1>,
+			 <&tegra_car TEGRA30_CLK_I2S2>,
+			 <&tegra_car TEGRA30_CLK_I2S3>,
+			 <&tegra_car TEGRA30_CLK_I2S4>,
+			 <&tegra_car TEGRA30_CLK_DAM0>,
+			 <&tegra_car TEGRA30_CLK_DAM1>,
+			 <&tegra_car TEGRA30_CLK_DAM2>,
+			 <&tegra_car TEGRA30_CLK_SPDIF_IN>;
 		clock-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
 			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
 			      "spdif_in";
@@ -476,7 +492,7 @@
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080300 0x100>;
 			nvidia,ahub-cif-ids = <4 4>;
-			clocks = <&tegra_car 30>;
+			clocks = <&tegra_car TEGRA30_CLK_I2S0>;
 			status = "disabled";
 		};
 
@@ -484,7 +500,7 @@
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080400 0x100>;
 			nvidia,ahub-cif-ids = <5 5>;
-			clocks = <&tegra_car 11>;
+			clocks = <&tegra_car TEGRA30_CLK_I2S1>;
 			status = "disabled";
 		};
 
@@ -492,7 +508,7 @@
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080500 0x100>;
 			nvidia,ahub-cif-ids = <6 6>;
-			clocks = <&tegra_car 18>;
+			clocks = <&tegra_car TEGRA30_CLK_I2S2>;
 			status = "disabled";
 		};
 
@@ -500,7 +516,7 @@
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080600 0x100>;
 			nvidia,ahub-cif-ids = <7 7>;
-			clocks = <&tegra_car 101>;
+			clocks = <&tegra_car TEGRA30_CLK_I2S3>;
 			status = "disabled";
 		};
 
@@ -508,7 +524,7 @@
 			compatible = "nvidia,tegra30-i2s";
 			reg = <0x70080700 0x100>;
 			nvidia,ahub-cif-ids = <8 8>;
-			clocks = <&tegra_car 102>;
+			clocks = <&tegra_car TEGRA30_CLK_I2S4>;
 			status = "disabled";
 		};
 	};
@@ -517,7 +533,7 @@
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 14>;
+		clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
 		status = "disabled";
 	};
 
@@ -525,7 +541,7 @@
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 9>;
+		clocks = <&tegra_car TEGRA30_CLK_SDMMC2>;
 		status = "disabled";
 	};
 
@@ -533,7 +549,7 @@
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 69>;
+		clocks = <&tegra_car TEGRA30_CLK_SDMMC3>;
 		status = "disabled";
 	};
 
@@ -541,7 +557,7 @@
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 15>;
+		clocks = <&tegra_car TEGRA30_CLK_SDMMC4>;
 		status = "disabled";
 	};
 
-- 
1.8.1.5
