From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 12:16:24 +0200
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <511CB86B.3070504@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
 <87fw0zb5kk.fsf@ashishki-desk.ger.corp.intel.com>
 <511CB338.8070204@pengutronix.de>
 <20130214095822.GD15275@arwen.pp.htv.fi>
 <511CB86B.3070504@pengutronix.de>
Message-ID: <20130214101624.GB15537@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 11:11:55AM +0100, Marc Kleine-Budde wrote:
> >>>> @@ -32,4 +35,37 @@ const char *usb_speed_string(enum usb_device_speed speed)
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(usb_speed_string);
> >>>>  
> >>>> +#ifdef CONFIG_OF
> >>>> +static const char *usb_dr_modes[] = {
> >>>> +	[USB_DR_MODE_UNKNOWN]		= "",
> >>>> +	[USB_DR_MODE_HOST]		= "host",
> >>>> +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> >>>> +	[USB_DR_MODE_OTG]		= "otg",
> >>>> +};
> >>>
> >>> It turns out this is a problem, especially since this is generic usb
> >>> code: we have a chipidea controller (a patchset just arrived) that does
> >>> both host and peripheral, but not otg. And I'm told now that dwc3
> >>> controller can be synthesized like that too.
> > 
> > I wonder if this part is really necessary. Usually you would read it
> > from HW's registers. For dwc3, it's quite recently that we allowed the
> > driver to be built with host-only, device-only or DRD functionality.
> 
> The imx25 USB version of the chipidea IP Core get's really confused if
> you read from the CAP_DCCPARAMS register on the host only port. In
> freescale's documentation the register is marked as reserved. The host
> port will not work then.

heh, nicely done.

> > Maybe we can ignore dr_mode in host-only and device-only builds and only
> > look at it for DRD builds ?
> > 
> >> You mean a single instance of the controller (i.e. USB port) is host and
> >> peripheral but has no otg registers. This means the mode of the port is
> >> configured by userspace via the debugfs file? Is this possible?
> > 
> > yes, it is possible. Dual-Role doesn't imply OTG, but OTG implies
> > Dual-Role.
> 
> Thanks for the info. Then we need a fourth value for the helper code.
> What's a sensible sting: "dual-role", "dr"?

dual-role.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/c09ab693/attachment.sig>
