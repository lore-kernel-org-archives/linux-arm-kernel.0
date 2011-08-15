From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 15 Aug 2011 15:37:02 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <20110815125442.GA18661@parrot.com>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
	<20040.45443.810005.525431@ipc1.ka-ro>
	<20110815082935.GA18364@parrot.com>
	<20040.59254.170515.492518@ipc1.ka-ro>
	<20110815125442.GA18661@parrot.com>
Message-ID: <20041.8446.744780.186928@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ivan Djelic writes:
> On Mon, Aug 15, 2011 at 10:31:34AM +0100, Lothar Wa?mann wrote:
> > > > It's not a problem of the device (Samsung K9F1G08U0B in my case)! The
> > > > problem is that the controller generates an ECC code that is non-FF
> > > > for all-FF data, which JFFS2 cannot handle properly.
> > > 
> > > JFFS2 has nothing to do with it. JFFS2 does not assume it can program empty
> > > pages and then reprogram them on a NAND flash device. You flashing method does.
> > > 
> > AFAICT JFFS2 checks the flash for areas that contain only FF and
> > treats them like erased flash. At least it tries to overwrite such
> > areas in flash without erasing it beforehand.
> 
> Hmmm, again, JFFS2 simply "writes" to an erased block. You say "it tries to
> overwrite", but that's only because you programmed an empty page in the first
>
Which will happen most of the time (unless the image file size is near
a multiple of the eraseblock size), if you create an jffs2 image with
mkfs.jffs2 and the '-p' option.

Unfortunately the data written by U-Boot must be page aligned and
mkfs.jffs2 cannot generate images that fulfill that constraint (unless
you know the exact image file size beforehand and specify the
rounded-up file size with the '-p' option).

> place! And it cannot "erase such areas beforehand" (think of a partially
> programmed block with tailing empty pages).
> 
I know, that it cannot simply erase such blocks.

> > > Therefore... it is simply a matter of avoiding empty page programming, which
> > > only happens in your flasher. See also the flashing guidelines [1] as per Artem
> > > suggestion.
> > > 
> > "Your flasher" is the standard mtd-utils mkfs.jffs2 to create an image
> > file and the U-Boot commands 'nand erase/nand write' or
> > the mtd-utils 'flash_eraseall/nandwrite' to write it to flash.
> 
> OK, maybe you could submit a patch to fix this issue then ?
> Thanks,
> 
I have no idea how and where it should be fixed.
- at driver level, creating an all-FF ECC for all-FF data?
- in the bootloader and mtd-utils preventing stretches of all-FF data
  to be written?
- in mkfs.jffs2, enabling it to generate images that are padded to
  page size instead of eraseblock size?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
