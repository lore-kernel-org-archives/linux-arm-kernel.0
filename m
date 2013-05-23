From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 May 2013 10:30:38 -0400 (EDT)
Subject: [RFC PATCH 2/3] USB: OHCI: Generic changes to make ohci-pci a
 separate driver
In-Reply-To: <1369307506-4458-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305231027140.925-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Manjunath Goudar wrote:

> Note that this changes is part of separating the ohci pci host controller
> driver from ohci-hcd host code.
> This contains :
>  -Moved sb800_prefetch() function from ohci-pci.c to pci-quirks.c file
>   and EXPORTed, this is part of the effort to move the ohci pci related
>   code to generic pci code.
>  -Passed "pci_dev" argument instead  of "ohci_hcd" in sb800_prefetch()
>   function to avoid extra include file in pci-quirks.c.

> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 13ebbb7..2490b81 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c

> @@ -1275,7 +1266,7 @@ MODULE_LICENSE ("GPL");
>  #define PLATFORM_DRIVER		ohci_platform_driver
>  #endif
>  
> -#if	!defined(PCI_DRIVER) &&		\
> +#if	!defined(PCI_DRIVER) && \
>  	!defined(PLATFORM_DRIVER) &&	\
>  	!defined(OMAP1_PLATFORM_DRIVER) &&	\
>  	!defined(OMAP3_PLATFORM_DRIVER) &&	\

As Arnd mentioned, this doesn't belong here.

> diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
> index 88731b7..78e0095 100644
> --- a/drivers/usb/host/ohci-q.c
> +++ b/drivers/usb/host/ohci-q.c
> @@ -41,6 +41,7 @@ finish_urb(struct ohci_hcd *ohci, struct urb *urb, int status)
>  __releases(ohci->lock)
>  __acquires(ohci->lock)
>  {
> +	struct pci_dev *pdev = to_pci_dev(ohci_to_hcd(ohci)->self.controller);

You shouldn't call to_pci_dev().  At this point you don't know if the 
controller is a PCI device or not.  Instead, just do

	struct device *dev = ohci_to_hcd(ohci)->self.controller;

Then in sb800_prefetch(), where it makes sense, you can call 
to_pci_dev().

> @@ -580,6 +581,7 @@ static void td_submit_urb (
>  	struct urb	*urb
>  ) {
>  	struct urb_priv	*urb_priv = urb->hcpriv;
> +	struct pci_dev *pdev = to_pci_dev(ohci_to_hcd(ohci)->self.controller);

Same thing here.

Otherwise this is okay.

Alan Stern
