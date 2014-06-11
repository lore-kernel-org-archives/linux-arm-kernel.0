From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 11 Jun 2014 17:58:18 +0200
Subject: [PATCH 1/3] clk: exynos-audss: Keep the parent of mout_audss
 always enabled
In-Reply-To: <1402464739-19044-2-git-send-email-tushar.b@samsung.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-2-git-send-email-tushar.b@samsung.com>
Message-ID: <CABxcv=nR+QqzBkzgn6EpZenFWsGLJ0_6HW=QX13H2XYgqcF24A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 7:32 AM, Tushar Behera <tushar.b@samsung.com> wrote:
> When the output clock of AUDSS mux is disabled, we are getting kernel
> oops while doing a clk_get() on other clocks provided by AUDSS. Though
> user manual doesn't specify this dependency, we came across this issue
> while disabling the parent of AUDSS mux clocks.
>
> Keeping the parents of AUDSS mux always enabled fixes this issue.
>
> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos-audss.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
> index 13eae14c..1542f30 100644
> --- a/drivers/clk/samsung/clk-exynos-audss.c
> +++ b/drivers/clk/samsung/clk-exynos-audss.c
> @@ -30,6 +30,8 @@ static struct clk **clk_table;
>  static void __iomem *reg_base;
>  static struct clk_onecell_data clk_data;
>
> +static struct clk *pll_ref, *pll_in;
> +
>  #define ASS_CLK_SRC 0x0
>  #define ASS_CLK_DIV 0x4
>  #define ASS_CLK_GATE 0x8
> @@ -83,7 +85,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>         const char *mout_audss_p[] = {"fin_pll", "fout_epll"};
>         const char *mout_i2s_p[] = {"mout_audss", "cdclk0", "sclk_audio0"};
>         const char *sclk_pcm_p = "sclk_pcm0";
> -       struct clk *pll_ref, *pll_in, *cdclk, *sclk_audio, *sclk_pcm_in;
> +       struct clk *cdclk, *sclk_audio, *sclk_pcm_in;
>         const struct of_device_id *match;
>         enum exynos_audss_clk_type variant;
>
> @@ -113,10 +115,14 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>
>         pll_ref = devm_clk_get(&pdev->dev, "pll_ref");
>         pll_in = devm_clk_get(&pdev->dev, "pll_in");
> -       if (!IS_ERR(pll_ref))
> +       if (!IS_ERR(pll_ref)) {
>                 mout_audss_p[0] = __clk_get_name(pll_ref);
> -       if (!IS_ERR(pll_in))
> +               clk_prepare_enable(pll_ref);
> +       }
> +       if (!IS_ERR(pll_in)) {
>                 mout_audss_p[1] = __clk_get_name(pll_in);
> +               clk_prepare_enable(pll_in);
> +       }
>         clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
>                                 mout_audss_p, ARRAY_SIZE(mout_audss_p),
>                                 CLK_SET_RATE_NO_REPARENT,
> @@ -217,6 +223,11 @@ static int exynos_audss_clk_remove(struct platform_device *pdev)
>                         clk_unregister(clk_table[i]);
>         }
>
> +       if (!IS_ERR(pll_in))
> +               clk_disable_unprepare(pll_in);
> +       if (!IS_ERR(pll_ref))
> +               clk_disable_unprepare(pll_ref);
> +
>         return 0;
>  }
>
> --
> 1.7.9.5
>

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
