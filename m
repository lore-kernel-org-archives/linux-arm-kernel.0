From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:56 +0900
Subject: [PATCH 3/6] ARM: shmobile: sh73a0: Common clock framework DT
 description
In-Reply-To: <cover.1419809955.git.horms+renesas@verge.net.au>
References: <cover.1419809955.git.horms+renesas@verge.net.au>
Message-ID: <00df611376e5cd84ae836d04608766096e4702e6.1419809955.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Declares all sh73a0 clocks supported by the legacy clock framework.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 329 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 329 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index d8def5a..3f21b32 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -10,6 +10,7 @@
 
 /include/ "skeleton.dtsi"
 
+#include <dt-bindings/clock/sh73a0-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -322,4 +323,332 @@
 		interrupts = <0 146 0x4>;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
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
+			clock-frequency = <26000000>;
+			clock-output-names = "extal1";
+		};
+		extal2_clk: extal2_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "extal2";
+		};
+		extcki_clk: extcki_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "extcki";
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
+			compatible = "renesas,sh73a0-cpg-clocks";
+			reg = <0xe6150000 0x10000>;
+			clocks = <&extal1_clk>, <&extal2_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll0", "pll1", "pll2",
+					     "pll3", "dsi0phy", "dsi1phy",
+					     "zg", "m3", "b", "m1", "m2",
+					     "z", "zx", "hp";
+		};
+
+		/* Variable factor clocks (DIV6) */
+		vclk1_clk: vclk1_clk at e6150008 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150008 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk1";
+		};
+		vclk2_clk: vclk2_clk at e615000c {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615000c 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk2";
+		};
+		vclk3_clk: vclk3_clk at e615001c {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615001c 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk3";
+		};
+		zb_clk: zb_clk at e6150010 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150010 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "zb";
+		};
+		flctl_clk: flctl_clk at e6150014 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150014 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "flctlck";
+		};
+		sdhi0_clk: sdhi0_clk at e6150074 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150074 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sdhi0ck";
+		};
+		sdhi1_clk: sdhi1_clk at e6150078 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150078 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sdhi1ck";
+		};
+		sdhi2_clk: sdhi2_clk at e615007c {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615007c 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sdhi2ck";
+		};
+		fsia_clk: fsia_clk at e6150018 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150018 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "fsia";
+		};
+		fsib_clk: fsib_clk at e6150090 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150090 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "fsib";
+		};
+		sub_clk: sub_clk at e6150080 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150080 4>;
+			clocks = <&extal2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sub";
+		};
+		spua_clk: spua_clk at e6150084 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150084 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "spua";
+		};
+		spuv_clk: spuv_clk at e6150094 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150094 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "spuv";
+		};
+		msu_clk: msu_clk at e6150088 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150088 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "msu";
+		};
+		hsi_clk: hsi_clk at e615008c {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615008c 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "hsi";
+		};
+		mfg1_clk: mfg1_clk at e6150098 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150098 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mfg1";
+		};
+		mfg2_clk: mfg2_clk at e615009c {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615009c 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mfg2";
+		};
+		dsit_clk: dsit_clk at e6150060 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150060 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "dsit";
+		};
+		dsi0p_clk: dsi0p_clk at e6150064 {
+			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150064 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "dsi0pck";
+		};
+
+		/* Fixed factor clocks */
+		main_div2_clk: main_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks SH73A0_CLK_MAIN>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "main_div2";
+		};
+		pll1_div2_clk: pll1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks SH73A0_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pll1_div2";
+		};
+		pll1_div7_clk: pll1_div7_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks SH73A0_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <7>;
+			clock-mult = <1>;
+			clock-output-names = "pll1_div7";
+		};
+		pll1_div13_clk: pll1_div13_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks SH73A0_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <13>;
+			clock-mult = <1>;
+			clock-output-names = "pll1_div13";
+		};
+		twd_clk: twd_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks SH73A0_CLK_Z>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "twd";
+		};
+
+		/* Gate clocks */
+		mstp0_clks: mstp0_clks at e6150130 {
+			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150130 4>, <0xe6150030 4>;
+			clocks = <&cpg_clocks SH73A0_CLK_HP>;
+			#clock-cells = <1>;
+			clock-indices = <
+				SH73A0_CLK_IIC2
+			>;
+			clock-output-names =
+				"iic2";
+		};
+		mstp1_clks: mstp1_clks at e6150134 {
+			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150134 4>, <0xe6150038 4>;
+			clocks = <&cpg_clocks SH73A0_CLK_B>,
+				 <&cpg_clocks SH73A0_CLK_B>,
+				 <&cpg_clocks SH73A0_CLK_B>,
+				 <&cpg_clocks SH73A0_CLK_B>,
+				 <&sub_clk>, <&cpg_clocks SH73A0_CLK_B>,
+				 <&cpg_clocks SH73A0_CLK_HP>,
+				 <&cpg_clocks SH73A0_CLK_ZG>,
+				 <&cpg_clocks SH73A0_CLK_B>;
+			#clock-cells = <1>;
+			clock-indices = <
+				SH73A0_CLK_CEU1 SH73A0_CLK_CSI2_RX1
+				SH73A0_CLK_CEU0 SH73A0_CLK_CSI2_RX0
+				SH73A0_CLK_TMU0	SH73A0_CLK_DSITX0
+				SH73A0_CLK_IIC0 SH73A0_CLK_SGX
+				SH73A0_CLK_LCDC0
+			>;
+			clock-output-names =
+				"ceu1", "csi2_rx1", "ceu0", "csi2_rx0",
+				"tmu0", "dsitx0", "iic0", "sgx", "lcdc0";
+		};
+		mstp2_clks: mstp2_clks at e6150138 {
+			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150138 4>, <0xe6150040 4>;
+			clocks = <&sub_clk>, <&cpg_clocks SH73A0_CLK_HP>,
+				 <&cpg_clocks SH73A0_CLK_HP>, <&sub_clk>,
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>, <&sub_clk>,
+				 <&sub_clk>, <&sub_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				SH73A0_CLK_SCIFA7 SH73A0_CLK_SY_DMAC
+				SH73A0_CLK_MP_DMAC SH73A0_CLK_SCIFA5
+				SH73A0_CLK_SCIFB SH73A0_CLK_SCIFA0
+				SH73A0_CLK_SCIFA1 SH73A0_CLK_SCIFA2
+				SH73A0_CLK_SCIFA3 SH73A0_CLK_SCIFA4
+			>;
+			clock-output-names =
+				"scifa7", "sy_dmac", "mp_dmac", "scifa5",
+				"scifb", "scifa0", "scifa1", "scifa2",
+				"scifa3", "scifa4";
+		};
+		mstp3_clks: mstp3_clks at e615013c {
+			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe615013c 4>, <0xe6150048 4>;
+			clocks = <&sub_clk>, <&extalr_clk>,
+				 <&cpg_clocks SH73A0_CLK_HP>, <&sub_clk>,
+				 <&cpg_clocks SH73A0_CLK_HP>,
+				 <&cpg_clocks SH73A0_CLK_HP>, <&flctl_clk>,
+				 <&sdhi0_clk>, <&sdhi1_clk>,
+				 <&cpg_clocks SH73A0_CLK_HP>, <&sdhi2_clk>,
+				 <&main_div2_clk>, <&main_div2_clk>,
+				 <&main_div2_clk>, <&main_div2_clk>,
+				 <&main_div2_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				SH73A0_CLK_SCIFA6 SH73A0_CLK_CMT1
+				SH73A0_CLK_FSI SH73A0_CLK_IRDA
+				SH73A0_CLK_IIC1 SH73A0_CLK_USB SH73A0_CLK_FLCTL
+				SH73A0_CLK_SDHI0 SH73A0_CLK_SDHI1
+				SH73A0_CLK_MMCIF0 SH73A0_CLK_SDHI2
+				SH73A0_CLK_TPU0 SH73A0_CLK_TPU1
+				SH73A0_CLK_TPU2 SH73A0_CLK_TPU3
+				SH73A0_CLK_TPU4
+			>;
+			clock-output-names =
+				"scifa6", "cmt1", "fsi", "irda", "iic1",
+				"usb", "flctl", "sdhi0", "sdhi1", "mmcif0", "sdhi2",
+				"tpu0", "tpu1", "tpu2", "tpu3", "tpu4";
+		};
+		mstp4_clks: mstp4_clks at e6150140 {
+			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150140 4>, <0xe615004c 4>;
+			clocks = <&cpg_clocks SH73A0_CLK_HP>,
+				 <&cpg_clocks SH73A0_CLK_HP>, <&extalr_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				SH73A0_CLK_IIC3 SH73A0_CLK_IIC4
+				SH73A0_CLK_KEYSC
+			>;
+			clock-output-names =
+				"iic3", "iic4", "keysc";
+		};
+	};
 };
-- 
2.1.3
