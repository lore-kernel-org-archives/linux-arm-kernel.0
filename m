From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Aug 2016 17:44:27 +0200
Subject: [PATCH v4 9/9] arm64: dts: mediatek: Add Video Decoder for MT8173
In-Reply-To: <1470840534-4788-10-git-send-email-tiffany.lin@mediatek.com>
References: <1470840534-4788-1-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-2-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-3-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-4-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-5-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-6-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-7-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-8-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-9-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-10-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <de51caf8-6db5-4754-0683-d3390dd2ac09@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/16 16:48, Tiffany Lin wrote:
> Add video decoder node for MT8173
>
> Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 10f638f..2872cd7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -974,6 +974,50 @@
>  			#clock-cells = <1>;
>  		};
>
> +		vcodec_dec: vcodec at 16000000 {
> +			compatible = "mediatek,mt8173-vcodec-dec";
> +			reg = <0 0x16000000 0 0x100>,	/* VDEC_SYS */
> +			      <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
> +			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
> +			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
> +			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
> +			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
> +			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
> +			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
> +			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
> +			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
> +			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
> +			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
> +			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
> +			mediatek,larb = <&larb1>;
> +			iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
> +				 <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
> +				 <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
> +				 <&iommu M4U_PORT_HW_VDEC_PRED_RD_EXT>,
> +				 <&iommu M4U_PORT_HW_VDEC_PRED_WR_EXT>,
> +				 <&iommu M4U_PORT_HW_VDEC_UFO_EXT>,
> +				 <&iommu M4U_PORT_HW_VDEC_VLD_EXT>,
> +				 <&iommu M4U_PORT_HW_VDEC_VLD2_EXT>;
> +			mediatek,vpu = <&vpu>;
> +			power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> +			clocks = <&apmixedsys CLK_APMIXED_VCODECPLL>,
> +				 <&topckgen CLK_TOP_UNIVPLL_D2>,
> +				 <&topckgen CLK_TOP_CCI400_SEL>,
> +				 <&topckgen CLK_TOP_VDEC_SEL>,
> +				 <&topckgen CLK_TOP_VCODECPLL>,
> +				 <&apmixedsys CLK_APMIXED_VENCPLL>,
> +				 <&topckgen CLK_TOP_VENC_LT_SEL>,
> +				 <&topckgen CLK_TOP_VCODECPLL_370P5>;
> +			clock-names = "vcodecpll",
> +				      "univpll_d2",
> +				      "clk_cci400_sel",
> +				      "vdec_sel",
> +				      "vdecpll",
> +				      "vencpll",
> +				      "venc_lt_sel",
> +				      "vdec_bus_clk_src";
> +		};
> +

Shouldn't we set here:
status = "disabled";

To save power on headless systems?

Regards,
Matthias

>  		larb1: larb at 16010000 {
>  			compatible = "mediatek,mt8173-smi-larb";
>  			reg = <0 0x16010000 0 0x1000>;
>
