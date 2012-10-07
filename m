From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 8 Oct 2012 00:54:17 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121007195759.GG12801@game.jcrosoft.org>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
 <20121007195759.GG12801@game.jcrosoft.org>
Message-ID: <20121007225417.GA29996@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 09:57:59PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 03:53 Sun 07 Oct     , Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > BCM476x's minimal infrastructure, Kernel's great reuse.
> > 
> > Look mom, no include/mach directory!
> > 
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > ---
> >  Documentation/devicetree/bindings/arm/bcm476x.txt |    8 +
> >  MAINTAINERS                                       |    9 +
> >  arch/arm/Kconfig                                  |    2 +
> >  arch/arm/Makefile                                 |    1 +
> >  arch/arm/boot/dts/bcm476x-catalina.dts            |   11 +
> >  arch/arm/boot/dts/bcm476x.dtsi                    |   31 ++
> >  arch/arm/configs/bcm476x_defconfig                |  352 ++++++++++++++++++++++
> >  arch/arm/include/debug/bcm476x-uncompress.h       |   53 +++
> >  arch/arm/include/debug/bcm476x.S                  |   35 ++
> >  arch/arm/mach-bcm476x/Kconfig                     |   17 +
> >  arch/arm/mach-bcm476x/Makefile                    |    1 +
> >  arch/arm/mach-bcm476x/Makefile.boot               |    5 +
> >  arch/arm/mach-bcm476x/bcm476x.c                   |   83 +++++
> >  13 files changed, 608 insertions(+)
> > 
> > Index: b/arch/arm/boot/dts/bcm476x.dtsi
> > ===================================================================
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/bcm476x.dtsi
> > @@ -0,0 +1,31 @@
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	compatible = "brcm,bcm476x";
> > +	model = "Broadcom BCM476x";
> > +
> > +	chosen {
> > +		bootargs = "earlyprintk";
> > +	};
> > +
> > +	amba {
> > +		compatible = "arm,amba-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		vic0: interrupt-controller at 80000 {
> > +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> why brcm specific compatbile?

Nothing breaks if I drop it. I think it's a future-proof clause, especially
if you consider that the devicetree could be not easy to upgrade and you
may need a way to differentiate the bcm476x's implementation from the
common one. I'm not sure it's an actual requirement with use cases.

> > +			reg = <0x80000 0x1000>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +		};
> > +
> > +		vic1: interrupt-controller at 81000 {
> > +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> > +			reg = <0x81000 0x1000>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +		};
> > +	};
> > +};
> > Index: b/arch/arm/include/debug/bcm476x.S
> > ===================================================================
> > --- /dev/null
> > +++ b/arch/arm/include/debug/bcm476x.S
> > @@ -0,0 +1,35 @@
> > +/*
> > + * Broadcom BCM476x SoCs DEBUG_LL support
> > + *
> > + * Copyright (C) 2012 Domenico Andreoli <domenico.andreoli@linux.com>
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
> > + */
> > +
> > +#if defined(CONFIG_DEBUG_BCM476X_UART0)
> > +# define BCM476X_DEBUG_PHYS	0x000c0000
> > +# define BCM476X_DEBUG_VIRT	0xd00c0000
> > +#elif defined(CONFIG_DEBUG_BCM476X_UART1)
> > +# define BCM476X_DEBUG_PHYS	0x000c1000
> > +# define BCM476X_DEBUG_VIRT	0xd00c1000
> > +#elif defined(CONFIG_DEBUG_BCM476X_UART2)
> > +# define BCM476X_DEBUG_PHYS	0x000b2000
> > +# define BCM476X_DEBUG_VIRT	0xd00b2000
> > +#else
> > +# error Unknown BCM476x debug port
> > +#endif
> 
> can't you detect it?

If I can assume that the boot loader will configure and enable only the
console port, I could use the first one in such state.

Where could I place such detection, in the maco addruart itself?

> > +
> > +	.macro	addruart, rp, rv, tmp
> > +	ldr	\rp, =BCM476X_DEBUG_PHYS
> > +	ldr	\rv, =BCM476X_DEBUG_VIRT
> > +	.endm
> > +
> > +#include <asm/hardware/debug-pl01x.S>
> > Index: b/arch/arm/include/debug/bcm476x-uncompress.h
> > ===================================================================
> > --- /dev/null
> > +++ b/arch/arm/include/debug/bcm476x-uncompress.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * Broadcom BCM476x SoCs decompressor output
> > + *
> > + * Copyright (C) 2012 Domenico Andreoli <domenico.andreoli@linux.com>
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
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/amba/serial.h>
> > +
> > +#if defined(CONFIG_DEBUG_BCM476X_UART0)
> > +# define BCM476X_DEBUG_PHYS	0x000c0000
> > +#elif defined(CONFIG_DEBUG_BCM476X_UART1)
> > +# define BCM476X_DEBUG_PHYS	0x000c1000
> > +#elif defined(CONFIG_DEBUG_BCM476X_UART2)
> > +# define BCM476X_DEBUG_PHYS	0x000b2000
> > +#else
> > +# error Unknown BCM476x debug port
> ditto here by using the first one enable by the bootloader

Are you saying that the detection should happen always or only in this
last else branch, which actually should be impossible?

> > +#endif
> > +
> > +#define BCM476X_UART_DR IOMEM(BCM476X_DEBUG_PHYS + UART01x_DR)
> > +#define BCM476X_UART_FR IOMEM(BCM476X_DEBUG_PHYS + UART01x_FR)
> > +#define BCM476X_UART_CR IOMEM(BCM476X_DEBUG_PHYS + UART011_CR)
> > +
> > +static inline void putc(int c)
> > +{
> > +	while (__raw_readl(BCM476X_UART_FR) & UART01x_FR_TXFF)
> > +		barrier();
> > +
> > +	__raw_writel(c, BCM476X_UART_DR);
> > +	barrier();
> > +}
> > +
> > +static inline void flush(void)
> > +{
> > +	int fr;
> > +
> > +	do {
> > +		fr = __raw_readl(BCM476X_UART_FR);
> > +		barrier();
> > +	} while ((fr & (UART011_FR_TXFE | UART01x_FR_BUSY)) != UART011_FR_TXFE);
> > +}
> > +

Thank you.

Regards,
Domenico
