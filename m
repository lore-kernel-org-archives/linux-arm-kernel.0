From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 7 Jan 2015 17:25:41 +0100
Subject: [PATCH v3 4/4] dts: mediatek: Enable clock support for Mediatek
 MT8135.
In-Reply-To: <1420601123-25859-5-git-send-email-jamesjj.liao@mediatek.com>
References: <1420601123-25859-1-git-send-email-jamesjj.liao@mediatek.com>
 <1420601123-25859-5-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <CABuKBeL34hV63t+zDy3Nbz_V4qAvCF87+=hV=eUUCTrKybBFjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-07 4:25 GMT+01:00 James Liao <jamesjj.liao@mediatek.com>:
> This patch adds MT8135 clock controllers into device tree.
>
> Change-Id: I9c5bab9289bbd6eb444aad97d015b8f26ca88a8a
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 47 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index ec83e69..09fcf0d 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -12,6 +12,7 @@
>   * GNU General Public License for more details.
>   */
>
> +#include <dt-bindings/clock/mt8135-clk.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include "skeleton64.dtsi"
> @@ -92,6 +93,24 @@
>                         clock-frequency = <26000000>;
>                         #clock-cells = <0>;
>                 };
> +
> +               clk_null: clk_null {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <0>;
> +               };
> +
> +               clk26m: clk26m {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <26000000>;
> +               };
> +
> +               rtc32k: rtc32k {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <32000>;
> +               };

Why do you add this clocks here?
This clocks are not represented by the clock tree? If so, what are the
consumers of this clocks?

>         };
>
>         soc {
> @@ -100,6 +119,28 @@
>                 compatible = "simple-bus";
>                 ranges;
>
> +               topckgen: topckgen at 10000000 {
> +                       compatible = "mediatek,mt8135-topckgen";
> +                       reg = <0 0x10000000 0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               infracfg: syscon at 10001000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "mediatek,mt8135-infracfg", "syscon";
> +                       reg = <0 0x10001000 0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               pericfg: syscon at 10003000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "mediatek,mt8135-pericfg", "syscon";
> +                       reg = <0 0x10003000 0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
>                 timer: timer at 10008000 {
>                         compatible = "mediatek,mt8135-timer",
>                                         "mediatek,mt6577-timer";
> @@ -128,6 +169,12 @@
>                               <0 0x10216000 0 0x2000>;
>                 };
>
> +               apmixedsys: apmixedsys at 10209000 {
> +                       compatible = "mediatek,mt8135-apmixedsys";
> +                       reg = <0 0x10209000 0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
>                 uart0: serial at 11006000 {
>                         compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
>                         reg = <0 0x11006000 0 0x400>;
> --
> 1.8.1.1.dirty
>



-- 
motzblog.wordpress.com
