From: stefan@agner.ch (Stefan Agner)
Date: Wed, 26 Aug 2015 10:57:38 -0700
Subject: [PATCH v10 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <20150825195411.GJ81844@google.com>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-3-git-send-email-stefan@agner.ch>
 <ff2e2716578a1ae5f0c4b0e0ca8bbdc3@agner.ch>
 <20150825195411.GJ81844@google.com>
Message-ID: <07a479863eef4c53ab2ef6ef85321680@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-25 12:54, Brian Norris wrote:
> On Mon, Aug 03, 2015 at 11:28:43AM +0200, Stefan Agner wrote:
>> On 2015-08-03 11:27, Stefan Agner wrote:
>> <snip>
>> > +static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat,
>> > +					 uint8_t *oob, int oob_loaded)
>> > +{
>> > +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> > +	u8 ecc_status;
>> > +	u8 ecc_count;
>> > +	int flip;
>> > +
>> > +	ecc_status = __raw_readb(nfc->regs + ECC_SRAM_ADDR * 8 + ECC_OFFSET);
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

Agreed, much cleaner.

>> > +	ecc_count = ecc_status & ECC_ERR_COUNT;
>> > +
>> > +	if (!(ecc_status & ECC_STATUS_MASK))
>> > +		return ecc_count;
>> > +
>> > +	if (!oob_loaded)
>> > +		vf610_nfc_read_buf(mtd, oob, mtd->oobsize);
>> > +
>> > +	/*
>> > +	 * On an erased page, bit count (including OOB) should be zero or
>> > +	 * at least less then half of the ECC strength.
>> > +	 */
>> > +	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
> 
> Another side note: why are you using ecc_count as a max threshold? AIUI,
> an ECC algorithm doesn't really report useful error count information if
> it's above the correction limit. So wouldn't we be looking to count up
> to our SW threshold? i.e., ecc.strength / 2, or similar? Similar
> comments below.
> 

Initially, that was the only threshold below, hence it made sense. But I
agree, we should count up to the threshold used below...

>> > +	flip += count_written_bits(oob, mtd->oobsize - nfc->chip.ecc.bytes,
>> > +				   ecc_count);
>>
>> With ECC the controller seems to clear the ECC bytes in SRAM buffer.
>> This is a dump of 64 Bit OOB with the 32-error ECC mode which requires
>> 60 bytes of OOB for ECC:
>>
>> [   22.190273] ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Hmm, that's not really good. The point is that we need to make sure that
> everything that could have been programmed (including the ECC area) was
> not actually programmed. But your ECC controller is not, contrary to
> MTD's expectations, dumping raw uncorrected data here.
> 
>> [   22.209698] vf610_nfc_correct_data, flips 1
>>
>> Not sure if this is acceptable, but I now only count the bits in the
>> non-ECC area of the OOB.
> 
> That's not the intention of my suggestion. You're still missing out on a
> class of patterns that might look close to all 0xff but are not
> actually.
> 
> If the HW ECC really doesn't give you valid data+OOB at this point, then
> you might have to re-read with ECC disabled. Of course, that's got a
> performance cost...

Yes I can do that. Not sure yet how it will look like exactly, maybe I
only need to reread the OOB area and (re-)use the main data part since
those arrive uncorrected in the error case.

> 
> Or perhaps Boris has a better suggestion? He's been surveying other NAND
> drivers that need to do similar things, and he's working on providing
> some support code for common design patterns.
> 
>> Btw, if the ECC check fails, the controller seems kind of count the
>> amount of bitflips. It works for most devices reliable, but we had
>> devices for which that number was not accurate, see:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/357439
> 
> I'm a little confused there. Why would you be expecting to get a count
> of bitflips, when the ECC engine can't correct all errors? How is it
> supposed to know what the "right" data is if the bit errors are beyond
> the correction strength?

When printing the ECC error count on ECC fail when reading an erased
NAND flash, the numbers of bit flips (stuck at zero) seem to widely
correlate with the number returned by the controller. While it seems to
correlate widely, there are exceptions, as discussed in the thread:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/295424

Maybe this is an artifact of the ECC algorithm we just can't/shouldn't
rely on? I am not sure where this originated, I did not found any
indication in the reference manual about what that value contains in the
error case.

Bill, do you have an idea why we used that value as threshold in early
implementations?

Otherwise I also think we should just drop the use of this value.

--
Stefan
