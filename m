From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Nov 2015 17:19:23 +0800
Subject: [PATCH v2] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <1448528281-11882-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1448528281-11882-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64S88vbPKoRL9LEJwrBMzaScP22HAVeYO81o=v3yRvdyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 26, 2015 at 4:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Remove the fixed dividers from the PLL6 driver to be able to have a
> reusable driver that can be used across several SoCs that share the same
> controller, but don't have the same set of dividers for this clock, and to
> also be reused multiple times in the same SoC, since we're droping the
> clock name.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Hi Jens,
>
> Here is an alternative (untested) patch to deal with the PLL6 issue you're
> experiencing with the H3.
>
> It doesn't rely on parsing clock-output-names that turns out to be pretty
> fragile.
>
> Let me know what you think,
> Maxime
>
> Changes from v1:
>   - Make the pll6 clock the /2 output, and add a multiplier for the
>     non-divided output
>
>  arch/arm/boot/dts/sun6i-a31.dtsi     | 36 ++++++++++++++++++------------------
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 25 +++++++++++++++++--------
>  arch/arm/boot/dts/sun8i-a23.dtsi     |  2 +-
>  arch/arm/boot/dts/sun8i-a33.dtsi     |  4 ++--
>  drivers/clk/sunxi/clk-sunxi.c        | 24 +++++++-----------------
>  5 files changed, 45 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 9c79af0c03b2..d6cb1e467bd5 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -456,9 +456,9 @@ static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
>  }
>
>  /**
> - * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6x2
> - * PLL6x2 rate is calculated as follows
> - * rate = parent_rate * (n + 1) * (k + 1)
> + * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6
> + * PLL6 rate is calculated as follows
> + * rate = parent_rate * (n + 1) * (k + 1) / 2
>   * parent_rate is always 24Mhz
>   */
>
> @@ -467,9 +467,9 @@ static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
>  {
>         u8 div;
>
> -       /* Normalize value to a parent_rate multiple (24M) */
> -       div = *freq / parent_rate;
> -       *freq = parent_rate * div;
> +       /* Normalize value to a parent_rate multiple (24M / 2) */
> +       div = *freq / (parent_rate / 2);
> +       *freq = (parent_rate / 2) * div;

This doesn't work with clk_factors_recalc_rate(). You'd get the wrong
clock rate read back. What you're doing here is no different than the
first incarnation of sun6i PLL6 driver in 92ef67c53ad9 ("clk: sunxi:
Add support for PLL6 on the A31"). The kernel readout of the clock
rate was wrong by a factor of 2.

I mentioned some while back that it may make sense to have a custom
.recalc_rate callback for some factor clocks with non-standard
formulas.

For this particular case you could just add a .post_div field
to factors_clk, and deal with it there.

Regards
ChenYu

>
>         /* we were called to round the frequency, we can now return */
>         if (n == NULL)
> @@ -718,7 +718,6 @@ static const struct factors_data sun6i_a31_pll6_data __initconst = {
>         .enable = 31,
>         .table = &sun6i_a31_pll6_config,
>         .getter = sun6i_a31_get_pll6_factors,
> -       .name = "pll6x2",
>  };
>
>  static const struct factors_data sun5i_a13_ahb_data __initconst = {
> @@ -951,15 +950,6 @@ static const struct divs_data pll6_divs_data __initconst = {
>         }
>  };
>
> -static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
> -       .factors = &sun6i_a31_pll6_data,
> -       .ndivs = 2,
> -       .div = {
> -               { .fixed = 2 }, /* normal output */
> -               { .self = 1 }, /* base factor clock, 2x */
> -       }
> -};
> -
>  /**
>   * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
>   *
> @@ -1101,6 +1091,7 @@ free_clkdata:
>  static const struct of_device_id clk_factors_match[] __initconst = {
>         {.compatible = "allwinner,sun4i-a10-pll1-clk", .data = &sun4i_pll1_data,},
>         {.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
> +       {.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
>         {.compatible = "allwinner,sun8i-a23-pll1-clk", .data = &sun8i_a23_pll1_data,},
>         {.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
>         {.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
> @@ -1122,7 +1113,6 @@ static const struct of_device_id clk_div_match[] __initconst = {
>  static const struct of_device_id clk_divs_match[] __initconst = {
>         {.compatible = "allwinner,sun4i-a10-pll5-clk", .data = &pll5_divs_data,},
>         {.compatible = "allwinner,sun4i-a10-pll6-clk", .data = &pll6_divs_data,},
> -       {.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_divs_data,},
>         {}
>  };
>
> --
> 2.6.3
>
