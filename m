From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 25 Aug 2015 22:43:35 +0200
Subject: [PATCH v10 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <20150825195411.GJ81844@google.com>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-3-git-send-email-stefan@agner.ch>
 <ff2e2716578a1ae5f0c4b0e0ca8bbdc3@agner.ch>
 <20150825195411.GJ81844@google.com>
Message-ID: <20150825224335.6f846a28@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian, Stefan,

On Tue, 25 Aug 2015 12:54:11 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Mon, Aug 03, 2015 at 11:28:43AM +0200, Stefan Agner wrote:
> > On 2015-08-03 11:27, Stefan Agner wrote:
> > <snip>
> > > +static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat,
> > > +					 uint8_t *oob, int oob_loaded)
> > > +{
> > > +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> > > +	u8 ecc_status;
> > > +	u8 ecc_count;
> > > +	int flip;
> > > +
> > > +	ecc_status = __raw_readb(nfc->regs + ECC_SRAM_ADDR * 8 + ECC_OFFSET);
> 
> Why __raw_readb()? That's not normally encourage, and it has issues with
> endianness. It looks like maybe this is actulaly a 32-bit register, and
> you're having trouble when trying to do bytewise access? I see this
> earlier:
> 
> /*
>  * ECC status is stored at NFC_CFG[ECCADD] +4 for little-endian
>  * and +7 for big-endian SoCs.
>  */
> #ifdef __LITTLE_ENDIAN
> #define ECC_OFFSET      4
> #else
> #define ECC_OFFSET      7
> #endif
> 
> So maybe you really just want:
> 
> #define ECC_OFFSET	4
> ...
> 	ecc_status = vf610_nfc_read(ECC_SRAM_ADDR * 8 + ECC_OFFSET) & 0xff;
> 
> ?
> 
> > > +	ecc_count = ecc_status & ECC_ERR_COUNT;
> > > +
> > > +	if (!(ecc_status & ECC_STATUS_MASK))
> > > +		return ecc_count;
> > > +
> > > +	if (!oob_loaded)
> > > +		vf610_nfc_read_buf(mtd, oob, mtd->oobsize);
> > > +
> > > +	/*
> > > +	 * On an erased page, bit count (including OOB) should be zero or
> > > +	 * at least less then half of the ECC strength.
> > > +	 */
> > > +	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
> 
> Another side note: why are you using ecc_count as a max threshold? AIUI,
> an ECC algorithm doesn't really report useful error count information if
> it's above the correction limit. So wouldn't we be looking to count up
> to our SW threshold? i.e., ecc.strength / 2, or similar? Similar
> comments below.

The exact threshold value is still something I'm not sure about, though
I'm sure it should be correlated to ecc.strength value (whether it's
directly set to ecc.strength or less than ecc.strength is something
we'll have to figure out).

> 
> > > +	flip += count_written_bits(oob, mtd->oobsize - nfc->chip.ecc.bytes,
> > > +				   ecc_count);
> > 
> > With ECC the controller seems to clear the ECC bytes in SRAM buffer.
> > This is a dump of 64 Bit OOB with the 32-error ECC mode which requires
> > 60 bytes of OOB for ECC:
> > 
> > [   22.190273] ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Hmm, that's not really good. The point is that we need to make sure that
> everything that could have been programmed (including the ECC area) was
> not actually programmed. But your ECC controller is not, contrary to
> MTD's expectations, dumping raw uncorrected data here.

Yep, for this test we really need the ECC bytes generated for the chunk
you're currently testing.
How to retrieve those bytes really depends on your NAND controller, but
such controllers usually provides a way to disable the ECC engine. The
only thing you'll have to do in this case is disable the ECC engine and
read the OOB data (using RNDOUT and read_buf for example).

> 
> > [   22.209698] vf610_nfc_correct_data, flips 1
> > 
> > Not sure if this is acceptable, but I now only count the bits in the
> > non-ECC area of the OOB.
> 
> That's not the intention of my suggestion. You're still missing out on a
> class of patterns that might look close to all 0xff but are not
> actually.

Exactly.

> 
> If the HW ECC really doesn't give you valid data+OOB at this point, then
> you might have to re-read with ECC disabled. Of course, that's got a
> performance cost...

As suggested above, if that's possible, reading the OOB area (or a
portion of the OOB area) with the ECC engine disabled should be enough.

> 
> Or perhaps Boris has a better suggestion? He's been surveying other NAND
> drivers that need to do similar things, and he's working on providing
> some support code for common design patterns.

Yep, the patch series is here in case you want to have a look [1].

Best Regards,

Boris

[1]https://patchwork.ozlabs.org/patch/509970/


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
