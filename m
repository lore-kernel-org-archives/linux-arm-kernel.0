From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 18 Feb 2013 17:34:35 -0500 (EST)
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1302181723540.6790-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013, Arnd Bergmann wrote:

> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> With the multiplatform changes in arm-soc tree, it becomes
> possible to enable the mvebu platform (which uses
> ehci-orion) at the same time as other platforms that require
> a conflicting EHCI bus glue. At the moment, this results
> in a warning like
> 
> drivers/usb/host/ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
> drivers/usb/host/ehci-hcd.c:1277:0: note: this is the location of the previous definition
> drivers/usb/host/ehci-orion.c:334:31: warning: 'ehci_orion_driver' defined but not used [-Wunused-variable]
> 
> and an ehci driver that only works on one of them.
> 
> With the infrastructure added by Alan Stern in patch 3e0232039
> "USB: EHCI: prepare to make ehci-hcd a library module", we can
> avoid this problem by turning a bus glue into a separate
> module, as we do here for the orion bus glue.

> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
>  
>  obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
>  obj-$(CONFIG_USB_EHCI_HCD_VT8500)+= ehci-vt8500.o
> +obj-$(CONFIG_USB_EHCI_HCD_ORION)+= ehci-orion.o

Both of these two new lines should be formatted like the other lines in
this file (i.e., with tabs at the corresponding places), and they
should come before the OXU210HP_HCD entry so that they are next to the
other EHCI-related lines.

> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -17,6 +17,13 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>

Is this line really needed?

> @@ -34,6 +41,17 @@
>  #define USB_PHY_IVREF_CTRL	0x440
>  #define USB_PHY_TST_GRP_CTRL	0x450
>  
> +#define DRIVER_DESC "EHCI orion driver"
> +
> +static const char hcd_name[] = "ehci-orion";
> +
> +static struct hc_driver __read_mostly ehci_orion_hc_driver;
> +
> +static const struct ehci_driver_overrides orion_overrides __initdata = {
> +	.reset = ehci_setup,
> +};

This is not necessary; ehci_setup is the default value anyway.  This 
structure can be omitted.

> @@ -323,8 +296,6 @@ static int __exit ehci_orion_drv_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -MODULE_ALIAS("platform:orion-ehci");
> -
>  static const struct of_device_id ehci_orion_dt_ids[] = {
>  	{ .compatible = "marvell,orion-ehci", },
>  	{},
> @@ -336,8 +307,31 @@ static struct platform_driver ehci_orion_driver = {
>  	.remove		= __exit_p(ehci_orion_drv_remove),
>  	.shutdown	= usb_hcd_platform_shutdown,
>  	.driver = {
> -		.name	= "orion-ehci",
> +		.name	= hcd_name,

Is this really what you want -- changing the driver name from 
"orion-ehci" to "ehci-orion"?  Is that liable to cause trouble?

> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_ALIAS("platform:ehci-orion");

And is this really what you want -- changing the alias from 
"platform:orion-ehci" to "platform:ehci-orion"?

Alan Stern
