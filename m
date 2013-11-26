From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:32:06 +0900
Subject: [PATCH RFC v2 04/17] ARM: shmobile: r8a7779: Add clocks
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385451139-29686-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare all core and MSTP clocks currently used by r8a7779-based boards.

Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts |   1 +
 arch/arm/boot/dts/r8a7779.dtsi       | 124 +++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index a7af2c2..ee3fb60 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r8a7779.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "marzen";
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index b2b418a..d524b3f 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -10,6 +10,7 @@
  */
 
 /include/ "skeleton.dtsi"
+#include <dt-bindings/clock/r8a7779-clock.h>
 
 #include <dt-bindings/interrupt-controller/irq.h>
 
@@ -248,4 +249,127 @@
 		cap-sdio-irq;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at 0xe6150000 {
+			compatible = "renesas,r8a7779-cpg-clocks";
+			reg = <0 0xe6150000 0 0x1000>;
+			#clock-cells = <1>;
+			clock-output-names = "plla", "z", "zs", "s", "s1",
+					     "p", "out";
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
+			compatible = "renesas,r8a7779-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xffc80030 0 4>, <0 0xffc80034 0 4>;
+			clocks = <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_HSPI0 R8A7779_CLK_HSPI1 R8A7779_CLK_HSPI2
+				R8A7779_CLK_TMU0 R8A7779_CLK_TMU1 R8A7779_CLK_TMU2
+				R8A7779_CLK_SCIF6 R8A7779_CLK_SCIF4 R8A7779_CLK_SCIF3
+				R8A7779_CLK_SCIF2 R8A7779_CLK_SCIF1 R8A7779_CLK_SCIF0
+				R8A7779_CLK_I2C3 R8A7779_CLK_I2C2 R8A7779_CLK_I2C1
+				R8A7779_CLK_I2C0
+			>;
+			clock-output-names =
+				"hspi0", "hspi1", "hspi2",
+				"tmu0", "tmu1", "tmu2",
+				"scif6", "scif4", "scif3",
+				"scif2", "scif1", "scif0",
+				"i2c3", "i2c2", "i2c1",
+				"i2c0";
+		};
+		mstp1_clks: mstp1_clks {
+			compatible = "renesas,r8a7779-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xffc80034 0 4>, <0 0xffc80038 0 4>;
+			clocks = <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_EHCI0 R8A7779_CLK_OHCI0
+				R8A7779_CLK_EHCI1 R8A7779_CLK_OHCI1
+				R8A7779_CLK_DU R8A7779_CLK_VIN2
+				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
+				R8A7779_CLK_SATA R8A7779_CLK_VIN3
+			>;
+			clock-output-names =
+				"ehci0", "ohci0",
+				"ehci1", "ohci1",
+				"du", "vin2",
+				"vin1", "vin0",
+				"sata", "vin3";
+		};
+		mstp3_clks: mstp3_clks {
+			compatible = "renesas,r8a7779-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xffc8003c 0 4>, <0 0xffc80040 0 4>;
+			clocks = <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_EHCI0 R8A7779_CLK_OHCI0
+				R8A7779_CLK_EHCI1 R8A7779_CLK_OHCI1
+				R8A7779_CLK_DU R8A7779_CLK_VIN2
+				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
+				R8A7779_CLK_SATA R8A7779_CLK_VIN3
+			>;
+			clock-output-names =
+				"ehci0", "ohci0",
+				"ehci1", "ohci1",
+				"du", "vin2",
+				"vin1", "vin0",
+				"sata", "vin3";
+		};
+	};
 };
-- 
1.8.4
