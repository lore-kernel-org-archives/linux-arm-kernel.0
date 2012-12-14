From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 14 Dec 2012 10:27:29 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
References: <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
Message-ID: <20121214172729.GA7671@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 04:10:45PM +0100, Thierry Reding wrote:
> > So I tried this today and it breaks horribly. There's some internal
> > abort or something. I don't have access to the hardware right now and
> > forgot to save the log output, but I can follow up in the morning. Also
> > up until the abort, bus 0000:00.0 was identified as the virtual switch
> > within the FPGA that's connected to port 0, so that would indicate that
> > it isn't in fact compliant and neither root port is reachable via the
> > regular mapping.
> 
> So here's the output of the crash when removing the special cases that I
> promised:
> 
> [    2.662948] tegra-pcie 80003000.pcie-controller: PCI host bridge to bus 0000:00
> [    2.670271] pci_bus 0000:00: root bus resource [io  0x82000000-0x8200ffff]
> [    2.687624] pci_bus 0000:00: root bus resource [mem 0x81000000-0xa7ffffff]
> [    2.696002] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xb7ffffff pref]
> [    2.708361] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.746728] pci 0000:00:00.0: [1556:4711] type 01 class 0x060400

This is your 

        02:00.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge

Device, right?

Just looking at the driver a bit, and your results, it looks to me
like the config space for the internal devices is seperate from the
register to send config packets to the bus(es).

So, it looks like what I suggested earlier is the trouble, you are
missing the host bridge configuration

If you change tegra_pcie_read/write_conf to be more like:

static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
                                int where, int size, u32 *val)
{
	/* Check the host bridge bus, all the pci-pci bridge ports
	   live here */
	if (bus->number == 0) {
           if (PCI_SLOT(devfn) >= 0x10 &&
	       PCI_SLOT(devfn) < 0x10 + tegra_pcie.num_ports &&
	       PCI_FUNC(devfn) == 0) {
               addr = tegra_pcie.port[PCI_SLOT(devfn) - 0x10].base + (where & ~0x3);
           } else {
	       *val = 0xffffffff;
               return PCIBIOS_DEVICE_NOT_FOUND;
           }
       }
}

Ie route access for 00:1N.0 to the configuration space on bridge port N

Also, you need to change the PCI core binding to report as only one
controller, and probably some other minor fixups related to that.

Then you are a bit closer. You should see both root port bridges
appear in your lspci.. IIRC the host bridge device is not essential to
discovery working on Linux.

        00:00.0 PCI bridge: NVIDIA Corporation Device 0bf0 (rev a0) (prog-if 00 [Normal decode])
                Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-

Heh, I wonder WTF that does on a ARM system! On a HT system that takes
care of mapping PCIe format MSI to HT format MSI..

Jason
