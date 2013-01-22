From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Tue, 22 Jan 2013 11:12:29 +0530
Subject: [PATCH 1/4] ARM: cache-l2x0: Manage the errata at run time
In-Reply-To: <20130121140344.GG18005@mudshark.cambridge.arm.com>
References: <20130121131451.GA29855@bnru10>
 <20130121140344.GG18005@mudshark.cambridge.arm.com>
Message-ID: <20130122054227.GA5594@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 15:03:44 +0100, Will Deacon wrote:
> On Mon, Jan 21, 2013 at 01:14:53PM +0000, srinidhi kasagar wrote:
> > Make it possible to manage the errata by its own by using the
> > l2x0 ID register. This relieves the platforms from choosing the
> > Errata's at compile time
> > 
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > ---
> >  arch/arm/include/asm/hardware/cache-l2x0.h |    2 +
> >  arch/arm/mm/cache-l2x0.c                   |   77 +++++++++++++++-------------
> >  2 files changed, 43 insertions(+), 36 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> > index 3b2c40b..d5994ac 100644
> > --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> > +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> > @@ -117,6 +117,8 @@ static inline int l2x0_of_init(u32 aux_val, u32 aux_mask)
> >  }
> >  #endif
> >  
> > +asmlinkage u32 l2x0_get_rtl_release(void);
> > +
> >  struct l2x0_regs {
> >  	unsigned long phy_base;
> >  	unsigned long aux_ctrl;
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index c2f3739..49058ac 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -49,6 +49,16 @@ struct l2x0_of_data {
> >  
> >  static bool of_init = false;
> >  
> > +/*
> > + * Identify ther RTL releases of l2x0 - This might help in applying
> > + * the l2x0 errata's dynamically rather compile time options
> > + */
> > +asmlinkage u32 l2x0_get_rtl_release(void)
> > +{
> > +	return readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
> > +			L2X0_CACHE_ID_RTL_MASK;
> > +}
> 
> You're calling this function all over the place, including from the flush
> code. Can you read the RTL release during probe and stash it somewhere
> instead please?

I thought of doing that, however TI omap's suspend is the only one which needs
this API as well, So, I had to make it global. Refer my patch 3/4. I can
duplicate this for omap if you think so..

srinidhi
