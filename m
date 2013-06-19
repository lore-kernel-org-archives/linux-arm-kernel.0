From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 19 Jun 2013 16:16:19 -0400 (EDT)
Subject: [PATCH V2 5/6] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <1371052442-14541-6-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306191609120.877-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI Atmel host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> V2:
>  -Set non-standard fields in ohci_at91_hc_driver manually, rather than
>   relying on an expanded struct ohci_driver_overrides.
>  -Save orig_ohci_hub_control and orig_ohci_hub_status_data rather than
>   relying on ohci_hub_control and hub_status_data being exported.
>  -ohci_setup() has been removed because it is called in .reset member
>   of the ohci_hc_driver structure.

> @@ -111,6 +125,8 @@ static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
>  static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  			struct platform_device *pdev)
>  {
> +	struct at91_usbh_data	*board;
> +	struct ohci_hcd	*ohci;

Variables are supposed to be not aligned at all (in which case you 
don't use tabs) or all aligned the same way.  In this case you put a 
tab before the "*board"; therefore the "*ohci" should line up with it.

No, this isn't an artifact of my email program.  They really are not
aligned.

> @@ -163,8 +179,11 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		goto err5;
>  	}
>  
> +	board = hcd->self.controller->platform_data;
> +	ohci = hcd_to_ohci(hcd);
> +	ohci->num_ports = board->ports;
>  	at91_start_hc(pdev);
> -	ohci_hcd_init(hcd_to_ohci(hcd));
> +	ohci_setup(hcd);

Didn't you say above that this version of the patch removes the call to 
ohci_setup()?

> @@ -686,7 +631,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
>  	 * REVISIT: some boards will be able to turn VBUS off...
>  	 */
>  	if (at91_suspend_entering_slow_clock()) {
> -		ohci_usb_reset (ohci);
> +		ohci_restart(ohci);

Why did you change this?  Did we discuss it earlier?

Alan Stern
