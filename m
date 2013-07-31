From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 31 Jul 2013 14:50:34 -0600
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20130731110045.2dc84981@skate>
References: <51DD88A4.1030506@keymile.com> <20130731100359.3e789236@skate>
 <51F8CA44.4080802@keymile.com> <20130731110045.2dc84981@skate>
Message-ID: <20130731205034.GA17615@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 11:00:45AM +0200, Thomas Petazzoni wrote:

> > Actually, the main reason for trying to use this driver was because I 
> > wanted to model a PCIe *device* within the device tree, so to expose its 
> > GPIOs and IRQs to be referenced (through phandles) from other device 
> > tree nodes. The way I understand it, turns out this is not the way to 
> > go, as PCI/PCIe are essentially enumerated busses, so you're not 
> > supposed to -and it's not a trivial task to- put any information about 
> > real devices within the device tree.
> > Do you have any suggestion about that?
> 
> Indeed, PCI/PCIe devices are enumerated dynamically, so they are not
> listed in the Device Tree, so there's no way to "attach" more
> information to them.
> 
> Device Tree people, any suggestion about the above question?

No, that isn't true.

Device tree can include the discovered PCI devices, you have to use
the special reg encoding and all that weirdness, but it does work. The
of_node will be attached to the struct pci device automatically.

On server/etc DT platforms the firmware will do PCI discovery and
resource assignment then dump all those results into DT for the OS to
reference.

This is a major reason why we wanted to see the standard PCI DT be
used for Marvell/etc, the existing infrastructure for this is
valuable.

AFAIK, Thierry has tested this on tegra, and I am doing it on Kirkwood
(though not yet with the new driver).

It is useful for exactly the reason stated - you can describe GPIOs,
I2C busses, etc, etc in DT and then upon load of the PCI driver engage
the DT code to populate and connect all that downstream
infrastructure.

I understand someday DT overlays might be a better alternative for
this, but AFAIK today in mainline this is what we have..

That said, the guideline to not include discoverable information in DT
is a good guideline for upstream DTs..

Jason
