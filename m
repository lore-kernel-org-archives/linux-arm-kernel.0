From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 17 Feb 2016 08:46:10 +0800
Subject: [PATCH v9 1/5] dt-bindings: iommu: Add binding for mediatek IOMMU
In-Reply-To: <1455669974-1527-1-git-send-email-yong.wu@mediatek.com>
References: <1455669974-1527-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1455669974-1527-2-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add mediatek iommu dts binding document.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
new file mode 100644
index 0000000..cd1b1cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -0,0 +1,68 @@
+* Mediatek IOMMU Architecture Implementation
+
+  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U) which
+uses the ARM Short-Descriptor translation table format for address translation.
+
+  About the M4U Hardware Block Diagram, please check below:
+
+              EMI (External Memory Interface)
+               |
+              m4u (Multimedia Memory Management Unit)
+               |
+           SMI Common(Smart Multimedia Interface Common)
+               |
+       +----------------+-------
+       |                |
+       |                |
+   SMI larb0        SMI larb1   ... SoCs have several SMI local arbiter(larb).
+   (display)         (vdec)
+       |                |
+       |                |
+ +-----+-----+     +----+----+
+ |     |     |     |    |    |
+ |     |     |...  |    |    |  ... There are different ports in each larb.
+ |     |     |     |    |    |
+OVL0 RDMA0 WDMA0  MC   PP   VLD
+
+  As above, The Multimedia HW will go through SMI and M4U while it
+access EMI. SMI is a bridge between m4u and the Multimedia HW. It contain
+smi local arbiter and smi common. It will control whether the Multimedia
+HW should go though the m4u for translation or bypass it and talk
+directly with EMI. And also SMI help control the power domain and clocks for
+each local arbiter.
+  Normally we specify a local arbiter(larb) for each multimedia HW
+like display, video decode, and camera. And there are different ports
+in each larb. Take a example, There are many ports like MC, PP, VLD in the
+video decode local arbiter, all these ports are according to the video HW.
+
+Required properties:
+- compatible : must be "mediatek,mt8173-m4u".
+- reg : m4u register base and size.
+- interrupts : the interrupt of m4u.
+- clocks : must contain one entry for each clock-names.
+- clock-names : must be "bclk", It is the block clock of m4u.
+- mediatek,larbs : List of phandle to the local arbiters in the current Socs.
+	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
+	according to the local arbiter index, like larb0, larb1, larb2...
+- iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
+	Specifies the mtk_m4u_id as defined in
+	dt-binding/memory/mt8173-larb-port.h.
+
+Example:
+	iommu: iommu at 10205000 {
+		compatible = "mediatek,mt8173-m4u";
+		reg = <0 0x10205000 0 0x1000>;
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larbs = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+		#iommu-cells = <1>;
+	};
+
+Example for a client device:
+	display {
+		compatible = "mediatek,mt8173-disp";
+		iommus = <&iommu M4U_PORT_DISP_OVL0>,
+			 <&iommu M4U_PORT_DISP_RDMA0>;
+		...
+	};
-- 
1.8.1.1.dirty
