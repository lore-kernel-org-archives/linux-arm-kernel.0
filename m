From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 May 2013 10:58:07 -0700
Subject: [PATCH v3 6/6] clk: samsung: Add EPLL and VPLL freq table for
 exynos5250 SoC
In-Reply-To: <1370003496-19288-7-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
 <1370003496-19288-7-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=UXV59zcrhLxjnU0LgX1LR855mQUd-xMM4bbXhRmB7UyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas and Yadwinder,

On Fri, May 31, 2013 at 5:31 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> Adds the EPLL and VPLL freq table for exynos5250 SoC.
>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos5250.c |   48 +++++++++++++++++++++++++++++++---
>  drivers/clk/samsung/clk.h            |    2 ++
>  2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index b0e6680..0566421 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -473,11 +473,32 @@ static __initdata struct of_device_id ext_clk_match[] = {
>         { },
>  };
>
> +static const struct samsung_pll_rate_table vpll_24mhz_tbl[] = {
> +       /* sorted in descending order */
> +       /* PLL_36XX_RATE(rate, m, p, s, k) */
> +       PLL_36XX_RATE(266000000, 266, 3, 3, 0),
> +       PLL_36XX_RATE(70500000, 94, 2, 4, 0),

Would be nice to include the comment that you included in our gerrit:
that the 70.5 is not in the manual but is used by exynos5250-snow.


> +       fin_pll_rate = _get_rate("fin_pll");
> +       mout_vpllsrc_rate = _get_rate("mout_vpllsrc");

This line is why you added an alias for mout_vpllsrc.  I'd rather not
see that since it also exports the clock to other places.

I've changed this to use __clk_lookup().  That function _is_ exported
by <linux/clk-provider.h> and we are a clock provider, so it seems
legit to use that.  ...and it's nice not to have an extra clock alias.

See my changes to <https://gerrit.chromium.org/gerrit/#/c/56797/> for
an example.


> @@ -507,10 +531,28 @@ void __init exynos5250_clk_init(struct device_node *np)
>                         reg_base + 0x10050, NULL, 0);
>         cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
>                         reg_base + 0x10020, NULL, 0);
> -       epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
> -                       reg_base + 0x10030, NULL, 0);
> -       vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc",
> +
> +       if (fin_pll_rate == (24 * MHZ)) {
> +               epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
> +                               reg_base + 0x10030, epll_24mhz_tbl,
> +                               ARRAY_SIZE(epll_24mhz_tbl));
> +       } else {
> +               pr_warn("Exynos5250: valid epll rate_table missing for\n"
> +                       "parent fin_pll:%lu hz\n", fin_pll_rate);

nit: use %s and __func__ rather than adding Exynos5250 hardcoded in here?


-Doug
