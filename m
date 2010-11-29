From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Nov 2010 16:02:54 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI BUS
In-Reply-To: <alpine.LNX.2.00.1011291316560.11926@localhost.localdomain>
References: <1290860675-15453-1-git-send-email-ulli.kroll@googlemail.com>
	<201011282056.17389.arnd@arndb.de>
	<alpine.LNX.2.00.1011291316560.11926@localhost.localdomain>
Message-ID: <201011291602.54932.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 November 2010, Hans Ulli Kroll wrote:
> > 
> > This looks wrong in multiple ways:
> > 
> > * resources are physical addresses, not virtual addresses
> > * GEMINI_PCI_IO_BASE is an address in memory space, so it
> >   needs to be IORESOURCE_MEM, not IORESOURCE_IO. You can
> >   also register the IORESOURCE_IO resource, but that would
> >   be .start=PCIBIOS_MIN_IO, .end=IO_SPACE_LIMIT.
> > * IO_SPACE_LIMIT is larger than the I/O window, which can
> >   cause overflows. Setting it to 0xffff is generally enough.
> > 
> 
> So I must remove these lines ??
>         }, {
>                 .virtual        = IO_ADDRESS(GEMINI_PCI_IO_BASE),
>                 .pfn            = __phys_to_pfn(GEMINI_PCI_IO_BASE),
>                 .length         = SZ_512K,
>                 .type           = MT_DEVICE,
>         },
> These are from arch/arm/mach-gemini/mm.c

No, these look right, just fix the issues I mentioned, i.e.
the definition of IO_SPACE_LIMIT and the resource registration.

	Arnd
