From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 11 Apr 2016 08:34:35 +0200
Subject: [PATCH RESEND] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <20160224145750.21050def@bbrezillon>
References: <1456059126-25469-1-git-send-email-mpa@pengutronix.de>
 <20160224145750.21050def@bbrezillon>
Message-ID: <3992227.rRuQ67A3ma@galactica>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Wednesday 24 February 2016 14:57:50 Boris Brezillon wrote:
> Hi Markus,
> 
> On Sun, 21 Feb 2016 13:52:06 +0100
> Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > ECC is only calculated for written pages. As erased pages are not
> > actively written the ECC is always invalid. For this purpose the
> > Hardware BCH unit is able to check for erased pages and does not raise
> > an ECC error in this case. This behaviour can be influenced using the
> > BCH_MODE register which sets the number of allowed bitflips in an erased
> > page. Unfortunately the unit is not capable of fixing the bitflips in
> > memory.
> > 
> > To avoid complete software checks for erased pages, we can simply check
> > buffers with uncorrectable ECC errors because we know that any erased
> > page with errors is uncorrectable by the BCH unit.
> > 
> > This patch adds the generic nand_check_erased_ecc_chunk() to gpmi-nand
> > to correct erased pages. To have the valid data in the buffer before
> > using them, this patch moves the read_page_swap_end() call before the
> > ECC status checking for-loop.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 49 ++++++++++++++++++++++++++++++----
> >  1 file changed, 44 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > index 235ddcb58f39..ce5a21252102 100644
> > --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > @@ -1035,14 +1035,58 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> >  	/* Loop over status bytes, accumulating ECC status. */
> >  	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
> >  
> > +	read_page_swap_end(this, buf, nfc_geo->payload_size,
> > +			   this->payload_virt, this->payload_phys,
> > +			   nfc_geo->payload_size,
> > +			   payload_virt, payload_phys);
> > +
> >  	for (i = 0; i < nfc_geo->ecc_chunk_count; i++, status++) {
> >  		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
> >  			continue;
> >  
> >  		if (*status == STATUS_UNCORRECTABLE) {
> > +			int flips;
> > +
> > +			/*
> > +			 * The ECC hardware has an uncorrectable ECC status
> > +			 * code in case we have bitflips in an erased page. As
> > +			 * nothing was written into this subpage the ECC is
> > +			 * obviously wrong and we can not trust it. We assume
> > +			 * at this point that we are reading an erased page and
> > +			 * try to correct the bitflips in buffer up to
> > +			 * ecc_strength bitflips. If this is a page with random
> > +			 * data, we exceed this number of bitflips and have a
> > +			 * ECC failure. Otherwise we use the corrected buffer.
> > +			 */
> > +			if (i == 0) {
> > +				/* The first block includes metadata */
> > +				flips = nand_check_erased_ecc_chunk(
> > +						buf + i * nfc_geo->ecc_chunk_size,
> > +						nfc_geo->ecc_chunk_size,
> > +						NULL, 0,
> > +						auxiliary_virt,
> > +						nfc_geo->metadata_size,
> > +						nfc_geo->ecc_strength);
> > +			} else {
> > +				flips = nand_check_erased_ecc_chunk(
> > +						buf + i * nfc_geo->ecc_chunk_size,
> > +						nfc_geo->ecc_chunk_size,
> > +						NULL, 0,
> > +						NULL, 0,
> > +						nfc_geo->ecc_strength);
> > +			}
> 
> You're not checking ECC bytes. I know it's a bit more complicated to
> implement, but as Brian stated several times, you should always check
> ECC bytes along with data bytes when testing for an erased chunk.
> 
> Indeed, it might appear that the user really programmed ff on the page,
> and in this case you don't want to consider the page as erased.
> In this case, the ECC bytes will be different from ff, and you'll
> be able to identify it by checking those ECC bytes.

Thanks for the feedback. Talking with a coworker about this we may have found a
better approach to this that is less complicated to implement. The hardware
unit allows us to set a bitflip threshold for erased pages. The ECC unit
creates an ECC error only if the number of bitflips exceeds this threshold, but
it does not correct these. So the idea is to change the patch so that we set
pages, that are signaled by the ECC as erased, to 0xff completely without
checking. So the ECC will do all the work and we completely trust in its
abilities to do it correctly.

I will send a modified patch as soon as I have some time for this.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160411/f276b318/attachment-0001.sig>
