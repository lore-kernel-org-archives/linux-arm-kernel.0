From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  1 Aug 2018 09:31:34 -0500
Subject: [PATCHv2 2/2] ARM: dts: socfpga: update NAND clocking for c5/a5
In-Reply-To: <1533133894-31932-1-git-send-email-dinguyen@kernel.org>
References: <1533133894-31932-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1533133894-31932-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND IP needs 3 clocks(nand_x_clk, nand_clk, and nand_ecc_clk). The
nand_x_clk and nand_ecc_clk are derived from the nand_clk. The nand_x_clk
has a fixed divider of 4.

Also, update the NAND dts property with the correct clocks property.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: add nand_ecc_clk and update commit message
---
 arch/arm/boot/dts/socfpga.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b38f8c2..daf249e 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -483,10 +483,17 @@
 						clk-gate = <0xa0 9>;
 					};
 
+					nand_ecc_clk: nand_ecc_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&nand_x_clk>;
+						clk-gate = <0xa0 9>;
+					};
+
 					nand_clk: nand_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+						clocks = <&nand_x_clk>;
 						clk-gate = <0xa0 10>;
 						fixed-divider = <4>;
 					};
@@ -754,7 +761,8 @@
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0x0 0x90 0x4>;
 			dma-mask = <0xffffffff>;
-			clocks = <&nand_x_clk>;
+			clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
+			clock-names = "nand", "nand_x", "ecc";
 			status = "disabled";
 		};
 
-- 
2.7.4
