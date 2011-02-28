From: John.Linn@xilinx.com (John Linn)
Date: Mon, 28 Feb 2011 07:13:24 -0700
Subject: [PATCH V4 1/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <20110228110618.GA8751@pulham.picochip.com>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<b8e72ca5-de48-41ec-89b9-95bb90e18826@VA3EHSMHS013.ehs.local>
	<20110228110618.GA8751@pulham.picochip.com>
Message-ID: <751e432e-7ff8-4197-a9b8-c185cf92b44c@VA3EHSMHS014.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jamie Iles [mailto:jamie at jamieiles.com]
> Sent: Monday, February 28, 2011 4:06 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org; linux at arm.linux.org.uk;
> catalin.marinas at arm.com; glikely at secretlab.ca; jamie at jamieiles.com;
arnd at arndb.de
> Subject: Re: [PATCH V4 1/4] ARM: Xilinx: Adding Xilinx board support
> 
> Hi John,
> 
> A couple of very pedantic nitpicks below, sorry I didn't spot them
> before!
> 
> On Fri, Feb 18, 2011 at 11:14:38AM -0700, John Linn wrote:
> > The 1st board support is minimal to get a system up and running
> > on the Xilinx platform.
> >
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > ---
> >
> > V4 Changes
> > 	Minor cleanup based on input from Jamie Iles.
> >
> > V3 Changes
> >
> > Updates based on Russell Kings' comments
> > 	Changed headers to update the license info and remove
> > 	the address
> >
> > 	Changed the name of functions to include "xilinx" in
> > 	common.c and common.h
> >
> > Changed the Kconfig and Makefile to use MACH_XILINX which
> > matches the machine registered.
> >
> > V2 Changes
> >
> > Updates based on Russell King's comments
> > 	minor cleanups
> > 	cleaned up physical/virtual addresses in early i/o table
> >
> >  arch/arm/mach-xilinx/Kconfig       |   14 +++++
> >  arch/arm/mach-xilinx/Makefile      |    7 ++
> >  arch/arm/mach-xilinx/Makefile.boot |    3 +
> >  arch/arm/mach-xilinx/board_ep107.c |   82
++++++++++++++++++++++++++
> >  arch/arm/mach-xilinx/common.c      |  113
++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-xilinx/common.h      |   30 ++++++++++
> >  6 files changed, 249 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-xilinx/Kconfig
> >  create mode 100644 arch/arm/mach-xilinx/Makefile
> >  create mode 100644 arch/arm/mach-xilinx/Makefile.boot
> >  create mode 100644 arch/arm/mach-xilinx/board_ep107.c
> >  create mode 100644 arch/arm/mach-xilinx/common.c
> >  create mode 100644 arch/arm/mach-xilinx/common.h
> >
> > diff --git a/arch/arm/mach-xilinx/Kconfig
b/arch/arm/mach-xilinx/Kconfig
> > new file mode 100644
> > index 0000000..61532af
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/Kconfig
> > @@ -0,0 +1,14 @@
> > +if ARCH_XILINX
> > +
> > +choice
> > +        prompt "Board Selection"
> > +	default MACH_XILINX
> > +
> > +config MACH_XILINX
> > +	bool "Xilinx EP107 Board"
> > +	help
> > +	  Select if you are using a Xilinx EP107 board.
> > +
> > +endchoice
> > +
> > +endif
> > diff --git a/arch/arm/mach-xilinx/Makefile
b/arch/arm/mach-xilinx/Makefile
> > new file mode 100644
> > index 0000000..76e9e55
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/Makefile
> > @@ -0,0 +1,7 @@
> > +#
> > +# Makefile for the linux kernel.
> > +#
> > +
> > +# Common support
> > +obj-y 				:= common.o
> > +obj-$(CONFIG_MACH_XILINX)	+= board_ep107.o
> > diff --git a/arch/arm/mach-xilinx/Makefile.boot
b/arch/arm/mach-xilinx/Makefile.boot
> > new file mode 100644
> > index 0000000..67039c3
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/Makefile.boot
> > @@ -0,0 +1,3 @@
> > +   zreladdr-y	:= 0x00008000
> > +params_phys-y	:= 0x00000100
> > +initrd_phys-y	:= 0x00800000
> > diff --git a/arch/arm/mach-xilinx/board_ep107.c
b/arch/arm/mach-xilinx/board_ep107.c
> > new file mode 100644
> > index 0000000..a1635b5
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/board_ep107.c
> > @@ -0,0 +1,82 @@
> > +/* arch/arm/mach-xilinx/board_ep107.c
> > + *
> > + * This file contains code specific to the Xilinx EP107 board.
> > + *
> > + *  Copyright (C) 2011 Xilinx
> > + *
> > + * based on /arch/arm/mach-realview/core.c
> > + *
> > + *  Copyright (C) 1999 - 2003 ARM Limited
> > + *  Copyright (C) 2000 Deep Blue Solutions Ltd
> > + *
> > + * This software is licensed under the terms of the GNU General
Public
> > + * License version 2, as published by the Free Software Foundation,
and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <asm/mach-types.h>
> > +#include <asm/mach/arch.h>
> > +#include <mach/xilinx_soc.h>
> > +#include <mach/irqs.h>
> > +#include <linux/clkdev.h>
> > +#include "common.h"
> 
> Usual convention is to order these as the linux, then the asm, then
the
> mach includes.

Easy to fix :), thanks for pointing it out.

> 
> > +
> > +/*
> > + * Fixed clocks for now
> > + */
> > +
> > +static struct clk ref50_clk = {
> > +	.rate	= 50000000,
> > +};
> > +
> > +/* Create all the platform devices for the board */
> > +
> > +static struct resource uart0[] = {
> > +	{
> > +		.start = UART0_PHYS,
> > +		.end = UART0_PHYS + 0xFFF,
> > +		.flags = IORESOURCE_MEM,
> > +	}, {
> > +		.start = IRQ_UART0,
> > +		.end = IRQ_UART0,
> > +		.flags = IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static struct platform_device uart_device0 = {
> > +	.name = "xuartpss",
> > +	.id = 0,
> > +	.dev = {
> > +		.platform_data = &ref50_clk.rate,
> > +	},
> > +	.resource = uart0,
> > +	.num_resources = ARRAY_SIZE(uart0),
> > +};
> > +
> > +static struct platform_device *xilinx_pdevices[] __initdata = {
> > +	&uart_device0,
> > +};
> > +
> > +/**
> > + * board_ep107_init - Board specific initialization for the Xilinx
EP107 board.
> > + *
> > + **/
> > +static void __init board_ep107_init(void)
> > +{
> > +	xilinx_system_init();
> > +	platform_add_devices(&xilinx_pdevices[0],
ARRAY_SIZE(xilinx_pdevices));
> > +}
> > +
> > +MACHINE_START(XILINX_EP107, "Xilinx EP107")
> > +	.boot_params    = PHYS_OFFSET + 0x00000100,
> 
> Should this use PLAT_PHYS_OFFSET?
> 

Yes, not sure why I didn't catch that.

Thanks,
John

> Jamie


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
