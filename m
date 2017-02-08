From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Feb 2017 10:57:43 +0000
Subject: [PATCH v2 7/8] mfd: exynos-lpass: Add missing remove() function
In-Reply-To: <1485419634-28331-8-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083405eucas1p29a888fa3896e2bd131e23585f7d033d9@eucas1p2.samsung.com>
 <1485419634-28331-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170208105743.wgq4o6ev6ybvwbgz@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jan 2017, Marek Szyprowski wrote:

> Disable device on driver remove and release allocated regmap.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/exynos-lpass.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
> index be264988bdc9..9dbbedad916f 100644
> --- a/drivers/mfd/exynos-lpass.c
> +++ b/drivers/mfd/exynos-lpass.c
> @@ -137,6 +137,16 @@ static int exynos_lpass_probe(struct platform_device *pdev)
>  	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
> +static int exynos_lpass_remove(struct platform_device *pdev)
> +{
> +	struct exynos_lpass *lpass = platform_get_drvdata(pdev);
> +
> +	exynos_lpass_disable(lpass);
> +	regmap_exit(lpass->top);
> +
> +	return 0;
> +}
> +
>  static int __maybe_unused exynos_lpass_suspend(struct device *dev)
>  {
>  	struct exynos_lpass *lpass = dev_get_drvdata(dev);
> @@ -171,6 +181,7 @@ static SIMPLE_DEV_PM_OPS(lpass_pm_ops, exynos_lpass_suspend,
>  		.of_match_table	= exynos_lpass_of_match,
>  	},
>  	.probe	= exynos_lpass_probe,
> +	.remove	= exynos_lpass_remove,
>  };
>  module_platform_driver(exynos_lpass_driver);
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
