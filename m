From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 20 Dec 2017 22:41:21 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <87y3lxccr7.fsf@belgarion.home>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon>
 <877etkecig.fsf@belgarion.home> <20171218092535.2ca1fe13@xps13>
 <87y3lxccr7.fsf@belgarion.home>
Message-ID: <20171220224121.2cb6f690@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Dec 2017 22:26:04 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:
> 
> > Hello Robert,
> >
> > On Mon, 18 Dec 2017 08:11:35 +0100
> > Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> >  
> >> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> >>   
> >> >> Robert, it would be great if you could also do more testing on PXA
> >> >> and validate this driver. If needed, a branch ready to be tested is
> >> >> available at [3]. It is based on nand/next and has all the changes
> >> >> brought by the previously mentionned series as well as this one.    
> >> >
> >> > Robert, do you think you'll have some time to test Miquel's branch
> >> > on your PXA boards? Miquel already tested on one of these boards
> >> > (CM-X300), but we'd like to have other testers. Also feel free to
> >> > review the driver if have the time.
> >> >
> >> > Thanks,
> >> >
> >> > Boris    
> >> 
> >> Hi Boris and Miquel,
> >> 
> >> I have applied the whole serie to linux-next yesterday.
> >> 
> >> A boot attempt on my zylonite with my old defconfig (with the new
> >> Marvell NAND config activated) yields to :
> >>  - this message
> >> [    3.136818] marvell-nfc pxa3xx-nand: could not identify the nand
> >> chip [    3.143874] marvell-nfc: probe of pxa3xx-nand failed with
> >> error -22
> >>  - then my board hangs
> >> 
> >> Is there something to be done to improve the trace level so that you
> >> can guess what's happening ?  
> >
> > Thank you very much for testing this.
> >
> > Could you please try this branch [1] instead of linux-next + the
> > patches?
> >
> > Also, can you please add #define DEBUG in marvell_nand.c + nand_base.c,
> > it should help us figuring out what is wrong.  
> 
> Done, same result, the dmesg is in [1].

Looks like there is a mismatch on the nand bus width detected by the
core and the one declared by the driver. Can you try with the following
diff applied?

Thanks,

Boris

--->8---
diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
index c618ccb22a61..ddd6a07888e2 100644
--- a/drivers/mtd/nand/marvell_nand.c
+++ b/drivers/mtd/nand/marvell_nand.c
@@ -2481,6 +2481,7 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
         */
        chip->ecc.mode = NAND_ECC_HW;
 
+       chip->options |= NAND_BUSWIDTH_AUTO;
        ret = nand_scan_ident(mtd, marvell_nand->nsels, NULL);
        if (ret) {
                dev_err(dev, "could not identify the nand chip\n");
