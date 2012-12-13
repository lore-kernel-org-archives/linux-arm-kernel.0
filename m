From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Dec 2012 14:58:54 +0000
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121212215138.GC11530@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121212165833.6a35a6ec@skate> <20121212215138.GC11530@obsidianresearch.com>
Message-ID: <201212131458.55020.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 December 2012, Jason Gunthorpe wrote:

> pex at e0000000 {
>                 /* The standard for PCI devices is 3 byte addresses, with the top
>                    cell being the region encoding 0x02000000 is non prefetchable mmio */
>                 device_type = "pci";
>                 #address-cells = <3>;
>                 #size-cells = <2>;
>                 ranges = <0x02000000 0x00000000 0x00000000  0xe0000000  0x0 0x8000000>;
> 		/* Also ranges for prefetchable and IO. On Marvell
> 		   prefetchable and MMIO are the same decoder window */
>                 bus-range = <0x0 0xFF>;
> 
> 		regs = <0xD0040000 0x2000
> 		        0xD0042000 0x2000
>                         ...>; // One tuple for each port
>                 interrupts = <58 59.. >; // One IRQ for each port
> 
> 		/* The PEX is a chained interrupt controller too,
> 		   since each pex has a interrupt mask/cause that
> 		   contains INTA/B/C/D and internal status */
> 		interrupt-controller;
> 
> 		/* This describes the INTA/B/C/D interrupt lines for
> 		   each port. The exact layout depends on how the
> 		   ports are viewed in the kernel */
> 		interrupt-map = <.. &pex ..>;
> };

Agreed, this looks like it would be the ideal representation.

> > device number." Again, we don't have such hardcoded relation between a
> > PCIe interface and "PCI address lines", so I really don't see how to
> > use this "interrupt mapping" representation.
> 
> The document is describing the legacy bus PCI interrupt scheme. PCI-E
> emulates this using INTA/B/C/D inband messaging. It also emulates the
> 'standard' IDSEL hookup. So you end up with a very simple identity
> mapping..
> 
>    /* Single port version, multiple-ports will have one group of four
>       for each */
>    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>    interrupt-map = <
>                      0x0 0x0 0x0 0x1 &pex 0> /* int A */
>                      0x0 0x0 0x0 0x2 &pex 1> /* int B */
>                      0x0 0x0 0x0 0x3 &pex 2> /* int C */
>                      0x0 0x0 0x0 0x4 &pex 3> /* int D */>;

> Note that the Kirkwood/Orion stuff doesn't really do this right. It
> just assigns a single interrupt to the port, which is the PEX
> interrupt cause summary interrupt and provides no possibility to
> access INTA/B/C/D which will break if you ever try to use a
> multi-function device or a PCI bridge. It also doesn't monitor the
> other PEX interrupt statuses to machine check when things go wrong on
> the bus.

If the IntA to IntD lines are all on the same host interrupt, you
might only need one line above and make the map-mask all zeroes.

I would assume though that we need to key in the slot ID in some way.

> Also, I have some stuff that makes MSI work on Kirkwood that I am
> using, you might be interested in some of that too someday..
> 
> Well, I hope you find this informative..

Thank you very much for your explanation, that was much more than I would
have known without extensive research on the Marvell specifics.

	Arnd
