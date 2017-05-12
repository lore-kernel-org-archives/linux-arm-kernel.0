From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Fri, 12 May 2017 11:15:12 +0800
Subject: [PATCH 1/3] dt-bindings: mt8173: Fix mdp device tree
In-Reply-To: <1494558914-41591-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1494558914-41591-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1494558914-41591-2-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the mdp_* nodes are under an mdp sub-node, their corresponding
platform device does not automatically get its iommu assigned properly.

Fix this by moving the mdp component nodes up a level such that they are
siblings of mdp and all other SoC subsystems.  This also simplifies the
device tree.

Although it fixes iommu assignment issue, it also break compatibility
with old device tree. So, the patch in driver is needed to iterate over
sibling mdp device nodes, not child ones, to keep driver work properly.

Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>

---
 Documentation/devicetree/bindings/media/mediatek-mdp.txt | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-mdp.txt b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
index 4182063..0d03e3a 100644
--- a/Documentation/devicetree/bindings/media/mediatek-mdp.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
@@ -2,7 +2,7 @@
 
 Media Data Path is used for scaling and color space conversion.
 
-Required properties (controller (parent) node):
+Required properties (controller node):
 - compatible: "mediatek,mt8173-mdp"
 - mediatek,vpu: the node of video processor unit, see
   Documentation/devicetree/bindings/media/mediatek-vpu.txt for details.
@@ -32,21 +32,16 @@ Required properties (DMA function blocks, child node):
   for details.
 
 Example:
-mdp {
-	compatible = "mediatek,mt8173-mdp";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	ranges;
-	mediatek,vpu = <&vpu>;
-
 	mdp_rdma0: rdma at 14001000 {
 		compatible = "mediatek,mt8173-mdp-rdma";
+			     "mediatek,mt8173-mdp";
 		reg = <0 0x14001000 0 0x1000>;
 		clocks = <&mmsys CLK_MM_MDP_RDMA0>,
 			 <&mmsys CLK_MM_MUTEX_32K>;
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 		iommus = <&iommu M4U_PORT_MDP_RDMA0>;
 		mediatek,larb = <&larb0>;
+		mediatek,vpu = <&vpu>;
 	};
 
 	mdp_rdma1: rdma at 14002000 {
@@ -106,4 +101,3 @@ mdp {
 		iommus = <&iommu M4U_PORT_MDP_WROT1>;
 		mediatek,larb = <&larb4>;
 	};
-};
-- 
1.9.1
