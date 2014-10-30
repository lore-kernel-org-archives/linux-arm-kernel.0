From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Oct 2014 20:07:10 +0100
Subject: [PATCH 2/2] [usb] add support for APM X-Gene to xhci-platform
In-Reply-To: <1414692989-23128-3-git-send-email-mlangsdo@redhat.com>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <1414692989-23128-3-git-send-email-mlangsdo@redhat.com>
Message-ID: <3416966.BJ3nX0qr78@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 October 2014 13:16:29 Mark Langsdorf wrote:
> Applied Micro's X-Gene platform uses the xhci-platform for USB.
> Add the glue to decode it from ACPI and change the Kconfig files
> so the xhci-plat.o file gets built.
> 
> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>

I don't see anything x-gene specific in this patch, the PNP0D10
ID should work on any platform.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 042f785..07549ec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -149,6 +149,7 @@ config ARCH_XGENE
>  	bool "AppliedMicro X-Gene SOC Family"
>  	select MFD_SYSCON
>  	select POWER_RESET_SYSCON
> +	select USB_XHCI_XGENE
>  	help
>  	  This enables support for AppliedMicro X-Gene SOC Family
>  
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 82800a7..9fd52db 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -45,6 +45,14 @@ config USB_XHCI_RCAR
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Renesas R-Car ARM SoCs.
>  
> +config USB_XHCI_XGENE
> +	tristate "xHCI support for Applied Micro X-Gene SoCs"
> +	select USB_XHCI_PLATFORM
> +	depends on ARCH_XGENE || COMPILE_TEST
> +	---help---
> +	  Say 'Y' to enable the support for the xHCI host controller
> +	   found in Applied Micro X-Gene ARM SoCs.
> +

So just remove this symbol and let the user select USB_XHCI_PLATFORM

> @@ -290,6 +291,15 @@ static const struct of_device_id usb_xhci_of_match[] = {
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
> +
>  static struct platform_driver usb_xhci_driver = {
>  	.probe	= xhci_plat_probe,
>  	.remove	= xhci_plat_remove,
> @@ -297,6 +307,7 @@ static struct platform_driver usb_xhci_driver = {
>  		.name = "xhci-hcd",
>  		.pm = DEV_PM_OPS,
>  		.of_match_table = of_match_ptr(usb_xhci_of_match),
> +		.acpi_match_table = ACPI_PTR(usb_xhci_acpi_match),
>  	},
>  };
>  MODULE_ALIAS("platform:xhci-hcd");

This change looks good, just the comment is a bit misleading.

	Arnd
