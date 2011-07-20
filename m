From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Jul 2011 09:59:10 -0400 (EDT)
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <1311160106-4898-6-git-send-email-tony.lin@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1107200954120.2071-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jul 2011, Tony Lin wrote:

> old driver uses some hard coding for clks' name which could
> not be used for mx28. So workaround these hard codings by
> judging the cpu is mx28 or not.
> add platform callback funtions in usb irq handler in the case
> usb phy need to change its disconnect detector mode after usb
> device is connected and disconnected. These callbacks also
> could be used for other machines whose usb phy need such kind
> of operations
> 
> Signed-off-by: Tony Lin <tony.lin@freescale.com>

...

> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c

...

> +static irqreturn_t fsl_ehci_irq(struct usb_hcd *hcd)
> +{
> +	struct mxc_usbh_platform_data *pdata;
> +	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
> +	u32			status;
> +
> +	pdata = hcd->self.controller->platform_data;
> +	if (pdata->plt_get_usb_connect_status == NULL || \
> +		pdata->plt_usb_disconnect_detect == NULL)
> +		goto out;
> +
> +	spin_lock(&ehci->lock);

Do you really need to use this spinlock?  I don't see any reason for
it.

> +	status = ehci_readl(ehci, &ehci->regs->status);
> +	if (status & STS_PCD) {
> +		if (pdata->plt_get_usb_connect_status())
> +			pdata->plt_usb_disconnect_detect(true);
> +		else
> +			pdata->plt_usb_disconnect_detect(false);

How about just this:

		pdata->plt_usb_disconnect_detect(
				pdata->plt_get_usb_connect_status());

> +	}
> +	spin_unlock(&ehci->lock);
> +out:
> +	return ehci_irq(hcd);
> +}

Alan Stern
