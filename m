From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 17 Jul 2013 07:07:49 +0200
Subject: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <3309315.fJN6KWK0oA@wuerfel>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <000001ce68d7$ca762200$5f626600$@samsung.com>
 <20130614105310.GA19060@manwe> <3309315.fJN6KWK0oA@wuerfel>
Message-ID: <20130717050748.GD11359@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 02:38:49PM +0200, Arnd Bergmann wrote:
> On Friday 14 June 2013 12:53:11 Thierry Reding wrote:
> > 
> > I think the biggest missing piece is pci_common_exit(), the counterpart
> > of pci_common_init(), to cleanup a host bridge on ARM. I haven't looked
> > in detail at the other architectures, but I suspect there must be some
> > code to call when a host bridge is removed.
> > 
> > Looking at drivers/pci/remove.c, it seems like pci_remove_root_bus()
> > might be what we're looking at. It isn't exported so it can't be used by
> > modules, but that can be changed. Is that how a host bridge is typically
> > removed from the system?
> 
> It's fairly new to have host bridges in loadable modules, so I'm pretty
> sure it's not supported by the core yet, but it also doesn't seem hard
> to do. I think you are right with regard to pci_remove_root_bus,
> and Bjorn might be able to provide more information.
> 
> Ideally we should be able to load and unload the pci host driver
> in a loop indefinitely without crashing or exposing any races
> or leaks, but I would not bet on that working without bugs in the
> core, since that goes beyond the normal pci (device) hotplug case.

I've done some preliminary testing on Tegra using sysfs to unbind and
rebind the device from and to the driver. Some code needs to be added
for this to work, but it doesn't crash and PCI even continues to work
after unbinding and rebinding (tested using gigabit ethernet).

However I haven't looked for leaks yet, and I'm pretty sure some more
code is required to undo some of what pci_common_init() does on ARM.
Looking more closely, I think most (if not all) remaining leaks could
be fixed by keeping the list of pci_sys_data structures around and
cleaning them up properly.

Given the experimental nature of this I don't want to make that part of
the driver for 3.12 and I've opted to just disable any means of removing
the driver for now. But I do want to get back to this after the driver
has been merged.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/f8bfe607/attachment.sig>
