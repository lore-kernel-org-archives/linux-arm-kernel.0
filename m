From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Apr 2013 15:21:43 -0600
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <201304052301.27231.arnd@arndb.de>
References: <20130405150200.7b6dee63@skate> <201304052149.33533.arnd@arndb.de>
 <20130405203652.GA10505@obsidianresearch.com>
 <201304052301.27231.arnd@arndb.de>
Message-ID: <20130405212143.GA16221@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 11:01:27PM +0200, Arnd Bergmann wrote:

> >  - The bridge ranges would be offset 0 length 4G-1 in the DT since
> >    the value is not known. However firmware could do PCI address
> >    assignment and fill in corrected values.
> 
> I don't undestand this part. It would make the topmost byte in the
> 4GB bus space unadressable, which seems strange. Why can't we use
> the entire 4GB? Maybe we should leave at least a page?

Oh, sorry, that was just a mostly arbitary hacky choice to fit within
1 size cell. Using 2 size cells requires an upgrade to skeleton64 for
all mvebu platforms, eg kirkwood.

Realistically this size should never be used so it doesn't matter if
it is 4G or 4G-1 - though obviously 4G is preferred in cases where
size cells is 2. :)

> >  - A full featured firmware could fill in the various ranges to
> >    represent a working PCI bus configuration
> 
> Yes, although Linux normally doesn't expect the firmware to do that. On
> PowerPC, we support both ways, either trusting the firmware to completely
> probe the PCI bus and fill all the properties, or doing everything
> ourselves. Given that Linux already has to do it for PCIe hotplug,
> there is little value in the former unless you run under a hypervisor
> that does not let you reconfigure the PCI resources (e.g. some
> versions of IBM pSeries).

Well, x86 is sort of half and half. If Linux is happy with the
firmware values it uses them, otherwise things can change. Hotplug
tries to work within those values in some cases.

There is a real need for this, any time the firmware is re-entered it
could touch any of the address map. Moving things around could break
that. On x86 there are re-entry points in AHCI, EFI, and system
management mode.

ARM seems to be developing PSCI which is a similar firmware re-entry
point, and 'secure mode' seems to be another (???)

So.. I don't think it matters today for mvebu, but something to think
about - shuffling the firmware's address map could be dangerous.

> > So the PCI driver would now have to dynamically determine on its own a
> > host bridge aperture based on available space in the resource tree,
> > this is done instead of parsing ranges. I guess we could have a
> > 'linux,host-aperture' or something as a stop gap.
> 
> The PCI driver already has to communicate with the MBUS driver, so
> it can just ask MBUS to return the largest unassigned continugous 
> physical address range.

Right, this information should be in the resource tracking stuff as
well. (/proc/iomem should work properly, for instance)

Jason
