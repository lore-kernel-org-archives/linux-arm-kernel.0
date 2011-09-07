From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Sep 2011 19:00:02 +0800
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <20110906202555.GQ28816@pengutronix.de>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<20110906202555.GQ28816@pengutronix.de>
Message-ID: <20110907110001.GI8148@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 10:25:55PM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Sep 06, 2011 at 05:58:36PM +0800, Shawn Guo wrote:
> > It adds the core definitions and low-level debug uart support
> > for imx6q.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/Kconfig                             |    2 +-
> >  arch/arm/Kconfig.debug                       |    7 +++++
> >  arch/arm/Makefile                            |    1 +
> >  arch/arm/mach-imx/Kconfig                    |    4 +++
> >  arch/arm/mach-imx/Makefile                   |    2 +
> >  arch/arm/mach-imx/Makefile.boot              |    4 +++
> >  arch/arm/mach-imx/lluart.c                   |   33 ++++++++++++++++++++++++++
> >  arch/arm/plat-mxc/Kconfig                    |    5 ++++
> >  arch/arm/plat-mxc/include/mach/debug-macro.S |    5 ++++
> >  arch/arm/plat-mxc/include/mach/entry-macro.S |   15 +++++++++++-
> >  arch/arm/plat-mxc/include/mach/hardware.h    |    1 +
> >  arch/arm/plat-mxc/include/mach/irqs.h        |    9 ++++--
> >  arch/arm/plat-mxc/include/mach/memory.h      |    3 ++
> >  arch/arm/plat-mxc/include/mach/mx6q.h        |   29 ++++++++++++++++++++++
> >  14 files changed, 115 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm/mach-imx/lluart.c
> >  create mode 100644 arch/arm/plat-mxc/include/mach/mx6q.h
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 4ea9974..37c20a4 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1348,7 +1348,7 @@ config SMP
> >  	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
> >  		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
> >  		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
> > -		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
> > +		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || SOC_IMX6Q
> >  	select USE_GENERIC_SMP_HELPERS
> >  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> >  	help
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 965d59a..68fc155 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -155,6 +155,13 @@ choice
> >  		  Say Y here if you want kernel low-level debugging support
> >  		  on i.MX50 or i.MX53.
> >  
> > +	config DEBUG_IMX6Q_UART
> > +		bool "i.MX6Q Debug UART"
> > +		depends on SOC_IMX6Q
> > +		help
> > +		  Say Y here if you want kernel low-level debugging support
> > +		  on i.MX6Q.
> > +
> >  	config DEBUG_S3C_UART0
> >  		depends on PLAT_SAMSUNG
> >  		bool "Use S3C UART 0 for low-level debug"
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 70c424e..3a0bbe4 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -159,6 +159,7 @@ machine-$(CONFIG_ARCH_MX2)		:= imx
> >  machine-$(CONFIG_ARCH_MX25)		:= imx
> >  machine-$(CONFIG_ARCH_MX3)		:= imx
> >  machine-$(CONFIG_ARCH_MX5)		:= mx5
> > +machine-$(CONFIG_ARCH_MX6)		:= imx
> >  machine-$(CONFIG_ARCH_MXS)		:= mxs
> >  machine-$(CONFIG_ARCH_NETX)		:= netx
> >  machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 0519dd7..4cf5178 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -58,6 +58,10 @@ config SOC_IMX35
> >  	select ARCH_MX35
> >  	select MXC_AVIC
> >  
> > +config SOC_IMX6Q
> > +	bool
> > +	select ARM_GIC
> > +	select CPU_V7
> >  
> >  if ARCH_MX1
> >  
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index e9eb36d..96ecc96 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -61,3 +61,5 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
> >  obj-$(CONFIG_MACH_EUKREA_CPUIMX35) += mach-cpuimx35.o
> >  obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
> >  obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
> > +
> > +obj-$(CONFIG_DEBUG_LL) += lluart.o
> > diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
> > index ebee18b..389a0e3 100644
> > --- a/arch/arm/mach-imx/Makefile.boot
> > +++ b/arch/arm/mach-imx/Makefile.boot
> > @@ -17,3 +17,7 @@ initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
> >  zreladdr-$(CONFIG_ARCH_MX3)	:= 0x80008000
> >  params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
> >  initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
> > +
> > +zreladdr-$(CONFIG_SOC_IMX6Q)	:= 0x10008000
> > +params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
> > +initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
> Do you really need params_phys and initrd_phys?
> 
I added them to make IMX6Q look consistent with other soc in the file,
and leave it to a global cleanup, if we decide to clean later.

