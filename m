From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 6 Jun 2017 13:54:37 +0300
Subject: [PATCH] spi: pxa2xx: Handle return value of clk_prepare_enable
In-Reply-To: <4e16c0aba047b068aaa41c1d180d98ccb441afd0.1496668108.git.arvind.yadav.cs@gmail.com>
References: <4e16c0aba047b068aaa41c1d180d98ccb441afd0.1496668108.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAHp75Vf+cm_-V4jcqJqcmMRdGA9j19RQYfyjJ8YRz3w1A+gRYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 12:44 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> clk_prepare_enable() can fail here and we must check its return value.

> @@ -1676,7 +1676,11 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)

> -       clk_prepare_enable(ssp->clk);
> +       status = clk_prepare_enable(ssp->clk);

This one looks fine.

> @@ -1855,8 +1859,13 @@ static int pxa2xx_spi_resume(struct device *dev)

>         /* Enable the SSP clock */
> -       if (!pm_runtime_suspended(dev))
> -               clk_prepare_enable(ssp->clk);
> +       if (!pm_runtime_suspended(dev)) {
> +               status = clk_prepare_enable(ssp->clk);
> +               if (status) {
> +                       dev_err(dev, "Failed to prepare clock\n");
> +                       return status;
> +               }

This...

> @@ -1886,8 +1895,7 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
>  {
>         struct driver_data *drv_data = dev_get_drvdata(dev);
>
> -       clk_prepare_enable(drv_data->ssp->clk);
> -       return 0;
> +       return clk_prepare_enable(drv_data->ssp->clk);

...and especially this should be carefully checked since there are
differences in behaviour how system or driver will be resumed.

So, the question is how did you test it?

-- 
With Best Regards,
Andy Shevchenko
