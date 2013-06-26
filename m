From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:11 +0300
Subject: [PATCH 08/23] ARM: dt: tegra114: Register AHB/IOMMU device first
Message-ID: <1372238906-9346-9-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move up AHB/IOMMU to register them earlier than others. IOMMU needs
AHB, and IOMMU needs to register all platform devices as
IOMMU'able. So AHB/IOMMU needs to be instanciated at very beginning.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 980a3b1..180186f 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -16,6 +16,23 @@
 		serial3 = &uartd;
 	};
 
+	/* FIXME: ahb/iommu needs to be populated first. */
+	ahb: ahb {
+		compatible = "nvidia,tegra114-ahb", "nvidia,tegra30-ahb";
+		reg = <0x6000c004 0x14c>;
+	};
+
+	iommu {
+		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
+		reg = <0x70019010 0x02c
+		       0x700191f0 0x010
+		       0x70019228 0x074>;
+		nvidia,#asids = <4>;
+		dma-window = <0 0x40000000>;
+		nvidia,swgroups = <0x00000000 0x01b659fe>;
+		nvidia,ahb = <&ahb>;
+	};
+
 	gic: interrupt-controller {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
@@ -84,11 +101,6 @@
 		clocks = <&tegra_car TEGRA114_CLK_APBDMA>;
 	};
 
-	ahb: ahb {
-		compatible = "nvidia,tegra114-ahb", "nvidia,tegra30-ahb";
-		reg = <0x6000c004 0x14c>;
-	};
-
 	gpio: gpio {
 		compatible = "nvidia,tegra114-gpio", "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
@@ -317,17 +329,6 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
-	iommu {
-		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
-		reg = <0x70019010 0x02c
-		       0x700191f0 0x010
-		       0x70019228 0x074>;
-		nvidia,#asids = <4>;
-		dma-window = <0 0x40000000>;
-		nvidia,swgroups = <0x00000000 0x01b659fe>;
-		nvidia,ahb = <&ahb>;
-	};
-
 	ahub {
 		compatible = "nvidia,tegra114-ahub";
 		reg = <0x70080000 0x200>,
-- 
1.8.1.5
