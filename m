From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Feb 2013 11:02:13 -0500 (EST)
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1302201055260.1671-100000@iolanthe.rowland.org>
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

One more comment on this patch...

> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
>  	  Enables support for the on-chip EHCI controller on
>  	  OMAP3 and later chips.
>  
> +config USB_EHCI_HCD_ORION
> +        tristate  "Support for Marvell Orion on-chip EHCI USB controller"
> +        depends on USB_EHCI_HCD && PLAT_ORION
> +        default y
> +        ---help---
> +          Enables support for the on-chip EHCI controller on
> +          Morvell Orion chips.

Currently there is no Kconfig option to control specifically whether
the ehci-orion driver gets built; it always gets built whenever
CONFIG_PLAT_ORION and CONFIG_USB_EHCI_HCD are both enabled.

Do you think it is a good idea to add an option for this?  Should it at
least be non-interactive, so that the driver always gets built under
the same conditions as currently?  A later patch can make it 
interactive, if desired.

Alan Stern
