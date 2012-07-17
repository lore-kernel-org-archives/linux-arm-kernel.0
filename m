From: dinguyen@altera.com (Dinh.Nguyen)
Date: Tue, 17 Jul 2012 15:31:32 -0600
Subject: [RFC PATCHv2 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <201207171547.58324.arnd@arndb.de>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <1342113976-27140-2-git-send-email-dinguyen@altera.com>
 <201207171547.58324.arnd@arndb.de>
Message-ID: <1342560692.26186.2.camel@dinh-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-07-17 at 15:47 +0000, Arnd Bergmann wrote:
> On Thursday 12 July 2012, dinguyen at altera.com wrote:
> 
> > +config ARCH_SOCFPGA
> > +	bool "Altera SOCFPGA family"
> > +	select ARCH_WANT_OPTIONAL_GPIOLIB
> > +	select ARM_AMBA
> > +	select ARM_GIC
> > +	select CACHE_L2X0
> > +	select CLKDEV_LOOKUP
> > +	select CPU_V7
> > +	select DW_APB_TIMER
> > +	select DW_APB_TIMER_OF
> > +	select GENERIC_CLOCKEVENTS
> > +	select GPIO_PL061 if GPIOLIB
> > +	select HAVE_ARM_SCU
> > +	select SPARSE_IRQ
> > +	select USE_OF
> > +	help
> > +	  This enables support for Altera SOCFPGA Cyclone V platform
> 
> Please select COMMON_CLK as well to use the generic clock implementation.
> 
> > diff --git a/arch/arm/mach-socfpga/clock.c b/arch/arm/mach-socfpga/clock.c
> > new file mode 100644
> > index 0000000..79f3890
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/clock.c
> > @@ -0,0 +1,45 @@
> 
> > +#include <linux/clkdev.h>
> > +
> > +#define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
> > +#define SOCFPGA_L4_MAIN_CLK					(400000000)
> > +
> > +struct clk {
> > +	unsigned long		rate;
> > +};
> > +
> > +static struct clk apb_pclk = { .rate = 200000000};
> > +static struct clk i2c_clk = { .rate = 100000000};
> > +static struct clk spim_clk = { .rate = 100000000};
> > +static struct clk mpu_pclk = { .rate = SOCFPGA_MPU_PERIHCLK_FREQ_HZ};
> > +static struct clk l4_main_clk = { .rate = SOCFPGA_L4_MAIN_CLK};
> 
> Then move this file into drivers/clk/ using that code.

This doesn't quite make sense to me. You want me to move platform
specific information to drivers folder? I only see mxs and spear under
drivers/clk. Surely, you don't want me to create another socfpga folder
under there, or do you?

thanks,
Dinh
> 
> > diff --git a/arch/arm/mach-socfpga/include/mach/iomap.h b/arch/arm/mach-socfpga/include/mach/iomap.h
> > new file mode 100644
> > index 0000000..d5f8493
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/include/mach/iomap.h
> > @@ -0,0 +1,33 @@
> > +/*
> > + *  Copyright (C) 2012 Altera Corporation <www.altera.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +#ifndef __MACH_SOCFPGA_IOMAP_H
> > +#define __MACH_SOCFPGA_IOMAP_H
> > +
> > +#include <asm/sizes.h>
> > +
> > +/* macro to get at IO space when running virtually */
> > +/*
> > + * Statically mapped addresses:
> > + *
> > + * 10xx xxxx -> fbxx xxxx
> > + * 1exx xxxx -> fdxx xxxx
> > + * 1fxx xxxx -> fexx xxxx
> > + */
> > +#define IO_ADDRESS(x)		(((x) & 0x03ffffff) + 0xfb000000)
> > +#define __io_address(n)		IOMEM(IO_ADDRESS(n))
> > +
> > +#endif
> 
> This is unused, right? Just remove it.
> 
> > diff --git a/arch/arm/mach-socfpga/include/mach/irqs.h b/arch/arm/mach-socfpga/include/mach/irqs.h
> > new file mode 100644
> > index 0000000..5e344db
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/include/mach/irqs.h
> > @@ -0,0 +1,24 @@
> > +/*
> > + *  Copyright (C) 2012 Altera Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > +*/
> > +
> > +#ifndef __MACH_IRQS_H
> > +#define __MACH_IRQS_H
> > +
> > +#define IRQ_SOCFPGA_GIC_START	32
> > +#define IRQ_LOCALWDOG		30
> > +#define MAX_GIC_NR		1
> > +
> > +#endif	/* __MACH_IRQS_H */
> 
> Same with this. Since you're using sparse IRQ, this file is not even included
> anywhere.
> 
> 	Arnd
> 
