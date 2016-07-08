From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 08 Jul 2016 09:13:32 -0700
Subject: [PATCH v2 5/7] spi: s3c64xx: add exynos5433 compatible for ioclk
 handling
In-Reply-To: <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
Message-ID: <146799441227.73491.13833003558807352160@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andi Shyti (2016-07-08 07:46:39)
> @@ -1147,6 +1150,21 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>                 goto err_disable_clk;
>         }
>  
> +       if (sdd->port_conf->clk_ioclk) {
> +               sdd->ioclk = devm_clk_get(&pdev->dev, "spi_ioclk");
> +               if (IS_ERR(sdd->ioclk)) {
> +                       dev_err(&pdev->dev, "Unable to acquire 'ioclk'\n");
> +                       ret = PTR_ERR(sdd->ioclk);
> +                       goto err_disable_src_clk;
> +               }
> +
> +               ret = clk_prepare_enable(sdd->ioclk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Couldn't enable clock 'ioclk'\n");
> +                       goto err_disable_src_clk;
> +               }
> +       }
> +
>         pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>         pm_runtime_use_autosuspend(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
> @@ -1193,6 +1211,8 @@ err_pm_put:
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>  
> +       clk_disable_unprepare(sdd->ioclk);
> +err_disable_src_clk:
>         clk_disable_unprepare(sdd->src_clk);
>  err_disable_clk:
>         clk_disable_unprepare(sdd->clk);

Why aren't these clocks enabled/disabled by calls to pm_runtime_get/put?

Regards,
Mike
