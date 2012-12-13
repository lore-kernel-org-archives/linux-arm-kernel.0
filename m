From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 13 Dec 2012 15:27:00 -0700
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <201212132146.05829.arnd@arndb.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121213175442.GC14619@obsidianresearch.com>
 <20121213201206.69452b8f@skate> <201212132146.05829.arnd@arndb.de>
Message-ID: <20121213222700.GA8129@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 09:46:05PM +0000, Arnd Bergmann wrote:

> > Hum, not sure to follow you here. What sort of finer granularity does
> > PCIe requires?

PCIe requires 4k alignment of bridge IO addresses and 1M alignment
of bridge memory addresses.. I was thinking the mismatch of 4k vs 64k
in the mbus kills the idea, but some cleverness with the VM is
possible to fix it up. See below

> Maybe it works correctly if you set up all ten I/O windows to point
> to the same addresses? I don't have the documentation, so it might
> say that this is unsupported, but otherwise it may be worth trying.

The kirkwood docs say windows must never overlap.

> > > By far the easiest thing is to keep them as separate PCI busses and
> > > require DT to manage each one individually, address ranges and
> > > all. :(
> > 
> > Does that mean that your earlier suggestion of emulating a PCI-to-PCI
> > bridge in software is no longer your preferred suggestion?
> 
> If the child buses of that virtual bridge can't use the same I/O
> space window, that would require significant changes to the Linux
> PCI implementation, which does not sound right.

The default value for ARM's IO_SPACE_LIMIT is 1048575 so can fit 16
64k IO regions within PCI_IO_VIRT_BASE space. So far the marvell
drivers have assigned a unique 64k io region to each PEX.

The Linux PCI implementation has no problem with a > 16 bit IO
address, it just truncates it when it goes into configuration
registers, which matches what the HW does.

However, if you want to make each PEX into a compliant virtual root
port bridge then you have to live with PCIe rules, which means the
host bridge gets a 64k region and each virtual root port bridge gets
configured for a 4k aligned sub region.

So you have to match this to the 64k IO decoding windows that marvell
supports.

Here is a possible way using the VM subsystem:

- You reserve 10*64k of physical address space for bridge IO decoding
- The Host bridge and linux are told to map only 64k of IO from 0 to 0xFFFF
- When linux asks the root port bridge to allocate an IO range it is
  aligned to a 4K boundary (PCIe requires this)
- The root port bridge grabs an mbus window and one of the 64k
  physical blocks and sets that up.
- The root port bridge uses pci_ioremap_io to assign the virtual addresses 
  for the 4k aligned range that was assigned by linux to a
  portion of the physical addresses within the 64k physical window.

eg:
 PEX 0: Physical IO window 0x10000 -> 0x1ffff
 PEX 1: Physical IO window 0x20000 -> 0x2ffff

 PEX 0: Bridge is configured to claim IO range 0x0 -> 0xfff
 PEX 1: Bridge is configured to claim IO range 0x3000 -> 0x3fff

pci_ioremap_io does:
 PCI_IO_VIRT_BASE +      0 ->  0xfff == physical 0x10000 -> 0x10fff
 PCI_IO_VIRT_BASE + 0x3000 -> 0x3fff == physical 0x23000 -> 0x23fff

So via pci_ioremap_io we stitch together a single 64k IO space across
all 10 PEX's using page granular portions of the physical 640K
allocated for the mbus mapping.

It would be a bit tidier if the PCIe core code could learn that these
particular root port bridges have a 64k alignment requirement for IO,
but I didn't see any easy way to do that .... ?

Regards,
Jason
