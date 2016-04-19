From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 19 Apr 2016 14:41:52 +0200
Subject: [PATCH v5 39/50] mtd: nand: omap2: switch to mtd_ooblayout_ops
In-Reply-To: <571624EF.9060707@ti.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-40-git-send-email-boris.brezillon@free-electrons.com>
 <5714F011.5080409@ti.com> <20160418170518.363f732d@bbrezillon>
 <57160862.90603@ti.com> <20160419132206.5d909f7e@bbrezillon>
 <571624EF.9060707@ti.com>
Message-ID: <20160419144152.30a4027d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Apr 2016 15:30:39 +0300
Roger Quadros <rogerq@ti.com> wrote:

> On 19/04/16 14:22, Boris Brezillon wrote:
> > Hi Roger,
> > 
> > On Tue, 19 Apr 2016 13:28:50 +0300
> > Roger Quadros <rogerq@ti.com> wrote:
> > 
> >>> @@ -1921,6 +1927,9 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>  		nand_chip->ecc.correct          = omap_correct_data;
> >>>  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
> >>>  		oobbytes_per_step		= nand_chip->ecc.bytes;
> >>> +
> >>> +		if (nand_chip->options & NAND_BUSWIDTH_16)
> >>> +			min_oobbytes		= 1;
> >>
> >> Shouldn't this have been
> >> 		if (!(nand_chip->options & NAND_BUSWIDTH_16)
> >> 			min_oobbytes		= 1;
> >> ?
> > 
> > Yep.
> > 
> >>
> >>>  		break;
> >>>  
> >>>  	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> >>> @@ -2038,10 +2047,8 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>>  	}
> >>>  
> >>>  	/* check if NAND device's OOB is enough to store ECC signatures */
> >>> -	min_oobbytes = (oobbytes_per_step *
> >>> -			(mtd->writesize / nand_chip->ecc.size)) +
> >>> -		       (nand_chip->options & NAND_BUSWIDTH_16 ?
> >>> -			BADBLOCK_MARKER_LENGTH : 1);
> >>> +	min_oobbytes += (oobbytes_per_step *
> >>> +			 (mtd->writesize / nand_chip->ecc.size));
> >>>  	if (mtd->oobsize < min_oobbytes) {
> >>>  		dev_err(&info->pdev->dev,
> >>>  			"not enough OOB bytes required = %d, available=%d\n",
> >>>
> >>
> >> After the above changes BCH with HW ECC worked fine but BCH with SW ECC still failed.
> >> I had to fix it up with the below patch. This is mainly because chip->ecc.steps wasn't
> >> yet initialized before calling nand_bch_init().
> >>
> >> After the below patch it worked fine with bch4 (hw & sw), bch8 (hw & sw) and ham1.
> >> I couldn't yet verify bch16 though.
> > 
> 
> I just verified that bch16 works as well.
> 
> > Thanks for the fix, but I'd prefer fixing the bug for all soft BCH
> > users.
> > 
> > Could you try this patch?
> 
> I tried your patch and it worked fine.

Thanks, I'll provide a reworked nand/next branch soon.
BTW, is there anything to fix in my merge commit (the commit merging
your GPMC/OMAP changes in nand/next)?

> You will still need the below change to omap2.c
> 
> --
> cheers,
> -roger
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 0abfba6..33c8fde 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1715,7 +1715,7 @@ static int omap_sw_ooblayout_free(struct mtd_info *mtd, int section,
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  	int off = BADBLOCK_MARKER_LENGTH;
>  
> -	if (section)
> +	if (section >= chip->ecc.steps)
>  		return -ERANGE;

Sorry but I don't get why we need that one. Don't we have a single
oobfree section starting at the end of the ECC sections?


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
