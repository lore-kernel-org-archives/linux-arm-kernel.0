From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  1 Aug 2018 09:31:33 -0500
Subject: [PATCHv2 1/2] ARM: dts: arria10: update NAND clocking
Message-ID: <1533133894-31932-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND IP needs 3 clocks(nand_x_clk, nand_clk, and nand_ecc_clk). This
patch adds a nand_clk, which is derived from the nand_x_clk, but has a
fixed divider of 4, and the nand_ecc_clk, which is derived from the
nand_x_clk.

Update the NAND node to use the additional clocks.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: add nand_ecc_clk and update commit message
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index a4dcb68..b614b86 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -377,13 +377,28 @@
 						clk-gate = <0xC8 11>;
 					};
 
-					nand_clk: nand_clk {
+					nand_x_clk: nand_x_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-a10-gate-clk";
 						clocks = <&l4_mp_clk>;
 						clk-gate = <0xC8 10>;
 					};
 
+					nand_ecc_clk: nand_ecc_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-a10-gate-clk";
+						clocks = <&nand_x_clk>;
+						clk-gate = <0xC8 10>;
+					};
+
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
@@ -650,7 +665,8 @@
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0 99 4>;
 			dma-mask = <0xffffffff>;
-			clocks = <&nand_clk>;
+			clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
+			clock-names = "nand", "nand_x", "ecc";
 			status = "disabled";
 		};
 
-- 
2.7.4
