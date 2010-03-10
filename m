From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 10 Mar 2010 12:37:26 +0100
Subject: [PATCH] Voipac PXA270
In-Reply-To: <4B9739C0.2090805@compulab.co.il>
References: <201003100247.27059.marek.vasut@gmail.com>
	<4B9739C0.2090805@compulab.co.il>
Message-ID: <201003101237.26819.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 10. b?ezna 2010 07:18:40 Mike Rapoport napsal(a):
> Hi Marek,
> 
> Marek Vasut wrote:
> > Hi
> >
> > This patch adds basic support for the Voipac PXA270 SBC.
> > The device consists of the following hardware:
> > - PXA270 @ 520 MHz
> > - 256MB RAM (sparsemem, 2*128MB regions)
> > - 64MB NOR flash
> > - 640x480 LCD
> > - Ports: 2xUHC, 1xUDC, 1xPCMCIA, VGA, FFUART, 2xPS2, Speaker, MIC
> >
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> 
> The patch looks good to me. Some nitpicking though :)
> 
> > From c2c517d966726c570a3a4fa6d7df029df4bac481 Mon Sep 17 00:00:00 2001
> > From: Marek <marek.vasut@gmail.com>
> > Date: Tue, 9 Mar 2010 04:04:12 +0100
> > Subject: [PATCH] Voipac PXA270
> >
> > This patch adds basic support for the Voipac PXA270 SBC.
> > The device consists of the following hardware:
> > - PXA270 @ 520 MHz
> > - 256MB RAM (sparsemem, 2*128MB regions)
> > - 64MB NOR flash
> > - 640x480 LCD
> > - Ports: 2xUHC, 1xUDC, 1xPCMCIA, VGA, FFUART, 2xPS2, Speaker, MIC
> >
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> >  arch/arm/mach-pxa/Kconfig                |    6 +
> >  arch/arm/mach-pxa/Makefile               |    1 +
> >  arch/arm/mach-pxa/include/mach/vpac270.h |   26 +++
> >  arch/arm/mach-pxa/vpac270.c              |  306
> > ++++++++++++++++++++++++++++++ 4 files changed, 339 insertions(+), 0
> > deletions(-)
> >  create mode 100644 arch/arm/mach-pxa/include/mach/vpac270.h
> >  create mode 100644 arch/arm/mach-pxa/vpac270.c
> >
> > diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> > index bf852b0..dc871aa 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -255,6 +255,12 @@ config MACH_COLIBRI320
> >  	select PXA3xx
> >  	select CPU_PXA320
> >
> > +config MACH_VPAC270
> > +	bool "Voipac PXA270"
> > +	select PXA27x
> > +	help
> > +	  PXA270 based Single Board Computer.
> > +
> >  comment "End-user Products (sorted by vendor name)"
> >
> >  config MACH_H4700
> > diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> > index c53397e..042bc54 100644
> > --- a/arch/arm/mach-pxa/Makefile
> > +++ b/arch/arm/mach-pxa/Makefile
> > @@ -62,6 +62,7 @@ obj-$(CONFIG_MACH_PCM990_BASEBOARD)	+=
> > pcm990-baseboard.o obj-$(CONFIG_MACH_COLIBRI)	+= colibri-pxa270.o
> >  obj-$(CONFIG_MACH_COLIBRI300)	+= colibri-pxa3xx.o colibri-pxa300.o
> >  obj-$(CONFIG_MACH_COLIBRI320)	+= colibri-pxa3xx.o colibri-pxa320.o
> > +obj-$(CONFIG_MACH_VPAC270)	+= vpac270.o
> >
> >  # End-user Products
> >  obj-$(CONFIG_MACH_H4700)	+= hx4700.o
> > diff --git a/arch/arm/mach-pxa/include/mach/vpac270.h
> > b/arch/arm/mach-pxa/include/mach/vpac270.h new file mode 100644
> > index 0000000..8f8eaed
> > --- /dev/null
> > +++ b/arch/arm/mach-pxa/include/mach/vpac270.h
> > @@ -0,0 +1,26 @@
> > +/*
> > + * GPIOs and interrupts for Voipac PXA270
> > + *
> > + * Copyright (C) 2010
> > + * Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#ifndef _INCLUDE_VPAC270_H_
> > +#define _INCLUDE_VPAC270_H_
> > +
> > +#define	GPIO1_VPAC270_USER_BTN		1
> > +
> > +#define	GPIO15_VPAC270_LED_ORANGE	15
> > +
> > +#define	GPIO81_VPAC270_BKL_ON		81
> > +#define	GPIO83_VPAC270_NL_ON		83
> > +
> > +#define	GPIO52_VPAC270_SD_READONLY	52
> > +#define	GPIO53_VPAC270_SD_DETECT_N	53
> > +
> > +#endif
> 
> Do these defines really deserve dedicated .h file? Why cannot they live
> in the arch/arm/mach-pxa/vpac270.c?

I'm not moving this in. I dont want to polute the .c file with stuff that should 
obviously go into the header file. Besides there'll be more GPIOs defined and 
that'd make the .c file less readable, which I want to avoid.

> 
> The same applies to additional defines in
>  arch/arm/mach-pxa/include/mach/vpac270.h in other patches in the series.
>  The GPIO definitions can be moved to the *vpac270.c thus reducing
>  pollution in arch/arm/mach-pxa/include/mach.
> 
> > diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> > new file mode 100644
> > index 0000000..c83abf6
> > --- /dev/null
> > +++ b/arch/arm/mach-pxa/vpac270.c
> > @@ -0,0 +1,306 @@
> > +/*
> > + * Hardware definitions for Voipac PXA270
> > + *
> > + * Copyright (C) 2010
> > + * Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/delay.h>
> > +#include <linux/irq.h>
> > +#include <linux/gpio_keys.h>
> > +#include <linux/input.h>
> > +#include <linux/gpio.h>
> > +#include <linux/sysdev.h>
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/partitions.h>
> > +#include <linux/mtd/physmap.h>
> > +
> > +#include <asm/mach-types.h>
> > +#include <asm/mach/arch.h>
> > +
> > +#include <mach/pxa27x.h>
> > +#include <mach/vpac270.h>
> > +#include <mach/mmc.h>
> > +#include <mach/pxafb.h>
> > +
> > +#include "generic.h"
> > +#include "devices.h"
> > +
> > +/***********************************************************************
> >******* + * Pin configuration
> > +
> > *************************************************************************
> >*****/ +static unsigned long vpac270_pin_config[] __initdata = {
> > +	/* MMC */
> > +	GPIO32_MMC_CLK,
> > +	GPIO92_MMC_DAT_0,
> > +	GPIO109_MMC_DAT_1,
> > +	GPIO110_MMC_DAT_2,
> > +	GPIO111_MMC_DAT_3,
> > +	GPIO112_MMC_CMD,
> > +	GPIO53_GPIO,	/* SD detect */
> > +	GPIO52_GPIO,	/* SD r/o switch */
> > +
> > +	/* GPIO KEYS */
> > +	GPIO1_GPIO,	/* USER BTN */
> > +
> > +	/* LEDs */
> > +	GPIO15_GPIO,	/* orange led */
> > +
> > +	/* FFUART */
> > +	GPIO34_FFUART_RXD,
> > +	GPIO39_FFUART_TXD,
> > +	GPIO27_FFUART_RTS,
> > +	GPIO100_FFUART_CTS,
> > +	GPIO33_FFUART_DSR,
> > +	GPIO40_FFUART_DTR,
> > +	GPIO10_FFUART_DCD,
> > +	GPIO38_FFUART_RI,
> > +
> > +	/* LCD */
> > +	GPIO58_LCD_LDD_0,
> > +	GPIO59_LCD_LDD_1,
> > +	GPIO60_LCD_LDD_2,
> > +	GPIO61_LCD_LDD_3,
> > +	GPIO62_LCD_LDD_4,
> > +	GPIO63_LCD_LDD_5,
> > +	GPIO64_LCD_LDD_6,
> > +	GPIO65_LCD_LDD_7,
> > +	GPIO66_LCD_LDD_8,
> > +	GPIO67_LCD_LDD_9,
> > +	GPIO68_LCD_LDD_10,
> > +	GPIO69_LCD_LDD_11,
> > +	GPIO70_LCD_LDD_12,
> > +	GPIO71_LCD_LDD_13,
> > +	GPIO72_LCD_LDD_14,
> > +	GPIO73_LCD_LDD_15,
> > +	GPIO86_LCD_LDD_16,
> > +	GPIO87_LCD_LDD_17,
> > +	GPIO74_LCD_FCLK,
> > +	GPIO75_LCD_LCLK,
> > +	GPIO76_LCD_PCLK,
> > +	GPIO77_LCD_BIAS,
> > +};
> > +
> > +/***********************************************************************
> >******* + * NOR Flash
> > +
> > *************************************************************************
> >*****/ +#if defined(CONFIG_MTD_PHYSMAP) ||
> > defined(CONFIG_MTD_PHYSMAP_MODULE) +static struct mtd_partition
> > vpac270_partitions[] = {
> > +	{
> > +		.name		= "Flash",
> > +		.offset		= 0x00000000,
> > +		.size		= MTDPART_SIZ_FULL,
> > +		.mask_flags	= 0
> 
> not necessary
> 
ok, updated patch attached
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Voipac-PXA270.patch
Type: text/x-patch
Size: 10530 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100310/4a12f8a1/attachment-0001.bin>
