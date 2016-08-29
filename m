From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:26:53 +0200
Subject: [PATCH v3 01/14] drivers: clk: st: Remove stih415-416 clock support
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

STiH415 and STiH416 platforms are no longer used.
these platforms will be deprecated for the next kernel.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../bindings/clock/st/st,clkgen-divmux.txt         |  49 --
 .../devicetree/bindings/clock/st/st,clkgen-mux.txt |  18 +-
 .../devicetree/bindings/clock/st/st,clkgen-pll.txt |  26 +-
 .../bindings/clock/st/st,clkgen-prediv.txt         |  36 -
 .../devicetree/bindings/clock/st/st,clkgen-vcc.txt |  61 --
 .../devicetree/bindings/clock/st/st,clkgen.txt     |  54 +-
 .../devicetree/bindings/clock/st/st,quadfs.txt     |  27 +-
 drivers/clk/st/clkgen-fsyn.c                       | 260 --------
 drivers/clk/st/clkgen-mux.c                        | 726 +--------------------
 drivers/clk/st/clkgen-pll.c                        | 419 ------------
 10 files changed, 37 insertions(+), 1639 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/st/st,clkgen-divmux.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/st/st,clkgen-prediv.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/st/st,clkgen-vcc.txt

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-divmux.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-divmux.txt
deleted file mode 100644
index 6247652..0000000
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-divmux.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Binding for a ST divider and multiplexer clock driver.
-
-This binding uses the common clock binding[1].
-Base address is located to the parent node. See clock binding[2]
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/clock/st/st,clkgen.txt
-
-Required properties:
-
-- compatible : shall be:
-	"st,clkgena-divmux-c65-hs",	"st,clkgena-divmux"
-	"st,clkgena-divmux-c65-ls",	"st,clkgena-divmux"
-	"st,clkgena-divmux-c32-odf0",	"st,clkgena-divmux"
-	"st,clkgena-divmux-c32-odf1",	"st,clkgena-divmux"
-	"st,clkgena-divmux-c32-odf2",	"st,clkgena-divmux"
-	"st,clkgena-divmux-c32-odf3",	"st,clkgena-divmux"
-
-- #clock-cells : From common clock binding; shall be set to 1.
-
-- clocks : From common clock binding
-
-- clock-output-names : From common clock binding.
-
-Example:
-
-	clockgen-a at fd345000 {
-		reg = <0xfd345000 0xb50>;
-
-		clk_m_a1_div1: clk-m-a1-div1 {
-			#clock-cells = <1>;
-			compatible = "st,clkgena-divmux-c32-odf1",
-				     "st,clkgena-divmux";
-
-			clocks = <&clk_m_a1_osc_prediv>,
-				 <&clk_m_a1_pll0 1>, /* PLL0 PHI1 */
-				 <&clk_m_a1_pll1 1>; /* PLL1 PHI1 */
-
-			clock-output-names = "clk-m-rx-icn-ts",
-					     "clk-m-rx-icn-vdp-0",
-					     "", /* unused */
-					     "clk-m-prv-t1-bus",
-					     "clk-m-icn-reg-12",
-					     "clk-m-icn-reg-10",
-					     "", /* unused */
-					     "clk-m-icn-st231";
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
index f1fa91c..4d277d6 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
@@ -10,13 +10,6 @@ This binding uses the common clock binding[1].
 Required properties:
 
 - compatible : shall be:
-	"st,stih416-clkgenc-vcc-hd",	"st,clkgen-mux"
-	"st,stih416-clkgenf-vcc-fvdp",	"st,clkgen-mux"
-	"st,stih416-clkgenf-vcc-hva", 	"st,clkgen-mux"
-	"st,stih416-clkgenf-vcc-hd",	"st,clkgen-mux"
-	"st,stih416-clkgenf-vcc-sd",	"st,clkgen-mux"
-	"st,stih415-clkgen-a9-mux",	"st,clkgen-mux"
-	"st,stih416-clkgen-a9-mux",	"st,clkgen-mux"
 	"st,stih407-clkgen-a9-mux",	"st,clkgen-mux"
 
 - #clock-cells : from common clock binding; shall be set to 0.
@@ -27,10 +20,13 @@ Required properties:
 
 Example:
 
-	clk_m_hva: clk-m-hva at fd690868 {
+	clk_m_a9: clk-m-a9 at 92b0000 {
 		#clock-cells = <0>;
-		compatible = "st,stih416-clkgenf-vcc-hva", "st,clkgen-mux";
-		reg = <0xfd690868 4>;
+		compatible = "st,stih407-clkgen-a9-mux";
+		reg = <0x92b0000 0x10000>;
 
-		clocks = <&clockgen_f 1>, <&clk_m_a1_div0 3>;
+		clocks = <&clockgen_a9_pll 0>,
+			 <&clockgen_a9_pll 0>,
+			 <&clk_s_c0_flexgen 13>,
+			 <&clk_m_a9_ext2f_div2>;
 	};
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
index 844b3a0..c9fd674 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
@@ -9,25 +9,12 @@ Base address is located to the parent node. See clock binding[2]
 Required properties:
 
 - compatible : shall be:
-	"st,clkgena-prediv-c65",	"st,clkgena-prediv"
-	"st,clkgena-prediv-c32",	"st,clkgena-prediv"
-
-	"st,clkgena-plls-c65"
-	"st,plls-c32-a1x-0",		"st,clkgen-plls-c32"
-	"st,plls-c32-a1x-1",		"st,clkgen-plls-c32"
-	"st,stih415-plls-c32-a9",	"st,clkgen-plls-c32"
-	"st,stih415-plls-c32-ddr",	"st,clkgen-plls-c32"
-	"st,stih416-plls-c32-a9",	"st,clkgen-plls-c32"
-	"st,stih416-plls-c32-ddr",	"st,clkgen-plls-c32"
 	"st,stih407-plls-c32-a0",	"st,clkgen-plls-c32"
 	"st,stih407-plls-c32-a9",	"st,clkgen-plls-c32"
 	"sst,plls-c32-cx_0",		"st,clkgen-plls-c32"
 	"sst,plls-c32-cx_1",		"st,clkgen-plls-c32"
 	"st,stih418-plls-c28-a9",	"st,clkgen-plls-c32"
 
-	"st,stih415-gpu-pll-c32",	"st,clkgengpu-pll-c32"
-	"st,stih416-gpu-pll-c32",	"st,clkgengpu-pll-c32"
-
 - #clock-cells : From common clock binding; shall be set to 1.
 
 - clocks : From common clock binding
@@ -36,17 +23,16 @@ Required properties:
 
 Example:
 
-	clockgen-a at fee62000 {
-		reg = <0xfee62000 0xb48>;
+	clockgen-a9 at 92b0000 {
+		compatible = "st,clkgen-c32";
+		reg = <0x92b0000 0xffff>;
 
-		clk_s_a0_pll: clk-s-a0-pll {
+		clockgen_a9_pll: clockgen-a9-pll {
 			#clock-cells = <1>;
-			compatible = "st,clkgena-plls-c65";
+			compatible = "st,stih407-plls-c32-a9", "st,clkgen-plls-c32";
 
 			clocks = <&clk_sysin>;
 
-			clock-output-names = "clk-s-a0-pll0-hs",
-					     "clk-s-a0-pll0-ls",
-					     "clk-s-a0-pll1";
+			clock-output-names = "clockgen-a9-pll-odf";
 		};
 	};
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-prediv.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-prediv.txt
deleted file mode 100644
index 604766c..0000000
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-prediv.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Binding for a ST pre-divider clock driver.
-
-This binding uses the common clock binding[1].
-Base address is located to the parent node. See clock binding[2]
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/clock/st/st,clkgen.txt
-
-Required properties:
-
-- compatible : shall be:
-	"st,clkgena-prediv-c65",	"st,clkgena-prediv"
-	"st,clkgena-prediv-c32",	"st,clkgena-prediv"
-
-- #clock-cells : From common clock binding; shall be set to 0.
-
-- clocks : From common clock binding
-
-- clock-output-names : From common clock binding.
-
-Example:
-
-	clockgen-a at fd345000 {
-		reg = <0xfd345000 0xb50>;
-
-		clk_m_a2_osc_prediv: clk-m-a2-osc-prediv {
-			#clock-cells = <0>;
-			compatible = "st,clkgena-prediv-c32",
-				     "st,clkgena-prediv";
-
-			clocks = <&clk_sysin>;
-
-			clock-output-names = "clk-m-a2-osc-prediv";
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-vcc.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-vcc.txt
deleted file mode 100644
index 109b3ed..0000000
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-vcc.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-Binding for a type of STMicroelectronics clock crossbar (VCC).
-
-The crossbar can take up to 4 input clocks and control up to 16
-output clocks. Not all inputs or outputs have to be in use in a
-particular instantiation. Each output can be individually enabled,
-select any of the input clocks and apply a divide (by 1,2,4 or 8) to
-that selected clock.
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-
-- compatible : shall be:
-	"st,stih416-clkgenc",		"st,vcc"
-	"st,stih416-clkgenf",		"st,vcc"
-
-- #clock-cells : from common clock binding; shall be set to 1.
-
-- reg : A Base address and length of the register set.
-
-- clocks : from common clock binding
-
-- clock-output-names : From common clock binding. The block has 16
-                       clock outputs but not all of them in a specific instance
-                       have to be used in the SoC. If a clock name is left as
-                       an empty string then no clock will be created for the
-                       output associated with that string index. If fewer than
-                       16 strings are provided then no clocks will be created
-                       for the remaining outputs.
-
-Example:
-
-	clockgen_c_vcc: clockgen-c-vcc at 0xfe8308ac {
-		#clock-cells = <1>;
-		compatible = "st,stih416-clkgenc", "st,clkgen-vcc";
-		reg = <0xfe8308ac 12>;
-
-		clocks = <&clk_s_vcc_hd>,
-			 <&clockgen_c 1>,
-			 <&clk_s_tmds_fromphy>,
-			 <&clockgen_c 2>;
-
-		clock-output-names  = "clk-s-pix-hdmi",
-				      "clk-s-pix-dvo",
-				      "clk-s-out-dvo",
-				      "clk-s-pix-hd",
-				      "clk-s-hddac",
-				      "clk-s-denc",
-				      "clk-s-sddac",
-				      "clk-s-pix-main",
-				      "clk-s-pix-aux",
-				      "clk-s-stfe-frc-0",
-				      "clk-s-ref-mcru",
-				      "clk-s-slave-mcru",
-				      "clk-s-tmds-hdmi",
-				      "clk-s-hdmi-reject-pll",
-				      "clk-s-thsens";
-	};
-
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
index b18bf86..c764d6b 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
@@ -13,14 +13,6 @@ address is common of all subnode.
 			...
 		};
 
-		prediv_node {
-			...
-		};
-
-		divmux_node {
-			...
-		};
-
 		quadfs_node {
 			...
 		};
@@ -29,10 +21,6 @@ address is common of all subnode.
 			...
 		};
 
-		vcc_node {
-			...
-		};
-
 		flexgen_node {
 			...
 		};
@@ -43,11 +31,8 @@ This binding uses the common clock binding[1].
 Each subnode should use the binding described in [2]..[7]
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/clock/st,clkgen-divmux.txt
 [3] Documentation/devicetree/bindings/clock/st,clkgen-mux.txt
 [4] Documentation/devicetree/bindings/clock/st,clkgen-pll.txt
-[5] Documentation/devicetree/bindings/clock/st,clkgen-prediv.txt
-[6] Documentation/devicetree/bindings/clock/st,vcc.txt
 [7] Documentation/devicetree/bindings/clock/st,quadfs.txt
 [8] Documentation/devicetree/bindings/clock/st,flexgen.txt
 
@@ -57,44 +42,27 @@ Required properties:
 
 Example:
 
-	clockgen-a at fee62000 {
-
-		reg = <0xfee62000 0xb48>;
+	clockgen-a at 090ff000 {
+		compatible = "st,clkgen-c32";
+		reg = <0x90ff000 0x1000>;
 
 		clk_s_a0_pll: clk-s-a0-pll {
 			#clock-cells = <1>;
-			compatible = "st,clkgena-plls-c65";
-
-			clocks = <&clk-sysin>;
-
-			clock-output-names = "clk-s-a0-pll0-hs",
-					     "clk-s-a0-pll0-ls",
-					     "clk-s-a0-pll1";
-		};
-
-		clk_s_a0_osc_prediv: clk-s-a0-osc-prediv {
-			#clock-cells = <0>;
-			compatible = "st,clkgena-prediv-c65",
-				     "st,clkgena-prediv";
+			compatible = "st,stih407-plls-c32-a0", "st,clkgen-plls-c32";
 
 			clocks = <&clk_sysin>;
 
-			clock-output-names = "clk-s-a0-osc-prediv";
+			clock-output-names = "clk-s-a0-pll-ofd-0";
 		};
 
-		clk_s_a0_hs: clk-s-a0-hs {
+		clk_s_a0_flexgen: clk-s-a0-flexgen {
+			compatible = "st,flexgen";
+
 			#clock-cells = <1>;
-			compatible = "st,clkgena-divmux-c65-hs",
-				     "st,clkgena-divmux";
 
-			clocks = <&clk-s_a0_osc_prediv>,
-				 <&clk-s_a0_pll 0>, /* pll0 hs */
-				 <&clk-s_a0_pll 2>; /* pll1 */
+			clocks = <&clk_s_a0_pll 0>,
+				 <&clk_sysin>;
 
-			clock-output-names = "clk-s-fdma-0",
-					     "clk-s-fdma-1",
-					     ""; /* clk-s-jit-sense */
-					     /* fourth output unused */
+			clock-output-names = "clk-ic-lmi0";
 		};
 	};
-
diff --git a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
index cedeb9c..6d81b11 100644
--- a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
@@ -11,10 +11,6 @@ This binding uses the common clock binding[1].
 
 Required properties:
 - compatible : shall be:
-  "st,stih416-quadfs216",	"st,quadfs"
-  "st,stih416-quadfs432",	"st,quadfs"
-  "st,stih416-quadfs660-E",	"st,quadfs"
-  "st,stih416-quadfs660-F",	"st,quadfs"
   "st,stih407-quadfs660-C",	"st,quadfs"
   "st,stih407-quadfs660-D",	"st,quadfs"
 
@@ -35,14 +31,15 @@ Required properties:
 
 Example:
 
-	clockgen_e: clockgen-e at fd3208bc {
-                #clock-cells = <1>;
-                compatible = "st,stih416-quadfs660-E", "st,quadfs";
-                reg = <0xfd3208bc 0xB0>;
-
-                clocks = <&clk_sysin>;
-                clock-output-names = "clk-m-pix-mdtp-0",
-				     "clk-m-pix-mdtp-1",
-				     "clk-m-pix-mdtp-2",
-				     "clk-m-mpelpc";
-        };
+	clk_s_c0_quadfs: clk-s-c0-quadfs at 9103000 {
+		#clock-cells = <1>;
+		compatible = "st,stih407-quadfs660-C", "st,quadfs";
+		reg = <0x9103000 0x1000>;
+
+		clocks = <&clk_sysin>;
+
+		clock-output-names = "clk-s-c0-fs0-ch0",
+				     "clk-s-c0-fs0-ch1",
+				     "clk-s-c0-fs0-ch2",
+				     "clk-s-c0-fs0-ch3";
+	};
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 09afeb8..942c187 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -42,45 +42,6 @@ struct stm_fs {
 	unsigned long nsdiv;
 };
 
-static const struct stm_fs fs216c65_rtbl[] = {
-	{ .mdiv = 0x1f, .pe = 0x0,	.sdiv = 0x7,	.nsdiv = 0 },	/* 312.5 Khz */
-	{ .mdiv = 0x17, .pe = 0x25ed,	.sdiv = 0x1,	.nsdiv = 0 },	/* 27    MHz */
-	{ .mdiv = 0x1a, .pe = 0x7b36,	.sdiv = 0x2,	.nsdiv = 1 },	/* 36.87 MHz */
-	{ .mdiv = 0x13, .pe = 0x0,	.sdiv = 0x2,	.nsdiv = 1 },	/* 48    MHz */
-	{ .mdiv = 0x11, .pe = 0x1c72,	.sdiv = 0x1,	.nsdiv = 1 },	/* 108   MHz */
-};
-
-static const struct stm_fs fs432c65_rtbl[] = {
-	{ .mdiv = 0x1f, .pe = 0x0,	.sdiv = 0x7,	.nsdiv = 0 },	/* 625     Khz */
-	{ .mdiv = 0x13, .pe = 0x777c,	.sdiv = 0x4,	.nsdiv = 1 },	/* 25.175  MHz */
-	{ .mdiv = 0x19, .pe = 0x4d35,	.sdiv = 0x2,	.nsdiv = 0 },	/* 25.200  MHz */
-	{ .mdiv = 0x11, .pe = 0x1c72,	.sdiv = 0x4,	.nsdiv = 1 },	/* 27.000  MHz */
-	{ .mdiv = 0x17, .pe = 0x28f5,	.sdiv = 0x2,	.nsdiv = 0 },	/* 27.027  MHz */
-	{ .mdiv = 0x16, .pe = 0x3359,	.sdiv = 0x2,	.nsdiv = 0 },	/* 28.320  MHz */
-	{ .mdiv = 0x1f, .pe = 0x2083,	.sdiv = 0x3,	.nsdiv = 1 },	/* 30.240  MHz */
-	{ .mdiv = 0x1e, .pe = 0x430d,	.sdiv = 0x3,	.nsdiv = 1 },	/* 31.500  MHz */
-	{ .mdiv = 0x17, .pe = 0x0,	.sdiv = 0x3,	.nsdiv = 1 },	/* 40.000  MHz */
-	{ .mdiv = 0x19, .pe = 0x121a,	.sdiv = 0x1,	.nsdiv = 0 },	/* 49.500  MHz */
-	{ .mdiv = 0x13, .pe = 0x6667,	.sdiv = 0x3,	.nsdiv = 1 },	/* 50.000  MHz */
-	{ .mdiv = 0x10, .pe = 0x1ee6,	.sdiv = 0x3,	.nsdiv = 1 },	/* 57.284  MHz */
-	{ .mdiv = 0x1d, .pe = 0x3b14,	.sdiv = 0x2,	.nsdiv = 1 },	/* 65.000  MHz */
-	{ .mdiv = 0x12, .pe = 0x7c65,	.sdiv = 0x1,	.nsdiv = 0 },	/* 71.000  MHz */
-	{ .mdiv = 0x19, .pe = 0xecd,	.sdiv = 0x2,	.nsdiv = 1 },	/* 74.176  MHz */
-	{ .mdiv = 0x19, .pe = 0x121a,	.sdiv = 0x2,	.nsdiv = 1 },	/* 74.250  MHz */
-	{ .mdiv = 0x19, .pe = 0x3334,	.sdiv = 0x2,	.nsdiv = 1 },	/* 75.000  MHz */
-	{ .mdiv = 0x18, .pe = 0x5138,	.sdiv = 0x2,	.nsdiv = 1 },	/* 78.800  MHz */
-	{ .mdiv = 0x1d, .pe = 0x77d,	.sdiv = 0x0,	.nsdiv = 0 },	/* 85.500  MHz */
-	{ .mdiv = 0x1c, .pe = 0x13d5,	.sdiv = 0x0,	.nsdiv = 0 },	/* 88.750  MHz */
-	{ .mdiv = 0x11, .pe = 0x1c72,	.sdiv = 0x2,	.nsdiv = 1 },	/* 108.000 MHz */
-	{ .mdiv = 0x17, .pe = 0x28f5,	.sdiv = 0x0,	.nsdiv = 0 },	/* 108.108 MHz */
-	{ .mdiv = 0x10, .pe = 0x6e26,	.sdiv = 0x2,	.nsdiv = 1 },	/* 118.963 MHz */
-	{ .mdiv = 0x15, .pe = 0x3e63,	.sdiv = 0x0,	.nsdiv = 0 },	/* 119.000 MHz */
-	{ .mdiv = 0x1c, .pe = 0x471d,	.sdiv = 0x1,	.nsdiv = 1 },	/* 135.000 MHz */
-	{ .mdiv = 0x19, .pe = 0xecd,	.sdiv = 0x1,	.nsdiv = 1 },	/* 148.352 MHz */
-	{ .mdiv = 0x19, .pe = 0x121a,	.sdiv = 0x1,	.nsdiv = 1 },	/* 148.500 MHz */
-	{ .mdiv = 0x19, .pe = 0x121a,	.sdiv = 0x0,	.nsdiv = 1 },	/* 297     MHz */
-};
-
 static const struct stm_fs fs660c32_rtbl[] = {
 	{ .mdiv = 0x14, .pe = 0x376b,	.sdiv = 0x4,	.nsdiv = 1 },	/* 25.175  MHz */
 	{ .mdiv = 0x14, .pe = 0x30c3,	.sdiv = 0x4,	.nsdiv = 1 },	/* 25.200  MHz */
@@ -144,168 +105,11 @@ struct clkgen_quadfs_data {
 			unsigned long *);
 };
 
-static const struct clk_ops st_quadfs_pll_c65_ops;
 static const struct clk_ops st_quadfs_pll_c32_ops;
-static const struct clk_ops st_quadfs_fs216c65_ops;
-static const struct clk_ops st_quadfs_fs432c65_ops;
 static const struct clk_ops st_quadfs_fs660c32_ops;
 
-static int clk_fs216c65_get_rate(unsigned long, const struct stm_fs *,
-		unsigned long *);
-static int clk_fs432c65_get_rate(unsigned long, const struct stm_fs *,
-		unsigned long *);
 static int clk_fs660c32_dig_get_rate(unsigned long, const struct stm_fs *,
 		unsigned long *);
-/*
- * Values for all of the standalone instances of this clock
- * generator found in STiH415 and STiH416 SYSCFG register banks. Note
- * that the individual channel standby control bits (nsb) are in the
- * first register along with the PLL control bits.
- */
-static const struct clkgen_quadfs_data st_fs216c65_416 = {
-	/* 416 specific */
-	.npda	= CLKGEN_FIELD(0x0, 0x1, 14),
-	.nsb	= { CLKGEN_FIELD(0x0, 0x1, 10),
-		    CLKGEN_FIELD(0x0, 0x1, 11),
-		    CLKGEN_FIELD(0x0, 0x1, 12),
-		    CLKGEN_FIELD(0x0, 0x1, 13) },
-	.nsdiv_present = true,
-	.nsdiv	= { CLKGEN_FIELD(0x0, 0x1, 18),
-		    CLKGEN_FIELD(0x0, 0x1, 19),
-		    CLKGEN_FIELD(0x0, 0x1, 20),
-		    CLKGEN_FIELD(0x0, 0x1, 21) },
-	.mdiv	= { CLKGEN_FIELD(0x4, 0x1f, 0),
-		    CLKGEN_FIELD(0x14, 0x1f, 0),
-		    CLKGEN_FIELD(0x24, 0x1f, 0),
-		    CLKGEN_FIELD(0x34, 0x1f, 0) },
-	.en	= { CLKGEN_FIELD(0x10, 0x1, 0),
-		    CLKGEN_FIELD(0x20, 0x1, 0),
-		    CLKGEN_FIELD(0x30, 0x1, 0),
-		    CLKGEN_FIELD(0x40, 0x1, 0) },
-	.ndiv	= CLKGEN_FIELD(0x0, 0x1, 15),
-	.bwfilter_present = true,
-	.ref_bw = CLKGEN_FIELD(0x0, 0x3, 16),
-	.pe	= { CLKGEN_FIELD(0x8, 0xffff, 0),
-		    CLKGEN_FIELD(0x18, 0xffff, 0),
-		    CLKGEN_FIELD(0x28, 0xffff, 0),
-		    CLKGEN_FIELD(0x38, 0xffff, 0) },
-	.sdiv	= { CLKGEN_FIELD(0xC, 0x7, 0),
-		    CLKGEN_FIELD(0x1C, 0x7, 0),
-		    CLKGEN_FIELD(0x2C, 0x7, 0),
-		    CLKGEN_FIELD(0x3C, 0x7, 0) },
-	.pll_ops	= &st_quadfs_pll_c65_ops,
-	.rtbl		= fs216c65_rtbl,
-	.rtbl_cnt	= ARRAY_SIZE(fs216c65_rtbl),
-	.get_rate	= clk_fs216c65_get_rate,
-};
-
-static const struct clkgen_quadfs_data st_fs432c65_416 = {
-	.npda	= CLKGEN_FIELD(0x0, 0x1, 14),
-	.nsb	= { CLKGEN_FIELD(0x0, 0x1, 10),
-		    CLKGEN_FIELD(0x0, 0x1, 11),
-		    CLKGEN_FIELD(0x0, 0x1, 12),
-		    CLKGEN_FIELD(0x0, 0x1, 13) },
-	.nsdiv_present = true,
-	.nsdiv	= { CLKGEN_FIELD(0x0, 0x1, 18),
-		   CLKGEN_FIELD(0x0, 0x1, 19),
-		   CLKGEN_FIELD(0x0, 0x1, 20),
-		   CLKGEN_FIELD(0x0, 0x1, 21) },
-	.mdiv	= { CLKGEN_FIELD(0x4, 0x1f, 0),
-		    CLKGEN_FIELD(0x14, 0x1f, 0),
-		    CLKGEN_FIELD(0x24, 0x1f, 0),
-		    CLKGEN_FIELD(0x34, 0x1f, 0) },
-	.en	= { CLKGEN_FIELD(0x10, 0x1, 0),
-		    CLKGEN_FIELD(0x20, 0x1, 0),
-		    CLKGEN_FIELD(0x30, 0x1, 0),
-		    CLKGEN_FIELD(0x40, 0x1, 0) },
-	.ndiv	= CLKGEN_FIELD(0x0, 0x1, 15),
-	.bwfilter_present = true,
-	.ref_bw = CLKGEN_FIELD(0x0, 0x3, 16),
-	.pe	= { CLKGEN_FIELD(0x8, 0xffff, 0),
-		    CLKGEN_FIELD(0x18, 0xffff, 0),
-		    CLKGEN_FIELD(0x28, 0xffff, 0),
-		    CLKGEN_FIELD(0x38, 0xffff, 0) },
-	.sdiv	= { CLKGEN_FIELD(0xC, 0x7, 0),
-		    CLKGEN_FIELD(0x1C, 0x7, 0),
-		    CLKGEN_FIELD(0x2C, 0x7, 0),
-		    CLKGEN_FIELD(0x3C, 0x7, 0) },
-	.pll_ops	= &st_quadfs_pll_c65_ops,
-	.rtbl		= fs432c65_rtbl,
-	.rtbl_cnt	= ARRAY_SIZE(fs432c65_rtbl),
-	.get_rate	= clk_fs432c65_get_rate,
-};
-
-static const struct clkgen_quadfs_data st_fs660c32_E_416 = {
-	.npda	= CLKGEN_FIELD(0x0, 0x1, 14),
-	.nsb	= { CLKGEN_FIELD(0x0, 0x1, 10),
-		    CLKGEN_FIELD(0x0, 0x1, 11),
-		    CLKGEN_FIELD(0x0, 0x1, 12),
-		    CLKGEN_FIELD(0x0, 0x1, 13) },
-	.nsdiv_present = true,
-	.nsdiv	= { CLKGEN_FIELD(0x0, 0x1, 18),
-		    CLKGEN_FIELD(0x0, 0x1, 19),
-		    CLKGEN_FIELD(0x0, 0x1, 20),
-		    CLKGEN_FIELD(0x0, 0x1, 21) },
-	.mdiv	= { CLKGEN_FIELD(0x4, 0x1f, 0),
-		    CLKGEN_FIELD(0x14, 0x1f, 0),
-		    CLKGEN_FIELD(0x24, 0x1f, 0),
-		    CLKGEN_FIELD(0x34, 0x1f, 0) },
-	.en	= { CLKGEN_FIELD(0x10, 0x1, 0),
-		    CLKGEN_FIELD(0x20, 0x1, 0),
-		    CLKGEN_FIELD(0x30, 0x1, 0),
-		    CLKGEN_FIELD(0x40, 0x1, 0) },
-	.ndiv	= CLKGEN_FIELD(0x0, 0x7, 15),
-	.pe	= { CLKGEN_FIELD(0x8, 0x7fff, 0),
-		    CLKGEN_FIELD(0x18, 0x7fff, 0),
-		    CLKGEN_FIELD(0x28, 0x7fff, 0),
-		    CLKGEN_FIELD(0x38, 0x7fff, 0) },
-	.sdiv	= { CLKGEN_FIELD(0xC, 0xf, 0),
-		    CLKGEN_FIELD(0x1C, 0xf, 0),
-		    CLKGEN_FIELD(0x2C, 0xf, 0),
-		    CLKGEN_FIELD(0x3C, 0xf, 0) },
-	.lockstatus_present = true,
-	.lock_status = CLKGEN_FIELD(0xAC, 0x1, 0),
-	.pll_ops	= &st_quadfs_pll_c32_ops,
-	.rtbl		= fs660c32_rtbl,
-	.rtbl_cnt	= ARRAY_SIZE(fs660c32_rtbl),
-	.get_rate	= clk_fs660c32_dig_get_rate,
-};
-
-static const struct clkgen_quadfs_data st_fs660c32_F_416 = {
-	.npda	= CLKGEN_FIELD(0x0, 0x1, 14),
-	.nsb	= { CLKGEN_FIELD(0x0, 0x1, 10),
-		    CLKGEN_FIELD(0x0, 0x1, 11),
-		    CLKGEN_FIELD(0x0, 0x1, 12),
-		    CLKGEN_FIELD(0x0, 0x1, 13) },
-	.nsdiv_present = true,
-	.nsdiv	= { CLKGEN_FIELD(0x0, 0x1, 18),
-		    CLKGEN_FIELD(0x0, 0x1, 19),
-		    CLKGEN_FIELD(0x0, 0x1, 20),
-		    CLKGEN_FIELD(0x0, 0x1, 21) },
-	.mdiv	= { CLKGEN_FIELD(0x4, 0x1f, 0),
-		    CLKGEN_FIELD(0x14, 0x1f, 0),
-		    CLKGEN_FIELD(0x24, 0x1f, 0),
-		    CLKGEN_FIELD(0x34, 0x1f, 0) },
-	.en	= { CLKGEN_FIELD(0x10, 0x1, 0),
-		    CLKGEN_FIELD(0x20, 0x1, 0),
-		    CLKGEN_FIELD(0x30, 0x1, 0),
-		    CLKGEN_FIELD(0x40, 0x1, 0) },
-	.ndiv	= CLKGEN_FIELD(0x0, 0x7, 15),
-	.pe	= { CLKGEN_FIELD(0x8, 0x7fff, 0),
-		    CLKGEN_FIELD(0x18, 0x7fff, 0),
-		    CLKGEN_FIELD(0x28, 0x7fff, 0),
-		    CLKGEN_FIELD(0x38, 0x7fff, 0) },
-	.sdiv	= { CLKGEN_FIELD(0xC, 0xf, 0),
-		    CLKGEN_FIELD(0x1C, 0xf, 0),
-		    CLKGEN_FIELD(0x2C, 0xf, 0),
-		    CLKGEN_FIELD(0x3C, 0xf, 0) },
-	.lockstatus_present = true,
-	.lock_status = CLKGEN_FIELD(0xEC, 0x1, 0),
-	.pll_ops	= &st_quadfs_pll_c32_ops,
-	.rtbl		= fs660c32_rtbl,
-	.rtbl_cnt	= ARRAY_SIZE(fs660c32_rtbl),
-	.get_rate	= clk_fs660c32_dig_get_rate,
-};
 
 static const struct clkgen_quadfs_data st_fs660c32_C = {
 	.nrst_present = true,
@@ -605,12 +409,6 @@ static int quadfs_pll_fs660c32_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static const struct clk_ops st_quadfs_pll_c65_ops = {
-	.enable		= quadfs_pll_enable,
-	.disable	= quadfs_pll_disable,
-	.is_enabled	= quadfs_pll_is_enabled,
-};
-
 static const struct clk_ops st_quadfs_pll_c32_ops = {
 	.enable		= quadfs_pll_enable,
 	.disable	= quadfs_pll_disable,
@@ -797,48 +595,6 @@ static int quadfs_fsynth_is_enabled(struct clk_hw *hw)
 	return fs->data->standby_polarity ? !nsb : !!nsb;
 }
 
-#define P15			(uint64_t)(1 << 15)
-
-static int clk_fs216c65_get_rate(unsigned long input, const struct stm_fs *fs,
-		unsigned long *rate)
-{
-	uint64_t res;
-	unsigned long ns;
-	unsigned long nd = 8; /* ndiv stuck@0 => val = 8 */
-	unsigned long s;
-	long m;
-
-	m = fs->mdiv - 32;
-	s = 1 << (fs->sdiv + 1);
-	ns = (fs->nsdiv ? 1 : 3);
-
-	res = (uint64_t)(s * ns * P15 * (uint64_t)(m + 33));
-	res = res - (s * ns * fs->pe);
-	*rate = div64_u64(P15 * nd * input * 32, res);
-
-	return 0;
-}
-
-static int clk_fs432c65_get_rate(unsigned long input, const struct stm_fs *fs,
-		unsigned long *rate)
-{
-	uint64_t res;
-	unsigned long nd = 16; /* ndiv value; stuck at 0 (30Mhz input) */
-	long m;
-	unsigned long sd;
-	unsigned long ns;
-
-	m = fs->mdiv - 32;
-	sd = 1 << (fs->sdiv + 1);
-	ns = (fs->nsdiv ? 1 : 3);
-
-	res = (uint64_t)(sd * ns * P15 * (uint64_t)(m + 33));
-	res = res - (sd * ns * fs->pe);
-	*rate = div64_u64(P15 * nd * input * 32, res);
-
-	return 0;
-}
-
 #define P20		(uint64_t)(1 << 20)
 
 static int clk_fs660c32_dig_get_rate(unsigned long input,
@@ -1065,22 +821,6 @@ static struct clk * __init st_clk_register_quadfs_fsynth(
 
 static const struct of_device_id quadfs_of_match[] = {
 	{
-		.compatible = "st,stih416-quadfs216",
-		.data = &st_fs216c65_416
-	},
-	{
-		.compatible = "st,stih416-quadfs432",
-		.data = &st_fs432c65_416
-	},
-	{
-		.compatible = "st,stih416-quadfs660-E",
-		.data = &st_fs660c32_E_416
-	},
-	{
-		.compatible = "st,stih416-quadfs660-F",
-		.data = &st_fs660c32_F_416
-	},
-	{
 		.compatible = "st,stih407-quadfs660-C",
 		.data = &st_fs660c32_C
 	},
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index b1e10ff..6fdb1ab 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -19,9 +19,6 @@
 #include <linux/clk-provider.h>
 #include "clkgen.h"
 
-static DEFINE_SPINLOCK(clkgena_divmux_lock);
-static DEFINE_SPINLOCK(clkgenf_lock);
-
 static const char ** __init clkgen_mux_get_parents(struct device_node *np,
 						       int *num_parents)
 {
@@ -40,498 +37,6 @@ static const char ** __init clkgen_mux_get_parents(struct device_node *np,
 	return parents;
 }
 
-/**
- * DOC: Clock mux with a programmable divider on each of its three inputs.
- *      The mux has an input setting which effectively gates its output.
- *
- * Traits of this clock:
- * prepare - clk_(un)prepare only ensures parent is (un)prepared
- * enable - clk_enable and clk_disable are functional & control gating
- * rate - set rate is supported
- * parent - set/get parent
- */
-
-#define NUM_INPUTS 3
-
-struct clkgena_divmux {
-	struct clk_hw hw;
-	/* Subclassed mux and divider structures */
-	struct clk_mux mux;
-	struct clk_divider div[NUM_INPUTS];
-	/* Enable/running feedback register bits for each input */
-	void __iomem *feedback_reg[NUM_INPUTS];
-	int feedback_bit_idx;
-
-	u8              muxsel;
-};
-
-#define to_clkgena_divmux(_hw) container_of(_hw, struct clkgena_divmux, hw)
-
-struct clkgena_divmux_data {
-	int num_outputs;
-	int mux_offset;
-	int mux_offset2;
-	int mux_start_bit;
-	int div_offsets[NUM_INPUTS];
-	int fb_offsets[NUM_INPUTS];
-	int fb_start_bit_idx;
-};
-
-#define CKGAX_CLKOPSRC_SWITCH_OFF 0x3
-
-static int clkgena_divmux_is_running(struct clkgena_divmux *mux)
-{
-	u32 regval = readl(mux->feedback_reg[mux->muxsel]);
-	u32 running = regval & BIT(mux->feedback_bit_idx);
-	return !!running;
-}
-
-static int clkgena_divmux_enable(struct clk_hw *hw)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-	struct clk_hw *mux_hw = &genamux->mux.hw;
-	unsigned long timeout;
-	int ret = 0;
-
-	__clk_hw_set_clk(mux_hw, hw);
-
-	ret = clk_mux_ops.set_parent(mux_hw, genamux->muxsel);
-	if (ret)
-		return ret;
-
-	timeout = jiffies + msecs_to_jiffies(10);
-
-	while (!clkgena_divmux_is_running(genamux)) {
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	return 0;
-}
-
-static void clkgena_divmux_disable(struct clk_hw *hw)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-	struct clk_hw *mux_hw = &genamux->mux.hw;
-
-	__clk_hw_set_clk(mux_hw, hw);
-
-	clk_mux_ops.set_parent(mux_hw, CKGAX_CLKOPSRC_SWITCH_OFF);
-}
-
-static int clkgena_divmux_is_enabled(struct clk_hw *hw)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-	struct clk_hw *mux_hw = &genamux->mux.hw;
-
-	__clk_hw_set_clk(mux_hw, hw);
-
-	return (s8)clk_mux_ops.get_parent(mux_hw) > 0;
-}
-
-static u8 clkgena_divmux_get_parent(struct clk_hw *hw)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-	struct clk_hw *mux_hw = &genamux->mux.hw;
-
-	__clk_hw_set_clk(mux_hw, hw);
-
-	genamux->muxsel = clk_mux_ops.get_parent(mux_hw);
-	if ((s8)genamux->muxsel < 0) {
-		pr_debug("%s: %s: Invalid parent, setting to default.\n",
-		      __func__, clk_hw_get_name(hw));
-		genamux->muxsel = 0;
-	}
-
-	return genamux->muxsel;
-}
-
-static int clkgena_divmux_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-
-	if (index >= CKGAX_CLKOPSRC_SWITCH_OFF)
-		return -EINVAL;
-
-	genamux->muxsel = index;
-
-	/*
-	 * If the mux is already enabled, call enable directly to set the
-	 * new mux position and wait for it to start running again. Otherwise
-	 * do nothing.
-	 */
-	if (clkgena_divmux_is_enabled(hw))
-		clkgena_divmux_enable(hw);
-
-	return 0;
-}
-
-static unsigned long clkgena_divmux_recalc_rate(struct clk_hw *hw,
-		unsigned long parent_rate)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-	struct clk_hw *div_hw = &genamux->div[genamux->muxsel].hw;
-
-	__clk_hw_set_clk(div_hw, hw);
-
-	return clk_divider_ops.recalc_rate(div_hw, parent_rate);
-}
-
-static int clkgena_divmux_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-	struct clk_hw *div_hw = &genamux->div[genamux->muxsel].hw;
-
-	__clk_hw_set_clk(div_hw, hw);
-
-	return clk_divider_ops.set_rate(div_hw, rate, parent_rate);
-}
-
-static long clkgena_divmux_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
-{
-	struct clkgena_divmux *genamux = to_clkgena_divmux(hw);
-	struct clk_hw *div_hw = &genamux->div[genamux->muxsel].hw;
-
-	__clk_hw_set_clk(div_hw, hw);
-
-	return clk_divider_ops.round_rate(div_hw, rate, prate);
-}
-
-static const struct clk_ops clkgena_divmux_ops = {
-	.enable = clkgena_divmux_enable,
-	.disable = clkgena_divmux_disable,
-	.is_enabled = clkgena_divmux_is_enabled,
-	.get_parent = clkgena_divmux_get_parent,
-	.set_parent = clkgena_divmux_set_parent,
-	.round_rate = clkgena_divmux_round_rate,
-	.recalc_rate = clkgena_divmux_recalc_rate,
-	.set_rate = clkgena_divmux_set_rate,
-};
-
-/**
- * clk_register_genamux - register a genamux clock with the clock framework
- */
-static struct clk * __init clk_register_genamux(const char *name,
-				const char **parent_names, u8 num_parents,
-				void __iomem *reg,
-				const struct clkgena_divmux_data *muxdata,
-				u32 idx)
-{
-	/*
-	 * Fixed constants across all ClockgenA variants
-	 */
-	const int mux_width = 2;
-	const int divider_width = 5;
-	struct clkgena_divmux *genamux;
-	struct clk *clk;
-	struct clk_init_data init;
-	int i;
-
-	genamux = kzalloc(sizeof(*genamux), GFP_KERNEL);
-	if (!genamux)
-		return ERR_PTR(-ENOMEM);
-
-	init.name = name;
-	init.ops = &clkgena_divmux_ops;
-	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
-	init.parent_names = parent_names;
-	init.num_parents = num_parents;
-
-	genamux->mux.lock  = &clkgena_divmux_lock;
-	genamux->mux.mask = BIT(mux_width) - 1;
-	genamux->mux.shift = muxdata->mux_start_bit + (idx * mux_width);
-	if (genamux->mux.shift > 31) {
-		/*
-		 * We have spilled into the second mux register so
-		 * adjust the register address and the bit shift accordingly
-		 */
-		genamux->mux.reg = reg + muxdata->mux_offset2;
-		genamux->mux.shift -= 32;
-	} else {
-		genamux->mux.reg   = reg + muxdata->mux_offset;
-	}
-
-	for (i = 0; i < NUM_INPUTS; i++) {
-		/*
-		 * Divider config for each input
-		 */
-		void __iomem *divbase = reg + muxdata->div_offsets[i];
-		genamux->div[i].width = divider_width;
-		genamux->div[i].reg = divbase + (idx * sizeof(u32));
-
-		/*
-		 * Mux enabled/running feedback register for each input.
-		 */
-		genamux->feedback_reg[i] = reg + muxdata->fb_offsets[i];
-	}
-
-	genamux->feedback_bit_idx = muxdata->fb_start_bit_idx + idx;
-	genamux->hw.init = &init;
-
-	clk = clk_register(NULL, &genamux->hw);
-	if (IS_ERR(clk)) {
-		kfree(genamux);
-		goto err;
-	}
-
-	pr_debug("%s: parent %s rate %lu\n",
-			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			clk_get_rate(clk));
-err:
-	return clk;
-}
-
-static struct clkgena_divmux_data st_divmux_c65hs = {
-	.num_outputs = 4,
-	.mux_offset = 0x14,
-	.mux_start_bit = 0,
-	.div_offsets = { 0x800, 0x900, 0xb00 },
-	.fb_offsets = { 0x18, 0x1c, 0x20 },
-	.fb_start_bit_idx = 0,
-};
-
-static struct clkgena_divmux_data st_divmux_c65ls = {
-	.num_outputs = 14,
-	.mux_offset = 0x14,
-	.mux_offset2 = 0x24,
-	.mux_start_bit = 8,
-	.div_offsets = { 0x810, 0xa10, 0xb10 },
-	.fb_offsets = { 0x18, 0x1c, 0x20 },
-	.fb_start_bit_idx = 4,
-};
-
-static struct clkgena_divmux_data st_divmux_c32odf0 = {
-	.num_outputs = 8,
-	.mux_offset = 0x1c,
-	.mux_start_bit = 0,
-	.div_offsets = { 0x800, 0x900, 0xa60 },
-	.fb_offsets = { 0x2c, 0x24, 0x28 },
-	.fb_start_bit_idx = 0,
-};
-
-static struct clkgena_divmux_data st_divmux_c32odf1 = {
-	.num_outputs = 8,
-	.mux_offset = 0x1c,
-	.mux_start_bit = 16,
-	.div_offsets = { 0x820, 0x980, 0xa80 },
-	.fb_offsets = { 0x2c, 0x24, 0x28 },
-	.fb_start_bit_idx = 8,
-};
-
-static struct clkgena_divmux_data st_divmux_c32odf2 = {
-	.num_outputs = 8,
-	.mux_offset = 0x20,
-	.mux_start_bit = 0,
-	.div_offsets = { 0x840, 0xa20, 0xb10 },
-	.fb_offsets = { 0x2c, 0x24, 0x28 },
-	.fb_start_bit_idx = 16,
-};
-
-static struct clkgena_divmux_data st_divmux_c32odf3 = {
-	.num_outputs = 8,
-	.mux_offset = 0x20,
-	.mux_start_bit = 16,
-	.div_offsets = { 0x860, 0xa40, 0xb30 },
-	.fb_offsets = { 0x2c, 0x24, 0x28 },
-	.fb_start_bit_idx = 24,
-};
-
-static const struct of_device_id clkgena_divmux_of_match[] = {
-	{
-		.compatible = "st,clkgena-divmux-c65-hs",
-		.data = &st_divmux_c65hs,
-	},
-	{
-		.compatible = "st,clkgena-divmux-c65-ls",
-		.data = &st_divmux_c65ls,
-	},
-	{
-		.compatible = "st,clkgena-divmux-c32-odf0",
-		.data = &st_divmux_c32odf0,
-	},
-	{
-		.compatible = "st,clkgena-divmux-c32-odf1",
-		.data = &st_divmux_c32odf1,
-	},
-	{
-		.compatible = "st,clkgena-divmux-c32-odf2",
-		.data = &st_divmux_c32odf2,
-	},
-	{
-		.compatible = "st,clkgena-divmux-c32-odf3",
-		.data = &st_divmux_c32odf3,
-	},
-	{}
-};
-
-static void __iomem * __init clkgen_get_register_base(struct device_node *np)
-{
-	struct device_node *pnode;
-	void __iomem *reg;
-
-	pnode = of_get_parent(np);
-	if (!pnode)
-		return NULL;
-
-	reg = of_iomap(pnode, 0);
-
-	of_node_put(pnode);
-	return reg;
-}
-
-static void __init st_of_clkgena_divmux_setup(struct device_node *np)
-{
-	const struct of_device_id *match;
-	const struct clkgena_divmux_data *data;
-	struct clk_onecell_data *clk_data;
-	void __iomem *reg;
-	const char **parents;
-	int num_parents = 0, i;
-
-	match = of_match_node(clkgena_divmux_of_match, np);
-	if (WARN_ON(!match))
-		return;
-
-	data = match->data;
-
-	reg = clkgen_get_register_base(np);
-	if (!reg)
-		return;
-
-	parents = clkgen_mux_get_parents(np, &num_parents);
-	if (IS_ERR(parents))
-		goto err_parents;
-
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		goto err_alloc;
-
-	clk_data->clk_num = data->num_outputs;
-	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
-				 GFP_KERNEL);
-
-	if (!clk_data->clks)
-		goto err_alloc_clks;
-
-	for (i = 0; i < clk_data->clk_num; i++) {
-		struct clk *clk;
-		const char *clk_name;
-
-		if (of_property_read_string_index(np, "clock-output-names",
-						  i, &clk_name))
-			break;
-
-		/*
-		 * If we read an empty clock name then the output is unused
-		 */
-		if (*clk_name == '\0')
-			continue;
-
-		clk = clk_register_genamux(clk_name, parents, num_parents,
-					   reg, data, i);
-
-		if (IS_ERR(clk))
-			goto err;
-
-		clk_data->clks[i] = clk;
-	}
-
-	kfree(parents);
-
-	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
-	return;
-err:
-	kfree(clk_data->clks);
-err_alloc_clks:
-	kfree(clk_data);
-err_alloc:
-	kfree(parents);
-err_parents:
-	iounmap(reg);
-}
-CLK_OF_DECLARE(clkgenadivmux, "st,clkgena-divmux", st_of_clkgena_divmux_setup);
-
-struct clkgena_prediv_data {
-	u32 offset;
-	u8 shift;
-	struct clk_div_table *table;
-};
-
-static struct clk_div_table prediv_table16[] = {
-	{ .val = 0, .div = 1 },
-	{ .val = 1, .div = 16 },
-	{ .div = 0 },
-};
-
-static struct clkgena_prediv_data prediv_c65_data = {
-	.offset = 0x4c,
-	.shift = 31,
-	.table = prediv_table16,
-};
-
-static struct clkgena_prediv_data prediv_c32_data = {
-	.offset = 0x50,
-	.shift = 1,
-	.table = prediv_table16,
-};
-
-static const struct of_device_id clkgena_prediv_of_match[] = {
-	{ .compatible = "st,clkgena-prediv-c65", .data = &prediv_c65_data },
-	{ .compatible = "st,clkgena-prediv-c32", .data = &prediv_c32_data },
-	{}
-};
-
-static void __init st_of_clkgena_prediv_setup(struct device_node *np)
-{
-	const struct of_device_id *match;
-	void __iomem *reg;
-	const char *parent_name, *clk_name;
-	struct clk *clk;
-	const struct clkgena_prediv_data *data;
-
-	match = of_match_node(clkgena_prediv_of_match, np);
-	if (!match) {
-		pr_err("%s: No matching data\n", __func__);
-		return;
-	}
-
-	data = match->data;
-
-	reg = clkgen_get_register_base(np);
-	if (!reg)
-		return;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
-		goto err;
-
-	if (of_property_read_string_index(np, "clock-output-names",
-					  0, &clk_name))
-		goto err;
-
-	clk = clk_register_divider_table(NULL, clk_name, parent_name,
-					 CLK_GET_RATE_NOCACHE,
-					 reg + data->offset, data->shift, 1,
-					 0, data->table, NULL);
-	if (IS_ERR(clk))
-		goto err;
-
-	of_clk_add_provider(np, of_clk_src_simple_get, clk);
-	pr_debug("%s: parent %s rate %u\n",
-		__clk_get_name(clk),
-		__clk_get_name(clk_get_parent(clk)),
-		(unsigned int)clk_get_rate(clk));
-
-	return;
-err:
-	iounmap(reg);
-}
-CLK_OF_DECLARE(clkgenaprediv, "st,clkgena-prediv", st_of_clkgena_prediv_setup);
-
 struct clkgen_mux_data {
 	u32 offset;
 	u8 shift;
@@ -541,49 +46,6 @@ struct clkgen_mux_data {
 	u8 mux_flags;
 };
 
-static struct clkgen_mux_data clkgen_mux_c_vcc_hd_416 = {
-	.offset = 0,
-	.shift = 0,
-	.width = 1,
-};
-
-static struct clkgen_mux_data clkgen_mux_f_vcc_fvdp_416 = {
-	.offset = 0,
-	.shift = 0,
-	.width = 1,
-};
-
-static struct clkgen_mux_data clkgen_mux_f_vcc_hva_416 = {
-	.offset = 0,
-	.shift = 0,
-	.width = 1,
-};
-
-static struct clkgen_mux_data clkgen_mux_f_vcc_hd_416 = {
-	.offset = 0,
-	.shift = 16,
-	.width = 1,
-	.lock = &clkgenf_lock,
-};
-
-static struct clkgen_mux_data clkgen_mux_c_vcc_sd_416 = {
-	.offset = 0,
-	.shift = 17,
-	.width = 1,
-	.lock = &clkgenf_lock,
-};
-
-static struct clkgen_mux_data stih415_a9_mux_data = {
-	.offset = 0,
-	.shift = 1,
-	.width = 2,
-	.lock = &clkgen_a9_lock,
-};
-static struct clkgen_mux_data stih416_a9_mux_data = {
-	.offset = 0,
-	.shift = 0,
-	.width = 2,
-};
 static struct clkgen_mux_data stih407_a9_mux_data = {
 	.offset = 0x1a4,
 	.shift = 0,
@@ -593,47 +55,18 @@ static struct clkgen_mux_data stih407_a9_mux_data = {
 
 static const struct of_device_id mux_of_match[] = {
 	{
-		.compatible = "st,stih416-clkgenc-vcc-hd",
-		.data = &clkgen_mux_c_vcc_hd_416,
-	},
-	{
-		.compatible = "st,stih416-clkgenf-vcc-fvdp",
-		.data = &clkgen_mux_f_vcc_fvdp_416,
-	},
-	{
-		.compatible = "st,stih416-clkgenf-vcc-hva",
-		.data = &clkgen_mux_f_vcc_hva_416,
-	},
-	{
-		.compatible = "st,stih416-clkgenf-vcc-hd",
-		.data = &clkgen_mux_f_vcc_hd_416,
-	},
-	{
-		.compatible = "st,stih416-clkgenf-vcc-sd",
-		.data = &clkgen_mux_c_vcc_sd_416,
-	},
-	{
-		.compatible = "st,stih415-clkgen-a9-mux",
-		.data = &stih415_a9_mux_data,
-	},
-	{
-		.compatible = "st,stih416-clkgen-a9-mux",
-		.data = &stih416_a9_mux_data,
-	},
-	{
 		.compatible = "st,stih407-clkgen-a9-mux",
 		.data = &stih407_a9_mux_data,
 	},
 	{}
 };
-
 static void __init st_of_clkgen_mux_setup(struct device_node *np)
 {
 	const struct of_device_id *match;
 	struct clk *clk;
 	void __iomem *reg;
 	const char **parents;
-	int num_parents;
+	int num_parents = 0;
 	const struct clkgen_mux_data *data;
 
 	match = of_match_node(mux_of_match, np);
@@ -680,160 +113,3 @@ err_parents:
 	iounmap(reg);
 }
 CLK_OF_DECLARE(clkgen_mux, "st,clkgen-mux", st_of_clkgen_mux_setup);
-
-#define VCC_MAX_CHANNELS 16
-
-#define VCC_GATE_OFFSET 0x0
-#define VCC_MUX_OFFSET 0x4
-#define VCC_DIV_OFFSET 0x8
-
-struct clkgen_vcc_data {
-	spinlock_t *lock;
-	unsigned long clk_flags;
-};
-
-static struct clkgen_vcc_data st_clkgenc_vcc_416 = {
-	.clk_flags = CLK_SET_RATE_PARENT,
-};
-
-static struct clkgen_vcc_data st_clkgenf_vcc_416 = {
-	.lock = &clkgenf_lock,
-};
-
-static const struct of_device_id vcc_of_match[] = {
-	{ .compatible = "st,stih416-clkgenc", .data = &st_clkgenc_vcc_416 },
-	{ .compatible = "st,stih416-clkgenf", .data = &st_clkgenf_vcc_416 },
-	{}
-};
-
-static void __init st_of_clkgen_vcc_setup(struct device_node *np)
-{
-	const struct of_device_id *match;
-	void __iomem *reg;
-	const char **parents;
-	int num_parents, i;
-	struct clk_onecell_data *clk_data;
-	const struct clkgen_vcc_data *data;
-
-	match = of_match_node(vcc_of_match, np);
-	if (WARN_ON(!match))
-		return;
-	data = match->data;
-
-	reg = of_iomap(np, 0);
-	if (!reg)
-		return;
-
-	parents = clkgen_mux_get_parents(np, &num_parents);
-	if (IS_ERR(parents))
-		goto err_parents;
-
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		goto err_alloc;
-
-	clk_data->clk_num = VCC_MAX_CHANNELS;
-	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
-				 GFP_KERNEL);
-
-	if (!clk_data->clks)
-		goto err_alloc_clks;
-
-	for (i = 0; i < clk_data->clk_num; i++) {
-		struct clk *clk;
-		const char *clk_name;
-		struct clk_gate *gate;
-		struct clk_divider *div;
-		struct clk_mux *mux;
-
-		if (of_property_read_string_index(np, "clock-output-names",
-						  i, &clk_name))
-			break;
-
-		/*
-		 * If we read an empty clock name then the output is unused
-		 */
-		if (*clk_name == '\0')
-			continue;
-
-		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-		if (!gate)
-			goto err;
-
-		div = kzalloc(sizeof(*div), GFP_KERNEL);
-		if (!div) {
-			kfree(gate);
-			goto err;
-		}
-
-		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
-		if (!mux) {
-			kfree(gate);
-			kfree(div);
-			goto err;
-		}
-
-		gate->reg = reg + VCC_GATE_OFFSET;
-		gate->bit_idx = i;
-		gate->flags = CLK_GATE_SET_TO_DISABLE;
-		gate->lock = data->lock;
-
-		div->reg = reg + VCC_DIV_OFFSET;
-		div->shift = 2 * i;
-		div->width = 2;
-		div->flags = CLK_DIVIDER_POWER_OF_TWO |
-			CLK_DIVIDER_ROUND_CLOSEST;
-
-		mux->reg = reg + VCC_MUX_OFFSET;
-		mux->shift = 2 * i;
-		mux->mask = 0x3;
-
-		clk = clk_register_composite(NULL, clk_name, parents,
-					     num_parents,
-					     &mux->hw, &clk_mux_ops,
-					     &div->hw, &clk_divider_ops,
-					     &gate->hw, &clk_gate_ops,
-					     data->clk_flags |
-					     CLK_GET_RATE_NOCACHE);
-		if (IS_ERR(clk)) {
-			kfree(gate);
-			kfree(div);
-			kfree(mux);
-			goto err;
-		}
-
-		pr_debug("%s: parent %s rate %u\n",
-			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			(unsigned int)clk_get_rate(clk));
-
-		clk_data->clks[i] = clk;
-	}
-
-	kfree(parents);
-
-	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
-	return;
-
-err:
-	for (i = 0; i < clk_data->clk_num; i++) {
-		struct clk_composite *composite;
-
-		if (!clk_data->clks[i])
-			continue;
-
-		composite = to_clk_composite(__clk_get_hw(clk_data->clks[i]));
-		kfree(to_clk_gate(composite->gate_hw));
-		kfree(to_clk_divider(composite->rate_hw));
-		kfree(to_clk_mux(composite->mux_hw));
-	}
-
-	kfree(clk_data->clks);
-err_alloc_clks:
-	kfree(clk_data);
-err_alloc:
-	kfree(parents);
-err_parents:
-	iounmap(reg);
-}
-CLK_OF_DECLARE(clkgen_vcc, "st,clkgen-vcc", st_of_clkgen_vcc_setup);
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 0b5990e..8a1b1cf 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -26,14 +26,6 @@ static DEFINE_SPINLOCK(clkgena_c32_odf_lock);
 DEFINE_SPINLOCK(clkgen_a9_lock);
 
 /*
- * Common PLL configuration register bits for PLL800 and PLL1600 C65
- */
-#define C65_MDIV_PLL800_MASK	(0xff)
-#define C65_MDIV_PLL1600_MASK	(0x7)
-#define C65_NDIV_MASK		(0xff)
-#define C65_PDIV_MASK		(0x7)
-
-/*
  * PLL configuration register bits for PLL3200 C32
  */
 #define C32_NDIV_MASK (0xff)
@@ -70,144 +62,10 @@ struct clkgen_pll_data {
 	const struct clk_ops *ops;
 };
 
-static const struct clk_ops st_pll1600c65_ops;
-static const struct clk_ops st_pll800c65_ops;
 static const struct clk_ops stm_pll3200c32_ops;
 static const struct clk_ops stm_pll3200c32_a9_ops;
-static const struct clk_ops st_pll1200c32_ops;
 static const struct clk_ops stm_pll4600c28_ops;
 
-static const struct clkgen_pll_data st_pll1600c65_ax = {
-	.pdn_status	= CLKGEN_FIELD(0x0, 0x1,			19),
-	.pdn_ctrl	= CLKGEN_FIELD(0x10,	0x1,			0),
-	.locked_status	= CLKGEN_FIELD(0x0, 0x1,			31),
-	.mdiv		= CLKGEN_FIELD(0x0, C65_MDIV_PLL1600_MASK,	0),
-	.ndiv		= CLKGEN_FIELD(0x0, C65_NDIV_MASK,		8),
-	.ops		= &st_pll1600c65_ops
-};
-
-static const struct clkgen_pll_data st_pll800c65_ax = {
-	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			19),
-	.pdn_ctrl	= CLKGEN_FIELD(0xC,	0x1,			1),
-	.locked_status	= CLKGEN_FIELD(0x0,	0x1,			31),
-	.mdiv		= CLKGEN_FIELD(0x0,	C65_MDIV_PLL800_MASK,	0),
-	.ndiv		= CLKGEN_FIELD(0x0,	C65_NDIV_MASK,		8),
-	.pdiv		= CLKGEN_FIELD(0x0,	C65_PDIV_MASK,		16),
-	.ops		= &st_pll800c65_ops
-};
-
-static const struct clkgen_pll_data st_pll3200c32_a1x_0 = {
-	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			31),
-	.pdn_ctrl	= CLKGEN_FIELD(0x18,	0x1,			0),
-	.locked_status	= CLKGEN_FIELD(0x4,	0x1,			31),
-	.ndiv		= CLKGEN_FIELD(0x0,	C32_NDIV_MASK,		0x0),
-	.idf		= CLKGEN_FIELD(0x4,	C32_IDF_MASK,		0x0),
-	.num_odfs = 4,
-	.odf =	{	CLKGEN_FIELD(0x54,	C32_ODF_MASK,		4),
-			CLKGEN_FIELD(0x54,	C32_ODF_MASK,		10),
-			CLKGEN_FIELD(0x54,	C32_ODF_MASK,		16),
-			CLKGEN_FIELD(0x54,	C32_ODF_MASK,		22) },
-	.odf_gate = {	CLKGEN_FIELD(0x54,	0x1,			0),
-			CLKGEN_FIELD(0x54,	0x1,			1),
-			CLKGEN_FIELD(0x54,	0x1,			2),
-			CLKGEN_FIELD(0x54,	0x1,			3) },
-	.ops		= &stm_pll3200c32_ops,
-};
-
-static const struct clkgen_pll_data st_pll3200c32_a1x_1 = {
-	.pdn_status	= CLKGEN_FIELD(0xC,	0x1,			31),
-	.pdn_ctrl	= CLKGEN_FIELD(0x18,	0x1,			1),
-	.locked_status	= CLKGEN_FIELD(0x10,	0x1,			31),
-	.ndiv		= CLKGEN_FIELD(0xC,	C32_NDIV_MASK,		0x0),
-	.idf		= CLKGEN_FIELD(0x10,	C32_IDF_MASK,		0x0),
-	.num_odfs = 4,
-	.odf = {	CLKGEN_FIELD(0x58,	C32_ODF_MASK,		4),
-			CLKGEN_FIELD(0x58,	C32_ODF_MASK,		10),
-			CLKGEN_FIELD(0x58,	C32_ODF_MASK,		16),
-			CLKGEN_FIELD(0x58,	C32_ODF_MASK,		22) },
-	.odf_gate = {	CLKGEN_FIELD(0x58,	0x1,			0),
-			CLKGEN_FIELD(0x58,	0x1,			1),
-			CLKGEN_FIELD(0x58,	0x1,			2),
-			CLKGEN_FIELD(0x58,	0x1,			3) },
-	.ops		= &stm_pll3200c32_ops,
-};
-
-/* 415 specific */
-static const struct clkgen_pll_data st_pll3200c32_a9_415 = {
-	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.locked_status	= CLKGEN_FIELD(0x6C,	0x1,			0),
-	.ndiv		= CLKGEN_FIELD(0x0,	C32_NDIV_MASK,		9),
-	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		22),
-	.num_odfs = 1,
-	.odf =		{ CLKGEN_FIELD(0x0,	C32_ODF_MASK,		3) },
-	.odf_gate =	{ CLKGEN_FIELD(0x0,	0x1,			28) },
-	.ops		= &stm_pll3200c32_ops,
-};
-
-static const struct clkgen_pll_data st_pll3200c32_ddr_415 = {
-	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.locked_status	= CLKGEN_FIELD(0x100,	0x1,			0),
-	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
-	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
-	.num_odfs = 2,
-	.odf		= { CLKGEN_FIELD(0x8,	C32_ODF_MASK,		8),
-			    CLKGEN_FIELD(0x8,	C32_ODF_MASK,		14) },
-	.odf_gate	= { CLKGEN_FIELD(0x4,	0x1,			28),
-			    CLKGEN_FIELD(0x4,	0x1,			29) },
-	.ops		= &stm_pll3200c32_ops,
-};
-
-static const struct clkgen_pll_data st_pll1200c32_gpu_415 = {
-	.pdn_status	= CLKGEN_FIELD(0x4,	0x1,			0),
-	.pdn_ctrl	= CLKGEN_FIELD(0x4,	0x1,			0),
-	.locked_status	= CLKGEN_FIELD(0x168,	0x1,			0),
-	.ldf		= CLKGEN_FIELD(0x0,	C32_LDF_MASK,		3),
-	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		0),
-	.num_odfs = 0,
-	.odf		= { CLKGEN_FIELD(0x0,	C32_ODF_MASK,		10) },
-	.ops		= &st_pll1200c32_ops,
-};
-
-/* 416 specific */
-static const struct clkgen_pll_data st_pll3200c32_a9_416 = {
-	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.locked_status	= CLKGEN_FIELD(0x6C,	0x1,			0),
-	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
-	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
-	.num_odfs = 1,
-	.odf		= { CLKGEN_FIELD(0x8,	C32_ODF_MASK,		8) },
-	.odf_gate	= { CLKGEN_FIELD(0x4,	0x1,			28) },
-	.ops		= &stm_pll3200c32_ops,
-};
-
-static const struct clkgen_pll_data st_pll3200c32_ddr_416 = {
-	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
-	.locked_status	= CLKGEN_FIELD(0x10C,	0x1,			0),
-	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
-	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
-	.num_odfs = 2,
-	.odf		= { CLKGEN_FIELD(0x8,	C32_ODF_MASK,		8),
-			    CLKGEN_FIELD(0x8,	C32_ODF_MASK,		14) },
-	.odf_gate	= { CLKGEN_FIELD(0x4,	0x1,			28),
-			    CLKGEN_FIELD(0x4,	0x1,			29) },
-	.ops		= &stm_pll3200c32_ops,
-};
-
-static const struct clkgen_pll_data st_pll1200c32_gpu_416 = {
-	.pdn_status	= CLKGEN_FIELD(0x8E4,	0x1,			3),
-	.pdn_ctrl	= CLKGEN_FIELD(0x8E4,	0x1,			3),
-	.locked_status	= CLKGEN_FIELD(0x90C,	0x1,			0),
-	.ldf		= CLKGEN_FIELD(0x0,	C32_LDF_MASK,		3),
-	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		0),
-	.num_odfs = 0,
-	.odf		= { CLKGEN_FIELD(0x0,	C32_ODF_MASK,		10) },
-	.ops		= &st_pll1200c32_ops,
-};
-
 static const struct clkgen_pll_data st_pll3200c32_407_a0 = {
 	/* 407 A0 */
 	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
@@ -410,57 +268,6 @@ static void clkgen_pll_disable(struct clk_hw *hw)
 		spin_unlock_irqrestore(pll->lock, flags);
 }
 
-static unsigned long recalc_stm_pll800c65(struct clk_hw *hw,
-		unsigned long parent_rate)
-{
-	struct clkgen_pll *pll = to_clkgen_pll(hw);
-	unsigned long mdiv, ndiv, pdiv;
-	unsigned long rate;
-	uint64_t res;
-
-	if (!clkgen_pll_is_enabled(hw) || !clkgen_pll_is_locked(hw))
-		return 0;
-
-	pdiv = CLKGEN_READ(pll, pdiv);
-	mdiv = CLKGEN_READ(pll, mdiv);
-	ndiv = CLKGEN_READ(pll, ndiv);
-
-	if (!mdiv)
-		mdiv++; /* mdiv=0 or 1 => MDIV=1 */
-
-	res = (uint64_t)2 * (uint64_t)parent_rate * (uint64_t)ndiv;
-	rate = (unsigned long)div64_u64(res, mdiv * (1 << pdiv));
-
-	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
-
-	return rate;
-
-}
-
-static unsigned long recalc_stm_pll1600c65(struct clk_hw *hw,
-		unsigned long parent_rate)
-{
-	struct clkgen_pll *pll = to_clkgen_pll(hw);
-	unsigned long mdiv, ndiv;
-	unsigned long rate;
-
-	if (!clkgen_pll_is_enabled(hw) || !clkgen_pll_is_locked(hw))
-		return 0;
-
-	mdiv = CLKGEN_READ(pll, mdiv);
-	ndiv = CLKGEN_READ(pll, ndiv);
-
-	if (!mdiv)
-		mdiv = 1;
-
-	/* Note: input is divided by 1000 to avoid overflow */
-	rate = ((2 * (parent_rate / 1000) * ndiv) / mdiv) * 1000;
-
-	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
-
-	return rate;
-}
-
 static int clk_pll3200c32_get_params(unsigned long input, unsigned long output,
 			  struct stm_pll *pll)
 {
@@ -608,33 +415,6 @@ static int set_rate_stm_pll3200c32(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static unsigned long recalc_stm_pll1200c32(struct clk_hw *hw,
-		unsigned long parent_rate)
-{
-	struct clkgen_pll *pll = to_clkgen_pll(hw);
-	unsigned long odf, ldf, idf;
-	unsigned long rate;
-
-	if (!clkgen_pll_is_enabled(hw) || !clkgen_pll_is_locked(hw))
-		return 0;
-
-	odf = CLKGEN_READ(pll, odf[0]);
-	ldf = CLKGEN_READ(pll, ldf);
-	idf = CLKGEN_READ(pll, idf);
-
-	if (!idf) /* idf==0 means 1 */
-		idf = 1;
-	if (!odf) /* odf==0 means 1 */
-		odf = 1;
-
-	/* Note: input is divided by 1000 to avoid overflow */
-	rate = (((parent_rate / 1000) * ldf) / (odf * idf)) * 1000;
-
-	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
-
-	return rate;
-}
-
 /* PLL output structure
  * FVCO >> /2 >> FVCOBY2 (no output)
  *                 |> Divider (ODF) >> PHI
@@ -792,20 +572,6 @@ static int set_rate_stm_pll4600c28(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static const struct clk_ops st_pll1600c65_ops = {
-	.enable		= clkgen_pll_enable,
-	.disable	= clkgen_pll_disable,
-	.is_enabled	= clkgen_pll_is_enabled,
-	.recalc_rate	= recalc_stm_pll1600c65,
-};
-
-static const struct clk_ops st_pll800c65_ops = {
-	.enable		= clkgen_pll_enable,
-	.disable	= clkgen_pll_disable,
-	.is_enabled	= clkgen_pll_is_enabled,
-	.recalc_rate	= recalc_stm_pll800c65,
-};
-
 static const struct clk_ops stm_pll3200c32_ops = {
 	.enable		= clkgen_pll_enable,
 	.disable	= clkgen_pll_disable,
@@ -822,13 +588,6 @@ static const struct clk_ops stm_pll3200c32_a9_ops = {
 	.set_rate	= set_rate_stm_pll3200c32,
 };
 
-static const struct clk_ops st_pll1200c32_ops = {
-	.enable		= clkgen_pll_enable,
-	.disable	= clkgen_pll_disable,
-	.is_enabled	= clkgen_pll_is_enabled,
-	.recalc_rate	= recalc_stm_pll1200c32,
-};
-
 static const struct clk_ops stm_pll4600c28_ops = {
 	.enable		= clkgen_pll_enable,
 	.disable	= clkgen_pll_disable,
@@ -877,22 +636,6 @@ static struct clk * __init clkgen_pll_register(const char *parent_name,
 	return clk;
 }
 
-static struct clk * __init clkgen_c65_lsdiv_register(const char *parent_name,
-						     const char *clk_name)
-{
-	struct clk *clk;
-
-	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0, 1, 2);
-	if (IS_ERR(clk))
-		return clk;
-
-	pr_debug("%s: parent %s rate %lu\n",
-			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			clk_get_rate(clk));
-	return clk;
-}
-
 static void __iomem * __init clkgen_get_register_base(
 				struct device_node *np)
 {
@@ -909,89 +652,6 @@ static void __iomem * __init clkgen_get_register_base(
 	return reg;
 }
 
-#define CLKGENAx_PLL0_OFFSET 0x0
-#define CLKGENAx_PLL1_OFFSET 0x4
-
-static void __init clkgena_c65_pll_setup(struct device_node *np)
-{
-	const int num_pll_outputs = 3;
-	struct clk_onecell_data *clk_data;
-	const char *parent_name;
-	void __iomem *reg;
-	const char *clk_name;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
-		return;
-
-	reg = clkgen_get_register_base(np);
-	if (!reg)
-		return;
-
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		return;
-
-	clk_data->clk_num = num_pll_outputs;
-	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk *),
-				 GFP_KERNEL);
-
-	if (!clk_data->clks)
-		goto err;
-
-	if (of_property_read_string_index(np, "clock-output-names",
-					  0, &clk_name))
-		goto err;
-
-	/*
-	 * PLL0 HS (high speed) output
-	 */
-	clk_data->clks[0] = clkgen_pll_register(parent_name,
-			(struct clkgen_pll_data *) &st_pll1600c65_ax,
-			reg + CLKGENAx_PLL0_OFFSET, 0, clk_name, NULL);
-
-	if (IS_ERR(clk_data->clks[0]))
-		goto err;
-
-	if (of_property_read_string_index(np, "clock-output-names",
-					  1, &clk_name))
-		goto err;
-
-	/*
-	 * PLL0 LS (low speed) output, which is a fixed divide by 2 of the
-	 * high speed output.
-	 */
-	clk_data->clks[1] = clkgen_c65_lsdiv_register(__clk_get_name
-						      (clk_data->clks[0]),
-						      clk_name);
-
-	if (IS_ERR(clk_data->clks[1]))
-		goto err;
-
-	if (of_property_read_string_index(np, "clock-output-names",
-					  2, &clk_name))
-		goto err;
-
-	/*
-	 * PLL1 output
-	 */
-	clk_data->clks[2] = clkgen_pll_register(parent_name,
-			(struct clkgen_pll_data *) &st_pll800c65_ax,
-			reg + CLKGENAx_PLL1_OFFSET, 0, clk_name, NULL);
-
-	if (IS_ERR(clk_data->clks[2]))
-		goto err;
-
-	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
-	return;
-
-err:
-	kfree(clk_data->clks);
-	kfree(clk_data);
-}
-CLK_OF_DECLARE(clkgena_c65_plls,
-	       "st,clkgena-plls-c65", clkgena_c65_pll_setup);
-
 static struct clk * __init clkgen_odf_register(const char *parent_name,
 					       void __iomem *reg,
 					       struct clkgen_pll_data *pll_data,
@@ -1044,30 +704,6 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
 
 static const struct of_device_id c32_pll_of_match[] = {
 	{
-		.compatible = "st,plls-c32-a1x-0",
-		.data = &st_pll3200c32_a1x_0,
-	},
-	{
-		.compatible = "st,plls-c32-a1x-1",
-		.data = &st_pll3200c32_a1x_1,
-	},
-	{
-		.compatible = "st,stih415-plls-c32-a9",
-		.data = &st_pll3200c32_a9_415,
-	},
-	{
-		.compatible = "st,stih415-plls-c32-ddr",
-		.data = &st_pll3200c32_ddr_415,
-	},
-	{
-		.compatible = "st,stih416-plls-c32-a9",
-		.data = &st_pll3200c32_a9_416,
-	},
-	{
-		.compatible = "st,stih416-plls-c32-ddr",
-		.data = &st_pll3200c32_ddr_416,
-	},
-	{
 		.compatible = "st,stih407-plls-c32-a0",
 		.data = &st_pll3200c32_407_a0,
 	},
@@ -1167,58 +803,3 @@ err:
 	kfree(clk_data);
 }
 CLK_OF_DECLARE(clkgen_c32_pll, "st,clkgen-plls-c32", clkgen_c32_pll_setup);
-
-static const struct of_device_id c32_gpu_pll_of_match[] = {
-	{
-		.compatible = "st,stih415-gpu-pll-c32",
-		.data = &st_pll1200c32_gpu_415,
-	},
-	{
-		.compatible = "st,stih416-gpu-pll-c32",
-		.data = &st_pll1200c32_gpu_416,
-	},
-	{}
-};
-
-static void __init clkgengpu_c32_pll_setup(struct device_node *np)
-{
-	const struct of_device_id *match;
-	struct clk *clk;
-	const char *parent_name;
-	void __iomem *reg;
-	const char *clk_name;
-	struct clkgen_pll_data	*data;
-
-	match = of_match_node(c32_gpu_pll_of_match, np);
-	if (!match) {
-		pr_err("%s: No matching data\n", __func__);
-		return;
-	}
-
-	data = (struct clkgen_pll_data *)match->data;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
-		return;
-
-	reg = clkgen_get_register_base(np);
-	if (!reg)
-		return;
-
-	if (of_property_read_string_index(np, "clock-output-names",
-					  0, &clk_name))
-		return;
-
-	/*
-	 * PLL 1200MHz output
-	 */
-	clk = clkgen_pll_register(parent_name, data, reg,
-				  0, clk_name, data->lock);
-
-	if (!IS_ERR(clk))
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
-
-	return;
-}
-CLK_OF_DECLARE(clkgengpu_c32_pll,
-	       "st,clkgengpu-pll-c32", clkgengpu_c32_pll_setup);
-- 
1.9.1
