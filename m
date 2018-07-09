From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon,  9 Jul 2018 17:41:02 -0500
Subject: [PATCH 1/2] ARM: dts: arria10: update NAND clocking
Message-ID: <1531176063-30140-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND IP needs 2 clocks(nand_x_clk and nand_clk). This patch adds a
nand_x_clk, which is derived from the nand_clk, but has a fixed divider
of 4.

Update the NAND node to use the additional clock.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index a4dcb68..558b5ea 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -377,13 +377,21 @@
 						clk-gate = <0xC8 11>;
 					};
 
-					nand_clk: nand_clk {
+					nand_x_clk: nand_x_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-a10-gate-clk";
 						clocks = <&l4_mp_clk>;
 						clk-gate = <0xC8 10>;
 					};
 
+					nand_clk: nand_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-a10-gate-clk";
+						clocks = <&nand_x_clk>;
+						fixed-divider = <4>;
+						clk-gate = <0xC8 10>;
+					};
+
 					spi_m_clk: spi_m_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-a10-gate-clk";
@@ -650,7 +658,8 @@
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0 99 4>;
 			dma-mask = <0xffffffff>;
-			clocks = <&nand_clk>;
+			clocks = <&nand_clk>, <&nand_x_clk>;
+			clock-names = "nand", "nand_x";
 			status = "disabled";
 		};
 
-- 
2.7.4
