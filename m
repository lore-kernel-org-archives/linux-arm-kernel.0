From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Feb 2013 11:21:43 -0500 (EST)
Subject: [V2 3/8] USB: EHCI: make ehci-s5p a separate driver
In-Reply-To: <1360923853-7875-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1302201118170.1671-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013, Manjunath Goudar wrote:

> --- a/drivers/usb/host/ehci-s5p.c
> +++ b/drivers/usb/host/ehci-s5p.c
> @@ -20,6 +20,17 @@
>  #include <linux/usb/phy.h>
>  #include <linux/usb/samsung_usb_phy.h>
>  #include <plat/usb-phy.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/io.h>
> +#include <linux/usb/otg.h>
> +#include <linux/dma-mapping.h>

It's generally a good idea to keep these #include's in alphabetical 
order, as near as possible.

> @@ -322,5 +305,27 @@ static struct platform_driver s5p_ehci_driver = {
>  		.of_match_table = of_match_ptr(exynos_ehci_match),
>  	}
>  };
> +static const struct ehci_driver_overrides s5p_overrides __initdata = {
> +	.reset = ehci_setup,

Not needed.  But you can use .extra_priv_size to eliminate the separate 
allocation of the s5p_ehci_hcd structure.  Once you do that, the .dev 
and .hcd members of the structure will be unnecessary.

> +MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_ALIAS("platform:s5p-ehci");
> +MODULE_LICENSE("GPL");

Should be GPLv2.

Alan Stern
