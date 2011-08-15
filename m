From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 15 Aug 2011 11:31:34 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <20110815082935.GA18364@parrot.com>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
	<20040.45443.810005.525431@ipc1.ka-ro>
	<20110815082935.GA18364@parrot.com>
Message-ID: <20040.59254.170515.492518@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ivan Djelic writes:
> On Mon, Aug 15, 2011 at 06:41:23AM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Ivan Djelic writes:
> > > On Fri, Aug 05, 2011 at 02:51:33PM +0100, Wolfram Sang wrote:
> > > (...)
> > > > 
> > > > problem overwriting all-0xff data in NAND [2]
> > > > =============================================
> > > > 
> > > > Although it occured only when writing JFFS2 images so far, this is a generic
> > > > issue and needs to be fixed, right?
> > > > 
> > > > 
> > > (...)
> > > > [2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037104.html
> > > 
> > > As explained in the thread linked above, this issue should be fixed in your
> > > flashing tool, _not_ in your driver. The nand device you are using does not
> > > support programming pages multiple times in a row; pretending it does in the
> > >
> > It's not a problem of the device (Samsung K9F1G08U0B in my case)! The
> > problem is that the controller generates an ECC code that is non-FF
> > for all-FF data, which JFFS2 cannot handle properly.
> 
> JFFS2 has nothing to do with it. JFFS2 does not assume it can program empty
> pages and then reprogram them on a NAND flash device. You flashing method does.
> 
AFAICT JFFS2 checks the flash for areas that contain only FF and
treats them like erased flash. At least it tries to overwrite such
areas in flash without erasing it beforehand.
I avoided the problem by creating JFFS2 images that are padded with
oxff to page size only instead of eraseblock size.

> If your BCH controller allows it, you could XOR the computed ECC bytes with a
> specific mask to make sure all-FF data have all-FF ecc. This is useful to allow
> reading erased blocks with ecc correction enabled.
> 
> But even so, you cannot work around the fact that NAND devices are different
> from NOR devices, in that they typically allow only a limited number of partial
> page programming operations (4 in your K9F1G08U0B).
> If you implemented the mask trick described above and used it to allow
> multiple page programming, you still would not track the number of partial
> program operations on a given page, and expose yourself to nasty bugs (when
> exceeding the number of specified partial operations); i.e. it could work on
> some devices for a few operations, but not reliably on all devices for any
> number of empty page programmings.
> 
> So the only real possibility is to avoid programming (physically) a page when
> its target contents are empty (all-FF); this is not implemented at the driver
> level because:
> - it is useless: none of the existing filesystems need this "feature"
> - it would waste cpu cycles to check if target data is all-FF each time a page
> is programmed
> 
> Therefore... it is simply a matter of avoiding empty page programming, which
> only happens in your flasher. See also the flashing guidelines [1] as per Artem
> suggestion.
> 
"Your flasher" is the standard mtd-utils mkfs.jffs2 to create an image
file and the U-Boot commands 'nand erase/nand write' or
the mtd-utils 'flash_eraseall/nandwrite' to write it to flash.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
