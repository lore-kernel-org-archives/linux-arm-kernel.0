From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 18 Jul 2013 16:51:17 -0400 (EDT)
Subject: [PATCH V3 5/6] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <1372141408-9894-6-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307181647240.1245-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI Atmel host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.

This looks okay except for some very minor issues.

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 46c2f42..e4dc9ab 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -390,6 +390,14 @@ config USB_OHCI_HCD_SPEAR
>            Enables support for the on-chip OHCI controller on
>            ST SPEAr chips.
>  
> +config USB_OHCI_HCD_AT91
> +        tristate  "Support for Atmel on-chip OHCI USB controller"
> +        depends on USB_OHCI_HCD && ARCH_AT91
> +        default y
> +        ---help---
> +          Enables support for the on-chip OHCI controller on
> +          Atmel chips.

Get rid of the extra space after "tristate".

> @@ -686,7 +630,11 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
>  	 * REVISIT: some boards will be able to turn VBUS off...
>  	 */
>  	if (at91_suspend_entering_slow_clock()) {
> -		ohci_usb_reset (ohci);
> +		ohci->hc_control = ohci_readl (ohci, &ohci->regs->control);
> +		ohci->hc_control &= OHCI_CTRL_RWC;
> +		ohci_writel (ohci, ohci->hc_control, &ohci->regs->control);
> +		ohci->rh_state = OHCI_RH_HALTED;

Even though you're just copying the code, don't also copy its mistakes.
Get rid of the extra spaces before the '(' characters.

> +static void __exit ohci_at91_cleanup(void)
> +{
> +	platform_driver_unregister(&ohci_hcd_at91_driver);
> +}
> +module_exit(ohci_at91_cleanup);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");

Please move the existing MODULE_ALIAS line down here with these lines.

Alan Stern
