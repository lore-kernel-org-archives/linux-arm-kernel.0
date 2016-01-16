From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Jan 2016 01:06:07 +0800
Subject: [PATCH v2 10/26] ARM: sun5i: a13: Add display and TCON clocks
In-Reply-To: <1452785109-6172-11-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-11-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67fqMUQsG-+zVxfgE3UzY7uyomBkwxgNHeXbqA1pwM8pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 14, 2016 at 11:24 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Enable the display and TCON (channel 0 and channel 1) clocks that are going
> to be needed to drive the display engine, tcon and TV encoders.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun5i-a13.dtsi | 38 +++++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/sun5i-r8.dtsi  |  5 +++--
>  2 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index d910d3a6c41c..9669b03f20f3 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -61,7 +61,8 @@
>                         compatible = "allwinner,simple-framebuffer",
>                                      "simple-framebuffer";
>                         allwinner,pipeline = "de_be0-lcd0";
> -                       clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
> +                       clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&de_be_clk>,
> +                                <&tcon_ch0_clk>;
>                         status = "disabled";
>                 };
>         };
> @@ -149,6 +150,41 @@
>                                              "apb1_i2c2", "apb1_uart1",
>                                              "apb1_uart3";
>                 };
> +
> +               de_be_clk: clk at 01c20104 {
> +                       #clock-cells = <0>;
> +                       #reset-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-display-clk";
> +                       reg = <0x01c20104 0x4>;
> +                       clocks = <&pll3>, <&pll7>, <&pll5 1>;
> +                       clock-output-names = "de-be";
> +               };
> +
> +               de_fe_clk: clk at 01c2010c {
> +                       #clock-cells = <0>;
> +                       #reset-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-display-clk";
> +                       reg = <0x01c2010c 0x4>;
> +                       clocks = <&pll3>, <&pll7>, <&pll5 1>;
> +                       clock-output-names = "de-fe";
> +               };
> +
> +               tcon_ch0_clk: clk at 01c20118 {
> +                       #clock-cells = <0>;
> +                       #reset-cells = <1>;

You got it right here...

> +                       compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
> +                       reg = <0x01c20118 0x4>;
> +                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> +                       clock-output-names = "tcon-ch0-sclk";
> +               };
> +
> +               tcon_ch1_clk: clk at 01c2012c {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> +                       reg = <0x01c2012c 0x4>;
> +                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> +                       clock-output-names = "tcon-ch1-sclk";
> +               };

I suggest moving these to sun5i.dtsi, as they are shared amongst them.

ChenYu

>         };
>
>         soc at 01c00000 {
> diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
> index 0ef865601ac9..b1e4e0170d51 100644
> --- a/arch/arm/boot/dts/sun5i-r8.dtsi
> +++ b/arch/arm/boot/dts/sun5i-r8.dtsi
> @@ -51,8 +51,9 @@
>                         compatible = "allwinner,simple-framebuffer",
>                                      "simple-framebuffer";
>                         allwinner,pipeline = "de_be0-lcd0-tve0";
> -                       clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
> -                                <&ahb_gates 44>;
> +                       clocks = <&ahb_gates 34>, <&ahb_gates 36>,
> +                                <&ahb_gates 44>, <&de_be_clk>,
> +                                <&tcon_ch1_clk>;
>                         status = "disabled";
>                 };
>         };
> --
> 2.6.4
>
