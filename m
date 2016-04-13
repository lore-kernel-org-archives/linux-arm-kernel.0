From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Wed, 13 Apr 2016 20:01:50 +0800
Subject: [PATCH 2/7] dt-bindings: Add a binding for Mediatek Video Decoder
In-Reply-To: <1460548915-17536-2-git-send-email-tiffany.lin@mediatek.com>
References: <1460548915-17536-1-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-2-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1460548915-17536-3-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT binding documentation of Video Decoder for the
MT8173 SoC from Mediatek.

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 .../devicetree/bindings/media/mediatek-vcodec.txt  |   50 ++++++++++++++++++--
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 59a47a5..9aa8848 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -1,25 +1,67 @@
 Mediatek Video Codec
 
 Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
-supports high resolution encoding functionalities.
+supports high resolution encoding and decoding functionalities.
 
 Required properties:
 - compatible : "mediatek,mt8173-vcodec-enc" for encoder
+  "mediatek,mt8173-vcodec-dec" for decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
 - mediatek,larb : must contain the local arbiters in the current Socs.
 - clocks : list of clock specifiers, corresponding to entries in
   the clock-names property.
-- clock-names: encoder must contain "venc_sel_src", "venc_sel",
-- "venc_lt_sel_src", "venc_lt_sel".
+- clock-names: encoder must contain "venc_sel_src", "venc_sel",,
+  "venc_lt_sel_src", "venc_lt_sel", decoder must contain "vcodecpll",
+  "univpll_d2", "clk_cci400_sel", "vdec_sel", "vdecpll".
 - iommus : should point to the respective IOMMU block with master port as
   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
   for details.
 - mediatek,vpu : the node of video processor unit
 
+
 Example:
-vcodec_enc: vcodec at 0x18002000 {
+
+vcodec_dec: vcodec at 16000000 {
+    compatible = "mediatek,mt8173-vcodec-dec";
+    reg = <0 0x16000000 0 0x100>,   /*VDEC_SYS*/
+          <0 0x16020000 0 0x1000>,  /*VDEC_MISC*/
+          <0 0x16021000 0 0x800>,   /*VDEC_LD*/
+          <0 0x16021800 0 0x800>,   /*VDEC_TOP*/
+          <0 0x16022000 0 0x1000>,  /*VDEC_CM*/
+          <0 0x16023000 0 0x1000>,  /*VDEC_AD*/
+          <0 0x16024000 0 0x1000>,  /*VDEC_AV*/
+          <0 0x16025000 0 0x1000>,  /*VDEC_PP*/
+          <0 0x16026800 0 0x800>,   /*VP8_VD*/
+          <0 0x16027000 0 0x800>,   /*VP6_VD*/
+          <0 0x16027800 0 0x800>,   /*VP8_VL*/
+          <0 0x16028400 0 0x400>;   /*VP9_VD*/
+    interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
+    mediatek,larb = <&larb1>;
+    iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
+             <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
+             <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
+             <&iommu M4U_PORT_HW_VDEC_PRED_RD_EXT>,
+             <&iommu M4U_PORT_HW_VDEC_PRED_WR_EXT>,
+             <&iommu M4U_PORT_HW_VDEC_UFO_EXT>,
+             <&iommu M4U_PORT_HW_VDEC_VLD_EXT>,
+             <&iommu M4U_PORT_HW_VDEC_VLD2_EXT>;
+    mediatek,vpu = <&vpu>;
+    power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+    clocks = <&apmixedsys CLK_APMIXED_VCODECPLL>,
+             <&topckgen CLK_TOP_UNIVPLL_D2>,
+             <&topckgen CLK_TOP_CCI400_SEL>,  
+             <&topckgen CLK_TOP_VDEC_SEL>,
+             <&topckgen CLK_TOP_VCODECPLL>;
+    clock-names = "vcodecpll",
+                  "univpll_d2",
+                  "clk_cci400_sel",   
+                  "vdec_sel",  
+                  "vdecpll";
+  };
+
+  vcodec_enc: vcodec at 0x18002000 {
     compatible = "mediatek,mt8173-vcodec-enc";
     reg = <0 0x18002000 0 0x1000>,    /*VENC_SYS*/
           <0 0x19002000 0 0x1000>;    /*VENC_LT_SYS*/
-- 
1.7.9.5
