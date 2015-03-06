From: yong.wu@mediatek.com (yong.wu at mediatek.com)
Date: Fri, 6 Mar 2015 18:48:19 +0800
Subject: [PATCH 4/5] dt-bindings: iommu: Add binding for mediatek IOMMU
In-Reply-To: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1425638900-24989-5-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Wu <yong.wu@mediatek.com>

This patch add mediatek iommu dts binding document.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
new file mode 100644
index 0000000..db01c92
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -0,0 +1,41 @@
+/******************************************************/
+/*    Mediatek IOMMU Hardware block diagram           */
+/******************************************************/
+              EMI (External Memory Interface)
+               |
+              m4u (Multimedia Memory Management Unit)
+               |
+              smi (Smart Multimedia Interface)
+               |
+        +---------------+-------
+        |               |
+        |               |
+    vdec larb       disp larb      ... SoCs have different local arbiter(larb).
+        |               |
+        |               |
+   +----+----+    +-----+-----+
+   |    |    |    |     |     |    ...
+   |    |    |    |     |     |    ...
+   |    |    |    |     |     |    ...
+  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
+
+Required properties:
+- compatible : must be "mediatek,mt8173-iommu"
+- reg : m4u register base
+- interrupts : must contain the interrupts from each internal translation unit
+- clocks : must contain one entry for each clock-name
+- clock-name: m4u clock
+- larb : must contain the larbes of current platform
+- iommu-cells : must be 1. Specifies the client PortID as defined in
+dt-binding/iommu/mt**-iommu-port.h
+
+Example:
+		iommu: mmsys_iommu at 10205000 {
+			compatible = "mediatek,mt8173-iommu";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infrasys INFRA_M4U>;
+			clock-names = "infra_m4u";
+			larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+			#iommu-cells = <1>;
+		};
\ No newline at end of file
-- 
1.8.1.1.dirty
