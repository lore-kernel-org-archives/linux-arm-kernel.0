From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 17:46:04 -0500
Subject: [RFC PATCHv2 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <1342113976-27140-2-git-send-email-dinguyen@altera.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <1342113976-27140-2-git-send-email-dinguyen@altera.com>
Message-ID: <500499AC.5060209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2012 12:26 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Adding core definitions for Altera's SOCFPGA ARM platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>

Two comments below, but otherwise:

Reviewed-by: Rob Herring <rob.herring@calxeda.com>

> diff --git a/arch/arm/mach-socfpga/include/mach/iomap.h b/arch/arm/mach-socfpga/include/mach/iomap.h
> new file mode 100644
> index 0000000..d5f8493
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/include/mach/iomap.h
> @@ -0,0 +1,33 @@
> +/*
> + *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __MACH_SOCFPGA_IOMAP_H
> +#define __MACH_SOCFPGA_IOMAP_H
> +
> +#include <asm/sizes.h>
> +
> +/* macro to get at IO space when running virtually */
> +/*
> + * Statically mapped addresses:
> + *
> + * 10xx xxxx -> fbxx xxxx
> + * 1exx xxxx -> fdxx xxxx
> + * 1fxx xxxx -> fexx xxxx
> + */
> +#define IO_ADDRESS(x)		(((x) & 0x03ffffff) + 0xfb000000)
> +#define __io_address(n)		IOMEM(IO_ADDRESS(n))

Is this used anywhere?

> +
> +#endif
> diff --git a/arch/arm/mach-socfpga/include/mach/irqs.h b/arch/arm/mach-socfpga/include/mach/irqs.h
> new file mode 100644
> index 0000000..5e344db
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/include/mach/irqs.h
> @@ -0,0 +1,24 @@
> +/*
> + *  Copyright (C) 2012 Altera Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +*/
> +
> +#ifndef __MACH_IRQS_H
> +#define __MACH_IRQS_H
> +
> +#define IRQ_SOCFPGA_GIC_START	32
> +#define IRQ_LOCALWDOG		30
> +#define MAX_GIC_NR		1

This header should not be needed.

> +
> +#endif	/* __MACH_IRQS_H */
> diff --git a/arch/arm/mach-socfpga/include/mach/timex.h b/arch/arm/mach-socfpga/include/mach/timex.h
> new file mode 100644
> index 0000000..43df435
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/include/mach/timex.h
> @@ -0,0 +1,19 @@
> +/*
> + *  Copyright (C) 2003 ARM Limited
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
> +#define CLOCK_TICK_RATE		(50000000 / 16)
> diff --git a/arch/arm/mach-socfpga/include/mach/uncompress.h b/arch/arm/mach-socfpga/include/mach/uncompress.h
> new file mode 100644
> index 0000000..bbe20e6
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/include/mach/uncompress.h
> @@ -0,0 +1,9 @@
> +#ifndef __MACH_UNCOMPRESS_H
> +#define __MACH_UNCOMPRESS_H
> +
> +#define putc(c)
> +#define flush()
> +#define arch_decomp_setup()
> +#define arch_decomp_wdog()
> +
> +#endif
> 
