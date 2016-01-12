From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 12 Jan 2016 18:38:54 +0000
Subject: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <4945809.OlUZI8D7JL@wuerfel>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <20160111153949.GA2366@red-moon> <5693D0AE.4020306@codeaurora.org>
 <4945809.OlUZI8D7JL@wuerfel>
Message-ID: <20160112183854.GB5139@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 03:30:25PM +0100, Arnd Bergmann wrote:
> On Monday 11 January 2016 10:56:30 Sinan Kaya wrote:
> > 
> > #_dmesg_|_grep_resource
> > [    2.945762] pci_bus 0000:00: root bus resource [io  0x0000-0xefff window] (bus address [0x1000-0xffff])
> > [    3.652201] pci_bus 0002:00: root bus resource [io  0xf000-0x1dfff window] (bus address [0x1000-0xffff])
> > [    6.546716] pci_bus 0006:00: root bus resource [io  0x1e000-0x2cfff window] (bus address [0x1000-0xffff])
> > / #
> 
> This is bad. We normally want to stay out of the first 0x1000 bytes of
> the Linux space, to prevent drivers from poking into the ISA
> registers.

You are referring to:

pci_bus 0000:00: root bus resource [io  0x0000-0xefff window]
                                        ^^^^^^
here, right ? [0x0 - PCIBIOS_MIN_IO] is not assigned by the PCI
code that reassigns resources anyway, so devices with IO BARs won't
get assigned [0x0 - PCIBIOS_MIN_IO] address space (Linux space).

Are you saying we should disallow the [0x0 - 0x1000] in the PCI busses
IO resource (Linux space) ?

In pci_address_to_pio() the offset (Linux IO resource) we assign starts
from 0x0, so we always allocate that chunk of IO address space (that is
an offset into the Linux virtual address space), am I correct ?

> We can have one of the buses be the "primary" bus that has its first
> 0x1000 bytes of I/O space mapped into the respective Linux addresses,
> but mapping the second 0x1000 bytes into the reserved space is the
> worst possible outcome here, as legacy ISA drivers will now poke at
> random other devices that are intentionally moved to high addresses to
> stay of of that range.

And you are referring to:

root bus resource [io  0x0000-0xefff window] (bus address [0x1000-0xffff])
		       ^^^^^^                              ^^^^^^

here ? If ISA drivers poke at addresses in the [0x0 - 0x1000]
range (Linux space IO offset) they end up on the PCI bus with addresses
above 0x1000, is that what you are saying when you refer to "moved to
high addresses to stay out of that range" ?

Thanks,
Lorenzo
