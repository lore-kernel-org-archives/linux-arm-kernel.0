From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 17:12:07 +0800
Subject: [PATCH 1/8] clk: sunxi: factors: Add m_start parameters
In-Reply-To: <1430565879-28113-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
 <1430565879-28113-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v669fsz_pA+B0r8efp0BMxY-D86qfLuGQCqK1POuu9PmxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 2, 2015 at 7:24 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some clocks start incrementing the m factor at 0. Add a parameter to handle
> it just like we did for the N factor.
>
> Since the behaviour until now was to assume that the m factor was starting
> at 1, we also need to fix the other users.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/clk-factors.c    | 11 ++++++++++-
>  drivers/clk/sunxi/clk-factors.h    |  2 ++
>  drivers/clk/sunxi/clk-mod0.c       |  2 ++
>  drivers/clk/sunxi/clk-sun8i-mbus.c |  2 ++
>  drivers/clk/sunxi/clk-sun9i-core.c |  6 ++++++
>  drivers/clk/sunxi/clk-sunxi.c      | 10 ++++++++++
>  6 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> index 8c20190a3e9f..100a711c3e3d 100644
> --- a/drivers/clk/sunxi/clk-factors.c
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -56,15 +56,24 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>         /* Get each individual factor if applicable */
>         if (config->nwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>                 n = FACTOR_GET(config->nshift, config->nwidth, reg);
> +
>         if (config->kwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>                 k = FACTOR_GET(config->kshift, config->kwidth, reg);
> +
>         if (config->mwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>                 m = FACTOR_GET(config->mshift, config->mwidth, reg);
> +       else
> +               /* Make sure we don't get a division by zero */
> +               m = 1;

What happens when mwidth is valid, m_start = 0, and m = 0?

Other than that, this one looks good.

ChenYu

> +
>         if (config->pwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>                 p = FACTOR_GET(config->pshift, config->pwidth, reg);
>
>         /* Calculate the rate */
> -       rate = (parent_rate * (n + config->n_start) * (k + 1) >> p) / (m + 1);
> +       rate = parent_rate * (n + config->n_start);
> +       rate *= k + 1;
> +       rate >>= p;
> +       rate /= m + config->m_start;
>
>         return rate;
>  }
> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
> index 171085ab5513..735d756d2923 100644
> --- a/drivers/clk/sunxi/clk-factors.h
> +++ b/drivers/clk/sunxi/clk-factors.h
> @@ -16,6 +16,8 @@ struct clk_factors_config {
>         u8 mwidth;
>         u8 pshift;
>         u8 pwidth;
> +
> +       u8 m_start;
>         u8 n_start;
>  };
>
> diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
> index ec8f5a1fca09..eefa9be4078b 100644
> --- a/drivers/clk/sunxi/clk-mod0.c
> +++ b/drivers/clk/sunxi/clk-mod0.c
> @@ -66,6 +66,8 @@ static struct clk_factors_config sun4i_a10_mod0_config = {
>         .mwidth = 4,
>         .pshift = 16,
>         .pwidth = 2,
> +
> +       .m_start = 1,
>  };
>
>  static const struct factors_data sun4i_a10_mod0_data = {
> diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
> index 14cd026064bf..66fbf14a0f8a 100644
> --- a/drivers/clk/sunxi/clk-sun8i-mbus.c
> +++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
> @@ -55,6 +55,8 @@ static void sun8i_a23_get_mbus_factors(u32 *freq, u32 parent_rate,
>  static struct clk_factors_config sun8i_a23_mbus_config = {
>         .mshift = 0,
>         .mwidth = 3,
> +
> +       .m_start = 1,
>  };
>
>  static const struct factors_data sun8i_a23_mbus_data __initconst = {
> diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
> index d8da77d72861..97e87ca4a8fc 100644
> --- a/drivers/clk/sunxi/clk-sun9i-core.c
> +++ b/drivers/clk/sunxi/clk-sun9i-core.c
> @@ -78,6 +78,8 @@ static struct clk_factors_config sun9i_a80_pll4_config = {
>         .nwidth = 8,
>         .pshift = 16,
>         .pwidth = 1,
> +
> +       .m_start = 1,
>  };
>
>  static const struct factors_data sun9i_a80_pll4_data __initconst = {
> @@ -137,6 +139,8 @@ static void sun9i_a80_get_gt_factors(u32 *freq, u32 parent_rate,
>  static struct clk_factors_config sun9i_a80_gt_config = {
>         .mshift = 0,
>         .mwidth = 2,
> +
> +       .m_start = 1,
>  };
>
>  static const struct factors_data sun9i_a80_gt_data __initconst = {
> @@ -294,6 +298,8 @@ static struct clk_factors_config sun9i_a80_apb1_config = {
>         .mwidth = 5,
>         .pshift = 16,
>         .pwidth = 2,
> +
> +       .m_start = 1,
>  };
>
>  static const struct factors_data sun9i_a80_apb1_data __initconst = {
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 7e1e2bd189b6..6df869050986 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -616,6 +616,8 @@ static struct clk_factors_config sun4i_pll1_config = {
>         .mwidth = 2,
>         .pshift = 16,
>         .pwidth = 2,
> +
> +       .m_start = 1,
>  };
>
>  static struct clk_factors_config sun6i_a31_pll1_config = {
> @@ -625,6 +627,8 @@ static struct clk_factors_config sun6i_a31_pll1_config = {
>         .kwidth = 2,
>         .mshift = 0,
>         .mwidth = 2,
> +
> +       .m_start = 1,
>         .n_start = 1,
>  };
>
> @@ -637,6 +641,8 @@ static struct clk_factors_config sun8i_a23_pll1_config = {
>         .mwidth = 2,
>         .pshift = 16,
>         .pwidth = 2,
> +
> +       .m_start = 1,
>         .n_start = 1,
>  };
>
> @@ -665,6 +671,8 @@ static struct clk_factors_config sun4i_apb1_config = {
>         .mwidth = 5,
>         .pshift = 16,
>         .pwidth = 2,
> +
> +       .m_start = 1,
>  };
>
>  /* user manual says "n" but it's really "p" */
> @@ -673,6 +681,8 @@ static struct clk_factors_config sun7i_a20_out_config = {
>         .mwidth = 5,
>         .pshift = 20,
>         .pwidth = 2,
> +
> +       .m_start = 1,
>  };
>
>  static const struct factors_data sun4i_pll1_data __initconst = {
> --
> 2.3.6
>
