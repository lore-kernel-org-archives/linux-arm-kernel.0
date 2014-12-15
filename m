From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Dec 2014 09:21:48 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Add I2C clocks to device tree
Message-ID: <1418602908-5370-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
[horms: omitted device nodes and aliases; only add clocks]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Based on the renesas-devel-20141212-v3.18 tag of my renesas tree

v1 [Simon Horman]
* Removed portion of patch which adds device nodes and aliases
* Renamed patch from
  "ARM: shmobile: r8a7794: Add I2C driver to device tree" to
  "ARM: shmobile: r8a7794: Add I2C clocks to device tree"

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8794df8..fd8a19c 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -308,6 +308,13 @@
 			#clock-cells = <0>;
 			clock-output-names = "sd2";
 		};
+		mmc0_clk: mmc0_clk at e6150240 {
+			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150240 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc0";
+		};

 		/* Fixed factor clocks */
 		pll1_div2_clk: pll1_div2_clk {
@@ -512,16 +519,16 @@
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
-			         <&rclk_clk>, <&hp_clk>, <&hp_clk>;
+			         <&mmc0_clk>, <&rclk_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 			        R8A7794_CLK_SDHI2 R8A7794_CLK_SDHI1 R8A7794_CLK_SDHI0
-				R8A7794_CLK_CMT1 R8A7794_CLK_USBDMAC0
-				R8A7794_CLK_USBDMAC1
+				R8A7794_CLK_CMT1 R8A7794_CLK_MMCIF0
+				R8A7794_CLK_USBDMAC0 R8A7794_CLK_USBDMAC1
 			>;
 			clock-output-names =
 			        "sdhi2", "sdhi1", "sdhi0",
-				"cmt1", "usbdmac0", "usbdmac1";
+				"mmcif0", "cmt1", "usbdmac0", "usbdmac1";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index f013cdc..4555b0f 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -55,6 +55,7 @@
 #define R8A7794_CLK_SDHI2		11
 #define R8A7794_CLK_SDHI1		12
 #define R8A7794_CLK_SDHI0		14
+#define R8A7794_CLK_MMCIF0		15
 #define R8A7794_CLK_CMT1		29
 #define R8A7794_CLK_USBDMAC0		30
 #define R8A7794_CLK_USBDMAC1		31
---
 arch/arm/boot/dts/r8a7794.dtsi            | 12 +++++++++---
 include/dt-bindings/clock/r8a7794-clock.h |  6 ++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 068ca09..728d719 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -538,10 +538,16 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cpg_clocks R8A7794_CLK_QSPI>;
+			clocks = <&cpg_clocks R8A7794_CLK_QSPI>, <&hp_clk>, <&hp_clk>,
+				<&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7794_CLK_QSPI_MOD>;
-			clock-output-names = "qspi_mod";
+			clock-indices = <
+				R8A7794_CLK_QSPI_MOD R8A7794_CLK_I2C5 R8A7794_CLK_I2C4
+				R8A7794_CLK_I2C3 R8A7794_CLK_I2C2 R8A7794_CLK_I2C1
+				R8A7794_CLK_I2C0
+			>;
+			clock-output-names =
+				"qspi_mod", "i2c5", "i2c4", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index fba89a4..94d9618 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -87,6 +87,12 @@
 #define R8A7794_CLK_GPIO1		11
 #define R8A7794_CLK_GPIO0		12
 #define R8A7794_CLK_QSPI_MOD		17
+#define R8A7794_CLK_I2C5		25
+#define R8A7794_CLK_I2C4		27
+#define R8A7794_CLK_I2C3		28
+#define R8A7794_CLK_I2C2		29
+#define R8A7794_CLK_I2C1		30
+#define R8A7794_CLK_I2C0		31
 
 /* MSTP11 */
 #define R8A7794_CLK_SCIFA3		6
-- 
2.1.3
