From: robherring2@gmail.com (Rob Herring)
Date: Fri, 30 Mar 2012 22:57:28 -0500
Subject: [PATCH] ARM: at91: resurrect mach-at91/include/mach/io.h
In-Reply-To: <4f7637c4.51e4cc0a.35ba.ffffce95@mx.google.com>
References: <4f7637c4.51e4cc0a.35ba.ffffce95@mx.google.com>
Message-ID: <4F7680A8.8030803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2012 05:46 PM, manabian at gmail.com wrote:
> From: Joachim Eastwood <joachim.eastwood@jotron.com>
> 
> Commmit 4d5fc58dbe34b78 "ARM: remove bunch of now unused mach/io.h files"
> removed the at91 io.h header. This makes pata_pcmcia when used with at91_cf
> fail on ioport_map in pcmcia_init_one.
> 
> Adding io.h and NEED_MACH_IO_H makes my CF card work again.
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> ---
> 
> If there is better/correct way to solve the problem please disregard this
> patch.

There is but it's not planned for 3.4. This fix is fine for 3.4 with one
comment below.

The real solution involves creating a fixed i/o virtual address for all
ARM platforms. Some testing to verify would help me. The following steps
are needed:

Create a static mapping for your i/o region (up to 1MB) at virtual
address 0xfef00000. The phys addr for this would be what
cf->phys_baseaddr + CF_IO_PHYS works out to. Then define __io to this:

#define __io(x) (0xfef00000 + ((x) & 0xfffff))

The i/o address needs to be an offset from the i/o base. I think this
line is wrong (but works with old __io definition) and needs to be
removed from at91_cf.c:

	/* pcmcia layer only remaps "real" memory not iospace */
	cf->socket.io_offset = (unsigned long)
			ioremap(cf->phys_baseaddr + CF_IO_PHYS, SZ_2K);


> 
>  arch/arm/mach-at91/Kconfig           |    1 +
>  arch/arm/mach-at91/include/mach/io.h |   32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 arch/arm/mach-at91/include/mach/io.h
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 6631d35..8bcf917 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -37,6 +37,7 @@ config ARCH_AT91RM9200
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_AT91_DBGU0
>  	select HAVE_AT91_USART3
> +	select NEED_MACH_IO_H
>  
>  config ARCH_AT91SAM9260
>  	bool "AT91SAM9260 or AT91SAM9XE"
> diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
> new file mode 100644
> index 0000000..ba9a22f
> --- /dev/null
> +++ b/arch/arm/mach-at91/include/mach/io.h
> @@ -0,0 +1,32 @@
> +/*
> + * arch/arm/mach-at91/include/mach/io.h
> + *
> + *  Copyright (C) 2003 SAN People
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
> +#ifndef __ASM_ARCH_IO_H
> +#define __ASM_ARCH_IO_H
> +
> +#include <mach/hardware.h>
> +
> +#define IO_SPACE_LIMIT		0xFFFFFFFF
> +
> +#define __io(a)			__typesafe_io(a)
> +#define __mem_pci(a)		(a)

__mem_pci is removed now.

Rob

> +
> +#endif
> +
