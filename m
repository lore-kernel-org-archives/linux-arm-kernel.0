From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 18 Dec 2012 08:32:50 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50CFD0B3.6030208@wwwdotorg.org>
References: <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
Message-ID: <20121218073250.GA32572@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 07:10:59PM -0700, Stephen Warren wrote:
> On 12/17/2012 12:41 PM, Thierry Reding wrote:
> > On Mon, Dec 17, 2012 at 11:29:11AM -0700, Jason Gunthorpe wrote:
> >> 
> >>>> Ie route access for 00:1N.0 to the configuration space on
> >>>> bridge port N
> >>> 
> >>> Is there any particular reason why you choose 0x10 as the base
> >>> slot for bridge ports? With the latest DT support patches,
> >>> mapping this should be even simpler as we associate a port
> >>> index with each port and the port array is gone.
> >> 
> >> No specific reason, it similar to what intel did and clearly
> >> shows the port number in a octet of the device id. It just can't
> >> be 0.
> > 
> > So I tried and implemented something along the lines of what you 
> > suggested, and guess what? It does work indeed. For some reason
> > even the "imprecise external abort" goes away. Basically what I did
> > is fake the configuration space accesses to 0000:0.0 so that they
> > return semi-valid data. Nothing special yet, just basically
> > returning vendor and product ID, header type, class and other
> > static data.
> > 
> > Initially the implementation was read-only and that still caused
> > the external abort, but adding nop'ed write functions apparently
> > solved that.
> > 
> > What I'll do next is add some caching of written values, so that
> > reading them back actually yields something correct. After that
> > I'll post what I have so that others can look at it or even reuse
> > it.
> 
> Some internal discussion implies this shouldn't be required; here's
> what they said:
> 
> -----Original Message----- (from Chung-Hung Lai)
> 
> All PCIE root port registers are in configuration space. To access
> them, as well as configuration registers of PCIE devices below the
> bridge, you will need to program the AXI to FPCI BAR mappings defined
> in AFI. After programmed those, the configuration register space of
> PCIE fabric are mapped to Tegra's MMIO register space. I take it back
> that T30 and [elided] have differences - that was for other units, not
> PCIE.
> 
> As Mark said, all AFI's own registers are in MMIO space and can be
> accessed directly.
> 
> Thanks,
> Luke
> 
> -----Original Message----- (from Mark Van Nostrand)
> 
> There are pci bridge registers but also registers to configure the
> PCIE wrapper.  AFAIK all Tegra devices (T20/T30/[elided]) have
> compliant bridge registers but also need AFI (PCIE wrapper)
> configuration updates as well.

But none of the above matches the (sparse) documentation. The TRM
clearly states that each root port has a 4 KiB window that should be
used to access the root port's configuration space. The driver supports
that information.

I can also easily refute it by modifying the configuration space
accessor to look like this:

	static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
					int where, int size, u32 *value)
	{
		struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
		void __iomem *addr = NULL;

		if (where >= 0x100)
			return PCIBIOS_BAD_REGISTER_NUMBER;

		addr = pcie->cs + PCIE_CONF_BUS(bus->number) +
				  PCIE_CONF_DEV(PCI_SLOT(devfn)) +
				  PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
				  PCIE_CONF_REG(where);

		*value = readl(addr);

		if (size == 1)
			*value = (*value >> (8 * (where & 3))) & 0xff;
		else if (size == 2)
			*value = (*value >> (8 * (where & 3))) & 0xffff;

		return PCIBIOS_SUCCESSFUL;
	}

and booting with that modification, which yields:

[    3.097784] pci 0000:00:00.0: [1556:4711] type 01 class 0x060400

Which is the PLDA bridge within the FPGA, *not* the Tegra host bridge.

So either we're doing something really wrong when setting up the FPCI
BAR mappings or you guys need to get your information right.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121218/b78f1872/attachment.sig>
