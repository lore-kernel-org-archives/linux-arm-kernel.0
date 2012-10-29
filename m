From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 29 Oct 2012 11:13:49 -0700
Subject: [PATCHv2 1/3] clk: wm831x: Fix clk_register() error code checking
In-Reply-To: <1348519085-5888-1-git-send-email-sboyd@codeaurora.org>
References: <1348034730-16473-1-git-send-email-sboyd@codeaurora.org>
 <1348519085-5888-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20121029181349.18780.28418@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2012-09-24 13:38:03)
> clk_register() returns an ERR_PTR upon failure, not NULL. Fix
> these error paths.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks for sending V2.  Taken into clk-next.

Regards,
Mike

> ---
> 
> v2: No changes
> 
>  drivers/clk/clk-wm831x.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
> index e7b7765..eb1afaf 100644
> --- a/drivers/clk/clk-wm831x.c
> +++ b/drivers/clk/clk-wm831x.c
> @@ -371,20 +371,20 @@ static __devinit int wm831x_clk_probe(struct platform_device *pdev)
>  
>         clkdata->xtal_hw.init = &wm831x_xtal_init;
>         clkdata->xtal = clk_register(&pdev->dev, &clkdata->xtal_hw);
> -       if (!clkdata->xtal)
> -               return -EINVAL;
> +       if (IS_ERR(clkdata->xtal))
> +               return PTR_ERR(clkdata->xtal);
>  
>         clkdata->fll_hw.init = &wm831x_fll_init;
>         clkdata->fll = clk_register(&pdev->dev, &clkdata->fll_hw);
> -       if (!clkdata->fll) {
> -               ret = -EINVAL;
> +       if (IS_ERR(clkdata->fll)) {
> +               ret = PTR_ERR(clkdata->fll);
>                 goto err_xtal;
>         }
>  
>         clkdata->clkout_hw.init = &wm831x_clkout_init;
>         clkdata->clkout = clk_register(&pdev->dev, &clkdata->clkout_hw);
> -       if (!clkdata->clkout) {
> -               ret = -EINVAL;
> +       if (IS_ERR(clkdata->clkout)) {
> +               ret = PTR_ERR(clkdata->clkout);
>                 goto err_fll;
>         }
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
