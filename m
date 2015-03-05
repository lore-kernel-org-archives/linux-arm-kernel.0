From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:03 +0900
Subject: [PATCH 03/16] ARM: shmobile: r8a7778: Common clock framework DT
 description
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <93aa970d2b0ce41efb7e5e6b94aaa66e8349a510.1425518337.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Declares all r8a7778 clocks supported by the legacy clock framework,
plus tmu2.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
[horms: only included dtsi changes]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 191 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index ef85339..822ba90 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -16,6 +16,7 @@
 
 /include/ "skeleton.dtsi"
 
+#include <dt-bindings/clock/r8a7778-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -294,4 +295,194 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* External input clock */
+		extal_clk: extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "extal";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at ffc80000 {
+			compatible = "renesas,r8a7778-cpg-clocks";
+			reg = <0xffc80000 0x80>;
+			#clock-cells = <1>;
+			clocks = <&extal_clk>;
+			clock-output-names = "plla", "pllb", "b",
+					     "out", "p", "s", "s1";
+		};
+
+		/* Audio clocks; frequencies are set by boards if applicable. */
+		audio_clk_a: audio_clk_a {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "audio_clk_a";
+		};
+		audio_clk_b: audio_clk_b {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "audio_clk_b";
+		};
+		audio_clk_c: audio_clk_c {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "audio_clk_c";
+		};
+
+		/* Fixed ratio clocks */
+		g_clk: g_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+			clock-output-names = "g";
+		};
+		i_clk: i_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+			clock-output-names = "i";
+		};
+		s3_clk: s3_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "s3";
+		};
+		s4_clk: s4_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "s4";
+		};
+		z_clk: z_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7778_CLK_PLLB>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+			clock-output-names = "z";
+		};
+
+		/* Gate clocks */
+		mstp0_clks: mstp0_clks at ffc80030 {
+			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xffc80030 4>;
+			clocks = <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_S>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7778_CLK_I2C0 R8A7778_CLK_I2C1
+				R8A7778_CLK_I2C2 R8A7778_CLK_I2C3
+				R8A7778_CLK_SCIF0 R8A7778_CLK_SCIF1
+				R8A7778_CLK_SCIF2 R8A7778_CLK_SCIF3
+				R8A7778_CLK_SCIF4 R8A7778_CLK_SCIF5
+				R8A7778_CLK_TMU0 R8A7778_CLK_TMU1
+				R8A7778_CLK_TMU2 R8A7778_CLK_SSI0
+				R8A7778_CLK_SSI1 R8A7778_CLK_SSI2
+				R8A7778_CLK_SSI3 R8A7778_CLK_SRU
+				R8A7778_CLK_HSPI
+			>;
+			clock-output-names =
+				"i2c0", "i2c1", "i2c2", "i2c3", "scif0",
+				"scif1", "scif2", "scif3", "scif4", "scif5",
+				"tmu0", "tmu1", "tmu2", "ssi0", "ssi1",
+				"ssi2", "ssi3", "sru", "hspi";
+		};
+		mstp1_clks: mstp1_clks at ffc80034 {
+			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xffc80034 4>, <0xffc80044 4>;
+			clocks = <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_S>,
+				 <&cpg_clocks R8A7778_CLK_S>,
+				 <&cpg_clocks R8A7778_CLK_P>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7778_CLK_ETHER R8A7778_CLK_VIN0
+				R8A7778_CLK_VIN1 R8A7778_CLK_USB
+			>;
+			clock-output-names =
+				"ether", "vin0", "vin1", "usb";
+		};
+		mstp3_clks: mstp3_clks at ffc8003c {
+			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xffc8003c 4>;
+			clocks = <&s4_clk>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7778_CLK_MMC R8A7778_CLK_SDHI0
+				R8A7778_CLK_SDHI1 R8A7778_CLK_SDHI2
+				R8A7778_CLK_SSI4 R8A7778_CLK_SSI5
+				R8A7778_CLK_SSI6 R8A7778_CLK_SSI7
+				R8A7778_CLK_SSI8
+			>;
+			clock-output-names =
+				"mmc", "sdhi0", "sdhi1", "sdhi2", "ssi4",
+				"ssi5", "ssi6", "ssi7", "ssi8";
+		};
+		mstp5_clks: mstp5_clks at ffc80054 {
+			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xffc80054 4>;
+			clocks = <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_P>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7778_CLK_SRU_SRC0 R8A7778_CLK_SRU_SRC1
+				R8A7778_CLK_SRU_SRC2 R8A7778_CLK_SRU_SRC3
+				R8A7778_CLK_SRU_SRC4 R8A7778_CLK_SRU_SRC5
+				R8A7778_CLK_SRU_SRC6 R8A7778_CLK_SRU_SRC7
+				R8A7778_CLK_SRU_SRC8
+			>;
+			clock-output-names =
+				"sru-src0", "sru-src1", "sru-src2",
+				"sru-src3", "sru-src4", "sru-src5",
+				"sru-src6", "sru-src7", "sru-src8";
+		};
+	};
 };
-- 
2.1.4
