From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 8 Aug 2010 22:43:41 +0200
Subject: [PATCH 6/8] mxc_nand: fix correct_data function
In-Reply-To: <20100808083244.GC21128@jasper.tkos.co.il>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<1281102791-8089-7-git-send-email-s.hauer@pengutronix.de>
	<20100808081955.GB8687@n2100.arm.linux.org.uk>
	<20100808083244.GC21128@jasper.tkos.co.il>
Message-ID: <20100808204341.GA20065@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 08, 2010 at 11:32:44AM +0300, Baruch Siach wrote:
> Hi Russell,
> 
> On Sun, Aug 08, 2010 at 09:19:56AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 06, 2010 at 03:53:09PM +0200, Sascha Hauer wrote:
> > > +		err = ecc_stat & ecc_bit_mask;
> > > +		if (err > err_limit) {
> > > +			printk(KERN_WARNING "UnCorrectable RS-ECC Error\n");
> > > +			return -1;
> > 
> > Someone's being lazy.
> 
> The code at nand_read_subpage() (drivers/mtd/nand/nand_base.c) expects the 
> .correct callback to return -1 on an uncorrectable error:
> 
>                 stat = chip->ecc.correct(mtd, p, &chip->buffers->ecccode[i], &chip->buffers->ecccalc[i]);
>                 if (stat == -1)
>                         mtd->ecc_stats.failed++;
>                 else
>                         mtd->ecc_stats.corrected += stat;

Then this should be changed to check for stat < 0. I found some drivers
in the tree returning an errno value in their .correct function instead
of -1.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
