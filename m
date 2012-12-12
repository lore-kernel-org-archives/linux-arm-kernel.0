From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Dec 2012 14:51:38 -0700
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121212165833.6a35a6ec@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111056.58970.arnd@arndb.de> <20121212165833.6a35a6ec@skate>
Message-ID: <20121212215138.GC11530@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 04:58:33PM +0100, Thomas Petazzoni wrote:

> and the global physical address space is limited in size, we definitely
> do not want to have static mappings at fixed physical addresses
> hardcoded in the Device Tree.

Unfortunately DT pretty much requires that all PCI host bridges hard
code the addresess. The expectation seems in many cases that the BIOS
will do assignment and discovery and just propagate it into the DT
format.

If you are able to make the driver appear as one host bridge with
multiple root ports, (as we have been discussion, one way other the
other) then the DT model is fairly sane. The ranges property specifies
the entire available decode address space and the driver/linux
core/whatever has to split that up amongst the ports and assign the
split up to the mbus windows.

pex at e0000000 {
                /* The standard for PCI devices is 3 byte addresses, with the top
                   cell being the region encoding 0x02000000 is non prefetchable mmio */
                device_type = "pci";
                #address-cells = <3>;
                #size-cells = <2>;
                ranges = <0x02000000 0x00000000 0x00000000  0xe0000000  0x0 0x8000000>;
		/* Also ranges for prefetchable and IO. On Marvell
		   prefetchable and MMIO are the same decoder window */
                bus-range = <0x0 0xFF>;

		regs = <0xD0040000 0x2000
		        0xD0042000 0x2000
                        ...>; // One tuple for each port
                interrupts = <58 59.. >; // One IRQ for each port

		/* The PEX is a chained interrupt controller too,
		   since each pex has a interrupt mask/cause that
		   contains INTA/B/C/D and internal status */
		interrupt-controller;

		/* This describes the INTA/B/C/D interrupt lines for
		   each port. The exact layout depends on how the
		   ports are viewed in the kernel */
		interrupt-map = <.. &pex ..>;
};

[ you may need to pull the pex interrupt controller out, but that is,
 IHMO, not as easy to work with considering how the HW is setup]

With your current driver that has one host bridge per PEX you need one
of the above for every PEX with ranges that describe the static
allocation for the PEX.

A combined multi-port driver would use something like the above, with
a regs tuple for each port.

The driver should parse the ranges and bus-range and setup the
resource regions appropriately, be it for the port or for the whole
port group.

> device number." Again, we don't have such hardcoded relation between a
> PCIe interface and "PCI address lines", so I really don't see how to
> use this "interrupt mapping" representation.

The document is describing the legacy bus PCI interrupt scheme. PCI-E
emulates this using INTA/B/C/D inband messaging. It also emulates the
'standard' IDSEL hookup. So you end up with a very simple identity
mapping..

   /* Single port version, multiple-ports will have one group of four
      for each */
   interrupt-map-mask = <0x0 0x0 0x0 0x7>;
   interrupt-map = <
                     0x0 0x0 0x0 0x1 &pex 0> /* int A */
                     0x0 0x0 0x0 0x2 &pex 1> /* int B */
                     0x0 0x0 0x0 0x3 &pex 2> /* int C */
                     0x0 0x0 0x0 0x4 &pex 3> /* int D */>;

However, be aware, that if you insert a bridge into your software
model (as discussed) then you probably want to describe the bridge in
the DTS and move the interrupt-map into the bridge itself so the
bridge required twizzling is not as complex.

The process that goes on behind the scences is roughly:
  - Start a device asking for an interrupt
  - Construct the 4 dw UIS
  - Travel up the bridges, swizzling the last dw according to the
    bridge rules
  - When we finally find a node with interrupt-map, match the 4 dw
    UIS to get to a OF interrupt handle

Note that the Kirkwood/Orion stuff doesn't really do this right. It
just assigns a single interrupt to the port, which is the PEX
interrupt cause summary interrupt and provides no possibility to
access INTA/B/C/D which will break if you ever try to use a
multi-function device or a PCI bridge. It also doesn't monitor the
other PEX interrupt statuses to machine check when things go wrong on
the bus.

Also, I have some stuff that makes MSI work on Kirkwood that I am
using, you might be interested in some of that too someday..

Well, I hope you find this informative..

Jason
