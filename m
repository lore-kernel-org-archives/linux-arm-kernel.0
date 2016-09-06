From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 6 Sep 2016 15:06:35 +0200
Subject: [PATCH 1/7] mtd: nand: Create a NAND reset function
In-Reply-To: <20160906130243.33si26g2jy54grvx@pengutronix.de>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
 <1473158355-22451-2-git-send-email-s.hauer@pengutronix.de>
 <20160906131851.34fa77a9@bbrezillon>
 <20160906130243.33si26g2jy54grvx@pengutronix.de>
Message-ID: <20160906150635.282ab003@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2016 15:02:43 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Tue, Sep 06, 2016 at 01:18:51PM +0200, Boris Brezillon wrote:
> > On Tue,  6 Sep 2016 12:39:09 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >   
> > > When NAND devices are resetted some initialization may have to be done,
> > > like for example they have to be configured for the timing mode that
> > > shall be used. To get a common place where this initialization can be
> > > implemented create a nand_reset() function. This currently only issues
> > > a NAND_CMD_RESET to the NAND device. The places issuing this command
> > > manually are replaced with a call to nand_reset().
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/mtd/nand/nand_base.c | 23 ++++++++++++++++++-----
> > >  include/linux/mtd/nand.h     |  3 +++
> > >  2 files changed, 21 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> > > index 77533f7..20151fc 100644
> > > --- a/drivers/mtd/nand/nand_base.c
> > > +++ b/drivers/mtd/nand/nand_base.c
> > > @@ -948,6 +948,19 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
> > >  }
> > >  
> > >  /**
> > > + * nand_reset - Reset and initialize a NAND device
> > > + * @mtd: mtd info
> > > + *
> > > + * Returns 0 for success or negative error code otherwise
> > > + */
> > > +int nand_reset(struct mtd_info *mtd)  
> > 
> > Can we pass a struct nand_chip * here?  
> 
> Instead of or additionally to truct mtd_info *? One should be enough,
> although most functions take both.

'Instead of'. mtd can be extracted from chip.

> 
> >   
> > > +{
> > > +	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);  
> > 
> > You miss the chip variable.  
> 
> Yeah, the missing hunk is probably in one of the other patches ;) Will
> fix.
> 
> > >  extern int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
> > >  
> > > +/* Reset and initialize a NAND device */
> > > +extern int nand_reset(struct mtd_info *mtd);  
> > 
> > The extern keyword is not needed here.  
> 
> Nope, just added it because the other functions have it aswell. Do we care
> to remove the extern from the other function declarations?

You can, if you want.
