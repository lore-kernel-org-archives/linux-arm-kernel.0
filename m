From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 14 Apr 2015 11:05:19 -0500
Subject: [PATCHv2] ARM: socfpga: dts: Add a clock node for sdmmc CIU
Message-ID: <1429027519-22209-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The CIU(Card Interface Unit) get its clock from the sdmmc_clk_divided clock
which is used to clock the card. The sdmmc_clk_divided clock is the sdmmc_clk
passed through a fixed divider of 4. This patch adds the sdmmc_clk_divided
node and makes the sdmmc_clk it's parent.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2: renamed ciu_clk to sdmmc_clk_divided
---
 arch/arm/boot/dts/socfpga.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index d9176e6..be4beda 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -451,6 +451,14 @@
 						clk-phase = <0 135>;
 					};
 
+					sdmmc_clk_divided: sdmmc_clk_divided {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&sdmmc_clk>;
+						clk-gate = <0xa0 8>;
+						fixed-divider = <4>;
+					};
+
 					nand_x_clk: nand_x_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
@@ -635,7 +643,7 @@
 			fifo-depth = <0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
+			clocks = <&l4_mp_clk>, <&sdmmc_clk_divided>;
 			clock-names = "biu", "ciu";
 		};
 
-- 
2.2.1
