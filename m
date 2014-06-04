From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 4 Jun 2014 15:04:05 -0600
Subject: [PATCH] ARM: fix debug prints relevant to PCI devices
In-Reply-To: <538F738A.6020003@wwwdotorg.org>
References: <1401909447-8434-1-git-send-email-vidyas@nvidia.com>
 <538F738A.6020003@wwwdotorg.org>
Message-ID: <20140604210405.GA31230@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 01:29:14PM -0600, Stephen Warren wrote:
> On 06/04/2014 01:17 PM, Vidya Sagar wrote:
> > As per PCIe spec, fast back-to-back transactions feature
> > is not applicable to PCIe devices. Hence, do not print
> > that fast back-to-back trasactions are disabled when
> > there is a PCIe device found on the bus
> 
> > @@ -298,6 +299,8 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> >  		u16 status;
> >  
> > +		if (!has_pcie_dev)
> > +			has_pcie_dev = pci_pcie_cap(dev);
> 
> This sets the flag if any PCIe device is detected, even if regular PCI
> devices are also detected. I assume the two can be mixed on a bus if
> there's a bridge (although perhaps that would be separate buses, and
> child buses don't get traversed by this function?)

I like the concept, and the logic looks OK as is (though pci_is_pcie
is a better choice). The function is called on a bus number basis, and
it isn't physically possible to mix technology on a single bus number.

Jason
