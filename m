From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Dec 2010 10:11:39 +0900
Subject: [patch 3/3] mmc, ARM: Add zboot from MMC support for SuperH
	Mobile ARM
In-Reply-To: <AANLkTin91C9XJKaKTNgvN9b=ExCYbt0ujPFe-qEx57hm@mail.gmail.com>
References: <20101206001243.949375995@vergenet.net>
	<20101206001310.825497890@vergenet.net>
	<AANLkTin91C9XJKaKTNgvN9b=ExCYbt0ujPFe-qEx57hm@mail.gmail.com>
Message-ID: <20101206011138.GA623@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 09:51:55AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> Thanks for your work on this!
> 
> On Mon, Dec 6, 2010 at 9:12 AM, Simon Horman <horms@verge.net.au> wrote:
> > This allows a ROM-able zImage to be written to MMC and
> > for SuperH Mobile ARM to boot directly from the MMCIF
> > hardware block.
> >
> > This is achieved by the MaskROM loading the first portion
> > of the image into MERAM and then jumping to it. This portion
> > contains loader code which copies the entire image to SDRAM
> > and jumps to it. From there the zImage boot code proceeds
> > as normal, uncompressing the image into its final location
> > and then jumping to it.
> >
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
> >
> > This patch depends on "ARM: 6514/1: mach-shmobile: Add zboot support for
> > SuperH Mobile ARM" which has been merged into the devel branch
> > of Russell King's linux-2.6-arm tree.
> >
> > Index: linux-2.6-ap4/arch/arm/boot/compressed/mmcif-sh7372.c
> > ===================================================================
> > --- /dev/null ? 1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6-ap4/arch/arm/boot/compressed/mmcif-sh7372.c ? ? ? 2010-12-06 09:11:42.000000000 +0900
> > @@ -0,0 +1,99 @@
> > +/*
> > + * sh7372 MMCIF loader
> > + *
> > + * Copyright (C) 2010 Magnus Damm
> > + * Copyright (C) 2010 Simon Horman
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License. ?See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/mmc/sh_mmcif.h>
> > +#include <mach/mmcif.h>
> > +
> > +#define MMCIF_BASE ? ? ?(void __iomem *)0xe6bd0000
> > +
> > +#define PORT84CR ? ? ? 0xe6050054
> > +#define PORT85CR ? ? ? 0xe6050055
> > +#define PORT86CR ? ? ? 0xe6050056
> > +#define PORT87CR ? ? ? 0xe6050057
> > +#define PORT88CR ? ? ? 0xe6050058
> > +#define PORT89CR ? ? ? 0xe6050059
> > +#define PORT90CR ? ? ? 0xe605005a
> > +#define PORT91CR ? ? ? 0xe605005b
> > +#define PORT92CR ? ? ? 0xe605005c
> > +#define PORT99CR ? ? ? 0xe6050063
> > +#define PORT185CR ? ? ?0xe60520b9
> > +#define PORT186CR ? ? ?0xe60520ba
> > +#define PORT187CR ? ? ?0xe60520bb
> > +#define PORT188CR ? ? ?0xe60520bc
> > +
> > +#define SMSTPCR3 ? ? ? 0xe615013c
> > +
> > +/* SH7372 specific MMCIF loader
> > + *
> > + * loads the zImage from an MMC card starting from block 1.
> > + *
> > + * The image must be start with a vrl4 header and
> > + * the zImage must start at offset 512 of the image. That is,
> > + * at block 2 (=byte 1024) on the media
> > + *
> > + * Use the following line to write the vrl4 formated zImage
> > + * to an MMC card
> > + * # dd if=vrl4.out of=/dev/sdx bs=512 seek=1
> > + */
> > +asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
> > +{
> > + ? ? ? /* Initialise LEDS1-4
> > + ? ? ? ?* registers: PORT185CR-PORT188CR (LED1-LED4 Control)
> > + ? ? ? ?* value: ? ? 0x10 - enable output
> > + ? ? ? ?*/
> > + ? ? ? __raw_writeb(0x10, PORT185CR);
> > + ? ? ? __raw_writeb(0x10, PORT186CR);
> > + ? ? ? __raw_writeb(0x10, PORT187CR);
> > + ? ? ? __raw_writeb(0x10, PORT188CR);
> 
> Aren't these LEDs a board-specific property?
> 
> I believe the rest of the code is common across multiple boards, so
> making it fully sharable would be nice.
> 
> Please break out the board-specific somehow, perhaps into
> mmcif_update_progress().

Sure, perhaps we could just move this initialisation into head-ap4evb.txt?
Or remove mmcif_update_progress() all together?

> > Index: linux-2.6-ap4/arch/arm/boot/compressed/head-shmobile.S
> > ===================================================================
> > --- linux-2.6-ap4.orig/arch/arm/boot/compressed/head-shmobile.S 2010-12-06 09:11:35.000000000 +0900
> > +++ linux-2.6-ap4/arch/arm/boot/compressed/head-shmobile.S ? ? ?2010-12-06 09:11:42.000000000 +0900
> > @@ -40,14 +59,19 @@ __atags:@ tag #1
> > ? ? ? ?@ tag #3
> > ? ? ? ?.long ? 0 ? ? ? ? ? ? ? ? ? ? ? @ tag->hdr.size = 0
> > ? ? ? ?.long ? 0 ? ? ? ? ? ? ? ? ? ? ? @ tag->hdr.tag = ATAG_NONE;
> > -1:
> > +__mach_type:
> > + ? ? ? .long ? MACH_TYPE
> > +__image_start:
> > + ? ? ? .long ? _start
> > +__image_end:
> > + ? ? ? .long ? _got_end
> > +__load_base:
> > + ? ? ? .long ? CONFIG_MEMORY_START + 0x02000000 @ Load at 32Mb into SDRAM
> 
> Just curious, where does these 32Mb come from?

IMHO Its fairly arbitrary where the zImage is copied to.
I chose 32Mb as it is the same place that uboot puts images.

> Say that a board with be equipped with less than 32Mb, how is that handled?

It isn't.

An alternate approach might be to just place it at the end of the
destination, which can be approximated using 4 * the compressed image size.
The same assumption is made in arch/arm/boot/compressed/vmlinux.lds.in.

I'm open to other ideas about where to copy the zImage to.

> > Index: linux-2.6-ap4/Documentation/arm/SH-Mobile/vrl4.c
> > ===================================================================
> > --- /dev/null ? 1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6-ap4/Documentation/arm/SH-Mobile/vrl4.c ? ?2010-12-06 09:11:42.000000000 +0900
> > @@ -0,0 +1,167 @@
> > +/*
> > + * vrl4 format generator
> > + *
> > + * Copyright (C) 2010 Magnus Damm
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License. ?See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> 
> That's sweet, but I don't think I've got anything to do with this
> portion of the code. =)

Sorry, I had both of our names there from text copied from elsewhere
and deleted the wrong one.

> Apart from those minor points it all looks very good IMO!

Thanks!
