From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 20 Jan 2015 16:53:59 +0100
Subject: [PATCH v4 5/5] ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for
 mt8135.
In-Reply-To: <1418772873-19747-6-git-send-email-hongzhou.yang@mediatek.com>
References: <1418772873-19747-1-git-send-email-hongzhou.yang@mediatek.com>
 <1418772873-19747-6-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CABuKBe+NxRMM0Yorr4=wi1JyN=ja-1OJV3sKEML5T-cfUpfEvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-17 0:34 GMT+01:00 Hongzhou Yang <hongzhou.yang@mediatek.com>:
> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
>
> Add pinctrl,GPIO and EINT node to mt8135.dtsi.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135-pinfunc.h | 1304 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt8135.dtsi      |   24 +
>  2 files changed, 1328 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt8135-pinfunc.h
>
[...]
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index 90a56ad..38e3469 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include "skeleton64.dtsi"
> +#include "mt8135-pinfunc.h"
>
>  / {
>         compatible = "mediatek,mt8135";
> @@ -94,6 +95,16 @@
>                 compatible = "simple-bus";
>                 ranges;
>
> +               syscfg_pctl_a: syscfg_pctl_a at 10005000 {
> +                       compatible = "mediatek,mt8135-pctl-a-syscfg", "syscon";
> +                       reg = <0 0x10005000 0 0x1000>;
> +               };
> +
> +               syscfg_pctl_b: syscfg_pctl_b at 1020C000 {
> +                       compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
> +                       reg = <0 0x1020C000 0 0x1000>;
> +               };
> +
>                 timer: timer at 10008000 {
>                         compatible = "mediatek,mt8135-timer", "mediatek,mt6577-timer";
>                         reg = <0 0x10008000 0 0x80>;
> @@ -111,5 +122,18 @@
>                               <0 0x10214000 0 0x2000>,
>                               <0 0x10216000 0 0x2000>;
>                 };
> +
> +               pio: pinctrl at 10005000 {
> +                       compatible = "mediatek,mt8135-pinctrl";
> +                       reg = <0 0x1000B000 0 0x1000>;
> +                       mediatek,pctl-regmap = <&syscfg_pctl_a &syscfg_pctl_b>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +                       interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +               };

Please order the nodes taking into account the memory address to which
they are mapped.

Cheers,
Matthias


-- 
motzblog.wordpress.com
