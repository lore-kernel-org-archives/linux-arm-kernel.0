From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 1 Jul 2013 16:50:58 -0400 (EDT)
Subject: [PATCH] USB: OHCI: make ohci-nxp a separate driver
In-Reply-To: <1372585818-8441-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307011649190.1547-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 30 Jun 2013, Manjunath Goudar wrote:

> Separate the OHCI NXP host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.
> 
> Many place function name and struct name started with usb,
> current scenario replaced usb with ohci for proper naming.

> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index f3dcaa2..9a0b023 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -1194,11 +1194,6 @@ MODULE_LICENSE ("GPL");
>  #define EP93XX_PLATFORM_DRIVER	ohci_hcd_ep93xx_driver
>  #endif
>  
> -#ifdef CONFIG_ARCH_LPC32XX
> -#include "ohci-nxp.c"
> -#define NXP_PLATFORM_DRIVER	usb_hcd_nxp_driver
> -#endif
> -
>  #ifdef CONFIG_ARCH_DAVINCI_DA8XX
>  #include "ohci-da8xx.c"
>  #define DAVINCI_PLATFORM_DRIVER	ohci_hcd_da8xx_driver
> @@ -1301,12 +1296,6 @@ static int __init ohci_hcd_mod_init(void)
>  		goto error_ep93xx;
>  #endif
>  
> -#ifdef NXP_PLATFORM_DRIVER
> -	retval = platform_driver_register(&NXP_PLATFORM_DRIVER);
> -	if (retval < 0)
> -		goto error_nxp;
> -#endif
> -
>  #ifdef DAVINCI_PLATFORM_DRIVER
>  	retval = platform_driver_register(&DAVINCI_PLATFORM_DRIVER);
>  	if (retval < 0)
> @@ -1320,10 +1309,6 @@ static int __init ohci_hcd_mod_init(void)
>  	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
>   error_davinci:
>  #endif
> -#ifdef NXP_PLATFORM_DRIVER
> -	platform_driver_unregister(&NXP_PLATFORM_DRIVER);
> - error_nxp:
> -#endif
>  #ifdef EP93XX_PLATFORM_DRIVER
>  	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
>   error_ep93xx:

You forgot to remove

#ifdef NXP_PLATFORM_DRIVER
	platform_driver_unregister(&NXP_PLATFORM_DRIVER);
#endif

from ohci_hcd_mod_exit().  The rest is okay.

Alan Stern
