From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Sep 2014 10:54:32 +0200
Subject: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
In-Reply-To: <542505B3.7040208@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo>
 <20140925171612.GC31157@bart.dudau.co.uk>
 <542505B3.7040208@huawei.com>
Message-ID: <20140926085430.GG31106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 02:20:35PM +0800, Yijing Wang wrote:
> >> The PCI core can already deal with that. An MSI chip can be set per bus
> >> and the weak pcibios_add_bus() can be used to set that. Often it might
> >> not even be necessary to do it via pcibios_add_bus() if you create the
> >> root bus directly, since you can attach the MSI chip at that time.
> > 
> > But I'm thinking that we need to move away from pcibios_add_bus() interface to do
> > something that should be generic. You don't need to be called for every bus when all
> > you want is just the root bus in order to add the MSI chip. Also, from looking at
> > the current patchset, a lot of architectures would set the MSI chip to a global
> > variable, which means you don't have an option to choose the MSI chip based on the
> > bus.
> 
> I also agree to remove the pcibios_add_bus() in arm which call .add_bus() to associate msi_chip
> and PCI bus.
> 
> In my opinions, all PCI devices under the same PCI hostbridge must share same msi chip, right ?
> So if we can associate msi chip and PCI hostbridge, every PCI device can find correct msi chip.
> PCI hostbridge private attributes can be saved in PCI sysdata, and this data will be propagate to
> PCI root bus and its child buses.

struct pci_sys_data is architecture specific, so the code won't become
any more generic than it is now.

> >>> What I would like to see is a way of creating the pci_host_bridge structure outside
> >>> the pci_create_root_bus(). That would then allow us to pass this sort of platform
> >>> details like associated msi_chip into the host bridge and the child busses will
> >>> have an easy way of finding the information needed by finding the root bus and then
> >>> the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
> >>> everyone and the drivers can remove their kludges that try to work around the
> >>> current limitations.
> >>
> >> I think both issues are orthogonal. Last time I checked a lot of work
> >> was still necessary to unify host bridges enough so that it could be
> >> shared across architectures. But perhaps some of that work has
> >> happened in the meantime.
> > 
> > Breaking out the host bridge creation from root bus creation is not difficult, just not
> > agree upon. That would be the first step in making the generic host brige structure
> > useful for sharing, specially if used as a sort of "parent" structure that you can
> > wrap with your actual host bridge structure.
> 
> Breaking out the host bridge creation is a good idea, but there need a lot of changes, we can
> do it in another series.

I agree, this can be done step by step.

> And if we save msi chip in pci sysdata now, it will be easy to
> move it to generic pci host bridge. We can also move the pci domain number and other common info to it.

But like I said above, we wouldn't gain anything by moving the MSI chip
into struct pci_sys_data, since the core code couldn't access it from
there. The code wouldn't become more generic than the current approach
of using pcibios_add_bus(). At least for Tegra it's trivial to just hook
it up in tegra_pcie_scan_bus() directly (patch attached). So I think a
generic solution would be to allow it to be easily associated with a
bus.

Perhaps it would be as simple as adding a pci_scan_root_bus_with_msi()
or something with a less awkward name, or extending the existing
pci_scan_root_bus() with an MSI chip parameter. The function already has
too many arguments for my taste, though, so I'd like to avoid the
latter.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/a887458e/attachment.sig>
