From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Tue, 23 May 2017 11:24:10 +0800
Subject: [PATCH v4 2/3] arm64: dts: mt8173: Fix mdp device tree
In-Reply-To: <1495509851-29159-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1495509851-29159-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1495509851-29159-3-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

If the mdp_* nodes are under an mdp sub-node, their corresponding
platform device does not automatically get its iommu assigned properly.

Fix this by moving the mdp component nodes up a level such that they are
siblings of mdp and all other SoC subsystems.  This also simplifies the
device tree.

Although it fixes iommu assignment issue, it also break compatibility
with old device tree. So, the patch in driver is needed to iterate over
sibling mdp device nodes, not child ones, to keep driver work properly.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 126 +++++++++++++++----------------
 1 file changed, 60 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 6922252..d28a363 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -792,80 +792,74 @@
 			#clock-cells = <1>;
 		};
 
-		mdp {
-			compatible = "mediatek,mt8173-mdp";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		mdp_rdma0: rdma at 14001000 {
+			compatible = "mediatek,mt8173-mdp-rdma",
+				     "mediatek,mt8173-mdp";
+			reg = <0 0x14001000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
+				 <&mmsys CLK_MM_MUTEX_32K>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
+			mediatek,larb = <&larb0>;
 			mediatek,vpu = <&vpu>;
+		};
 
-			mdp_rdma0: rdma at 14001000 {
-				compatible = "mediatek,mt8173-mdp-rdma";
-				reg = <0 0x14001000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_RDMA0>,
-					 <&mmsys CLK_MM_MUTEX_32K>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-				iommus = <&iommu M4U_PORT_MDP_RDMA0>;
-				mediatek,larb = <&larb0>;
-			};
-
-			mdp_rdma1: rdma at 14002000 {
-				compatible = "mediatek,mt8173-mdp-rdma";
-				reg = <0 0x14002000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_RDMA1>,
-					 <&mmsys CLK_MM_MUTEX_32K>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-				iommus = <&iommu M4U_PORT_MDP_RDMA1>;
-				mediatek,larb = <&larb4>;
-			};
+		mdp_rdma1: rdma at 14002000 {
+			compatible = "mediatek,mt8173-mdp-rdma";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RDMA1>,
+				 <&mmsys CLK_MM_MUTEX_32K>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_RDMA1>;
+			mediatek,larb = <&larb4>;
+		};
 
-			mdp_rsz0: rsz at 14003000 {
-				compatible = "mediatek,mt8173-mdp-rsz";
-				reg = <0 0x14003000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_RSZ0>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-			};
+		mdp_rsz0: rsz at 14003000 {
+			compatible = "mediatek,mt8173-mdp-rsz";
+			reg = <0 0x14003000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ0>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		};
 
-			mdp_rsz1: rsz at 14004000 {
-				compatible = "mediatek,mt8173-mdp-rsz";
-				reg = <0 0x14004000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_RSZ1>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-			};
+		mdp_rsz1: rsz at 14004000 {
+			compatible = "mediatek,mt8173-mdp-rsz";
+			reg = <0 0x14004000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		};
 
-			mdp_rsz2: rsz at 14005000 {
-				compatible = "mediatek,mt8173-mdp-rsz";
-				reg = <0 0x14005000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_RSZ2>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-			};
+		mdp_rsz2: rsz at 14005000 {
+			compatible = "mediatek,mt8173-mdp-rsz";
+			reg = <0 0x14005000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ2>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		};
 
-			mdp_wdma0: wdma at 14006000 {
-				compatible = "mediatek,mt8173-mdp-wdma";
-				reg = <0 0x14006000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_WDMA>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-				iommus = <&iommu M4U_PORT_MDP_WDMA>;
-				mediatek,larb = <&larb0>;
-			};
+		mdp_wdma0: wdma at 14006000 {
+			compatible = "mediatek,mt8173-mdp-wdma";
+			reg = <0 0x14006000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_WDMA>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_WDMA>;
+			mediatek,larb = <&larb0>;
+		};
 
-			mdp_wrot0: wrot at 14007000 {
-				compatible = "mediatek,mt8173-mdp-wrot";
-				reg = <0 0x14007000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_WROT0>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-				iommus = <&iommu M4U_PORT_MDP_WROT0>;
-				mediatek,larb = <&larb0>;
-			};
+		mdp_wrot0: wrot at 14007000 {
+			compatible = "mediatek,mt8173-mdp-wrot";
+			reg = <0 0x14007000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_WROT0>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_WROT0>;
+			mediatek,larb = <&larb0>;
+		};
 
-			mdp_wrot1: wrot at 14008000 {
-				compatible = "mediatek,mt8173-mdp-wrot";
-				reg = <0 0x14008000 0 0x1000>;
-				clocks = <&mmsys CLK_MM_MDP_WROT1>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-				iommus = <&iommu M4U_PORT_MDP_WROT1>;
-				mediatek,larb = <&larb4>;
-			};
+		mdp_wrot1: wrot at 14008000 {
+			compatible = "mediatek,mt8173-mdp-wrot";
+			reg = <0 0x14008000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_WROT1>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_WROT1>;
+			mediatek,larb = <&larb4>;
 		};
 
 		ovl0: ovl at 1400c000 {
-- 
1.9.1
