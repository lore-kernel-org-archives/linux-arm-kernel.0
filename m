From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 22:29:21 +0200
Subject: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
In-Reply-To: <20120417121800.GB3852@pengutronix.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <201204171345.07851.marex@denx.de> <20120417121800.GB3852@pengutronix.de>
Message-ID: <201204172229.22062.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Tue, Apr 17, 2012 at 01:45:07PM +0200, Marek Vasut wrote:
> > Dear Sascha Hauer,
> > 
> > > Hi Marek,
> > > 
> > > On Tue, Apr 17, 2012 at 12:15:43PM +0200, Marek Vasut wrote:
> > > > This patchset introduces the USB Host driver for i.MX28 CPU,
> > > > utilising the generic USB PHY infrastructure.
> > > 
> > > Your patches won't work when more than one USB port is enabled because
> > > of the singular usb transceiver present in the kernel. That of course
> > > is not your fault. I think Heikki (Added to Cc) is working on this
> > > issue, but I don't know the status here.
> > 
> > All right, I'll let Heikki hack on that. I'm not sure if we have any mx28
> > based device with multiple USB ports in kernel. Do we ?
> > 
> > > Another problem is that what you are doing does not integrate at all
> > > with otg.
> > 
> > Well, how should this be done to integrate with OTG then?
> > 
> > > I don't ask you to implement otg support because you are
> > > likely not interested in this, but since you are adding a new ehci
> > > glue driver anyway I suggest another approach:
> > > 
> > > Put a driver under drivers/usb/otg which:
> > > 
> > > - matches a 'imx-usb' device
> > > - gets/enables all clocks needed for USB
> > > - finds the transceiver
> > > - registers a ehci device
> > 
> > So the PHY actually registers the EHCI driver (plat_bus->phy->ehci)?
> > That's slightly weird, don't you think?
> 
> Your hardware device is a device consisting of a ehci core and a USB device
> core. Currently we register the child devices independently which leads
> to the mentioned problems. Instead we should register the USB core as a
> whole and pass the resources to either the client or the host driver.

Ok, giving it a second thought -- you mean to create "stub" driver, which claims 
and toggles the clock _and_ registers both the EHCI host driver and PHY driver 
under itself in the hierarchy. Is that correct?

> The phys are completely independent devices (from a bus topology point
> of view). The USB core just happens to use the phys.

Correct.

> Sascha

Best regards,
Marek Vasut
