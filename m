From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 09:40:58 +0200
Subject: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B76562@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <20120417112910.GA3852@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B76562@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20120418074058.GM3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 04:31:50AM +0000, Chen Peter-B29397 wrote:
>  
> > 
> > Your patches won't work when more than one USB port is enabled because
> > of the singular usb transceiver present in the kernel. That of course is
> > not your fault. I think Heikki (Added to Cc) is working on this issue,
> > but I don't know the status here.
> > 
> > Another problem is that what you are doing does not integrate at all
> > with otg. I don't ask you to implement otg support because you are
> > likely not interested in this, but since you are adding a new ehci
> > glue driver anyway I suggest another approach:
> > 
> > Put a driver under drivers/usb/otg which:
> > 
> > - matches a 'imx-usb' device
> > - gets/enables all clocks needed for USB
> > - finds the transceiver
> > - registers a ehci device
> > 
> > Future additions would be:
> > 
> > - Put a USB_MODE_HOST/DEVICE flag into platform_data, and register a
> >   host or gadget driver depending on this flag
> > - Add a USB_MODE_OTG flag to platform_data and implement otg in this
> >   driver (or use whatever infrastructure present in the kernel then)
> > 
> > This is similar to what msm does. This way we have the clocks and phys
> > handled where they are needed. We may use this code on i.MX later.
> > 
> > We did this wrong on i.MX (and several other architectures) and getting
> > this right will be hard work. No need to introduce the same flaws again
> > with a new architecture.
> > 
> Hi Sascha,
> 
> We have been discussing i.mx usb re-structure at freescale internal during
> this periods, one side does not agree with otg driver manages PHY/clock
> solution due to below reasons:
> 
> - May confuse the users who only use device or host function, the users may
> double "why I need to include otg file to support device/host only function"?

I can't find anything confusing in this.

>  
> - For some special cases, like device sends resume signal(remote wakeup)
> after host suspend, but before otg suspend (system needs to refuse to suspend) .
> It needs to add hcd flag to judge if there is a remote wakeup after host suspend, 
> and if the port is sending resume signal now (when the port is sending resume signal, 
> we can't put power to low power mode). Is it suitable to put some hcd stuffs at otg driver?

I can't follow you here what the actual problem is, but since the otg
driver is the driver for host and gadget (which happens to pass control to
either the host or the gadget driver most of the time) it is ok to do
whatever it takes in the otg driver to make it work.

> 
> - Any disadvantages three individual drivers manage PHY/clock separately after the generic PHY
> layer/FSL PHY driver have finished? It can define where to get/put PHY/clock operation at
> individual drivers clearly. When OTG switch, for host mode, the hcd struct (includes interrupt)
> will be free/created using usb_remove_hcd/usb_add_hcd, for device mode, 
> we can deinit/init udc like current ci13xxx_udc.c at ci13xxx_vbus_session does. 

I once made a quick hack using the msm otg driver on i.MX. I had to
comment out some msm specifics but after that it worked quite well.

Sascga

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
