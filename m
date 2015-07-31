From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 31 Jul 2015 16:47:18 -0700
Subject: [PATCH v9 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <9dd7975072cf16dd6ea1947bd4ae830a@agner.ch>
References: <1438361581-2702-1-git-send-email-stefan@agner.ch>
 <1438361581-2702-3-git-send-email-stefan@agner.ch>
 <20150731230901.GK10676@google.com>
 <9dd7975072cf16dd6ea1947bd4ae830a@agner.ch>
Message-ID: <20150731234718.GO10676@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 01, 2015 at 01:35:52AM +0200, Stefan Agner wrote:
> On 2015-08-01 01:09, Brian Norris wrote:

> >> +static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> >> +				uint8_t *buf, int oob_required, int page)
> >> +{
> >> +	int eccsize = chip->ecc.size;
> >> +	int stat;
> >> +
> >> +	vf610_nfc_read_buf(mtd, buf, eccsize);
> >> +
> >> +	if (oob_required)
> >> +		vf610_nfc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
> > 
> > To fix the bitflips issue above, you'll just want to unconditionally
> > read the OOB (it's fine to ignore 'oob_required') and...
> > 
> >> +
> >> +	stat = vf610_nfc_correct_data(mtd, buf);
> > 
> > ...pass in chip->oob_poi as a third argument.
> > 
> 
> Hm, this probably will have an effect on performance, since we usually
> omit the OOB if not requested.

You could test :) I don't really like performance claims without tests.
(I say this because I added the oob_required flag myself, but just for
functional purposes, not performance. Many drivers got by just fine by
always copying the OOB data.)

> I could fetch the OOB from the NAND
> controllers SRAM only if necessary (if HW ECC status is not ok...). Does
> this sound reasonable?

That does.

Brian
