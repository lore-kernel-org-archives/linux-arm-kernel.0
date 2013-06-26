From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:07 +0300
Subject: [PATCH 04/23] ARM: dt: tegra30: Register AHB/IOMMU device first
Message-ID: <1372238906-9346-5-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move up AHB/IOMMU to register them earlier than others. IOMMU needs
AHB, and IOMMU needs to register all platform devices as
IOMMU'able. So AHB/IOMMU needs to be instanciated at very beginning.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 3fcee3f..7c480f2 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -17,6 +17,23 @@
 		serial4 = &uarte;
 	};
 
+	/* FIXME: ahb/iommu needs to be populated first. */
+	ahb: ahb {
+		compatible = "nvidia,tegra30-ahb";
+		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
+	};
+
+	iommu {
+		compatible = "nvidia,tegra30-smmu";
+		reg = <0x7000f010 0x02c
+		       0x7000f1f0 0x010
+		       0x7000f228 0x05c>;
+		nvidia,#asids = <4>;		/* # of ASIDs */
+		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x00000000 0x000779ff>;
+		nvidia,ahb = <&ahb>;
+	};
+
 	host1x {
 		compatible = "nvidia,tegra30-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
@@ -213,11 +230,6 @@
 		clocks = <&tegra_car TEGRA30_CLK_APBDMA>;
 	};
 
-	ahb: ahb {
-		compatible = "nvidia,tegra30-ahb";
-		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
-	};
-
 	gpio: gpio {
 		compatible = "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
@@ -469,17 +481,6 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	iommu {
-		compatible = "nvidia,tegra30-smmu";
-		reg = <0x7000f010 0x02c
-		       0x7000f1f0 0x010
-		       0x7000f228 0x05c>;
-		nvidia,#asids = <4>;		/* # of ASIDs */
-		dma-window = <0 0x40000000>;	/* IOVA start & length */
-		nvidia,swgroups = <0x00000000 0x000779ff>;
-		nvidia,ahb = <&ahb>;
-	};
-
 	ahub {
 		compatible = "nvidia,tegra30-ahub";
 		reg = <0x70080000 0x200
-- 
1.8.1.5