> > diff --git a/arch/arm/mach-imx/lluart.c b/arch/arm/mach-imx/lluart.c
> > new file mode 100644
> > index 0000000..34205cb
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/lluart.c
> > @@ -0,0 +1,33 @@
> > +/*
> > + * Copyright 2011 Freescale Semiconductor, Inc.
> > + * Copyright 2011 Linaro Ltd.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <asm/page.h>
> > +#include <asm/sizes.h>
> > +#include <asm/mach/map.h>
> > +#include <mach/hardware.h>
> > +
> > +static struct map_desc imx_lluart_desc = {
> > +#ifdef CONFIG_DEBUG_IMX6Q_UART
> > +	.virtual	= MX6Q_UART4_BASE_VADDR,
> > +	.pfn		= __phys_to_pfn(MX6Q_UART4_BASE_ADDR),
> > +	.length		= SZ_16K,
> > +	.type		= MT_DEVICE,
> > +#endif
> > +};
> > +
> > +void __init imx_lluart_map_io(void)
> > +{
> > +	if (imx_lluart_desc.virtual)
> > +		iotable_init(&imx_lluart_desc, 1);
> > +}
> I don't see yet where this is called, but I wonder what happens on a
> non-imx6q machine (provided it is called there).

This is called by imx6q_map_io() in mach-imx6q.c.  For non-imx6q
machines, imx_lluart_desc will be all zero, therefore iotable_init()
call will be bypassed.

> > +
> > diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> > index a5353fc..e548f9b 100644
> > --- a/arch/arm/plat-mxc/Kconfig
> > +++ b/arch/arm/plat-mxc/Kconfig
> > @@ -48,6 +48,11 @@ config ARCH_MX51
> >  	help
> >  	  This enables support for systems based on the Freescale i.MX51 family
> >  
> > +config ARCH_MX6
> > +	bool "i.MX6"
> > +	help
> > +	  This enables support for systems based on the Freescale i.MX6 family
> > +
> >  endchoice
> >  
> >  source "arch/arm/mach-imx/Kconfig"
> > diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> > index 07cfdbe..471872a 100644
> > --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> > +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> > @@ -24,9 +24,14 @@
> >  #define UART_PADDR	MX51_UART1_BASE_ADDR
> >  #elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
> >  #define UART_PADDR	MX53_UART1_BASE_ADDR
> > +#elif defined (CONFIG_DEBUG_IMX6Q_UART)
> > +#define UART_PADDR	MX6Q_UART4_BASE_ADDR
> > +#define UART_VADDR	MX6Q_UART4_BASE_VADDR
> You cannot use the existing IMX_IO_P2V? I'd like to have a look into it
> to make it usable there, too. See below.
> 
> >  #endif
> >  
> > +#ifndef UART_VADDR
> >  #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
> > +#endif
> >  
> >  		.macro	addruart, rp, rv
> >  		ldr	\rp, =UART_PADDR	@ physical
> > diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
> > index 066d464..341f800 100644
> > --- a/arch/arm/plat-mxc/include/mach/entry-macro.S
> > +++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
> > @@ -1,6 +1,6 @@
> >  /*
> >   *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
> > - *  Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *  Copyright 2004-2011 Freescale Semiconductor, Inc. All Rights Reserved.
> >   */
> >  
> >  /*
> > @@ -11,6 +11,17 @@
> >  
> >  #include <mach/hardware.h>
> >  
> > +#ifdef CONFIG_ARM_GIC
> > +#include <asm/hardware/entry-macro-gic.S>
> > +
> > +	.macro	disable_fiq
> > +	.endm
> > +
> > +	.macro	arch_ret_to_user, tmp1, tmp2
> > +	.endm
> > +
> > +#else
> > +
> hmm, this essentially means mx6 support cannot go into a kernel image
> for the other imx machines :-(
> 
Ah, sorry.  I totally forgot about this.  Will fix it in the next
version.

> >  #define AVIC_NIMASK	0x04
> >  
> >  	@ this macro disables fast irq (not implemented)
> > @@ -78,3 +89,5 @@
> >  	movs \irqnr, \irqnr
> >  #endif
> >  	.endm
> > +
> > +#endif /* CONFIG_ARM_GIC */
> > diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
> > index a8bfd56..e1f84ce 100644
> > --- a/arch/arm/plat-mxc/include/mach/hardware.h
> > +++ b/arch/arm/plat-mxc/include/mach/hardware.h
> > @@ -97,6 +97,7 @@
> >  
> >  #include <mach/mxc.h>
> >  
> > +#include <mach/mx6q.h>
> >  #include <mach/mx50.h>
> >  #include <mach/mx51.h>
> >  #include <mach/mx53.h>
> > diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> > index 00e812b..3ae400f 100644
> > --- a/arch/arm/plat-mxc/include/mach/irqs.h
> > +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> > @@ -14,12 +14,15 @@
> >  #include <asm-generic/gpio.h>
> >  
> >  /*
> > - * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
> > + * SoCs with AVIC interrupt controller have 64 IRQs, those with TZIC
> > + * have 128, otherwise those with GIC have 160 IRQs.
> >   */
> > -#ifdef CONFIG_MXC_TZIC
> > +#if defined CONFIG_MXC_AVIC
> > +#define MXC_INTERNAL_IRQS	64
> > +#elif defined CONFIG_MXC_TZIC
> >  #define MXC_INTERNAL_IRQS	128
> >  #else
> > -#define MXC_INTERNAL_IRQS	64
> > +#define MXC_INTERNAL_IRQS	160
> >  #endif
> This is broken. The highest number has to go to the top. Otherwise if
> you have an image with at least 2 of the available irq controllers your
> MXC_INTERNAL_IRQS is too small.
> 
Yes, this is yet another one I forgot about single image support.
I should probably put some documentation about the correct order,
which can be forgot by people like me.

