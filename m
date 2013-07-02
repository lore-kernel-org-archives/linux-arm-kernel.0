From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 02 Jul 2013 18:50:08 +0400
Subject: [PATCH] USB: OHCI: make ohci-da8xx a separate driver
In-Reply-To: <1372765019-7191-1-git-send-email-manjunath.goudar@linaro.org>
References: <1372765019-7191-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51D2E8A0.1080102@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-07-2013 15:36, Manjunath Goudar wrote:

> Separate the Davinci OHCI host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.

> One preexisting error:
> "da8xx_syscfg0_base" [drivers/usb/host/ohci-da8xx.ko] undefined!

> Fixed eventually using below modification:
> added EXPORT_SYMBOL_GPL(da8xx_syscfg0_base) in
> arch/arm/mach-davinci/devices-da8xx.c.

    And you managed to get this fix into the DaVinci tree? I tried it 
long ago and it was refused by then DaVinci maintainer Kevin Hilman.

> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: Kevin Hilman <kjh@hilman.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> ---
>   drivers/usb/host/Kconfig      |    8 +++
>   drivers/usb/host/Makefile     |    1 +
>   drivers/usb/host/ohci-da8xx.c |  139 +++++++++++++++++++----------------------
>   drivers/usb/host/ohci-hcd.c   |   18 ------
>   4 files changed, 75 insertions(+), 91 deletions(-)

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 002bf73..bf2689d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -406,6 +406,14 @@ config USB_OHCI_HCD_LPC32XX
>             Enables support for the on-chip OHCI controller on
>             NXP chips.
>
> +config USB_OHCI_HCD_DA8XX
> +	tristate "Support for DAVINCI on-chip OHCI USB controller"
> +	depends on USB_OHCI_HCD && ARCH_DAVINCI_DA8XX
> +	default y
> +	---help---
> +          Enables support for the on-chip OHCI controller on
> +          Davinci chips.

    DA8xx is not a real DaVinci chip. The real DaVincis don't have OHCI 
at all. Please replace "Davinci" with "DA8xx/OMAP-L1x" in both the 
prompt and help text.

> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index c649a35..9b4d1e4 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -11,20 +11,35 @@
p...]
> +#define DRIVER_DESC "OHCI DA8XX driver"

    Better "DA8xx".

[...]
> @@ -444,6 +397,11 @@ static int ohci_da8xx_resume(struct platform_device *dev)
>   }
>   #endif
>
> +static const struct ohci_driver_overrides da8xx_overrides __initconst = {
> +	.reset		= ohci_da8xx_reset

    Better terminate the line with comma.

> +};
> +
> +

    Too many blank lines?

> @@ -461,4 +419,39 @@ static struct platform_driver ohci_hcd_da8xx_driver = {
>   	},
>   };
>
> +static int __init ohci_da8xx_init(void)
> +{
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> +	ohci_init_driver(&ohci_da8xx_hc_driver, &da8xx_overrides);
> +
> +	/*
> +	 * The Davinci da8xx HW has some unusual quirks, which require
> +	 * da8xx-specific workarounds. We override certain hc_driver
> +	 * functions here to achieve that. We explicitly do not enhance
> +	 * ohci_driver_overrides to allow this more easily, since this
> +	 * is an unusual case, and we don't want to encourage others to

    Not as unusual as it seems. IIRC Samsung OHCI has the same quirks.

WBR, Sergei
