From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Feb 2013 19:49:49 +0000
Subject: [PATCH 06/32] arm: pci: add a align_resource hook
In-Reply-To: <20130212200118.531cda2e@skate>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302121803.12660.arnd@arndb.de> <20130212200118.531cda2e@skate>
Message-ID: <20130212194949.GV17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 08:01:18PM +0100, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 12 Feb 2013 18:03:12 +0000, Arnd Bergmann wrote:
> > On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> > > The PCI specifications says that an I/O region must be aligned on a
> > > 4 KB boundary, and a memory region aligned on a 1 MB boundary.
> > > 
> > > However, the Marvell PCIe interfaces rely on address decoding
> > > windows (which allow to associate a range of physical addresses
> > > with a given device), and those have special requirements compared
> > > to the standard PCI-to-PCI bridge specifications.
> > 
> > I'm not convince that we should add this complexity yet, until
> > everyone agrees on the basic approach taken.
> 
> Regardless of whether we choose to have the emulated PCI-to-PCI bridges
> or not, we still need this align_resource() hook.
> 
> In the solution you propose, where each PCIe interface is represented
> as a separate PCIe domain, we still need the kernel to dynamically
> assign ranges of address to each memory BAR and I/O BAR of each PCIe
> device. And those range of address must comply with the address
> decoding windows requirements, otherwise, we don't be able to create
> those address decoding windows, and the devices will be unaccessible.

I think what Arnd is suggesting is that you treat each of your busses
as a separate root bus.

This then means that you register each bus separately via
pci_common_init() (this can take 0..N root buses and scan them.)

We can then size each bus (which means, totalling up the amount of space
each bus requires).

At that point, we know how much memory and IO space each bus requires,
and platform code can then setup the appropriate bridge windows.  The
alignment of the bases is something that platform code can deal with
in its allocation mechanism, and the resulting allocated resources
can then be assigned to each PCI bus.

Once that's done, we can then call pci_bus_assign_resources() to setup
the resources for each bus, which will use our allocated resources.

There's a downside to this though: the pci core doesn't size root buses,
because:
(a) it assumes that they're fixed size.
(b) root buses don't have a P2P 'bridge' to be sized.

I'm wondering if we could come up with a way to refactor
__pci_bus_size_bridges() so that we can get this information out of it.
That's more a question for PCI people though.
