From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Thu, 4 Feb 2016 19:34:59 +0800
Subject: [PATCH v4 4/8] dt-bindings: Add a binding for Mediatek Video Encoder
In-Reply-To: <1454585703-42428-4-git-send-email-tiffany.lin@mediatek.com>
References: <1454585703-42428-1-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-2-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-3-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-4-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1454585703-42428-5-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT binding documentation of Video Encoder for the
MT8173 SoC from Mediatek.

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 .../devicetree/bindings/media/mediatek-vcodec.txt  |   59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-vcodec.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
new file mode 100644
index 0000000..572bfdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -0,0 +1,59 @@
+Mediatek Video Codec
+
+Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
+supports high resolution encoding functionalities.
+
+Required properties:
+- compatible : "mediatek,mt8173-vcodec-enc" for encoder
+- reg : Physical base address of the video codec registers and length of
+  memory mapped region.
+- interrupts : interrupt number to the cpu.
+- mediatek,larb : must contain the local arbiters in the current Socs.
+- clocks : list of clock specifiers, corresponding to entries in
+  the clock-names property.
+- clock-names: encoder must contain "vencpll_d2", "venc_sel", "univpll1_d2",
+  "venc_lt_sel".
+- iommus : should point to the respective IOMMU block with master port as
+  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+  for details.
+- mediatek,vpu : the node of video processor unit
+
+Example:
+vcodec_enc: vcodec at 0x18002000 {
+    compatible = "mediatek,mt8173-vcodec-enc";
+    reg = <0 0x18002000 0 0x1000>,    /*VENC_SYS*/
+          <0 0x19002000 0 0x1000>;    /*VENC_LT_SYS*/
+    interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
+           <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
+    mediatek,larb = <&larb3>,
+		    <&larb5>;
+    iommus = <&iommu M4U_PORT_VENC_RCPU>,
+             <&iommu M4U_PORT_VENC_REC>,
+             <&iommu M4U_PORT_VENC_BSDMA>,
+             <&iommu M4U_PORT_VENC_SV_COMV>,
+             <&iommu M4U_PORT_VENC_RD_COMV>,
+             <&iommu M4U_PORT_VENC_CUR_LUMA>,
+             <&iommu M4U_PORT_VENC_CUR_CHROMA>,
+             <&iommu M4U_PORT_VENC_REF_LUMA>,
+             <&iommu M4U_PORT_VENC_REF_CHROMA>,
+             <&iommu M4U_PORT_VENC_NBM_RDMA>,
+             <&iommu M4U_PORT_VENC_NBM_WDMA>,
+             <&iommu M4U_PORT_VENC_RCPU_SET2>,
+             <&iommu M4U_PORT_VENC_REC_FRM_SET2>,
+             <&iommu M4U_PORT_VENC_BSDMA_SET2>,
+             <&iommu M4U_PORT_VENC_SV_COMA_SET2>,
+             <&iommu M4U_PORT_VENC_RD_COMA_SET2>,
+             <&iommu M4U_PORT_VENC_CUR_LUMA_SET2>,
+             <&iommu M4U_PORT_VENC_CUR_CHROMA_SET2>,
+             <&iommu M4U_PORT_VENC_REF_LUMA_SET2>,
+             <&iommu M4U_PORT_VENC_REC_CHROMA_SET2>;
+    mediatek,vpu = <&vpu>;
+    clocks = <&topckgen CLK_TOP_VENCPLL_D2>,
+             <&topckgen CLK_TOP_VENC_SEL>,
+             <&topckgen CLK_TOP_UNIVPLL1_D2>,
+             <&topckgen CLK_TOP_VENC_LT_SEL>;
+    clock-names = "vencpll_d2",
+                  "venc_sel",
+                  "univpll1_d2",
+                  "venc_lt_sel";
+  };
-- 
1.7.9.5
