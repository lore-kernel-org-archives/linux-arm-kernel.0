From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 19 Apr 2016 13:22:06 +0200
Subject: [PATCH v5 39/50] mtd: nand: omap2: switch to mtd_ooblayout_ops
In-Reply-To: <57160862.90603@ti.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-40-git-send-email-boris.brezillon@free-electrons.com>
 <5714F011.5080409@ti.com> <20160418170518.363f732d@bbrezillon>
 <57160862.90603@ti.com>
Message-ID: <20160419132206.5d909f7e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Tue, 19 Apr 2016 13:28:50 +0300
Roger Quadros <rogerq@ti.com> wrote:

> > @@ -1921,6 +1927,9 @@ static int omap_nand_probe(struct platform_device *pdev)
> >  		nand_chip->ecc.correct          = omap_correct_data;
> >  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
> >  		oobbytes_per_step		= nand_chip->ecc.bytes;
> > +
> > +		if (nand_chip->options & NAND_BUSWIDTH_16)
> > +			min_oobbytes		= 1;
> 
> Shouldn't this have been
> 		if (!(nand_chip->options & NAND_BUSWIDTH_16)
> 			min_oobbytes		= 1;
> ?

Yep.

> 
> >  		break;
> >  
> >  	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> > @@ -2038,10 +2047,8 @@ static int omap_nand_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	/* check if NAND device's OOB is enough to store ECC signatures */
> > -	min_oobbytes = (oobbytes_per_step *
> > -			(mtd->writesize / nand_chip->ecc.size)) +
> > -		       (nand_chip->options & NAND_BUSWIDTH_16 ?
> > -			BADBLOCK_MARKER_LENGTH : 1);
> > +	min_oobbytes += (oobbytes_per_step *
> > +			 (mtd->writesize / nand_chip->ecc.size));
> >  	if (mtd->oobsize < min_oobbytes) {
> >  		dev_err(&info->pdev->dev,
> >  			"not enough OOB bytes required = %d, available=%d\n",
> > 
> 
> After the above changes BCH with HW ECC worked fine but BCH with SW ECC still failed.
> I had to fix it up with the below patch. This is mainly because chip->ecc.steps wasn't
> yet initialized before calling nand_bch_init().
> 
> After the below patch it worked fine with bch4 (hw & sw), bch8 (hw & sw) and ham1.
> I couldn't yet verify bch16 though.

Thanks for the fix, but I'd prefer fixing the bug for all soft BCH
users.

Could you try this patch?

--->8---

diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index ca9b2a4..3ca3d39 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -177,6 +177,16 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 	}
 
+	/*
+	 * ecc->steps and ecc->total might be used by mtd->ooblayout->ecc(),
+	 * which is called by mtd_ooblayout_count_eccbytes().
+	 * Make sure they are properly initialized before calling
+	 * mtd_ooblayout_count_eccbytes().
+	 * FIXME: we should probaly rework the sequencing in nand_scan_tail()
+	 * to avoid setting those fields twice.
+	 */
+	nand->ecc.steps = eccsteps;
+	nand->ecc.total = eccsteps * eccbytes;
 	if (mtd_ooblayout_count_eccbytes(mtd) != (eccsteps*eccbytes)) {
 		printk(KERN_WARNING "invalid ecc layout\n");
 		goto fail;
