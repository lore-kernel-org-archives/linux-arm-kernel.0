From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 30 Apr 2015 14:38:31 +0800
Subject: [PATCH 2/2] arm64: dts: mt8173: Fixup pinctrl nodes
In-Reply-To: <1430213037-23831-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1430213037-23831-1-git-send-email-yingjoe.chen@mediatek.com>
 <1430213037-23831-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CAGS+omBmhsbVp0t2mPqrod-MkGi185tC0gcHvm0tHg4dHQr0cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 5:23 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> The 8173 pinctrl node doesn't follow dts convention. Fix them.
> Also add a comment to explain pinctrl register usage to make it
> more clear.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Thanks for the fix.

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 8346c0f..e4a30cd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -128,6 +128,7 @@
>                 compatible = "simple-bus";
>                 ranges;
>
> +               /* Provide regmap for pinctrl driver */
>                 syscfg_pctl_a: syscfg_pctl_a at 10005000 {
>                         compatible = "mediatek,mt8173-pctl-a-syscfg", "syscon";
>                         reg = <0 0x10005000 0 0x1000>;
> @@ -159,9 +160,13 @@
>                         #reset-cells = <1>;
>                 };
>
> -               pio: pinctrl at 0x10005000 {
> +               /*
> +                * Pinctrl access register at 0x10005000 through regmap.
> +                * Register 0x1000b000 is used by EINT.
> +                */
> +               pio: pinctrl at 10005000 {
>                         compatible = "mediatek,mt8173-pinctrl";
> -                       reg = <0 0x1000B000 0 0x1000>;
> +                       reg = <0 0x1000b000 0 0x1000>;
>                         mediatek,pctl-regmap = <&syscfg_pctl_a>;
>                         pins-are-numbered;
>                         gpio-controller;
> @@ -169,8 +174,8 @@
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
>                         interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> -                                               <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> -                                               <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +                                    <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
>                 sysirq: intpol-controller at 10200620 {
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
