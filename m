From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 20 Jul 2011 08:12:41 +0300
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <20004.12663.29494.339601@ipc1.ka-ro>
References: <20004.12663.29494.339601@ipc1.ka-ro>
Message-ID: <1311138766.20738.142.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-18 at 15:13 +0200, Lothar Wa?mann wrote:
> Hi,
> 
> with the gpmi-nfc driver for imx28 from Shawn Guo on a TX28 I
> encountered some problems with jffs2 when overwriting pages that have
> been written with 0xff (e.g. from padding from the file system image
> file).
> 
> The problem is that the ECC info for an all-0xff block is not all-0xff
> and thus a newly erased block is different from a block that has been
> written with 0xff.
> If such a block is being altered (jffs2 thinking it can simply
> overwrite it without erasing first) the ECC information will be
> corrupted and will produce ECC errors upon read.
> 
> The only remedy I can think of is to prevent empty pages from actually
> being written to flash, but leaving them in the erased state instead.
> 
> Any comments?

Hi,

I think Ivan is right, the only issue is how you flash your images. This
problem is not JFFS2-specific, you'd have it with UBIFS as well.

For UBIFS users, I described this issue here:
http://www.linux-mtd.infradead.org/doc/ubi.html#L_flasher_algo

You might find it useful, because this basically applies to JFFS2 as
well, but for JFFS2 the problem can be solved by simply making sure your
images are not padded to the eraseblock size and that your flasher does
not do the padding.

For "I cannot change my industrial flasher" case we nowadays have a
solution in the UBIFS level:
http://www.linux-mtd.infradead.org/faq/ubifs.html#L_free_space_fixup

Similar thing could be implemented for JFFS2, I guess, but not sure.

HTH

-- 
Best Regards,
Artem Bityutskiy
