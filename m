From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 9 Aug 2013 16:01:42 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20130731205034.GA17615@obsidianresearch.com>
References: <51DD88A4.1030506@keymile.com> <20130731100359.3e789236@skate>
 <51F8CA44.4080802@keymile.com> <20130731110045.2dc84981@skate>
 <20130731205034.GA17615@obsidianresearch.com>
Message-ID: <20130809140140.GA14990@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 02:50:34PM -0600, Jason Gunthorpe wrote:
> On Wed, Jul 31, 2013 at 11:00:45AM +0200, Thomas Petazzoni wrote:
> 
> > > Actually, the main reason for trying to use this driver was because I 
> > > wanted to model a PCIe *device* within the device tree, so to expose its 
> > > GPIOs and IRQs to be referenced (through phandles) from other device 
> > > tree nodes. The way I understand it, turns out this is not the way to 
> > > go, as PCI/PCIe are essentially enumerated busses, so you're not 
> > > supposed to -and it's not a trivial task to- put any information about 
> > > real devices within the device tree.
> > > Do you have any suggestion about that?
> > 
> > Indeed, PCI/PCIe devices are enumerated dynamically, so they are not
> > listed in the Device Tree, so there's no way to "attach" more
> > information to them.
> > 
> > Device Tree people, any suggestion about the above question?
> 
> No, that isn't true.
> 
> Device tree can include the discovered PCI devices, you have to use
> the special reg encoding and all that weirdness, but it does work. The
> of_node will be attached to the struct pci device automatically.
> 
> On server/etc DT platforms the firmware will do PCI discovery and
> resource assignment then dump all those results into DT for the OS to
> reference.
> 
> This is a major reason why we wanted to see the standard PCI DT be
> used for Marvell/etc, the existing infrastructure for this is
> valuable.
> 
> AFAIK, Thierry has tested this on tegra, and I am doing it on Kirkwood
> (though not yet with the new driver).
> 
> It is useful for exactly the reason stated - you can describe GPIOs,
> I2C busses, etc, etc in DT and then upon load of the PCI driver engage
> the DT code to populate and connect all that downstream
> infrastructure.

Obviously this doesn't work in general purpose systems because the PCI
hierarchy needs to be hardcoded in the DT. If you start adding and
removing PCI devices that will likely change the hierarchy and break
this matching of PCI device to DT node.

It's quite unlikely to have a need to hook up GPIOs or IRQs via DT in a
general purpose system, though, so I don't really see that being a big
problem.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/52a28f3e/attachment.sig>
