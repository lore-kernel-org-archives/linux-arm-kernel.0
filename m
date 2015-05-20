From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 20 May 2015 16:44:20 +0800
Subject: [PATCH 1/3] ARM64: dts: mt8173: Add clock controller device nodes
In-Reply-To: <1432032824-7955-2-git-send-email-s.hauer@pengutronix.de>
References: <1432032824-7955-1-git-send-email-s.hauer@pengutronix.de>
 <1432032824-7955-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAGS+omA_XnUPm_838jLmK4w7HCQVhNZ20HaXoaskWjpTcQ8CAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 6:53 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds the device nodes providing clocks on the Mediatek MT8173.
> These are: topckgen, infracfg, pericfg and apmixedsys. These are
> fed by two oscillators also added by this patch.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 41 ++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 924fdb6..30ac8dd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include "mt8173-pinfunc.h"
> +#include <dt-bindings/clock/mt8173-clk.h>

nit: alphabetize headers

With that fixed, this one is:
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

>
>  / {
>         compatible = "mediatek,mt8173";
> @@ -87,6 +88,20 @@
>                 #clock-cells = <0>;
>         };
>
> +       clk26m: oscillator at 0 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <26000000>;
> +               clock-output-names = "clk26m";
> +       };
> +
> +       clk32k: oscillator at 1 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32000>;
> +               clock-output-names = "clk32k";
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupt-parent = <&gic>;
> @@ -106,6 +121,26 @@
>                 compatible = "simple-bus";
>                 ranges;
>
> +               topckgen: clock-controller at 10000000 {
> +                       compatible = "mediatek,mt8173-topckgen";
> +                       reg = <0 0x10000000 0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               infracfg: power-controller at 10001000 {
> +                       compatible = "mediatek,mt8173-infracfg", "syscon";
> +                       reg = <0 0x10001000 0 0x1000>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
> +               pericfg: power-controller at 10003000 {
> +                       compatible = "mediatek,mt8173-pericfg", "syscon";
> +                       reg = <0 0x10003000 0 0x1000>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
>                 syscfg_pctl_a: syscfg_pctl_a at 10005000 {
>                         compatible = "mediatek,mt8173-pctl-a-syscfg", "syscon";
>                         reg = <0 0x10005000 0 0x1000>;
> @@ -134,6 +169,12 @@
>                         reg = <0 0x10200620 0 0x20>;
>                 };
>
> +               apmixedsys: clock-controller at 10209000 {
> +                       compatible = "mediatek,mt8173-apmixedsys";
> +                       reg = <0 0x10209000 0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
>                 gic: interrupt-controller at 10220000 {
>                         compatible = "arm,gic-400";
>                         #interrupt-cells = <3>;
> --
> 2.1.4
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
