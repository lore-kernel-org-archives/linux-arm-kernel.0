From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Feb 2013 11:13:56 -0500 (EST)
Subject: [V2 1/8] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <1360923853-7875-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1302201105440.1671-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013, Manjunath Goudar wrote:

> Separate the SPEAr host controller driver from ehci-hcd host code
> into its own driver module.
> 
> In V2:
> Replaced spear as SPEAr everywhere, leaving functions/variables/config options.

> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
>  	  Enables support for the on-chip EHCI controller on
>  	  OMAP3 and later chips.
>  
> +config USB_EHCI_HCD_SPEAR
> +        tristate "Support for ST SPEAr on-chip EHCI USB controller"
> +        depends on USB_EHCI_HCD && PLAT_SPEAR
> +        default y
> +        ---help---
> +          Enables support for the on-chip EHCI controller on
> +          ST SPEAr chips.

Is it a good idea to make this option interactive?  That might cause 
people to disable it by mistake.

> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -27,7 +27,7 @@ obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
>  obj-$(CONFIG_USB_EHCI_PCI)	+= ehci-pci.o
>  obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)	+= ehci-platform.o
>  obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
> -
> +obj-$(CONFIG_USB_EHCI_HCD_SPEAR)+= ehci-spear.o

Please don't eliminate the blank line that separates the EHCI drivers 
from the following non-EHCI drivers.

>  obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
>  obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
>  obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o

> --- a/drivers/usb/host/ehci-spear.c
> +++ b/drivers/usb/host/ehci-spear.c

> +static const char hcd_name[] = "ehci-SPEAr";

> @@ -209,11 +188,35 @@ static struct platform_driver spear_ehci_hcd_driver = {
>  	.remove		= spear_ehci_hcd_drv_remove,
>  	.shutdown	= usb_hcd_platform_shutdown,
>  	.driver		= {
> -		.name = "spear-ehci",
> +		.name = hcd_name,

You must not change the driver's name.  It won't work on non-DT 
systems; the platform bus relies on matching drivers to devices by 
comparing their names.

>  		.bus = &platform_bus_type,
>  		.pm = &ehci_spear_pm_ops,
>  		.of_match_table = of_match_ptr(spear_ehci_id_table),
>  	}
>  };
>  
> -MODULE_ALIAS("platform:spear-ehci");

You must not remove the MODULE_ALIAS.

> +static const struct ehci_driver_overrides spear_overrides __initdata = {
> +	.reset = ehci_spear_setup,
> +};

You forgot to use the .extra_priv_size field.  It will allow the driver 
to be simplified by storing the "clk" field of struct spear_ehci in the 
private part of the ehci_hcd structure.

Also, you can completely eliminate the ehci_spear_setup routine if you 
move the lines

	/* registers start at offset 0x0 */
	ehci->caps = hcd->regs;

into spear_ehci_hcd_drv_probe.

> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");

There probably should be a MODULE_AUTHOR field, yes?

Alan Stern
