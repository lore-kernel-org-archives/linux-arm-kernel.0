From: greg@kroah.com (Greg KH)
Date: Tue, 4 Nov 2014 09:12:20 -0800
Subject: [PATCH v2 2/2] [usb] add support for ACPI identification to
 xhci-platform
In-Reply-To: <1415119833-9135-2-git-send-email-mlangsdo@redhat.com>
References: <1414692989-23128-2-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-1-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-2-git-send-email-mlangsdo@redhat.com>
Message-ID: <20141104171220.GA30385@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 10:50:33AM -0600, Mark Langsdorf wrote:
> Provide the methods to let ACPI identify the need to use
> xhci-platform. Change the Kconfig files so the
> xhci-plat.o file is selectable during kernel config.
> 
> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
> ---
> Changes from v1
> 	Renamed from "add support for APM X-Gene to xhci-platform"
> 	Removed changes to arm64/Kconfig
> 	Made CONFIG_USB_XHCI_PLATFORM a user selectable config option
> 
>  drivers/usb/host/Kconfig     |  7 ++++++-
>  drivers/usb/host/xhci-plat.c | 11 +++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 82800a7..060a2361 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -27,7 +27,12 @@ config USB_XHCI_HCD
>  if USB_XHCI_HCD
>  
>  config USB_XHCI_PLATFORM
> -	tristate
> +	tristate "xHCI platform driver support"
> +	--help--
> +	  Say 'Y' to enable the support for the xHCI host controller
> +	  as a platform device. Many ARM SoCs provide USB this way.
> +
> +	  If unsure, say 'Y'.

You really want a 'default Y' response here?

That's not good at all, what happens if I select this on a system
without such hardware?


>  
>  config USB_XHCI_MVEBU
>  	tristate "xHCI support for Marvell Armada 375/38x"
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 91c7557..3db47ea 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/usb/xhci_pdriver.h>
> +#include <linux/acpi.h>
>  
>  #include "xhci.h"
>  #include "xhci-mvebu.h"
> @@ -287,6 +288,15 @@ static const struct of_device_id usb_xhci_of_match[] = {
>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id usb_xhci_acpi_match[] = {
> +	/* APM X-Gene USB Controller */
> +	{ "PNP0D10", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
> +#endif

That looks like a very "generic" PNP value, are you sure it is assigned
only to this specific device?

> +
>  static struct platform_driver usb_xhci_driver = {
>  	.probe	= xhci_plat_probe,
>  	.remove	= xhci_plat_remove,
> @@ -294,6 +304,7 @@ static struct platform_driver usb_xhci_driver = {
>  		.name = "xhci-hcd",
>  		.pm = DEV_PM_OPS,
>  		.of_match_table = of_match_ptr(usb_xhci_of_match),
> +		.acpi_match_table = ACPI_PTR(usb_xhci_acpi_match),

Shouldn't the reworked driver core code handle this differently with the
ability to handle either OF or ACPI in the same driver?

thanks,

greg k-h
