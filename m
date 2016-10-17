From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 17 Oct 2016 13:13:35 +0100
Subject: [PATCH 2/3] arm64: dts: Update AMD Seattle to generic IOMMU binding
In-Reply-To: <acf4f770eab43fec8c5b6e9cddb6dd0defc52138.1476706244.git.robin.murphy@arm.com>
References: <acf4f770eab43fec8c5b6e9cddb6dd0defc52138.1476706244.git.robin.murphy@arm.com>
Message-ID: <ba181e825cd125690bdded339f2003730d7d866e.1476706244.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMU-401 supports stream matching, so with the SMMU implementation of
the generic "iommus" binding we can use masks to nicely simplify the
XGBE's blocks of contiguous stream IDs.

CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: Brijesh Singh <brijeshkumar.singh@amd.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
index 8e8631952497..4cd0a443d4f6 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
@@ -54,8 +54,8 @@
 		clocks = <&xgmacclk0_dma_250mhz>, <&xgmacclk0_ptp_250mhz>;
 		clock-names = "dma_clk", "ptp_clk";
 		phy-mode = "xgmii";
-		#stream-id-cells = <16>;
 		dma-coherent;
+		iommus = <&xgmac0_smmu 0x00 0x17>;
 	};
 
 	xgmac1: xgmac at e0900000 {
@@ -80,8 +80,8 @@
 		clocks = <&xgmacclk1_dma_250mhz>, <&xgmacclk1_ptp_250mhz>;
 		clock-names = "dma_clk", "ptp_clk";
 		phy-mode = "xgmii";
-		#stream-id-cells = <16>;
 		dma-coherent;
+		iommus = <&xgmac1_smmu 0x00 0x17>;
 	};
 
 	xgmac0_smmu: smmu at e0600000 {
@@ -93,11 +93,7 @@
 			       */
 			      <0 336 4>,
 			      <0 336 4>;
-
-		 mmu-masters = <&xgmac0
-			  0  1  2  3  4  5  6  7
-			 16 17 18 19 20 21 22 23
-		 >;
+		#iommu-cells = <2>;
 	 };
 
 	 xgmac1_smmu: smmu at e0800000 {
@@ -109,9 +105,5 @@
 			       */
 			      <0 335 4>,
 			      <0 335 4>;
-
-		 mmu-masters = <&xgmac1
-			  0  1  2  3  4  5  6  7
-			 16 17 18 19 20 21 22 23
-		 >;
+		#iommu-cells = <2>;
 	 };
-- 
1.9.1
