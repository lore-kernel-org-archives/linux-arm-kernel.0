From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 15:56:47 +0200
Subject: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <000001ce6bd7$50146e60$f03d4b20$@samsung.com>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <7174350.I5qK0sQfHM@wuerfel> <000001ce6bd7$50146e60$f03d4b20$@samsung.com>
Message-ID: <201306181556.47656.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Jingoo Han wrote:
> On Monday, June 17, 2013 9:45 PM, Arnd Bergmann wrote:
> > On Monday 17 June 2013 18:45:52 Jingoo Han wrote:
> > > On Friday, June 14, 2013 9:54 PM, Arnd Bergmann wrote:
> > > >
> > > > Please look up the documentation about inbound viewport and describe
> > > > in a code comment what it does. I /assume/ that this is how DMA accesses
> > > > from the bus get translated into AXI bus transactions. If so, you have
> > > > to let the window translate addresses from RAM. If it's something else,
> > > > then you should document what it is and how it needs to be set up.
> > >
> > > One of our hardware engineer confirmed it.
> > > He said that these inbound functions are unnecessary.
> > > Also, I checked that PCIe works properly without these functions.
> > > So, I will remove these inbound functions.
> > 
> > Ok, good. So DMA just gets translated 1:1 independent of the
> > inbound viewport? Have you tested this with PCI device using
> > DMA?
> 
> According to our hardware engineer,
> He said that
> "That's correct. We tested it by doing a memory write from the device.
> A device DMA is a series of memory r/w so I expect it to work same way."
> 
> Also, he thought that I already tested too, since it works after removing
> the functions.

It could be that the default setting just creates a 1:1 map so that would
work, but if you tested it, that should be good enough.

> I looked at the pci-mvebu driver,
> Then I fixed it as the pci-mvebu driver did.
> Also, I added 'global_io_offset'.
> 
> @@ -909,6 +909,12 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>                 if (restype == IORESOURCE_IO) {
>                         of_pci_range_to_resource(&range, np, &pp->io);
>                         pp->io.name = "I/O";
> +                       pp->io.start = max_t(resource_size_t,
> +                                               PCIBIOS_MIN_IO,
> +                                               range.pci_addr + global_io_offset);
> +                       pp->io.end = min_t(resource_size_t,
> +                                               IO_SPACE_LIMIT,
> +                                               range.pci_addr + range.size + global_io_offset);
>                         pp->config.io_size = resource_size(&pp->io);
>                         pp->config.io_bus_addr = range.pci_addr;
> 
> In this case, boot message is as below:
> 
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
> pci_bus 0000:00: root bus resource [mem 0x40011000-0x5fffffff]
> [.....]
> PCI host bridge to bus 0001:00
> pci_bus 0001:00: root bus resource [io  0x10000-0x20000] (bus address [0x0000-0x10000])
> pci_bus 0001:00: root bus resource [mem 0x60011000-0x7fffffff]

Ok, very good.
> 
> I will remove a 'remove' callback. Is it OK?
> Or what should I do?

I think you should keep the remove function, but add a comment explaining that
you don't allow module unload and that in order to allow it, the remove function
will have to remove all pci buses and devices under the host bridge.

	Arnd
