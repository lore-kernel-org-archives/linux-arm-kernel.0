From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Dec 2012 16:55:45 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions
 in CONFIG_HAS_IOPORT
In-Reply-To: <20121211173013.0ceea196@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de> <20121211170338.4859ddf0@skate>
 <201212111615.03262.arnd@arndb.de> <20121211173013.0ceea196@skate>
Message-ID: <20121211165545.GV14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 05:30:13PM +0100, Thomas Petazzoni wrote:
> arch/arm/mm/iomap.c is unconditionally compiled in all ARM kernels. And
> in this file, ioport_map() and ioport_unmap() are implement as soon as
> __io is defined. And basically, in arch/arm/include/asm/io.h, __io is
> defined for all platforms

Actually, I think that's a major bug in the single-zImage conversion:

#ifdef CONFIG_NEED_MACH_IO_H
#include <mach/io.h>
#elif defined(CONFIG_PCI)
#define IO_SPACE_LIMIT  ((resource_size_t)0xfffff)
#define __io(a)         __typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
#else
#define __io(a)         __typesafe_io((a) & IO_SPACE_LIMIT)
#endif

#ifndef IO_SPACE_LIMIT
#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
#define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
#else
#define IO_SPACE_LIMIT ((resource_size_t)0)
#endif
#endif

So, in the !PCI !PCMCIA !ISA !PCCARD case, IO_SPACE_LIMIT will be zero,
which means the above common __io() functions will end up pointing the
access at the NULL pointer - whereas we shouldn't be providing IO space
support at all.  (Okay, there's a couple of corner cases we've known
about for a few _years_ but it's about time that stuff got fixed before
we try and put yet more band-aids over this.  Fix the root problems
guys, don't create more problems.)
