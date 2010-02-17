From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 17 Feb 2010 10:10:57 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF84D1@dbde02.ent.ti.com>
References: <20100208065519.GE1290@ucw.cz>
	<201002161522.38467.oliver@neukum.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF84D1@dbde02.ent.ti.com>
Message-ID: <201002171010.57464.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Februar 2010 09:55:08 schrieb Shilimkar, Santosh:
> > Your original patch however kills ehci, ohci and uhci on some architectures.
> 
> How about below approach? Controller driver can set 
> "uses_pio_for_control" if it can't do dma for control transfer.
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 80995ef..e3eae02 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1276,7 +1276,7 @@ static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  
>         if (usb_endpoint_xfer_control(&urb->ep->desc)
>             && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
> -               if (hcd->self.uses_dma) {
> +               if (hcd->self.uses_dma && !hcd->self.uses_pio_for_control) {

It is not elegant to describe exceptions. It would be better, if you split up
the flag into two flags, called uses_dma_for_ordinary_transfers and
uses_dma_for control_transfers. Doing so also makes sure you look at
all hcd drivers ;-)

And the tests become straightforward. And please add a detailed comment
to explain why this differentiation is needed on ARM.

	Regards
		Oliver
