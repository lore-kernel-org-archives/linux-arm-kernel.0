From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 08 Feb 2013 10:58:40 +0800
Subject: [PATCH 05/10] USB: EHCI: make ehci-atmel a separate driver
In-Reply-To: <5113e60e.c84e420a.08c3.ffffbeda@mx.google.com>
References: <yes> <1360258447-27247-1-git-send-email-yes>
 <5113e60e.c84e420a.08c3.ffffbeda@mx.google.com>
Message-ID: <511469E0.1020307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath Goudar,
   I test this patch based on linux master branch, the commit id is: 
6bacaa9ddacb71c691d32c678d37bc59ffc71fac. (I am not sure this is the 
right place for testing).
   First, it has an compile error as following. After fix it, and 
tested, the EHCI doesn't work.
---<8---
drivers/usb/host/ehci-atmel.c: In function 'ehci_atmel_drv_remove':
drivers/usb/host/ehci-atmel.c:167: error: implicit declaration of 
function 'ehci_shutdown'
--->8---

And a little code style comments as following.

On 2/8/2013 1:34, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>
> Separate the Atmel host controller driver from ehci-hcd host code
> into its own driver module.
>
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg KH <greg@kroah.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: linux-usb at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   drivers/usb/host/Kconfig      |    7 ++++
>   drivers/usb/host/Makefile     |    1 +
>   drivers/usb/host/ehci-atmel.c |   78 ++++++++++++++++++++++-------------------
>   drivers/usb/host/ehci-hcd.c   |    6 +---
>   4 files changed, 51 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 3689b7b..5a13f9d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -176,6 +176,13 @@ config USB_EHCI_HCD_ORION
>           ---help---
>             Enables support for the on-chip EHCI controller on
>             Morvell Orion chips.

Need blank line here.

> +config USB_EHCI_HCD_AT91
> +        tristate  "Support for Atmel on-chip EHCI USB controller"
> +        depends on USB_EHCI_HCD && ARCH_AT91
> +        default y
> +        ---help---
> +          Enables support for the on-chip EHCI controller on
> +          Atmel chips.
>
>   config USB_EHCI_MSM
>   	bool "Support for MSM on-chip EHCI USB controller"

[snip]

> +static void __exit ehci_atmel_cleanup(void)
> +{
> +	platform_driver_unregister(&ehci_atmel_driver);
> +}
> +module_exit(ehci_atmel_cleanup);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +
> +MODULE_ALIAS("platform:ehci-atmel");
> +MODULE_AUTHOR("Nicolas Ferre");
> +MODULE_LICENSE("GPL");
> +

Remove the blank line here. As to it is the EOF.

Best Regards,
Bo Shen
