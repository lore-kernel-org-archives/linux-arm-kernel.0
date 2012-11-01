From: mturquette@ti.com (Mike Turquette)
Date: Thu, 1 Nov 2012 04:06:36 -0700
Subject: [PATCH -next] CLK: clk-twl6040: fix return value check in
 twl6040_clk_probe()
In-Reply-To: <CAPgLHd-LVhPkOHUWOwjmcsDA-4spfQMTxW9z2tB7fnEuS_5OOw@mail.gmail.com>
References: <CAPgLHd-LVhPkOHUWOwjmcsDA-4spfQMTxW9z2tB7fnEuS_5OOw@mail.gmail.com>
Message-ID: <20121101110636.22860.46946@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Wei Yongjun (2012-10-31 22:33:55)
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_register() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks for the patch.  Will take into clk-next.

Regards,
Mike

> ---
>  drivers/clk/clk-twl6040.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
> index f4a3389..bc1e713 100644
> --- a/drivers/clk/clk-twl6040.c
> +++ b/drivers/clk/clk-twl6040.c
> @@ -92,8 +92,8 @@ static int __devinit twl6040_clk_probe(struct platform_device *pdev)
>  
>         clkdata->mcpdm_fclk.init = &wm831x_clkout_init;
>         clkdata->clk = clk_register(&pdev->dev, &clkdata->mcpdm_fclk);
> -       if (!clkdata->clk)
> -               return -EINVAL;
> +       if (IS_ERR(clkdata->clk))
> +               return PTR_ERR(clkdata->clk);
>  
>         dev_set_drvdata(&pdev->dev, clkdata);
