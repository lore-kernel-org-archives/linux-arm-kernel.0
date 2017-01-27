From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 27 Jan 2017 17:01:53 +0200
Subject: [PATCH linux-next v2 1/1] usb: gadget: udc: atmel: Update
 endpoint allocation scheme
In-Reply-To: <e7d44f0d-d51a-316f-98b1-1582c60f2cac@microchip.com>
References: <1485182759-17165-1-git-send-email-cristian.birsan@microchip.com>
 <1485182759-17165-2-git-send-email-cristian.birsan@microchip.com>
 <84fe6fa4-7cf7-22cb-b4b7-47e2cb202a68@atmel.com>
 <e7d44f0d-d51a-316f-98b1-1582c60f2cac@microchip.com>
Message-ID: <878tpw7di6.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Cristian Birsan <cristian.birsan@microchip.com> writes:
>>> +		/* It might be a little bit late to set this */
>> 
>> Is it too late or not? This comment is frightening... We may need some
>> feedback from the USB guys here...
>>
>
> If someone from USB can comment a bit on this topic I will be grateful.

it is not too late :-) Just look at the implementation of
usb_ep_autoconfig_ss(). That said, I haven't considered if gadget
drivers might want this value to be valid before calling
usb_ep_autoconfig_ss(). I can't see why they would, but still; just a
little warning.

struct usb_ep *usb_ep_autoconfig_ss(
	struct usb_gadget		*gadget,
	struct usb_endpoint_descriptor	*desc,
	struct usb_ss_ep_comp_descriptor *ep_comp
)
{
	struct usb_ep	*ep;
	u8		type;

	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;

	if (gadget->ops->match_ep) {
		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
		if (ep)
			goto found_ep;
	}

	/* Second, look at endpoints until an unclaimed one looks usable */
	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
			goto found_ep;
	}

	/* Fail */
	return NULL;
found_ep:

	/*
	 * If the protocol driver hasn't yet decided on wMaxPacketSize
	 * and wants to know the maximum possible, provide the info.
	 */
	if (desc->wMaxPacketSize == 0)
		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);

	/* report address */
	desc->bEndpointAddress &= USB_DIR_IN;
	if (isdigit(ep->name[2])) {
		u8 num = simple_strtoul(&ep->name[2], NULL, 10);
		desc->bEndpointAddress |= num;
	} else if (desc->bEndpointAddress & USB_DIR_IN) {
		if (++gadget->in_epnum > 15)
			return NULL;
		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
	} else {
		if (++gadget->out_epnum > 15)
			return NULL;
		desc->bEndpointAddress |= gadget->out_epnum;
	}

	/* report (variable) full speed bulk maxpacket */
	if ((type == USB_ENDPOINT_XFER_BULK) && !ep_comp) {
		int size = ep->maxpacket_limit;

		/* min() doesn't work on bitfields with gcc-3.5 */
		if (size > 64)
			size = 64;
		desc->wMaxPacketSize = cpu_to_le16(size);
	}

	ep->address = desc->bEndpointAddress;
	ep->desc = NULL;
	ep->comp_desc = NULL;
	ep->claimed = true;
	return ep;
}

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/fa9be2a4/attachment.sig>
