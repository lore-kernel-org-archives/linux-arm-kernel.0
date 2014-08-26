From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 14:23:56 +0900
Subject: [PATCH 2/8] ARM: shmobile: r8a7740: add SoC clocks to DTS
In-Reply-To: <cover.1409030383.git.horms+renesas@verge.net.au>
References: <cover.1409030383.git.horms+renesas@verge.net.au>
Message-ID: <d9ffd583bf345e2ea79a8ab8044df3a979349af7.1409030383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Declares the r8a7740 clocks supported by the legacy clock framework,
excluding those requiring extensions to the DIV6 driver.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 180 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index bda18fb..3c61c5d 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -10,6 +10,7 @@
 
 /include/ "skeleton.dtsi"
 
+#include <dt-bindings/clock/r8a7740-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -291,4 +292,183 @@
 		interrupts = <0 9 0x4>;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* External root clock */
+		extalr_clk: extalr_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "extalr";
+		};
+		extal1_clk: extal1_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "extal1";
+		};
+		extal2_clk: extal2_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "extal2";
+		};
+		dv_clk: dv_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+			clock-output-names = "dv";
+		};
+		fsiack_clk: fsiack_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fsiack";
+		};
+		fsibck_clk: fsibck_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fsibck";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at e6150000 {
+			compatible = "renesas,r8a7740-cpg-clocks";
+			reg = <0xe6150000 0x10000>;
+			clocks = <&extal1_clk>, <&extalr_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "system", "pllc0", "pllc1",
+					     "pllc2", "r",
+					     "usb24s",
+					     "i", "zg", "b", "m1", "hp",
+					     "hpp", "usbp", "s", "zb", "m3",
+					     "cp";
+		};
+
+		/* Variable factor clocks (DIV6) */
+		sub_clk: sub_clk at e6150080 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150080 4>;
+			clocks = <&pllc1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sub";
+		};
+
+		/* Fixed factor clocks */
+		pllc1_div2_clk: pllc1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7740_CLK_PLLC1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pllc1_div2";
+		};
+		extal1_div2_clk: extal1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&extal1_clk>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "extal1_div2";
+		};
+
+		/* Gate clocks */
+		subck_clks: subck_clks at e6150080 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150080 4>;
+			clocks = <&sub_clk>, <&sub_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_SUBCK R8A7740_CLK_SUBCK2
+			>;
+			clock-output-names =
+				"subck", "subck2";
+		};
+		mstp1_clks: mstp1_clks at e6150134 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150134 4>, <0xe6150038 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_S>,
+				 <&cpg_clocks R8A7740_CLK_S>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_B>,
+				 <&sub_clk>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_B>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_CEU21 R8A7740_CLK_CEU20 R8A7740_CLK_TMU0
+				R8A7740_CLK_LCDC1 R8A7740_CLK_IIC0 R8A7740_CLK_TMU1
+				R8A7740_CLK_LCDC0
+			>;
+			clock-output-names =
+				"ceu21", "ceu20", "tmu0", "lcdc1", "iic0",
+				"tmu1", "lcdc0";
+		};
+		mstp2_clks: mstp2_clks at e6150138 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150138 4>, <0xe6150040 4>;
+			clocks = <&sub_clk>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>,
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>,
+				 <&sub_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_SCIFA6 R8A7740_CLK_SCIFA7
+				R8A7740_CLK_DMAC1 R8A7740_CLK_DMAC2
+				R8A7740_CLK_DMAC3 R8A7740_CLK_USBDMAC
+				R8A7740_CLK_SCIFA5 R8A7740_CLK_SCIFB
+				R8A7740_CLK_SCIFA0 R8A7740_CLK_SCIFA1
+				R8A7740_CLK_SCIFA2 R8A7740_CLK_SCIFA3
+				R8A7740_CLK_SCIFA4
+			>;
+			clock-output-names =
+				"scifa6", "scifa7", "dmac1", "dmac2", "dmac3",
+				"usbdmac", "scifa5", "scifb", "scifa0", "scifa1",
+				"scifa2", "scifa3", "scifa4";
+		};
+		mstp3_clks: mstp3_clks at e615013c {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe615013c 4>, <0xe6150048 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_R>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_CMT1 R8A7740_CLK_FSI R8A7740_CLK_IIC1
+				R8A7740_CLK_USBF R8A7740_CLK_SDHI0 R8A7740_CLK_SDHI1
+				R8A7740_CLK_MMC R8A7740_CLK_GETHER R8A7740_CLK_TPU0
+			>;
+			clock-output-names =
+				"cmt1", "fsi", "iic1", "usbf", "sdhi0", "sdhi1",
+				"mmc", "gether", "tpu0";
+		};
+		mstp4_clks: mstp4_clks at e6150140 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150140 4>, <0xe615004c 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_USBH R8A7740_CLK_SDHI2
+				R8A7740_CLK_USBFUNC R8A7740_CLK_USBPHY
+			>;
+			clock-output-names =
+				"usbhost", "sdhi2", "usbfunc", "usphy";
+		};
+	};
 };
-- 
2.0.1
