From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 2 Sep 2015 10:21:08 +0200
Subject: [PATCH v2] mtd: nand: sunxi: rely on nand_dt_init initialization
In-Reply-To: <20150902011616.GP81844@google.com>
References: <1440411031-8910-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150902011616.GP81844@google.com>
Message-ID: <20150902102108.72219170@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Tue, 1 Sep 2015 18:16:16 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Mon, Aug 24, 2015 at 12:10:31PM +0200, Boris Brezillon wrote:
> > nand_dt_init(), called from nand_scan_ident(), is already parsing the
> > generic MTD/NAND DT properties, and initializing the nand_chip struct
> > accordingly.
> > Rely on this initialization instead of manually parsing those properties.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Changes since v1:
> > - drop unused strength and blk_size variables
> 
> Good catch, I was about to comment on v1 :)
> 
> > ---
> >  drivers/mtd/nand/sunxi_nand.c | 20 +++++---------------
> >  1 file changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> > index 96dda70..92a2c58 100644
> > --- a/drivers/mtd/nand/sunxi_nand.c
> > +++ b/drivers/mtd/nand/sunxi_nand.c
> > @@ -1164,16 +1164,9 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
> >  			       struct device_node *np)
> >  {
> >  	struct nand_chip *nand = mtd->priv;
> > -	int strength;
> > -	int blk_size;
> >  	int ret;
> >  
> > -	blk_size = of_get_nand_ecc_step_size(np);
> > -	strength = of_get_nand_ecc_strength(np);
> > -	if (blk_size > 0 && strength > 0) {
> > -		ecc->size = blk_size;
> > -		ecc->strength = strength;
> > -	} else {
> > +	if (!ecc->size) {
> >  		ecc->size = nand->ecc_step_ds;
> >  		ecc->strength = nand->ecc_strength_ds;
> >  	}
> > @@ -1183,10 +1176,6 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
> >  
> >  	ecc->mode = NAND_ECC_HW;
> >  
> > -	ret = of_get_nand_ecc_mode(np);
> > -	if (ret >= 0)
> > -		ecc->mode = ret;
> > -
> 
> I think you've missed something here. You're now *only* allowing HW ECC!
> You now want to make this a default case.

Indeed, I missed that point.

> 
> There's also a subtle change here that affects more than just here: you
> don't have a good way to tell the difference between "no ECC mode
> provide" and NAND_ECC_NONE. Perhaps we can modify the nand_ecc_modes_t
> enum to include a "uninitialized" value? I'm not sure if that'd work
> best as 0, -1, or something else, in case there are people making
> assumptions elsewhere...

It really depends on what we want to do. I see at least two solutions
for this problem:
1/ keep the nand_dt_init() implementation as is and ask
   nand_scan_ident() callers to pre-set their default value in ecc.mode.
   This should work since ecc.mode is only overridden if ecc_mode is >= 0.
2/ modify the nand_dt_init function to assign the ecc_mode even if it
   is negative, or create a new value in the enum (NAND_ECC_UNSPECIFIED
   = -1) and assign it to ecc.mode when ecc_mode is negative.

1# does not require any change, but if we choose this solution, we
should make it clear that NAND controller drivers should set their
default value before calling nand_scan_ident().
And if go for 2#, that's not like we'll have to patch a lot of
drivers (AFAICT, the only user in 4.2 is the brcmnand driver) ;-).

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
