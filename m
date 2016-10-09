From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 9 Oct 2016 19:34:46 +0300
Subject: [PATCH 1/2] host: ehci-exynos: Convert to use the
 SET_SYSTEM_SLEEP_PM_OPS
In-Reply-To: <1476023655-3232-1-git-send-email-linux.amoon@gmail.com>
References: <1476023655-3232-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <20161009163446.GA9672@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2016 at 02:34:14PM +0000, Anand Moon wrote:
> Move the ehci-exynos system PM callbacks within #ifdef CONFIG_PM_SLEEP
> as to avoid them being build when not used. This also allows us to use the
> SET_SYSTEM_SLEEP_PM_OPS macro which simplifies the code.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/usb/host/ehci-exynos.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index 42e5b66..1899900 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -251,7 +251,7 @@ static int exynos_ehci_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP

Does not look like an equivalent change. How will it behave in a config
with !SUSPEND && !HIBERNATE && PM?

Best regards,
Krzysztof

>  static int exynos_ehci_suspend(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
> @@ -292,15 +292,13 @@ static int exynos_ehci_resume(struct device *dev)
>  	ehci_resume(hcd, false);
>  	return 0;
>  }
> -#else
> -#define exynos_ehci_suspend	NULL
> -#define exynos_ehci_resume	NULL
> -#endif
>  
>  static const struct dev_pm_ops exynos_ehci_pm_ops = {
> -	.suspend	= exynos_ehci_suspend,
> -	.resume		= exynos_ehci_resume,
> +	SET_SYSTEM_SLEEP_PM_OPS(exynos_ehci_suspend, exynos_ehci_resume)
>  };
> +#endif /* CONFIG_PM_SLEEP */
> +
> +#define DEV_PM_OPS IS_ENABLED(CONFIG_PM_SLEEP) ? &exynos_ehci_pm_ops : NULL
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id exynos_ehci_match[] = {
> @@ -317,7 +315,7 @@ static struct platform_driver exynos_ehci_driver = {
>  	.shutdown	= usb_hcd_platform_shutdown,
>  	.driver = {
>  		.name	= "exynos-ehci",
> -		.pm	= &exynos_ehci_pm_ops,
> +		.pm	= DEV_PM_OPS,
>  		.of_match_table = of_match_ptr(exynos_ehci_match),
>  	}
>  };
> -- 
> 2.7.4
> 
