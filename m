From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 13 Oct 2014 12:33:50 +0200
Subject: [PATCH 08/12] ARM: tegra: Add memory controller support for Tegra114
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1413196434-5292-8-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add the device tree node for the memory controller found on Tegra114
SoCs. The memory controller integrates an IOMMU (called SMMU) as well as
various knobs to tweak memory accesses by the various clients.

The old IOMMU device tree node is collapsed into the memory controller
node to more accurately describe the hardware. While this change is
incompatible, the IOMMU driver has never had any users so the change is
not going to cause any breakage.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 2ca9c1807f72..2c26b07c11ed 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -505,15 +505,15 @@
 		reset-names = "fuse";
 	};
 
-	iommu at 70019010 {
-		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
-		reg = <0x70019010 0x02c
-		       0x700191f0 0x010
-		       0x70019228 0x074>;
-		nvidia,#asids = <4>;
-		dma-window = <0 0x40000000>;
-		nvidia,swgroups = <0x18659fe>;
-		nvidia,ahb = <&ahb>;
+	mc: memory-controller at 70019000 {
+		compatible = "nvidia,tegra114-mc";
+		reg = <0x70019000 0x1000>;
+		clocks = <&tegra_car TEGRA114_CLK_MC>;
+		clock-names = "mc";
+
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+
+		#iommu-cells = <1>;
 	};
 
 	ahub at 70080000 {
-- 
2.1.2
