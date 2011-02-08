From: John.Linn@xilinx.com (John Linn)
Date: Mon, 7 Feb 2011 17:14:13 -0700
Subject: [PATCH 4/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <20110205164325.GE29411@n2100.arm.linux.org.uk>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-3-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-4-git-send-email-john.linn@xilinx.com>
	<a45cf64b-c91a-4f8b-a121-5a675daee4ca@VA3EHSMHS006.ehs.local>
	<20110205164325.GE29411@n2100.arm.linux.org.uk>
Message-ID: <8718a09f-604a-41b0-8b5a-856bacac9e9a@VA3EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, February 05, 2011 9:43 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
glikely at secretlab.ca
> Subject: Re: [PATCH 4/4] ARM: Xilinx: base header files and assembly
macros
> 

<snip>

> 
> > diff --git a/arch/arm/mach-xilinx/include/mach/hardware.h
b/arch/arm/mach-
> xilinx/include/mach/hardware.h
> > new file mode 100644
> > index 0000000..a635322
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/include/mach/hardware.h
> > @@ -0,0 +1,44 @@
> > +/* arch/arm/mach-xilinx/include/mach/hardware.h
> > + *
> > + *  Copyright (C) 2011 Xilinx
> > + *
> > + * This program is free software; you can redistribute it and/or
modify
> > + * it under the terms of the GNU General Public License as
published by
> > + * the Free Software Foundation; either version 2 of the License,
or
> > + * (at your option) any later version.
> > + *
> > + * You should have received a copy of the GNU General Public
License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
> > + */
> > +
> > +#ifndef __MACH_HARDWARE_H__
> > +#define __MACH_HARDWARE_H__
> > +
> > +#include <mach/memory.h>
> > +#include <mach/irqs.h>
> > +
> > +#define PERIPHERAL_CLOCK_RATE	2500000
> > +
> > +#define IO_BASE			0xE0000000
> > +#define UART0_BASE		(IO_BASE)
> > +
> > +#define PERIPH_BASE		0xF8000000
> > +#define TTC0_BASE		(PERIPH_BASE + 0x1000)
> > +
> > +#define SCU_PERIPH_BASE		0xF8F00000
> > +#define SCU_GIC_CPU_BASE	(SCU_PERIPH_BASE + 0x100)
> > +#define SCU_GLOBAL_TIMER_BASE	(SCU_PERIPH_BASE + 0x200)
> > +#define SCU_CPU_TIMER_BASE	(SCU_PERIPH_BASE + 0x600)
> > +#define SCU_WDT_BASE		(SCU_PERIPH_BASE + 0x620)
> > +#define SCU_GIC_DIST_BASE	(SCU_PERIPH_BASE + 0x1000)
> > +
> > +#define PL310_L2CC_BASE		0xF8F02000
> > +
> > +/*
> > + * Mandatory for CONFIG_LL_DEBUG, UART is mapped virtual = physical
> > + */
> > +#define LL_UART_PADDR	UART0_BASE
> > +#define LL_UART_VADDR	UART0_BASE
> > +
> > +#endif
> 
> This file is included by much of the kernel build, so symbol conflicts
> tend to be a concern.  It may be better to move most of this to a
> private header instead.
> 
> You may also like to consider using something like this:
> 
> #ifndef __ASSEMBLER__
> #define IOMEM(a)	((void __force __iomem *)(a))
> #else
> #define IOMEM(a)	a
> #endif
> 
> #define SCU_PERIPH_BASE	IOMEM(0xF8F00000)
> 
> which means it's typed correctly for most of the kernel.  The only
place
> where you have to use casts is in the map_desc array - that's pretty
> much unavoidable though.

Hi Russell,

I'm assuming you meant to change all addresses of devices (#defines) to
use the IOMEM.

I did that and it's ok. You also have to cast them to ints when putting
the addresses into
the resource for a platform device.

It makes sense that the typing is now better in general.

Thanks,
John


> 
> > diff --git a/arch/arm/mach-xilinx/include/mach/io.h
b/arch/arm/mach-xilinx/include/mach/io.h
> > new file mode 100644
> > index 0000000..2e69db7
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/include/mach/io.h
> > @@ -0,0 +1,27 @@
> > +/* arch/arm/mach-xilinx/include/mach/io.h
> > + *
> > + *  Copyright (C) 2011 Xilinx
> > + *
> > + * This program is free software; you can redistribute it and/or
modify
> > + * it under the terms of the GNU General Public License as
published by
> > + * the Free Software Foundation; either version 2 of the License,
or
> > + * (at your option) any later version.
> > + *
> > + * You should have received a copy of the GNU General Public
License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
> > + */
> > +
> > +#ifndef __MACH_IO_H__
> > +#define __MACH_IO_H__
> > +
> > +/* Allow IO space to be anywhere in the memory */
> > +
> > +#define IO_SPACE_LIMIT 0xffffffff
> 
> Probably should be 0xffff as that's the standard PCI/ISA IO window.
> 
> > +
> > +/* IO address mapping macros, nothing special at this time but
required */
> > +
> > +#define __io(a)			((void __iomem *)(a))
> 
> #define io(a)			__typesafe_io(a)
> 
> gives a nice, simple, typesafe solution.
> 
> > diff --git a/arch/arm/mach-xilinx/include/mach/memory.h
b/arch/arm/mach-xilinx/include/mach/memory.h
> > new file mode 100644
> > index 0000000..2b6d1eb
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/include/mach/memory.h
> > @@ -0,0 +1,23 @@
> > +/* arch/arm/mach-xilinx/include/mach/memory.h
> > + *
> > + *  Copyright (C) 2011 Xilinx
> > + *
> > + * This program is free software; you can redistribute it and/or
modify
> > + * it under the terms of the GNU General Public License as
published by
> > + * the Free Software Foundation; either version 2 of the License,
or
> > + * (at your option) any later version.
> > + *
> > + * You should have received a copy of the GNU General Public
License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
> > + */
> > +
> > +#ifndef __MACH_MEMORY_H__
> > +#define __MACH_MEMORY_H__
> > +
> > +#include <mach/hardware.h>
> > +
> > +#define PHYS_OFFSET             0x0
> 
> Eventually this will need to become PLAT_PHYS_OFFSET during the next
> merge window.


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
