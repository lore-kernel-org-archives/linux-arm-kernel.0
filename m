From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 16:32:40 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <4F4C043C.3030407@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140804.49026.arnd@arndb.de> <4F4C043C.3030407@gmail.com>
Message-ID: <201202281632.40396.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 February 2012, Rob Herring wrote:

> > 3. scary multi-way translation, needs someone to really understand (Nico?, Lennert?)
> > arch/arm/mach-iop32x/include/mach/io.h:#define __io(p)          ((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
> > arch/arm/mach-iop33x/include/mach/io.h:#define __io(p)          ((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
> > arch/arm/mach-iop13xx/include/mach/io.h:#define __io(a) __iop13xx_io(a)
> > arch/arm/mach-mv78xx0/include/mach/io.h:static inline void __iomem *__io(unsigned long addr)
> 
> It seems iop3xx and mv78xx0 are just setting the PCI bus address to the
> local bus address. The OIOWTVR register controls local bus to PCI
> address translation. It is set to 0x90000000 which is effectively no
> translation.

I'm not sure about this. IOP3XX_PCI_LOWER_IO_PA and IOP3XX_PCI_LOWER_IO_BA
are set to 0x90000000, so sys->io_offset is set to zero. However,
IOP3XX_PCI_LOWER_IO_PA gets put into the start of the ioport_resource,
which seems rather misguided because it means that any 16 bit port
number from a BAR plus the zero sys->io_offset are way outside of the
I/O resource, and the translation using IOP3XX_PCI_IO_PHYS_TO_VIRT(x)
ends up in the jungle.

> But don't we really want 0x9000xxxx local bus translated to
> 0x0000xxxx PCI bus? Then the io resource region is setup for 0x9000xxxx
> as well. If both the PCI bus address and i/o resources are moved to 0x0
> that should make these category 1.

The plan is certainly to put them into category 1.

> Also, you've left off ixp4xx from this list. It has PCI and needs io.h,
> so fixing all the PCI platforms above will not make using CONFIG_PCI,
> ISA or PCMCIA to include mach/io.h or not work. However, if indirect io
> is all that io.h is needed for then perhaps a config option called
> NEEDS_INDIRECT_IO would be a better name.

Yes, makes sense. From what I can tell, ixp4xx always uses indirect
access for I/O space but can use either direct or indirect access
for memory space.

	Arnd
