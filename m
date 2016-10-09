From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 9 Oct 2016 13:58:21 +0200
Subject: [PATCH 5/9] mtd: nand: Expose data interface for ONFI mode 0
In-Reply-To: <20161009051248.GC10199@brian-ubuntu>
References: <1473928373-8680-1-git-send-email-s.hauer@pengutronix.de>
 <1473928373-8680-6-git-send-email-s.hauer@pengutronix.de>
 <20160915145625.15e81012@bbrezillon>
 <20161009051248.GC10199@brian-ubuntu>
Message-ID: <20161009135821.02ec6636@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Sat, 8 Oct 2016 22:12:48 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Thu, Sep 15, 2016 at 02:56:25PM +0200, Boris Brezillon wrote:
> > On Thu, 15 Sep 2016 10:32:49 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >   
> > > The nand layer will need ONFI mode 0 to use it as timing mode
> > > before and right after reset.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/mtd/nand/nand_timings.c | 11 +++++++++++
> > >  include/linux/mtd/nand.h        |  2 ++
> > >  2 files changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/nand/nand_timings.c b/drivers/mtd/nand/nand_timings.c
> > > index 608d098..9cdbc16 100644
> > > --- a/drivers/mtd/nand/nand_timings.c
> > > +++ b/drivers/mtd/nand/nand_timings.c
> > > @@ -297,3 +297,14 @@ int onfi_init_data_interface(struct nand_chip *chip,
> > >  
> > >  	return 0;
> > >  }
> > > +
> > > +/**
> > > + * nand_get_default_data_interface - [NAND Interface] Retrieve NAND
> > > + * data interface for mode 0. This is used as default timing after
> > > + * reset.
> > > + */
> > > +const struct nand_data_interface *nand_get_default_data_interface(void)
> > > +{
> > > +	return &onfi_sdr_timings[0];
> > > +}
> > > +EXPORT_SYMBOL(nand_get_default_data_interface);  
> > 
> > You export nand_get_default_data_interface() here, but you don't export
> > onfi_init_data_interface().
> > None of these functions should be called from NAND controller drivers,
> > so they don't need to be exported. ITOH, the prototypes are public
> > (defined in nand.h), so nothing prevents a driver from calling these
> > functions.  
> 
> A bit late, but we can still change things for the next cycle of
> course...
> 
> > I don't know what's the best solution here:
> > 1/ Export both nand_get_default_data_interface() and
> >    onfi_init_data_interface()  
> 
> I don't really like this one. We shouldn't export them if we don't want
> people to use them in modules. And I'm sure the various compile-test
> builders out there would complain eventually if someone did.

Yes, I had the feeling it was the wrong choice, but it was also the
less invasive one ;-).

> 
> > 2/ Do not export them, but keep their prototypes in nand.h with a
> >    comment saying that they should not be directly called by NAND
> >    controller drivers  
> 
> Could be OK.

I don't like that one. It just bloats nand.h with things that are not
supposed to be exported to NAND controller drivers, which just adds
more confusion (the NAND framework is already hard to
follow/understand, let's try not to make it worse).

> 
> > 3/ Removing the prototypes from nand.h and defining them in nand_base.c
> >    (or in a private header).  
> 
> I like this one. Why not add a drivers/mtd/nand/nand.h that's intended
> for the nand.{o,ko} module only?

I like this one too. I'll try to come up with something (maybe with a
different name, like core.h, to prevent developers from including this
file in their NAND controller drivers).

Thanks,

Boris
