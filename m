From: cxie4@marvell.com (Chao Xie)
Date: Mon, 22 Nov 2010 19:11:33 -0800
Subject: [PATCH 2/2] USB: pxa: Add USB client support for Marvell
	PXA9xx/PXA168 chips
In-Reply-To: <Pine.LNX.4.44L0.1011221020360.1758-100000@iolanthe.rowland.org>
References: <1290418347-6861-2-git-send-email-chao.xie@marvell.com>
	<Pine.LNX.4.44L0.1011221020360.1758-100000@iolanthe.rowland.org>
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D15054F6FC9@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
You are right. I have added source code to fix it. Patch is attached.

+static int mv_ep_set_halt_wedge(struct usb_ep *_ep, int halt, int wedge)
+{
+	struct mv_ep *ep;
+	unsigned long flags = 0;
+	int status = 0;
+	struct mv_udc *udc;
+
+	ep = container_of(_ep, struct mv_ep, ep);
+	udc = ep->udc;
+	if (!_ep || !ep->desc) {
+		status = -EINVAL;
+		goto out;
+	}
+
+	if (ep->desc->bmAttributes == USB_ENDPOINT_XFER_ISOC) {
+		status = -EOPNOTSUPP;
+		goto out;
+	}
+
+	/* Attempt to halt IN ep will fail if any transfer requests
+	 * are still queue */
+	if (halt && (ep_dir(ep) == EP_DIR_IN) && !list_empty(&ep->queue)) {
+		status = -EAGAIN;
+		goto out;
+	}
+
+	spin_lock_irqsave(&ep->udc->lock, flags);
+	ep_set_stall(udc, ep->ep_num, ep_dir(ep), halt);
+	if (halt && wedge)
+		ep->wedge = 1;
+	else if (!halt)
+		ep->wedge = 0;
+	spin_unlock_irqrestore(&ep->udc->lock, flags);
+
+	if (ep->ep_num == 0) {
+		udc->ep0_state = WAIT_FOR_SETUP;
+		udc->ep0_dir = EP_DIR_OUT;
+	}
+out:
+	return status;
+}
+
+static int mv_ep_set_halt(struct usb_ep *_ep, int halt)
+{
+	return mv_ep_set_halt_wedge(_ep, halt, 0);
+}
+
+static int mv_ep_set_wedge(struct usb_ep *_ep)
+{
+	return mv_ep_set_halt_wedge(_ep, 1, 1);
+}

...
+
+	.set_wedge	= mv_ep_set_wedge,
+	.set_halt	= mv_ep_set_halt,
...
	case USB_ENDPOINT_HALT:
+			ep_num = setup->wIndex & USB_ENDPOINT_NUMBER_MASK;
+			direction = (setup->wIndex & USB_ENDPOINT_DIR_MASK)
+				? EP_DIR_IN : EP_DIR_OUT;
+			if (setup->wValue != 0 || setup->wLength != 0
+				|| ep_num > udc->max_eps)
+				goto out;
+			ep = &udc->eps[ep_num * 2 + direction];
+			if (ep->wedge == 1)
+				break;
+			spin_unlock(&udc->lock);
+			ep_set_stall(udc, ep_num, direction, 0);
+			spin_lock(&udc->lock);
+			break;

-----Original Message-----
From: Alan Stern [mailto:stern at rowland.harvard.edu] 
Sent: Monday, November 22, 2010 11:22 PM
To: Chao Xie
Cc: gregkh at suse.de; linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; eric.y.miao at gmail.com; Chao Xie
Subject: Re: [PATCH 2/2] USB: pxa: Add USB client support for Marvell PXA9xx/PXA168 chips

On Mon, 22 Nov 2010 chao.xie at marvell.com wrote:

> From: cxie4 <cxie4@marvell.com>
> 
> This patch add USB client support Marvell PXA9xx/PXA168 chips. The USB
> controller in PXA9xx/PXA168 is a High-Speed OTG controller. The available
> endpoints is different between PXA9xx and PXA168.
> 
> NOTE:
> It is the first version of Marvell PXA9xx/PXA168 USB controller driver.
> The support for OTG mode will be added in later patch.
> PXA9xx and PXA168 has integrated UTMI PHY in the chips. The initialization
> for the PHY is a little different between PXA9xx and PXA168.

...

> +static struct usb_ep_ops mv_ep_ops = {
> +	.enable		= mv_ep_enable,
> +	.disable	= mv_ep_disable,
> +
> +	.alloc_request	= mv_alloc_request,
> +	.free_request	= mv_free_request,
> +
> +	.queue		= mv_ep_queue,
> +	.dequeue	= mv_ep_dequeue,
> +
> +	.set_halt	= mv_ep_set_halt,
> +	.fifo_flush	= mv_ep_fifo_flush,	/* flush fifo */
> +};

What happened to the .set_wedge method?

Alan Stern

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-USB-pxa-Add-USB-client-support-for-Marvell-PXA9xx-PX.patch
Type: application/octet-stream
Size: 72344 bytes
Desc: 0002-USB-pxa-Add-USB-client-support-for-Marvell-PXA9xx-PX.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101122/b8b5e2a8/attachment-0001.obj>
