From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 13 Sep 2016 11:46:36 +0100
Subject: [PATCH] mfd: exynos-lpass: mark PM functions as __maybe_unused
In-Reply-To: <20160906132432.2083493-1-arnd@arndb.de>
References: <20160906132432.2083493-1-arnd@arndb.de>
Message-ID: <20160913104636.GA26864@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Sep 2016, Arnd Bergmann wrote:

> The newly added exynos lpass driver produces a build warning when
> CONFIG_PM is disabled since the only callers of exynos_lpass_disable
> are under an #ifdef:
> 
> drivers/mfd/exynos-lpass.c:93:13: error: 'exynos_lpass_disable' defined but not used [-Werror=unused-function]
>  static void exynos_lpass_disable(struct exynos_lpass *lpass)
> 
> This removes the #ifdef and replaces it with __maybe_unused annotations
> so the compiler can leave out the unused code silently with less
> room for mistakes.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 36c26760bba8 ("mfd: Add Samsung Exynos Low Power Audio Subsystem driver")
> ---
>  drivers/mfd/exynos-lpass.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
> index 578ac7b57b96..2e064fb8826f 100644
> --- a/drivers/mfd/exynos-lpass.c
> +++ b/drivers/mfd/exynos-lpass.c
> @@ -144,8 +144,7 @@ static int exynos_lpass_probe(struct platform_device *pdev)
>  	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int exynos_lpass_suspend(struct device *dev)
> +static int __maybe_unused exynos_lpass_suspend(struct device *dev)
>  {
>  	struct exynos_lpass *lpass = dev_get_drvdata(dev);
>  
> @@ -154,7 +153,7 @@ static int exynos_lpass_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int exynos_lpass_resume(struct device *dev)
> +static int __maybe_unused exynos_lpass_resume(struct device *dev)
>  {
>  	struct exynos_lpass *lpass = dev_get_drvdata(dev);
>  
> @@ -162,7 +161,6 @@ static int exynos_lpass_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(lpass_pm_ops, exynos_lpass_suspend,
>  					exynos_lpass_resume);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