Thanks for catching this.

> >  
> >  #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
> > diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
> > index 11be5cd..2b8e186 100644
> > --- a/arch/arm/plat-mxc/include/mach/memory.h
> > +++ b/arch/arm/plat-mxc/include/mach/memory.h
> > @@ -19,6 +19,7 @@
> >  #define MX50_PHYS_OFFSET	UL(0x70000000)
> >  #define MX51_PHYS_OFFSET	UL(0x90000000)
> >  #define MX53_PHYS_OFFSET	UL(0x70000000)
> > +#define MX6Q_PHYS_OFFSET	UL(0x10000000)
> >  
> >  #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
> >  # if defined CONFIG_ARCH_MX1
> > @@ -37,6 +38,8 @@
> >  #  define PLAT_PHYS_OFFSET		MX51_PHYS_OFFSET
> >  # elif defined CONFIG_ARCH_MX53
> >  #  define PLAT_PHYS_OFFSET		MX53_PHYS_OFFSET
> > +# elif defined CONFIG_SOC_IMX6Q
> > +#  define PLAT_PHYS_OFFSET		MX6Q_PHYS_OFFSET
> >  # endif
> >  #endif
> >  
> > diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/plat-mxc/include/mach/mx6q.h
> > new file mode 100644
> > index 0000000..7432310
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/include/mach/mx6q.h
> > @@ -0,0 +1,29 @@
> > +/*
> > + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> > + * Copyright 2011 Linaro Ltd.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#ifndef __MACH_MX6Q_H__
> > +#define __MACH_MX6Q_H__
> > +
> > +/* static mappings */
> > +#define IMX6Q_VA(x)		(0xf4000000 + (x))
> > +
> > +#define MX6Q_SCU_BASE_ADDR	0x00a00000
> > +#define MX6Q_CCM_BASE_ADDR	0x020c4000
> > +#define MX6Q_ANATOP_BASE_ADDR	0x020c8000
> > +#define MX6Q_UART4_BASE_ADDR	0x021f0000
> > +
> > +#define MX6Q_SCU_BASE_VADDR	IMX6Q_VA(MX6Q_SCU_BASE_ADDR)
> > +#define MX6Q_CCM_BASE_VADDR	IMX6Q_VA(MX6Q_CCM_BASE_ADDR)
> > +#define MX6Q_ANATOP_BASE_VADDR	IMX6Q_VA(MX6Q_ANATOP_BASE_ADDR)
> > +#define MX6Q_UART4_BASE_VADDR	IMX6Q_VA(MX6Q_UART4_BASE_ADDR)
> Depending on the sizes of these memory regions you can use the existing
> IMX_IO_P2V here. The conditions are:
> 
> 	SCU_SIZE <= 0x200000
> 	CCM_SIZE <= 0x4000
> 	ANATOP_SIZE <= 0x28000
> 	UART4 <= 0x100000
> 
This is exactly what I dislike about IMX_IO_P2V().  We have to verify
all these conditions manually.  Looking at the static mapping below
(copied from arch/arm/plat-mxc/include/mach/hardware.h), do you think
it's really scalable and easy to maintain for the long run?

