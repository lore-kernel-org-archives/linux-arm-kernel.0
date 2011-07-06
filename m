From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 14:42:04 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706122501.GU8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
Message-ID: <201107061442.05182.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Russell King - ARM Linux wrote:
> On Wed, Jul 06, 2011 at 02:47:56AM -0700, Barry Song wrote:
> > diff --git a/arch/arm/mach-prima2/include/mach/io.h b/arch/arm/mach-
> > +
> > +#ifndef __MACH_PRIMA2_IO_H
> > +#define __MACH_PRIMA2_IO_H
> > +
> > +#define IO_SPACE_LIMIT 0xffffffff
> 
> Can folk please start putting comments in their io.h file explaining their
> choice for this definition?  Looking through the existing files, it is
> almost impossible to infer the reason the value was picked, which makes
> future maintanence a headache.

I had the same comment for one of the earlier versions of the patch
set, but we agreed that I'd come up with a way to remove this at a
later stage for all platforms that don't have PC-style PIO.

Right now, the only platforms that use a value other than 0xffffffff
are ones that actually have PCI and set it to 0xffff.

> IO_SPACE_LIMIT sets the upper bound for the PCI/ISA style IO accessor
> macros (inb, et.al.)
> 
> My guidance is:
> 
> 1. If you have no support for ISA/PCI/PC card drivers, then set this to
>    zero to prevent ISA/PCI drivers reserving IO port space.  You should
>    be able to leave __io() set to __typesafe_io() without risking any
>    ISA driver stamping on memory as those drivers should no longer
>    successfully initialize with this set to zero.
> 
> 2. If you have MMIO-mapped IO space (eg, a PCI bridge which forwards
>    MMIO accesses in a window to PCI IO space) or equivalent, then set
>    this to the size of the window, or 64K-1.  Explain this.
> 
> 3. If you have MMIO-mapped IO space which is scattered (eg, multiple
>    PC cards with their IO space individually mapped as separate 64K
>    blocks) then explain this and set it to 0xffffffff for the time
>    being.

Sounds good.

> I shall be making this change to asm/io.h shortly:
> 
>  #include <mach/io.h>
> 
> +/*
> + * This is the limit of PCI/ISA/PC card IO space, which is by default
> + * 64K if we have PC card, PCI or ISA support.  Otherwise, default to
> + * zero to prevent ISA/PCI drivers claiming IO space (and potentially
> + * oopsing.)
> + *
> + * Only set this larger if you really need inb() et.al. to operate over
> + * a larger address space (eg, for multiple MMIO-mapped PC card sockets
> + * as found on SA11x0 and PXA.)
> + */
> +#ifndef IO_SPACE_LIMIT
> +#if defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> +#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
> +#else
> +#define IO_SPACE_LIMIT ((resource_size_t)0)
> +#endif
> +#endif

Good idea. The related change that I want to do is to conditionalize
all drivers that require PC-style I/O on the respective bus they
use, so we can also remove the __io macro for platforms that don't
need it and catch all drivers using inb/outb at compile time.

To do that, I'm working on a patch set that splits the 8250
driver into separate parts for platform drivers (mostly MMIO)
and ISA drivers (mostly PIO), since that seems to be the only
driver that we need on non-PIO platforms that uses inb/outb
directly.

	Arnd
