From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:52 +0900
Subject: [PATCH 21/30] ARM: shmobile: r8a7794: Add SDHI clocks to device tree
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <8e181633e6ca960491ac502ccd4a4aac482c3ff9.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
[horms: omitted device nodes; only add clock]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 20 +++++++++++++++++++-
 include/dt-bindings/clock/r8a7794-clock.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 728d719..c376676 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -293,6 +293,21 @@
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z";
 		};
+		/* Variable factor clocks */
+		sd1_clk: sd2_clk at e6150078 {
+			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150078 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sd1";
+		};
+		sd2_clk: sd3_clk at e615007c {
+			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615007c 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sd2";
+		};
 
 		/* Fixed factor clocks */
 		pll1_div2_clk: pll1_div2_clk {
@@ -496,13 +511,16 @@
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&rclk_clk>, <&hp_clk>, <&hp_clk>;
+			clocks = <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
+			         <&rclk_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
+			        R8A7794_CLK_SDHI2 R8A7794_CLK_SDHI1 R8A7794_CLK_SDHI0
 				R8A7794_CLK_CMT1 R8A7794_CLK_USBDMAC0
 				R8A7794_CLK_USBDMAC1
 			>;
 			clock-output-names =
+			        "sdhi2", "sdhi1", "sdhi0",
 				"cmt1", "usbdmac0", "usbdmac1";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 94d9618..ccd5667 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -52,6 +52,9 @@
 #define R8A7794_CLK_SYS_DMAC0		19
 
 /* MSTP3 */
+#define R8A7794_CLK_SDHI2		11
+#define R8A7794_CLK_SDHI1		12
+#define R8A7794_CLK_SDHI0		14
 #define R8A7794_CLK_CMT1		29
 #define R8A7794_CLK_USBDMAC0		30
 #define R8A7794_CLK_USBDMAC1		31
-- 
2.1.3