/*
 * This is rather complicated for humans and ugly to verify, but for a machine
 * it's OK.  Still more as it is usually only applied to constants.  The upsides
 * on using this approach are:
 *
 *  - same mapping on all i.MX machines
 *  - works for assembler, too
 *  - no need to nurture #defines for virtual addresses
 *
 * The downside it, it's hard to verify (but I have a script for that).
 *
 * Obviously this needs to be injective for each SoC.  In general it maps the
 * whole address space to [0xf4000000, 0xf5ffffff].  So [0xf6000000,0xfeffffff]
 * is free for per-machine use (e.g. KZM_ARM11_01 uses 64MiB there).
 *
 * It applies the following mappings for the different SoCs:
 *
 * mx1:
 *	IO	0x00200000+0x100000	->	0xf4000000+0x100000
 * mx21:
 *	AIPI	0x10000000+0x100000	->	0xf4400000+0x100000
 *	SAHB1	0x80000000+0x100000	->	0xf4000000+0x100000
 *	X_MEMC	0xdf000000+0x004000	->	0xf5f00000+0x004000
 * mx25:
 *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
 *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
 *	AVIC	0x68000000+0x100000	->	0xf5800000+0x100000
 * mx27:
 *	AIPI	0x10000000+0x100000	->	0xf4400000+0x100000
 *	SAHB1	0x80000000+0x100000	->	0xf4000000+0x100000
 *	X_MEMC	0xd8000000+0x100000	->	0xf5c00000+0x100000
 * mx31:
 *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
 *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
 *	AVIC	0x68000000+0x100000	->	0xf5800000+0x100000
 *	X_MEMC	0xb8000000+0x010000	->	0xf4c00000+0x010000
 *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
 * mx35:
 *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
 *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
 *	AVIC	0x68000000+0x100000	->	0xf5800000+0x100000
 *	X_MEMC	0xb8000000+0x010000	->	0xf4c00000+0x010000
 *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
 * mx50:
 *	TZIC	0x0fffc000+0x004000	->	0xf4bfc000+0x004000
 *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
 *	AIPS1	0x53f00000+0x100000	->	0xf5700000+0x100000
 *	AIPS2	0x63f00000+0x100000	->	0xf5300000+0x100000
 * mx51:
 *	IRAM	0x1ffe0000+0x020000	->	0xf4fe0000+0x020000
 *	DEBUG	0x60000000+0x100000	->	0xf5000000+0x100000
 *	SPBA0	0x70000000+0x100000	->	0xf5400000+0x100000
 *	AIPS1	0x73f00000+0x100000	->	0xf5700000+0x100000
 *	AIPS2	0x83f00000+0x100000	->	0xf4300000+0x100000
 */
#define IMX_IO_P2V(x)	(						\
			0xf4000000 +					\
			(((x) & 0x50000000) >> 6) +			\
			(((x) & 0x0b000000) >> 4) +			\
			(((x) & 0x000fffff)))

> hmm, looking at patch 4 SCU_BASE is determined by a coprocessor
> instruction?!

Ah, yes.  The SCU physical base address can be retrieved from
coprocessor.

Regards,
Shawn

> Other than that these restrictions seem to be fulfilled.
> 
