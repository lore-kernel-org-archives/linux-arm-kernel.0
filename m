From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Jul 2011 10:18:36 +0300
Subject: [RFC][PATCH 4/5] ARM: S5P64x0: Adding OTG PHY control code
In-Reply-To: <CAD6zSYOYUPpnovsxGWxiazKr3QnHhG78dfkctp3huvuNzdT4aw@mail.gmail.com>
References: <0LN400HTOZEQDIL0@mailout1.samsung.com>
	<BANLkTikDDBQjE2RCeeBB50vokSTcnCO46A@mail.gmail.com>
	<20110622094923.GA23598@legolas.emea.dhcp.ti.com>
	<CAD6zSYOYUPpnovsxGWxiazKr3QnHhG78dfkctp3huvuNzdT4aw@mail.gmail.com>
Message-ID: <20110706071834.GB10729@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 06, 2011 at 11:03:10AM +0530, Praveen Paneri wrote:
> >> > drivers should not live in arch/arm/*, why don't you move this to
> >> > drivers/usb/otg where the PHYs are staying right now ?
> >> PHY init/exit code can vary across SoCs. Wouldn't it be better to have it in the
> >> SoC specific location?
> >
> > It will vary how ? If it's only regarding e.g. a different GPIO pin or a
> > different IRQ number, you handle that by passing data down to driver
> > (via platform_data or struct resource), now if it varies because a
> > different board uses a different PHY, then another driver should be
> > written (well, as long as it's really different from the one you have
> > now, otherwise you should see if it's worth making the existing driver
> > more flexible).
> We have only 4 registers which are used for phy control. The bit structure
> of these registers vary across the SoCs.
> 1) PHY power control
> 2) PHY clock control
> 3) OTG reset control
> 4) PHY tune
> 
> To init/de-init the phy we just need to set the above 4 registers appropriately.
> Do you still think there is a necessity for a separate driver ?

well, we do have the otg utilities on drivers/usb/otg/ ;-)

> I have gone through the reference drivers suggested by you.
> Functionality of this PHY
> control remains very less relative to those drivers.

on OMAP4 we have one "PHY" which actually only handle VBUS and ID pin
detection :-p

> I have removed a lot of ifdefery from the initial patches. The only
> problem I am facing is
> in implementing a generic register I/O method which can work for both
> ARM and PPC.
> Existing code for PPC was using following funtions
> in_le32, in_be32, out_le32, out_be32
> while in ARM readl and writel functions are used.
> kindly suggest a way out of it.

Can you use the versions on include/asm-generic/io.h ?
ioread8(addr), ioread16(addr), ioread32(addr)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110706/f9eb3262/attachment.sig>
