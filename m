From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Mar 2016 16:34:12 +0100
Subject: [PATCH 3/6] usb: ohci-at91: use __maybe_unused to hide pm
 functions
In-Reply-To: <1456932255-71725-4-git-send-email-arnd@arndb.de>
References: <1456932255-71725-1-git-send-email-arnd@arndb.de>
 <1456932255-71725-4-git-send-email-arnd@arndb.de>
Message-ID: <56D707F4.9030903@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/03/2016 16:24, Arnd Bergmann a ?crit :
> The ohci-at91 driver uses #ifdef to check for CONFIG_PM, but then
> uses SIMPLE_DEV_PM_OPS, which leaves the references out when
> CONFIG_PM_SLEEP is not defined, so we get a warning with
> PM=y && PM_SLEEP=n:
> 
> drivers/usb/host/ohci-at91.c:587:1: error: 'ohci_hcd_at91_drv_suspend' defined but not used [-Werror=unused-function]
> drivers/usb/host/ohci-at91.c:631:12: error: 'ohci_hcd_at91_drv_resume' defined but not used [-Werror=unused-function]
> 
> This removes the incorrect #ifdef and instead uses a __maybe_unused
> annotation to let the compiler know it can silently drop
> the function definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Arnd, bye.

> ---
>  drivers/usb/host/ohci-at91.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 95c8ddde0725..d177372bb357 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -581,9 +581,7 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -
> -static int
> +static int __maybe_unused
>  ohci_hcd_at91_drv_suspend(struct device *dev)
>  {
>  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> @@ -628,7 +626,8 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int ohci_hcd_at91_drv_resume(struct device *dev)
> +static int __maybe_unused
> +ohci_hcd_at91_drv_resume(struct device *dev)
>  {
>  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
>  	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
> @@ -641,7 +640,6 @@ static int ohci_hcd_at91_drv_resume(struct device *dev)
>  	ohci_resume(hcd, false);
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(ohci_hcd_at91_pm_ops, ohci_hcd_at91_drv_suspend,
>  					ohci_hcd_at91_drv_resume);
> 


-- 
Nicolas Ferre
