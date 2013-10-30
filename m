From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Oct 2013 17:17:48 -0600
Subject: [PATCH] ARM: tegra: fix Tegra114 IOMMU register address
Message-ID: <1383175068-27420-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi Doyu <hdoyu@nvidia.com>

The IOMMU node's reg property contains completely bogus values! Somehow,
this had no practical effect, despite the fact the IOMMU driver appears
to be writing to those registers. I suppose that since no HW modules is
actually at that address, the writes simply had no effect.

Note that I'm not CCing stable here, even though the problem exists as
far back as v3.9, simply because this patch doesn't fix any observed
issue, and I don't want to run the risk of suddenly writing to some
registers and causing a regression.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
[swarren, wrote commit description]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Kevin, Olof, if you could apply this directly for 3.13, that's be awesome.

 arch/arm/boot/dts/tegra114.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 2905145..8d42787 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -318,9 +318,9 @@
 
 	iommu {
 		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
-		reg = <0x7000f010 0x02c
-		       0x7000f1f0 0x010
-		       0x7000f228 0x074>;
+		reg = <0x70019010 0x02c
+		       0x700191f0 0x010
+		       0x70019228 0x074>;
 		nvidia,#asids = <4>;
 		dma-window = <0 0x40000000>;
 		nvidia,swgroups = <0x18659fe>;
-- 
1.8.1.5
