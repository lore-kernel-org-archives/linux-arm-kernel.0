From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Nov 2014 10:32:31 +0100
Subject: [PATCH v7 06/12] ARM: tegra: Add memory controller support for Tegra30
In-Reply-To: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1415871157-21968-7-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Collapses the old memory-controller and IOMMU device tree nodes into a
single node to more accurately describe the hardware.

While this is an incompatible change there are no users of the IOMMU on
Tegra, even though a driver has existed for some time.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index b270b9e3d455..0d20058afe9d 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -615,23 +615,15 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
-	memory-controller at 7000f000 {
+	mc: memory-controller at 7000f000 {
 		compatible = "nvidia,tegra30-mc";
-		reg = <0x7000f000 0x010
-		       0x7000f03c 0x1b4
-		       0x7000f200 0x028
-		       0x7000f284 0x17c>;
+		reg = <0x7000f000 0x400>;
+		clocks = <&tegra_car TEGRA30_CLK_MC>;
+		clock-names = "mc";
+
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-	};
 
-	iommu at 7000f010 {
-		compatible = "nvidia,tegra30-smmu";
-		reg = <0x7000f010 0x02c
-		       0x7000f1f0 0x010
-		       0x7000f228 0x05c>;
-		nvidia,#asids = <4>;		/* # of ASIDs */
-		dma-window = <0 0x40000000>;	/* IOVA start & length */
-		nvidia,ahb = <&ahb>;
+		#iommu-cells = <1>;
 	};
 
 	fuse at 7000f800 {
-- 
2.1.3
