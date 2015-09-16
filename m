From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Sep 2015 18:29:35 +0100
Subject: [PATCH 4/6] PCI: generic: Correct, and avoid overflow, in
 bus_max calculation.
In-Reply-To: <20150916112852.GC17510@red-moon>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-5-git-send-email-ddaney.cavm@gmail.com>
 <20150915174934.GL31157@arm.com>
 <55F85D4E.9020604@caviumnetworks.com>
 <20150915183500.GR31157@arm.com>
 <55F86764.4060502@caviumnetworks.com>
 <20150916104152.GC28771@arm.com> <20150916112852.GC17510@red-moon>
Message-ID: <20150916172935.GT28771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Wed, Sep 16, 2015 at 12:28:52PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 16, 2015 at 11:41:53AM +0100, Will Deacon wrote:
> > > Here is the current code:
> > > 
> > > >> 	bus_range = pci->cfg.bus_range;
> > > >> 	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> > > >> 		u32 idx = busn - bus_range->start;
> > > 
> > > The index is offset by the bus range start...
> > > 
> > > >> 		u32 sz = 1 << pci->cfg.ops.bus_shift;
> > > >>
> > > >> 		pci->cfg.win[idx] = devm_ioremap(dev,
> > > >> 						 pci->cfg.res.start + busn * sz,
> > > >> 						 sz);
> > > 
> > > But, the offset into the "reg" property is the raw bus number.
> > > 
> > > 
> > > >> 		if (!pci->cfg.win[idx])
> > > >> 			return -ENOMEM;
> > > >> 	}
> > > 
> > > 
> > > I hope that makes it more clear.
> > 
> > Got it. So we should be using idx instead of busn in the devm_ioremap
> > call above.
> 
> I think that's not what's specified in the PCI firmware specification,
> at least for the MMCFG regions. For MMCFG regions (quoting the specs)
> the "base address of the memory mapped configuration space always
> corresponds to bus number 0 (regardless of the start bus number decoded
> by the host bridge)..."
> 
> For the x86 implementation have a look at:
> 
> arch/x86/pci/mmconfig_64.c mcfg_ioremap()
> 
> static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
> {
> 	void __iomem *addr;
> 	u64 start, size;
> 	int num_buses;
> 
> 	start = cfg->address + PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
> 	num_buses = cfg->end_bus - cfg->start_bus + 1;
> 	size = PCI_MMCFG_BUS_OFFSET(num_buses);
> 	addr = ioremap_nocache(start, size);
> 	if (addr)
> 		addr -= PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
> 	return addr;
> }
> 
> The MCFG config accessors add back the PCI_MMCFG_BUS_OFFSET(cfg->start_bus)
> to the virtual address so that the proper virtual address is used when
> issuing the config cycles, that's my understanding.

Ok. I think that whether the config space mapping or the config accessors
do the fixup should remain an implementation detail, but the resource
identifying config space should be dealt with consistently.

So that means the reg property should describe everything from bus 0,
but then we only map the region corresponding to the bus-range.

> So IMO we have to define what "reg" represents for ECAM in DT, we can't
> leave this open to interpretation (and I think makng MCFG and DT config
> work the same way would be ideal).

If we define reg to cover the whole config space from bus 0 onwards,
then I think the driver should work as-is today. It's slightly odd, in
that there may be a prefix of config space that maps to god-knows-where,
but it's consistent with ACPI and doesn't require us to change the driver.

David?

Will
