From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Feb 2013 18:52:07 +0000
Subject: [PATCH] USB: EHCI: make ehci-s5p a separate driver
In-Reply-To: <5118e536.4439440a.3347.ffffdc89@mx.google.com>
References: <y> <1360586008-5895-1-git-send-email-y>
 <5118e536.4439440a.3347.ffffdc89@mx.google.com>
Message-ID: <51193DD7.6060506@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/13 12:33, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar<manjunath.goudar@linaro.org>
>
> Separate the s5p host controller driver from ehci-hcd host code
> into its own driver module.
>
> Signed-off-by: Manjunath Goudar<manjunath.goudar@linaro.org>
> Cc: Greg KH<greg@kroah.com>
> Cc: Alan Stern<stern@rowland.harvard.edu>
> Cc: Kukjin Kim<kgene.kim@samsung.com>
> Cc: Kyungmin Park<kyungmin.park@samsung.com>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Rob Herring<rob.herring@calxeda.com>
> Cc: linux-usb at vger.kernel.org
> ---
>   drivers/usb/host/Kconfig    |    2 +-
>   drivers/usb/host/Makefile   |    1 +
>   drivers/usb/host/ehci-hcd.c |    6 +---
>   drivers/usb/host/ehci-s5p.c |   69 ++++++++++++++++++++++++-------------------
>   4 files changed, 41 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 1ef37d7..8ffbafa 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -215,7 +215,7 @@ config USB_EHCI_SH
>   	  If you use the PCI EHCI controller, this option is not necessary.
>
>   config USB_EHCI_S5P
> -       boolean "S5P EHCI support"
> +       tristate "S5P EHCI support"
>          depends on USB_EHCI_HCD&&  PLAT_S5P
>          help
>   	 Enable support for the S5P SOC's on-chip EHCI controller.
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index b301243..77e0331 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
>   obj-$(CONFIG_USB_EHCI_HCD_SPEAR)+= ehci-spear.o
>   obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
>   obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
> +obj-$(CONFIG_USB_EHCI_S5P)      += ehci-s5p.o
>   obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
>   obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
>   obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index dda3d1b..fa0e665 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1312,11 +1312,6 @@ MODULE_LICENSE ("GPL");
>   #define PLATFORM_DRIVER		tegra_ehci_driver
>   #endif
>
> -#ifdef CONFIG_USB_EHCI_S5P
> -#include "ehci-s5p.c"
> -#define PLATFORM_DRIVER		s5p_ehci_driver
> -#endif
> -
>   #ifdef CONFIG_SPARC_LEON
>   #include "ehci-grlib.c"
>   #define PLATFORM_DRIVER		ehci_grlib_driver
> @@ -1339,6 +1334,7 @@ MODULE_LICENSE ("GPL");
>   	!IS_ENABLED(CONFIG_PLAT_SPEAR)&&  \
>   	!defined(PLATFORM_DRIVER)&&  \
>   	!IS_ENABLED(CONFIG_ARCH_AT91)&&  \
> +	!IS_ENABLED(CONFIG_USB_EHCI_S5P)&&  \
>   	!defined(PS3_SYSTEM_BUS_DRIVER)&&  \
>   	!defined(OF_PLATFORM_DRIVER)&&  \
>   	!defined(XILINX_OF_PLATFORM_DRIVER)
> diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
> index 20ebf6a..6ddf526 100644
> --- a/drivers/usb/host/ehci-s5p.c
> +++ b/drivers/usb/host/ehci-s5p.c
> @@ -20,6 +20,17 @@
>   #include<linux/usb/phy.h>
>   #include<linux/usb/samsung_usb_phy.h>
>   #include<plat/usb-phy.h>
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/usb.h>
> +#include<linux/usb/hcd.h>
> +#include<linux/io.h>
> +#include<linux/usb/otg.h>
> +#include<linux/dma-mapping.h>
> +
> +#include "ehci.h"
> +
> +#define DRIVER_DESC "EHCI s5p driver"
>
>   #define EHCI_INSNREG00(base)			(base + 0x90)
>   #define EHCI_INSNREG00_ENA_INCR16		(0x1<<  25)
> @@ -30,6 +41,10 @@
>   	(EHCI_INSNREG00_ENA_INCR16 | EHCI_INSNREG00_ENA_INCR8 |	\
>   	 EHCI_INSNREG00_ENA_INCR4 | EHCI_INSNREG00_ENA_INCRX_ALIGN)
>
> +static const char hcd_name[] = "ehci-s5p";
> +static struct hc_driver __read_mostly s5p_ehci_hc_driver;
> +
> +
>   struct s5p_ehci_hcd {
>   	struct device *dev;
>   	struct usb_hcd *hcd;
> @@ -39,36 +54,6 @@ struct s5p_ehci_hcd {
>   	struct s5p_ehci_platdata *pdata;
>   };
>
> -static const struct hc_driver s5p_ehci_hc_driver = {
> -	.description		= hcd_name,
> -	.product_desc		= "S5P EHCI Host Controller",
> -	.hcd_priv_size		= sizeof(struct ehci_hcd),
> -
> -	.irq			= ehci_irq,
> -	.flags			= HCD_MEMORY | HCD_USB2,
> -
> -	.reset			= ehci_setup,
> -	.start			= ehci_run,
> -	.stop			= ehci_stop,
> -	.shutdown		= ehci_shutdown,
> -
> -	.get_frame_number	= ehci_get_frame,
> -
> -	.urb_enqueue		= ehci_urb_enqueue,
> -	.urb_dequeue		= ehci_urb_dequeue,
> -	.endpoint_disable	= ehci_endpoint_disable,
> -	.endpoint_reset		= ehci_endpoint_reset,
> -
> -	.hub_status_data	= ehci_hub_status_data,
> -	.hub_control		= ehci_hub_control,
> -	.bus_suspend		= ehci_bus_suspend,
> -	.bus_resume		= ehci_bus_resume,
> -
> -	.relinquish_port	= ehci_relinquish_port,
> -	.port_handed_over	= ehci_port_handed_over,
> -
> -	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
> -};
>
>   static void s5p_ehci_phy_enable(struct s5p_ehci_hcd *s5p_ehci)
>   {
> @@ -322,5 +307,27 @@ static struct platform_driver s5p_ehci_driver = {
>   		.of_match_table = of_match_ptr(exynos_ehci_match),
>   	}
>   };
> +static const struct ehci_driver_overrides s5p_overrides __initdata = {
> +	.reset = ehci_setup,
> +};
> +
> +static int __init ehci_s5p_init(void)
> +{
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> +	ehci_init_driver(&s5p_ehci_hc_driver,&s5p_overrides);
> +	return platform_driver_register(&s5p_ehci_driver);
> +}

If we had a single module for all the platform drivers then we
wouldn't have a number of 'struct hc_drivers' sitting around. The
probe code could have one and fill it in depending on the type it
was initialised with.

> +module_init(ehci_s5p_init);
> +
> +static void __exit ehci_s5p_cleanup(void)
> +{
> +	platform_driver_unregister(&s5p_ehci_driver);
> +}
> +module_exit(ehci_s5p_cleanup);
>
> -MODULE_ALIAS("platform:s5p-ehci");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_ALIAS("platform:ehci-s5p");
> +MODULE_LICENSE("GPL");

You should probably put the MODULE_ALIAS lines together


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
