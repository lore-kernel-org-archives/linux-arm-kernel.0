From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 09:28:59 +0000
Subject: RFC [PATCH 8/9] Added plc32xx platform include files
In-Reply-To: <083DF309106F364B939360100EC290F804F54D5611@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F54D5611@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091121092859.GB7998@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 02:11:38AM +0100, Kevin Wells wrote:
> diff --git a/arch/arm/mach-lpc32xx/include/mach/irqs.h b/arch/arm/mach-lpc32xx/include/mach/irqs.h
> new file mode 100644
> index 0000000..b80f92b
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/include/mach/irqs.h
> @@ -0,0 +1,134 @@
> +/*
> + * mach-lpc32xx/include/mach/irqs.h
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __ASM_ARM_ARCH_IRQS_H
> +#define __ASM_ARM_ARCH_IRQS_H
> +
> +/*
> + * Register offsets
> + */
> +#define INTC_MASK              0x00
> +#define INTC_RAW_STAT          0x04
> +#define INTC_STAT              0x08
> +#define INTC_POLAR             0x0C
> +#define INTC_ACT_TYPE          0x10
> +#define INTC_TYPE              0x14
> +
> +/*
> + * Software interrupt group offsets
> + */
> +#define INTC_SIC1_OFFS         32
> +#define INTC_SIC2_OFFS         64

These should not be in this file; this file is included by all the rest
of the kernel, and namespace pollution is a definite concern here.

> diff --git a/arch/arm/mach-lpc32xx/include/mach/memory.h b/arch/arm/mach-lpc32xx/include/mach/memory.h
> new file mode 100644
> index 0000000..0958e85
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/include/mach/memory.h
> @@ -0,0 +1,119 @@
> +/*
> + * mach-lpc32xx/include/mach/memory.h
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __ASM_ARCH_MEMORY_H
> +#define __ASM_ARCH_MEMORY_H
> +
> +/*
> + * Physical DRAM offset.
> + */
> +#define PHYS_OFFSET    (0x80000000)
> +
> +#if defined (CONFIG_ARCH_DISCONTIGMEM_ENABLE)

This is the wrong symbol.  Discontiguous memory is enabled when the
CONFIG_DISCONTIGMEM symbol is defined.  The above symbol is meant to
be something that the platform code selects to make the discontigmem
configuration option a possibility.

Moreover, discontigmem is rather expensive.  It's primary purpose is
to support NUMA.  The simpler sparsemem should be used instead - it's
overall cheaper.

With sparsemem, you have two definitions:

MAX_PHYSMEM_BITS - the number of physical address bits needed to contain
 a memory physical address.  This would be 32 for you.
SECTION_SIZE_BITS - the maximum number of address bits required to address
 a section of memory.  If your largest memory is 128MB, the minimum it
 should be is 27 and since you're memory section spacing is 512MB, the
 maximum is 29.

I would suggest getting rid of the non-linear virt_to_phys/phys_to_virt
translations and setting SECTION_SIZE_BITS to 29 to reduce the number of
sparsemem sections to 8.

> diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
> new file mode 100644
> index 0000000..b985aee
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/include/mach/system.h
> @@ -0,0 +1,40 @@
> +/*
> + * mach-lpc32xx/include/mach/system.h
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __ASM_ARCH_SYSTEM_H
> +#define __ASM_ARCH_SYSTEM_H
> +
> +#include <mach/hardware.h>
> +#include <mach/io.h>
> +#include <mach/platform.h>

These three headers seem not required.

> +
> +static void arch_idle(void)
> +{
> +       cpu_do_idle();
> +}
> +
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +       cpu_reset(0);
> +}
> +
> +#endif
> diff --git a/arch/arm/mach-lpc32xx/include/mach/timex.h b/arch/arm/mach-lpc32xx/include/mach/timex.h
> new file mode 100644
> index 0000000..4385fc7
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/include/mach/timex.h
> @@ -0,0 +1,31 @@
> +/*
> + * mach-lpc32xx/include/mach/timex.h
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __ASM_ARCH_TIMEX_H
> +#define __ASM_ARCH_TIMEX_H
> +
> +#include <mach/platform.h>

This is another header which is used throughout the kernel.  I'd prefer
to see just a definition for CLOCK_TICK_RATE in here.
