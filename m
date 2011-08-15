From: ivan.djelic@parrot.com (Ivan Djelic)
Date: Mon, 15 Aug 2011 14:54:42 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <20040.59254.170515.492518@ipc1.ka-ro>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
	<20040.45443.810005.525431@ipc1.ka-ro>
	<20110815082935.GA18364@parrot.com>
	<20040.59254.170515.492518@ipc1.ka-ro>
Message-ID: <20110815125442.GA18661@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 10:31:34AM +0100, Lothar Wa?mann wrote:
> > > It's not a problem of the device (Samsung K9F1G08U0B in my case)! The
> > > problem is that the controller generates an ECC code that is non-FF
> > > for all-FF data, which JFFS2 cannot handle properly.
> > 
> > JFFS2 has nothing to do with it. JFFS2 does not assume it can program empty
> > pages and then reprogram them on a NAND flash device. You flashing method does.
> > 
> AFAICT JFFS2 checks the flash for areas that contain only FF and
> treats them like erased flash. At least it tries to overwrite such
> areas in flash without erasing it beforehand.

Hmmm, again, JFFS2 simply "writes" to an erased block. You say "it tries to
overwrite", but that's only because you programmed an empty page in the first
place! And it cannot "erase such areas beforehand" (think of a partially
programmed block with tailing empty pages).

> I avoided the problem by creating JFFS2 images that are padded with
> oxff to page size only instead of eraseblock size.

Good.

> > Therefore... it is simply a matter of avoiding empty page programming, which
> > only happens in your flasher. See also the flashing guidelines [1] as per Artem
> > suggestion.
> > 
> "Your flasher" is the standard mtd-utils mkfs.jffs2 to create an image
> file and the U-Boot commands 'nand erase/nand write' or
> the mtd-utils 'flash_eraseall/nandwrite' to write it to flash.

OK, maybe you could submit a patch to fix this issue then ?
Thanks,

Ivan
