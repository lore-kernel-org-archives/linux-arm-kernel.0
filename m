From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 30 Oct 2014 10:02:25 +0100
Subject: [PATCH 3/3] ARM: dts: mt8135: Add Reset Controller for MediaTek
 SoC
In-Reply-To: <1414638733-10080-4-git-send-email-flora.fu@mediatek.com>
References: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
 <1414638733-10080-4-git-send-email-flora.fu@mediatek.com>
Message-ID: <1414659745.3069.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, den 30.10.2014, 11:12 +0800 schrieb
flora.fu at mediatek.com:
> From: Flora Fu <flora.fu@mediatek.com>
> 
> Add reset controller to MT8135 board dts.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index 90a56ad..0b1ddc9 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -102,6 +102,28 @@
>  			clock-names = "system-clk", "rtc-clk";
>  		};
>  
> +		infracfg: syscon at 10001000 {
> +			compatible = "mediatek,mt8135-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +		};
> +
> +		pericfg: syscon at 10003000 {
> +			compatible = "mediatek,mt8135-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +		};
> +
> +		infrarst: reset-controller at 10001030 {
> +			#reset-cells = <1>;
> +			compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
> +			mediatek,syscon-reset = <&infracfg 0x30 0x8>;
> +		};
> +
> +		perirst: reset-controller at 10003000 {
> +			#reset-cells = <1>;
> +			compatible = "mediatek,mt8135-pericfg-reset", "mediatek,reset";
> +			mediatek,syscon-reset = <&pericfg 0x00 0x8>;
> +		};
> +

Since the reset controller driver accesses registers solely through the
syscon regmap, I'd prefer to keep with the device tree control graph
concept and make the reset-controller nodes children of the syscon
nodes. I've brought this up before: https://lkml.org/lkml/2014/5/27/422,
and I think this is another case where child node support for syscon
makes sense:

        infracfg: syscon at 10001000 {
                compatible = "mediatek,mt8135-infracfg", "syscon";
                reg = <0 0x10001000 0 0x1000>;
                
                infrarst: reset-controller at 30 {
                        #reset-cells = <1>;
                        compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
                        reg = <0x30 0x8>;
                };
        };

        pericfg: syscon at 10003000 {
                compatible = "mediatek,mt8135-pericfg", "syscon";
                reg = <0 0x10003000 0 0x1000>;

                perirst: reset-controller at 00 {                                                                                               
                        #reset-cells = <1>;
                        compatible = "mediatek,mt8135-pericfg-reset", "mediatek,reset";
                        reg = <0x00 0x8>;
                };
        };

regards
Philipp
