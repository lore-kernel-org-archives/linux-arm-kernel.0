From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 13:45:07 +0200
Subject: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
In-Reply-To: <20120417112910.GA3852@pengutronix.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <20120417112910.GA3852@pengutronix.de>
Message-ID: <201204171345.07851.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> Hi Marek,
> 
> On Tue, Apr 17, 2012 at 12:15:43PM +0200, Marek Vasut wrote:
> > This patchset introduces the USB Host driver for i.MX28 CPU, utilising
> > the generic USB PHY infrastructure.
> 
> Your patches won't work when more than one USB port is enabled because
> of the singular usb transceiver present in the kernel. That of course is
> not your fault. I think Heikki (Added to Cc) is working on this issue,
> but I don't know the status here.

All right, I'll let Heikki hack on that. I'm not sure if we have any mx28 based 
device with multiple USB ports in kernel. Do we ?

> Another problem is that what you are doing does not integrate at all
> with otg.

Well, how should this be done to integrate with OTG then?

> I don't ask you to implement otg support because you are
> likely not interested in this, but since you are adding a new ehci
> glue driver anyway I suggest another approach:
> 
> Put a driver under drivers/usb/otg which:
> 
> - matches a 'imx-usb' device
> - gets/enables all clocks needed for USB
> - finds the transceiver
> - registers a ehci device

So the PHY actually registers the EHCI driver (plat_bus->phy->ehci)? That's 
slightly weird, don't you think?

> 
> Future additions would be:
> 
> - Put a USB_MODE_HOST/DEVICE flag into platform_data, and register a
>   host or gadget driver depending on this flag
> - Add a USB_MODE_OTG flag to platform_data and implement otg in this
>   driver (or use whatever infrastructure present in the kernel then)

Ok, this sounds reasonable.

> This is similar to what msm does. This way we have the clocks and phys
> handled where they are needed. We may use this code on i.MX later.

Ok, I'll check the MSM stuff.

> We did this wrong on i.MX (and several other architectures) and getting
> this right will be hard work. No need to introduce the same flaws again
> with a new architecture.

Ack, thanks for pointers.

> Sascha

Best regards,
Marek Vasut
