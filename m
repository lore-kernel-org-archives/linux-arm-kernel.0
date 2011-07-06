From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Jul 2011 12:35:54 -0400 (EDT)
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107061442.05182.arnd@arndb.de>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
	<201107061442.05182.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1107061228250.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Arnd Bergmann wrote:
> On Wednesday 06 July 2011, Russell King - ARM Linux wrote:
> > I shall be making this change to asm/io.h shortly:
> > 
> >  #include <mach/io.h>
> > 
> > +/*
> > + * This is the limit of PCI/ISA/PC card IO space, which is by default
> > + * 64K if we have PC card, PCI or ISA support.  Otherwise, default to
> > + * zero to prevent ISA/PCI drivers claiming IO space (and potentially
> > + * oopsing.)
> > + *
> > + * Only set this larger if you really need inb() et.al. to operate over
> > + * a larger address space (eg, for multiple MMIO-mapped PC card sockets
> > + * as found on SA11x0 and PXA.)
> > + */
> > +#ifndef IO_SPACE_LIMIT
> > +#if defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> > +#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
> > +#else
> > +#define IO_SPACE_LIMIT ((resource_size_t)0)
> > +#endif
> > +#endif
> 
> Good idea. The related change that I want to do is to conditionalize
> all drivers that require PC-style I/O on the respective bus they
> use, so we can also remove the __io macro for platforms that don't
> need it and catch all drivers using inb/outb at compile time.

In the spirit of removing as much machine specific and globally used 
defines (see my patch series removing a bunch of mach/memory.h 
instances), I'd like to see a solution that would make IO_SPACE_LIMIT 
into a variable, or having the same definition with a fixed mapping, for 
as many SOCs as possible.


Nicolas
