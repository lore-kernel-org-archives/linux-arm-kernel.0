From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 17:47:10 +0200
Subject: [PATCH 3/5] arm: dts: mt7623: add iommu/smi device nodes
In-Reply-To: <2d9d216adb779bac6f5515b39cfeaed8b4b61878.1536141302.git.ryder.lee@mediatek.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
 <2d9d216adb779bac6f5515b39cfeaed8b4b61878.1536141302.git.ryder.lee@mediatek.com>
Message-ID: <de407ddd-d423-288b-02d1-5b75381b6417@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/09/2018 12:22, Ryder Lee wrote:
> Add iommu/smi device nodes for MT7623.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to v4.19-next/dts32

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 59 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index b7ccf8b..a46987b 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <dt-bindings/reset/mt2701-resets.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
> @@ -286,6 +287,17 @@
>  		clock-names = "system-clk", "rtc-clk";
>  	};
>  
> +	smi_common: smi at 1000c000 {
> +		compatible = "mediatek,mt7623-smi-common",
> +			     "mediatek,mt2701-smi-common";
> +		reg = <0 0x1000c000 0 0x1000>;
> +		clocks = <&infracfg CLK_INFRA_SMI>,
> +			 <&mmsys CLK_MM_SMI_COMMON>,
> +			 <&infracfg CLK_INFRA_SMI>;
> +		clock-names = "apb", "smi", "async";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};
> +
>  	pwrap: pwrap at 1000d000 {
>  		compatible = "mediatek,mt7623-pwrap",
>  			     "mediatek,mt2701-pwrap";
> @@ -317,6 +329,17 @@
>  		reg = <0 0x10200100 0 0x1c>;
>  	};
>  
> +	iommu: mmsys_iommu at 10205000 {
> +		compatible = "mediatek,mt7623-m4u",
> +			     "mediatek,mt2701-m4u";
> +		reg = <0 0x10205000 0 0x1000>;
> +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_INFRA_M4U>;
> +		clock-names = "bclk";
> +		mediatek,larbs = <&larb0 &larb1 &larb2>;
> +		#iommu-cells = <1>;
> +	};
> +
>  	efuse: efuse at 10206000 {
>  		compatible = "mediatek,mt7623-efuse",
>  			     "mediatek,mt8173-efuse";
> @@ -709,6 +732,18 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	larb0: larb at 14010000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x14010000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <0>;
> +		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> +			 <&mmsys CLK_MM_SMI_LARB0>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};
> +
>  	imgsys: syscon at 15000000 {
>  		compatible = "mediatek,mt7623-imgsys",
>  			     "mediatek,mt2701-imgsys",
> @@ -717,6 +752,18 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	larb2: larb at 15001000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x15001000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <2>;
> +		clocks = <&imgsys CLK_IMG_SMI_COMM>,
> +			 <&imgsys CLK_IMG_SMI_COMM>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +	};
> +
>  	vdecsys: syscon at 16000000 {
>  		compatible = "mediatek,mt7623-vdecsys",
>  			     "mediatek,mt2701-vdecsys",
> @@ -725,6 +772,18 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	larb1: larb at 16010000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x16010000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <1>;
> +		clocks = <&vdecsys CLK_VDEC_CKGEN>,
> +			 <&vdecsys CLK_VDEC_LARB>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
> +	};
> +
>  	hifsys: syscon at 1a000000 {
>  		compatible = "mediatek,mt7623-hifsys",
>  			     "mediatek,mt2701-hifsys",
> 
