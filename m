From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Mar 2017 11:35:39 +0800
Subject: [linux-sunxi] [PATCH 14/15] ARM: sun5i: a10s: Add the HDMI
 controller node
In-Reply-To: <61406c0ba992f2fa5b5180b790a1ef3fa38d9567.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <61406c0ba992f2fa5b5180b790a1ef3fa38d9567.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64KKp0cYB3u0=bSVcq0gB41LkurCeiTJ3OEzn7UjdSPpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 7, 2017 at 4:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A10s has an HDMI controller connected to the second TCON channel. Add
> it to our DT.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 34 ++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/sun5i.dtsi      |  1 +-
>  2 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> index 074485782a4a..3482c9d2b120 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -72,7 +72,33 @@
>                 };
>         };
>
> +       display-engine {
> +               compatible = "allwinner,sun5i-a10s-display-engine",
> +                            "allwinner,sun5i-a13-display-engine";
> +               allwinner,pipelines = <&fe0>;
> +       };
> +
>         soc at 01c00000 {
> +               hdmi0: hdmi at 01c16000 {

Nit: is the 0 suffix needed? I don't see any indication that there is
a second controller.

> +                       compatible = "allwinner,sun5i-a10s-hdmi";
> +                       reg = <0x01c16000 0x1000>;
> +                       clocks = <&ccu CLK_AHB_HDMI>, <&ccu CLK_HDMI>,
> +                                <&ccu CLK_PLL_VIDEO0_2X>,
> +                                <&ccu CLK_PLL_VIDEO1_2X>;
> +                       clock-names = "ahb", "mod", "pll-0", "pll-1";
> +                       status = "disabled";
> +
> +                       port {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               hdmi0_in_tcon0: endpoint at 0 {
> +                                       reg = <0>;
> +                                       remote-endpoint = <&tcon0_out_hdmi0>;
> +                               };
> +                       };
> +               };
> +
>                 pwm: pwm at 01c20e00 {
>                         compatible = "allwinner,sun5i-a10s-pwm";
>                         reg = <0x01c20e00 0xc>;
> @@ -129,3 +155,11 @@
>
>  &sram_a {
>  };
> +
> +&tcon0_out {
> +       tcon0_out_hdmi0: endpoint at 2 {
> +               reg = <2>;
> +               remote-endpoint = <&hdmi0_in_tcon0>;
> +               allwinner,tcon-channel = <1>;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index f3b6e19244f9..3d009b2aa42a 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -273,6 +273,7 @@
>                                         tcon0_out_tve0: endpoint at 1 {
>                                                 reg = <1>;
>                                                 remote-endpoint = <&tve0_in_tcon0>;
> +                                               allwinner,tcon-channel = <1>;

This looks like a separate patch, probably following the binding change?

Regards
ChenYu

>                                         };
>                                 };
>                         };
> --
> git-series 0.8.11
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
