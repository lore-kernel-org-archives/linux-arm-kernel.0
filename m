From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Jan 2013 12:42:08 +0100
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <201301301003.44272.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301300946.54040.arnd@arndb.de> <20130130105418.7f53bc77@skate>
 <201301301003.44272.arnd@arndb.de>
Message-ID: <20130130124208.5098ea41@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 30 Jan 2013 10:03:43 +0000, Arnd Bergmann wrote:

> 0xfee00000 is the platform independent virtual address that pci_ioremap_io
> maps your platform specific physical address (from pcie->io.start) to. It's
> defined (in the kernel I am looking at) in asm/io.h as
> 
> #define PCI_IO_VIRT_BASE        0xfee00000
> 
> and used by pci_ioremap_io as
> 
>         return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
>                                   PCI_IO_VIRT_BASE + offset + SZ_64K,
>                                   phys_addr,
>                                   __pgprot(get_mem_type(MT_DEVICE)->prot_pte));
> 
> 
> > And it works just fine, I get my I/O ranges allocated at 0xc0000000 for
> > the first device, 0xc0010000 (i.e base address + 64KB) for the second
> > device, etc.
> 
> (void*)0xc0000000 is the normal PAGE_OFFSET. If you map your I/O space there,
> you are in big trouble because that is supposed to have the start of your
> physical memory mapping.

Aaah, I know where the confusion comes from. You are talking about
virtual addresses, while I am talking about physical addresses.
0xC0000000 in my DT is a *physical* address.

Basically, with Marvell SoCs, we have the following behavior:

                     -------                          --------------------
 Virtual address --> | MMU | --> Physical address --> | Address decoding | --> real hardware
                     -------                          --------------------

The MMU is the usual stuff everybody knows about. What's more special
about Marvell SoC is this "Address decoding" thing. Basically, instead
of having the physical address of things fully hardcoded and mentioned
in the datasheets, they are configurable. So for each PCIe interface,
you have to set up an address decoding window for the I/O accesses and
another address decoding window for the memory accesses. And the
physical address associated to each of these "address decoding windows"
can be freely chosen, so they must be "assigned" for each PCIe
interface.

So, my 0xC0000000 is a *physical* address is the diagram above. The
fact that it gets maps at 0xfee00000 as a virtual address doesn't
really matter for me, I'm just fine with that.

Does that clarify things?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
