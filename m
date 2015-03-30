From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 31 Mar 2015 01:07:41 +0900
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Please see my comments inline.

2015-03-31 0:53 GMT+09:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
[snip]
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 07d666cc6a29..2d39b629144a 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -151,6 +151,7 @@ enum exynos5x_plls {
>
>  static void __iomem *reg_base;
>  static enum exynos5x_soc exynos5x_soc;
> +struct samsung_clk_provider *ctx;

static

>
>  #ifdef CONFIG_PM_SLEEP
>  static struct samsung_clk_reg_dump *exynos5x_save;
> @@ -275,8 +276,18 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
>         { .offset = GATE_IP_PERIC,              .value = 0xffffffff, },
>  };
>
> +/*
> + * list of clocks that have to be kept enabled during suspend/resume cycle.
> + */
> +static unsigned int exynos5x_clk_suspend[] = {

static const

> +       CLK_MDMA0,
> +};
> +
>  static int exynos5420_clk_suspend(void)
>  {
> +       int i;
> +       struct clk *clk;
> +
>         samsung_clk_save(reg_base, exynos5x_save,
>                                 ARRAY_SIZE(exynos5x_clk_regs));
>
> @@ -287,11 +298,24 @@ static int exynos5420_clk_suspend(void)
>         samsung_clk_restore(reg_base, exynos5420_set_clksrc,
>                                 ARRAY_SIZE(exynos5420_set_clksrc));
>
> +       for (i = 0; i < ARRAY_SIZE(exynos5x_clk_suspend); i++) {
> +               clk = samsung_clk_lookup(ctx, exynos5x_clk_suspend[i]);

If look-up speed is important here, maybe all the relevant clocks
could be looked up once at initialization time and just prepared and
enabled here?

Best regards,
Tomasz
