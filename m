From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Mar 2014 12:26:57 +0100
Subject: [PATCH V2 2/5] ARM: shmobile: r8a7791: add IIC(B) clocks to dtsi
In-Reply-To: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394450820-8158-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

Changes since V1: kept sorting by bit number

Note: Adding clocks whilst keeping the current sorting is very likely to
break a previously working clock IMO. Imagine adding PCIEC clock inbetween IIC0
and IIC1 here. Adding chronologically and grouped by similar function blocks is
easier to track IMO. An example addition could then look like:

 	R8A7791_CLK_TPU0
 	R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
 	R8A7791_CLK_MMCIF0
 	R8A7791_CLK_CMT1
	R8A7791_CLK_IIC0 R8A7791_CLK_IIC1
+	R8A7791_CLK_PCIEC

 arch/arm/boot/dts/r8a7791.dtsi | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 71bac2ca4bcd..858a8a923b00 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -716,15 +716,16 @@
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>,
-				<&cpg_clocks R8A7791_CLK_SD0>, <&mmc0_clk>, <&rclk_clk>;
+			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
+				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1
-				R8A7791_CLK_SDHI0 R8A7791_CLK_MMCIF0 R8A7791_CLK_CMT1
+				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
+				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_IIC1 R8A7791_CLK_CMT1
 			>;
 			clock-output-names =
-				"tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0", "cmt1";
+				"tpu0", "sdhi2", "sdhi1", "sdhi0",
+				"mmcif0", "i2c7", "i2c8", "cmt1";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
@@ -768,17 +769,17 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>,
-				 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				 <&p_clk>;
+			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>, <&p_clk>,
+				 <&cp_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				 <&p_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
-				R8A7791_CLK_I2C5 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
-				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
+				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD R8A7791_CLK_I2C5
+				R8A7791_CLK_IICDVFS R8A7791_CLK_I2C4 R8A7791_CLK_I2C3 R8A7791_CLK_I2C2
+				R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
 			>;
 			clock-output-names =
-				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c4", "i2c3",
+				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c6", "i2c4", "i2c3",
 				"i2c2", "i2c1", "i2c0";
 		};
 		mstp11_clks: mstp11_clks at e615099c {
-- 
1.9.0
