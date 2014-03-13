From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:47 +0900
Subject: [PATCH v4 04/19] ARM: shmobile: r8a7779: Add clocks
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare all core and MSTP clocks currently used by r8a7779-based boards.

Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v4
* As suggested by Geert Uytterhoeven
  - Wrap lines at < 80columns
  - Beef-up short lines towards 80 columns
* As suggested by Laurent Pinchart
  - Add HSCIF clocks
  - Correct many clock sources
  - Correct reg of cpg_clocks
* Add CPG clock "b" which is now part of the binding

v3
* As suggested by Laurent Pinchart
  - Add and use extal_clk
  - Fix bogus status register use for MSTP clocks
  - Fix bogus mstp3_cls to use its own entries rather than
    that of mstp1_clks

* Update to use "main" in cpg_clocks as per updated
  binding in previous patch
* Update for new, consolidated and renamed index macros
  - R8A7779_CLK_ETHER
  - R8A7779_CLK_HSCIF
  - R8A7779_CLK_HSPI
  - R8A7779_CLK_MMC0,1
  - R8A7779_CLK_PCIE
  - R8A7779_CLK_USB01,2
---
 arch/arm/boot/dts/r8a7779.dtsi | 151 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d0561d4..c0802aa 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -11,6 +11,7 @@
 
 /include/ "skeleton.dtsi"
 
+#include <dt-bindings/clock/r8a7779-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -278,4 +279,154 @@
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* External root clock */
+		extal_clk: extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overriden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "extal";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at 0xe6150000 {
+			compatible = "renesas,r8a7779-cpg-clocks";
+			reg = <0 0xffc80000 0 0x30>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "plla", "z", "zs", "s",
+					     "s1", "p", "b", "out";
+		};
+
+		/* Fixed factor clocks */
+		i_clk: i_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "i";
+		};
+		s3_clk: s3_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "s3";
+		};
+		s4_clk: s4_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <16>;
+			clock-mult = <1>;
+			clock-output-names = "s4";
+		};
+		g_clk: g_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+			clock-output-names = "g";
+		};
+
+		/* Gate clocks */
+		mstp0_clks: mstp0_clks {
+			compatible = "renesas,r8a7779-mstp-clocks",
+			             "renesas,cpg-mstp-clocks";
+			reg = <0 0xffc80030 0 4>;
+			clocks = <&cpg_clocks R8A7779_CLK_S>,
+			         <&cpg_clocks R8A7779_CLK_S>,
+			         <&cpg_clocks R8A7779_CLK_S>,
+			         <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_HSPI R8A7779_CLK_HSPI
+				R8A7779_CLK_HSPI R8A7779_CLK_TMU0
+				R8A7779_CLK_TMU0 R8A7779_CLK_TMU0
+				R8A7779_CLK_HSCIF0 R8A7779_CLK_HSCIF0
+				R8A7779_CLK_SCIF5 R8A7779_CLK_SCIF4
+				R8A7779_CLK_SCIF3 R8A7779_CLK_SCIF2
+				R8A7779_CLK_SCIF1 R8A7779_CLK_SCIF0
+				R8A7779_CLK_I2C3 R8A7779_CLK_I2C2
+				R8A7779_CLK_I2C1 R8A7779_CLK_I2C0
+			>;
+			clock-output-names =
+				"hspi0", "hspi1", "hspi2", "tmu0", "tmu1",
+				"tmu2", "hscif1", "hscif0", "scif5", "scif4",
+				"scif3", "scif2", "scif1", "scif0", "i2c3",
+				"i2c2", "i2c1", "i2c0";
+		};
+		mstp1_clks: mstp1_clks {
+			compatible = "renesas,r8a7779-mstp-clocks",
+			             "renesas,cpg-mstp-clocks";
+			reg = <0 0xffc80034 0 4>, <0 0xffc80044 0 4>;
+			clocks = <&cpg_clocks R8A7779_CLK_P>,
+			         <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_S>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_USB01 R8A7779_CLK_USB01
+				R8A7779_CLK_USB2 R8A7779_CLK_USB2
+				R8A7779_CLK_DU R8A7779_CLK_VIN2
+				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
+				R8A7779_CLK_ETHER R8A7779_CLK_SATA
+				R8A7779_CLK_PCIE R8A7779_CLK_VIN3
+			>;
+			clock-output-names =
+				"ehci0", "ohci0",
+				"ehci1", "ohci1",
+				"du", "vin2",
+				"vin1", "vin0",
+				"ether", "sata",
+				"pcie", "vin3";
+		};
+		mstp3_clks: mstp3_clks {
+			compatible = "renesas,r8a7779-mstp-clocks",
+			             "renesas,cpg-mstp-clocks";
+			reg = <0 0xffc8003c 0 4>;
+			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
+				 <&s4_clk>, <&s4_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_SDHI3 R8A7779_CLK_SDHI2
+				R8A7779_CLK_SDHI1 R8A7779_CLK_SDHI0
+				R8A7779_CLK_MMC1 R8A7779_CLK_MMC0
+			>;
+			clock-output-names =
+				"sdhi3", "sdhi2", "sdhi1", "sdhi0",
+				"mmc1", "mmc0";
+		};
+	};
 };
-- 
1.8.5.2
