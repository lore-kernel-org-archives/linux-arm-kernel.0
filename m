From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 16 Mar 2018 14:38:24 +0100
Subject: [PATCH 21/52] mtd: rawnand: jz4780: convert driver to nand_scan()
In-Reply-To: <d57f95d3-03d0-5905-835f-c278df578b1e@gmail.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
 <20180302170400.6712-22-miquel.raynal@bootlin.com>
 <d57f95d3-03d0-5905-835f-c278df578b1e@gmail.com>
Message-ID: <20180316143824.568be773@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harvey,

On Thu, 15 Mar 2018 15:40:25 +0000, Harvey Hunt
<harveyhuntnexus@gmail.com> wrote:

> Hi Miquel,
> 
> Sorry it's taken me a little while to review your changes, a few
> comments below:
> 
> On 03/02/2018 05:03 PM, Miquel Raynal wrote:
> > Two helpers have been added to the core to make ECC-related
> > configuration between the detection phase and the final NAND scan. Use
> > these hooks and convert the driver to just use nand_scan() instead of
> > both nand_scan_ident() and nand_scan_tail().
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/mtd/nand/raw/jz4780_nand.c | 30 ++++++++++++------------------
> >  1 file changed, 12 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
> > index e69f6ae4c539..fd5dc9d9b0c6 100644
> > --- a/drivers/mtd/nand/raw/jz4780_nand.c
> > +++ b/drivers/mtd/nand/raw/jz4780_nand.c
> > @@ -157,9 +157,8 @@ static int jz4780_nand_ecc_correct(struct mtd_info *mtd, u8 *dat,
> >  	return jz4780_bch_correct(nfc->bch, &params, dat, read_ecc);
> >  }
> >  
> > -static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *dev)
> > +static int jz4780_nand_attach_chip(struct nand_chip *chip)
> >  {
> > -	struct nand_chip *chip = &nand->chip;
> >  	struct mtd_info *mtd = nand_to_mtd(chip);
> >  	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
> >  	int eccbytes;
> > @@ -170,7 +169,8 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
> >  	switch (chip->ecc.mode) {
> >  	case NAND_ECC_HW:
> >  		if (!nfc->bch) {
> > -			dev_err(dev, "HW BCH selected, but BCH controller not found\n");
> > +			dev_err(nfc->dev,
> > +				"HW BCH selected, but BCH controller not found\n");
> >  			return -ENODEV;
> >  		}
> >  
> > @@ -179,15 +179,16 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
> >  		chip->ecc.correct = jz4780_nand_ecc_correct;
> >  		/* fall through */
> >  	case NAND_ECC_SOFT:
> > -		dev_info(dev, "using %s (strength %d, size %d, bytes %d)\n",
> > -			(nfc->bch) ? "hardware BCH" : "software ECC",
> > -			chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
> > +		dev_info(nfc->dev, "using %s (strength %d, size %d, bytes %d)\n",
> > +			 (nfc->bch) ? "hardware BCH" : "software ECC",
> > +			 chip->ecc.strength, chip->ecc.size, chip->ecc.bytes)>  		break;
> >  	case NAND_ECC_NONE:
> > -		dev_info(dev, "not using ECC\n");
> > +		dev_info(nfc->dev, "not using ECC\n");
> >  		break;
> >  	default:
> > -		dev_err(dev, "ECC mode %d not supported\n", chip->ecc.mode);
> > +		dev_err(nfc->dev, "ECC mode %d not supported\n",
> > +			chip->ecc.mode);
> >  		return -EINVAL;
> >  	}  
> These changes seem redundant as dev is passed into the function,
> although you could remove it from the function defintion.

That is right, I should have also removed the 'dev' parameter.

> 
> >  
> > @@ -199,7 +200,7 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
> >  	eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
> >  
> >  	if (eccbytes > mtd->oobsize - 2) {
> > -		dev_err(dev,
> > +		dev_err(nfc->dev,
> >  			"invalid ECC config: required %d ECC bytes, but only %d are available",
> >  			eccbytes, mtd->oobsize - 2);
> >  		return -EINVAL;
> > @@ -279,15 +280,8 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
> >  	chip->controller = &nfc->controller;
> >  	nand_set_flash_node(chip, np);
> >  
> > -	ret = nand_scan_ident(mtd, 1, NULL);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = jz4780_nand_init_ecc(nand, dev)  
> 
> You've removed this call, but without it the ECC won't be initialised...

Actually it is not removed but just renamed to match the core's hook
name. The purpose of this function is to perform any chip-related
tuning after the identification, and the name should not limit
ourselves to do something not related to ECC configuration.

> 
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = nand_scan_tail(mtd);
> > +	chip->ecc.attach_chip = jz4780_nand_attach_chip;  
> 
> This function doesn't exist.

See above, the *nand_init_ecc() function has been renamed in
*nand_attach_chip().

This hook: chip->ecc.attach_chip() will be called between
nand_scan_ident() and nand_scan_tail() from within nand_scan().

> 
> > +	ret = nand_scan(mtd, 1);
> >  	if (ret)
> >  		return ret;
> >  
> >   
> 
> Thanks,
> 
> Harvey

Thanks for reviewing,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
