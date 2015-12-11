From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Fri, 11 Dec 2015 17:55:40 +0800
Subject: [PATCH v2 5/8] arm64: dts: mediatek: Add Video Encoder for MT8173
In-Reply-To: <1449827743-22895-1-git-send-email-tiffany.lin@mediatek.com>
References: <1449827743-22895-1-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1449827743-22895-6-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add video encoder node for MT8173

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index b8c8ff0..a6b0fcf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -545,6 +545,53 @@
 			#clock-cells = <1>;
 		};
 
+		larb3: larb at 18001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x18001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
+			clocks = <&vencsys CLK_VENC_CKE1>,
+				 <&vencsys CLK_VENC_CKE0>;
+			clock-names = "apb", "smi";
+		};
+
+		vcodec_enc: vcodec at 18002000 {
+			compatible = "mediatek,mt8173-vcodec-enc";
+			reg = <0 0x18002000 0 0x1000>,	/* VENC_SYS */
+			      <0 0x19002000 0 0x1000>;	/* VENC_LT_SYS */
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
+			larb = <&larb3>,
+			       <&larb5>;
+			iommus = <&iommu M4U_LARB3_ID M4U_PORT_VENC_RCPU>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_REC>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_BSDMA>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_SV_COMV>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_RD_COMV>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_CUR_LUMA>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_CUR_CHROMA>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_REF_LUMA>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_REF_CHROMA>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_NBM_RDMA>,
+				 <&iommu M4U_LARB3_ID M4U_PORT_VENC_NBM_WDMA>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_RCPU_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_REC_FRM_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_BSDMA_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_SV_COMA_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_RD_COMA_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_CUR_LUMA_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_CUR_CHROMA_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_REF_LUMA_SET2>,
+				 <&iommu M4U_LARB5_ID M4U_PORT_VENC_REC_CHROMA_SET2>;
+			vpu = <&vpu>;
+			clocks = <&apmixedsys CLK_APMIXED_VENCPLL>,
+				 <&topckgen CLK_TOP_VENC_LT_SEL>,
+				 <&topckgen CLK_TOP_VCODECPLL_370P5>;
+			clock-names = "vencpll",
+				      "venc_lt_sel",
+				      "vcodecpll_370p5_ck";
+		};
+
 		vencltsys: clock-controller at 19000000 {
 			compatible = "mediatek,mt8173-vencltsys", "syscon";
 			reg = <0 0x19000000 0 0x1000>;
-- 
1.7.9.5
