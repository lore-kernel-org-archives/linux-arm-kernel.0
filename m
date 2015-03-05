From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:57:54 +0900
Subject: [PATCH 02/13] ARM: shmobile: r8a73a4: Common clock framework DT
 description
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <a76809a329d6ebae6cdf995670cc770304e265c0.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Declares all r8a73a4 clocks supported by the legacy clock framework.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 294 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 294 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 38136d9..a1adfe4 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -9,6 +9,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/clock/r8a73a4-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
@@ -377,4 +378,297 @@
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* External root clocks */
+		extalr_clk: extalr_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "extalr";
+		};
+		extal1_clk: extal1_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+			clock-output-names = "extal1";
+		};
+		extal2_clk: extal2_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+			clock-output-names = "extal2";
+		};
+		fsiack_clk: fsiack_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "fsiack";
+		};
+		fsibck_clk: fsibck_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "fsibck";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at e6150000 {
+			compatible = "renesas,r8a73a4-cpg-clocks";
+			reg = <0 0xe6150000 0 0x10000>;
+			clocks = <&extal1_clk>, <&extal2_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll0", "pll1", "pll2",
+					     "pll2s", "pll2h", "z", "z2",
+					     "i", "m3", "b", "m1", "m2",
+					     "zx", "zs", "hp";
+		};
+
+		/* Variable factor clocks (DIV6) */
+		zb_clk: zb_clk at e6150010 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150010 0 4>;
+			clocks = <&pll1_div2_clk>, <0>,
+				 <&cpg_clocks R8A73A4_CLK_PLL2S>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "zb";
+		};
+		sdhi0_clk: sdhi0_clk at e6150074 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150074 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sdhi0ck";
+		};
+		sdhi1_clk: sdhi1_clk at e6150078 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150078 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sdhi1ck";
+		};
+		sdhi2_clk: sdhi2_clk at e615007c {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615007c 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sdhi2ck";
+		};
+		mmc0_clk: mmc0_clk at e6150240 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150240 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc0";
+		};
+		mmc1_clk: mmc1_clk at e6150244 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150244 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc1";
+		};
+		vclk1_clk: vclk1_clk at e6150008 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150008 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk1";
+		};
+		vclk2_clk: vclk2_clk at e615000c {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615000c 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk2";
+		};
+		vclk3_clk: vclk3_clk at e615001c {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615001c 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk3";
+		};
+		vclk4_clk: vclk4_clk at e6150014 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150014 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk4";
+		};
+		vclk5_clk: vclk5_clk at e6150034 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150034 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <0>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk5";
+		};
+		fsia_clk: fsia_clk at e6150018 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150018 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <&fsiack_clk>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "fsia";
+		};
+		fsib_clk: fsib_clk at e6150090 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150090 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <&fsibck_clk>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "fsib";
+		};
+		mp_clk: mp_clk at e6150080 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150080 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <&extal2_clk>, <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mp";
+		};
+		m4_clk: m4_clk at e6150098 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150098 0 4>;
+			clocks = <&cpg_clocks R8A73A4_CLK_PLL2S>;
+			#clock-cells = <0>;
+			clock-output-names = "m4";
+		};
+		hsi_clk: hsi_clk at e615026c {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615026c 0 4>;
+			clocks = <&cpg_clocks R8A73A4_CLK_PLL2H>, <&pll1_div2_clk>,
+				 <&cpg_clocks R8A73A4_CLK_PLL2S>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "hsi";
+		};
+		spuv_clk: spuv_clk at e6150094 {
+			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150094 0 4>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+				 <&extal2_clk>, <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "spuv";
+		};
+
+		/* Fixed factor clocks */
+		main_div2_clk: main_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A73A4_CLK_MAIN>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "main_div2";
+		};
+		pll0_div2_clk: pll0_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A73A4_CLK_PLL0>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pll0_div2";
+		};
+		pll1_div2_clk: pll1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A73A4_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pll1_div2";
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
+		mstp2_clks: mstp2_clks at e6150138 {
+			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
+				 <&mp_clk>, <&mp_clk>, <&cpg_clocks R8A73A4_CLK_HP>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A73A4_CLK_SCIFA0 R8A73A4_CLK_SCIFA1
+				R8A73A4_CLK_SCIFB0 R8A73A4_CLK_SCIFB1
+				R8A73A4_CLK_SCIFB2 R8A73A4_CLK_SCIFB3
+				R8A73A4_CLK_DMAC
+			>;
+			clock-output-names =
+				"scifa0", "scifa1", "scifb0", "scifb1",
+				"scifb2", "scifb3", "dmac";
+		};
+		mstp3_clks: mstp3_clks at e615013c {
+			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+			clocks = <&cpg_clocks R8A73A4_CLK_HP>, <&mmc1_clk>,
+				 <&sdhi2_clk>, <&sdhi1_clk>, <&sdhi0_clk>,
+				 <&mmc0_clk>, <&cpg_clocks R8A73A4_CLK_HP>,
+				 <&cpg_clocks R8A73A4_CLK_HP>, <&cpg_clocks
+				 R8A73A4_CLK_HP>, <&cpg_clocks
+				 R8A73A4_CLK_HP>, <&extalr_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A73A4_CLK_IIC2 R8A73A4_CLK_MMCIF1
+				R8A73A4_CLK_SDHI2 R8A73A4_CLK_SDHI1
+				R8A73A4_CLK_SDHI0 R8A73A4_CLK_MMCIF0
+				R8A73A4_CLK_IIC6 R8A73A4_CLK_IIC7
+				R8A73A4_CLK_IIC0 R8A73A4_CLK_IIC1
+				R8A73A4_CLK_CMT1
+			>;
+			clock-output-names =
+				"iic2", "mmcif1", "sdhi2", "sdhi1", "sdhi0",
+				"mmcif0", "iic6", "iic7", "iic0", "iic1",
+				"cmt1";
+		};
+		mstp4_clks: mstp4_clks at e6150140 {
+			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&main_div2_clk>, <&cpg_clocks R8A73A4_CLK_HP>,
+				 <&cpg_clocks R8A73A4_CLK_HP>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A73A4_CLK_IIC5 R8A73A4_CLK_IIC4
+				R8A73A4_CLK_IIC3
+			>;
+			clock-output-names =
+				"iic5", "iic4", "iic3";
+		};
+		mstp5_clks: mstp5_clks at e6150144 {
+			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+			clocks = <&extal2_clk>, <&cpg_clocks R8A73A4_CLK_HP>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A73A4_CLK_THERMAL R8A73A4_CLK_IIC8
+			>;
+			clock-output-names =
+				"thermal", "iic8";
+		};
+	};
 };
-- 
2.1.4
