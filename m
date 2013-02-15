From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 16 Feb 2013 11:21:16 +1300
Subject: [PATCH 1/2] USB: EHCI: make ehci-vt8500 a separate driver
In-Reply-To: <1360966349-1242560-1-git-send-email-arnd@arndb.de>
References: <201302152158.23446.arnd@arndb.de>
 <1360966349-1242560-1-git-send-email-arnd@arndb.de>
Message-ID: <1360966876.24923.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-15 at 23:12 +0100, Arnd Bergmann wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> With the multiplatform changes in arm-soc tree, it becomes
> possible to enable the vt8500 platform at the same time
> as other platforms that require a conflicting EHCI bus
> glue. At the moment, this results in a warning like
> 
> drivers/usb/host/ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
> drivers/usb/host/ehci-hcd.c:1257:0: note: this is the location of the previous definition
> drivers/usb/host/ehci-omap.c:319:31: warning: 'ehci_hcd_omap_driver' defined but not used [-Wunused-variable]
> 
> and an ehci driver that only works on one of them.
> 
> With the infrastructure added by Alan Stern in patch 3e0232039
> "USB: EHCI: prepare to make ehci-hcd a library module", we can
> avoid this problem by turning a bus glue into a separate
> module, as we do here for the vt8500 bus glue.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Alexey Charkov <alchark@gmail.com>
> ---
>  drivers/usb/host/Kconfig       |  8 +++++
>  drivers/usb/host/Makefile      |  1 +
>  drivers/usb/host/ehci-hcd.c    |  6 +---
>  drivers/usb/host/ehci-vt8500.c | 73 +++++++++++++++++++-----------------------
>  4 files changed, 43 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index c59a112..d77e028 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
>  	  Enables support for the on-chip EHCI controller on
>  	  OMAP3 and later chips.
>  
> +config USB_EHCI_HCD_VT8500
> +        tristate "Support for VT8500 on-chip EHCI USB controller"
> +        depends on USB_EHCI_HCD && ARCH_VT8500
> +        default y
> +        ---help---
> +          Enables support for the on-chip EHCI controller on
> +          VT8500 chips.
> +

This should also mention Wondermedia SoCs I guess since the same driver
is used for VT8500, WM8505, WM8650 etc etc.

Other than that:

Acked-by: Tony Prisk <linux@prisktech.co.nz>
