From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 13 Apr 2013 11:26:29 +0200
Subject: [PATCHv2 08/10] arm: kirkwood: convert QNAP TS219 to use DT for
 the PCIe interface
In-Reply-To: <20130411165158.GA5865@obsidianresearch.com>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130411003301.GH28693@titan.lakedaemon.net>
 <20130411052432.GP13524@lunn.ch>
 <20130411165158.GA5865@obsidianresearch.com>
Message-ID: <20130413092629.GF2824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 10:51:58AM -0600, Jason Gunthorpe wrote:
> On Thu, Apr 11, 2013 at 07:24:32AM +0200, Andrew Lunn wrote:
>  
> > I've hacked around with PCI driver on my QNAP TS119P+, which does not
> > have any PCI devices, and never had any problems with the driver
> > enabled and finding two empty PCI busses. PCI does not share any pins
> > with anything else. So i think it is safe to just enable it for all
> > devices.
> 
> In the general case, this is probably only safe if the board has
> configured the PEX to have the PHY clock. Marvell has guidelines for
> unused PEX's that would result in the PHY clock being permanently
> inactive.
> 
> Register 10030 tells what the strap for the PHY clock is. I expect in
> many cases the PEX driver should not be loaded if the PHY clock is not
> internally derived. Maybe checking this register will tell your QNAPs
> apart?
 
Hi Jason

I did a bit of experimentation and reading of documents.

My QNAP, which has nothing on the PCI bus, has bit 14 of register
10030, the Sample At Reset, set. This indicates it should derive the
PCIe clock from the internal clock.

I also played with Topkick. It also has bit 14 set, and is quite happy
having the PCI driver loaded, even though there is nothing on the bus,
and USI website makes no reference to PCIe, so i don't think there is
an hardware support for PCIe devices.

The hardware manual says that this strapping pin has an internal
pullup, so it will default to one, internal clock.

So, to have a problem, it would mean the hardware designed has
deliberately pulled the strapping pin low to indicate external clock,
and not actually applied an external clock. Is this likely? Given my
QNAP board is not designed to have active PCIe, i kind of expect if
QNAP where to do such a thing, it would be so on my board....

So i'm tempted to go with Thomas's patch, once fixed, so enabling
loading of the PCI driver for all QNAP devices. If we get reports of
issues, we can then look at the specific hardware and decide what to
do.

	Andrew
