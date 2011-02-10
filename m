From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 10 Feb 2011 21:08:00 +0800
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <20110210104639.GZ27982@pengutronix.de>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<4D52F73A.4010707@bluewatersys.com>
	<20110210100319.GB24710@b20223-02.ap.freescale.net>
	<20110210104639.GZ27982@pengutronix.de>
Message-ID: <20110210130800.GB3316@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 11:46:39AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Feb 10, 2011 at 06:03:19PM +0800, Richard Zhao wrote:
> > On Thu, Feb 10, 2011 at 09:21:14AM +1300, Ryan Mallon wrote:
> > > On 02/09/2011 07:41 PM, Jeremy Kerr wrote:
> > > 
> > > Hi Jeremy,
> > > 
> > > Couple more comments below.
> > > 
> > > ~Ryan
> > > 
> > [...]
> > > > +int clk_enable(struct clk *clk)
> > > > +{
> > > > +     unsigned long flags;
> > > > +     int ret = 0;
> > > > +
> > > > +     spin_lock_irqsave(&clk->enable_lock, flags);
> > > 
> > >         WARN_ON(clk->prepare_count == 0); ?
> > > 
> > > > +     if (clk->enable_count == 0 && clk->ops->enable)
> > > > +             ret = clk->ops->enable(clk);
> > > 
> > > Does it make sense to have a clock with no enable function which still
> > > returns success from clk_enable? Do we have any platforms which have
> > > NULL clk_enable functions?
> > > 
> > > I think that for enable/disable at least we should require platforms to
> > > provide functions and oops if they have failed to do so. In the rare
> > > case that a platform doesn't need to do anything for enable/disable they
> > > can just supply empty functions.
> > It's possible to be NULL. So are set_rate/get_rate.
> > Ideally, if it's NULL: 
> > prepare/unprepare: only call parent's prepare/unprepare
> > enable/disable: only call parent's enable/disable
> > set_rate: fail
> > get_rate: reture parent's get_rate
> > set_parent: fail
> > get_parent: fail
> I wouldn't hard-code the parents into the generic functions.  But I
> suggest to provide generic callbacks to do this, e.g.
Why? what restriction will it cause to add parent in clk?
Two benifits at least I can see:
1. null ops handle, as I said above.
2. export clock tree to user level for debug. It's very helpfull.

Thanks
Richard
> 
> clk_get_rate_from_parent(struct clk *c)
> {
> 	struct clk *parent = clk_get_parent(c);
> 
> 	return clk_get_rate(parent);
> }
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
