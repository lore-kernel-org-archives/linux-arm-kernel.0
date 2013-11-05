From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 5 Nov 2013 20:24:26 -0300
Subject: [PATCH v3 14/28] mtd: nand: pxa3xx: Add driver-specific ECC BCH
 support
In-Reply-To: <20131105183156.GO20061@ld-irv-0074.broadcom.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-15-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105183156.GO20061@ld-irv-0074.broadcom.com>
Message-ID: <20131105232425.GD11759@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:31:56AM -0800, Brian Norris wrote:
> On Tue, Nov 05, 2013 at 09:55:21AM -0300, Ezequiel Garcia wrote:
> > --- a/drivers/mtd/nand/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
> > @@ -1073,6 +1075,43 @@ static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
> >  	return -ENODEV;
> >  }
> >  
> > +static int pxa_ecc_init(struct pxa3xx_nand_info *info,
> > +			struct nand_ecc_ctrl *ecc,
> > +			int strength, int page_size)
> > +{
> > +	/*
> > +	 * We don't use strength here as the PXA variant
> > +	 * is used with non-ONFI compliant devices.
> 
> Hmm, rather than assuming you never get any relevant 'strength' info
> from nand_base, could you check if it is zero and only ignore it if it
> is zero? But if it is non-zero, you could at least use it to validate
> the strength settings below.
> 
> At the same time, I would also caution against fragile ECC determination
> methods that can indirectly cause regressions in the future, such as
> with Huang's recent GPMI ECC layout regressions. Perhaps you'll want a
> DT binding for the ECC strength to future proof this? (Not a
> requirement; just a thought.)
> 

Well, for the PXA path, as I don't have this hardware enabled to test
I try do clean-ups and change but without *functionality changes*.

So, you'll notice this pxa_ecc_init() is a different way of doing the
old initialization:

       chip->ecc.mode = NAND_ECC_HW;
       chip->ecc.size = info->fifo_size;
       chip->ecc.strength = 1;

And in fact...

> > +	 */
> > +	if (page_size == 2048) {
> > +		ecc->mode = NAND_ECC_HW;
> > +		ecc->size = 512;

To match the previous code, this should be "ecc->size = 2048"! :/

> > +		ecc->strength = 1;
> 
> I assume this is actually a 1-bit ECC, not just a dummy value? Note that
> the ecc->strength and ecc->size fields are used by nand_base for some
> bitflip calculations and are also exposed via sysfs.
> 

Right. Well, as I said: I tried not to change anything that I'm not able
to fully test.

> > +
> > +		info->spare_size = 40;
> > +		info->ecc_size = 24;
> > +		return 1;
> > +
> > +	} else if (page_size == 512) {
> > +		ecc->mode = NAND_ECC_HW;
> > +		ecc->size = 512;
> > +		ecc->strength = 1;
> > +
> > +		info->spare_size = 8;
> > +		info->ecc_size = 8;
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int armada370_ecc_init(struct pxa3xx_nand_info *info,
> > +			      struct nand_ecc_ctrl *ecc,
> > +			      int strength, int page_size)
> > +{
> > +	/* Unimplemented yet */
> > +	return 0;
> > +}
> > +
> >  static int pxa3xx_nand_scan(struct mtd_info *mtd)
> >  {
> >  	struct pxa3xx_nand_host *host = mtd->priv;

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
