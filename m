From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Aug 2010 23:10:42 +0100
Subject: [PATCH 6/8] mxc_nand: fix correct_data function
In-Reply-To: <20100808204341.GA20065@pengutronix.de>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<1281102791-8089-7-git-send-email-s.hauer@pengutronix.de>
	<20100808081955.GB8687@n2100.arm.linux.org.uk>
	<20100808083244.GC21128@jasper.tkos.co.il>
	<20100808204341.GA20065@pengutronix.de>
Message-ID: <20100808221042.GE23623@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 08, 2010 at 10:43:41PM +0200, Sascha Hauer wrote:
> On Sun, Aug 08, 2010 at 11:32:44AM +0300, Baruch Siach wrote:
> > Hi Russell,
> > 
> > On Sun, Aug 08, 2010 at 09:19:56AM +0100, Russell King - ARM Linux wrote:
> > > On Fri, Aug 06, 2010 at 03:53:09PM +0200, Sascha Hauer wrote:
> > > > +		err = ecc_stat & ecc_bit_mask;
> > > > +		if (err > err_limit) {
> > > > +			printk(KERN_WARNING "UnCorrectable RS-ECC Error\n");
> > > > +			return -1;
> > > 
> > > Someone's being lazy.
> > 
> > The code at nand_read_subpage() (drivers/mtd/nand/nand_base.c) expects the 
> > .correct callback to return -1 on an uncorrectable error:
> > 
> >                 stat = chip->ecc.correct(mtd, p, &chip->buffers->ecccode[i], &chip->buffers->ecccalc[i]);
> >                 if (stat == -1)
> >                         mtd->ecc_stats.failed++;
> >                 else
> >                         mtd->ecc_stats.corrected += stat;
> 
> Then this should be changed to check for stat < 0. I found some drivers
> in the tree returning an errno value in their .correct function instead
> of -1.

That's the whole danger of the whole 'return -1' evilness in the kernel.
The long established convention in the kernel is that negative numbers
returned from functions are negative errno codes.

As soon as you decide that you want a function to return -1 to indicate
an error rather than a real errno code, you lose clarity on which
functions need '-1' and which are proper negative errno codes, and then
you end up with people returning negative errno codes for functions
which should be -1, and people returning -1 for functions which should
be negative errno codes.

If you want a function to return -1 for error, then it probably makes
sense to create a ECC_CORRECT_FAILED definition which happens to be -1.
Or some other number.  But don't use plain '-1' - it looks far too much
like "I was lazy, I couldn't be bothered to look up a proper errno."

We know full well that _lots_ of people submit stuff with 'return -1'
statements where they should be proper negative errno codes, so it's
something people are having a great deal of trouble with already.  Let's
not further confuse everyone by having functions expecting called methods
to do a plain "return -1;" on error.
