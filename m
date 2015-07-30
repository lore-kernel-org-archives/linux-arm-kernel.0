From: mturquette@linaro.org (Michael Turquette)
Date: Wed, 29 Jul 2015 18:21:32 -0700
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <20150727085338.GW3436@x1>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
 <20150727072549.GP2564@lukather> <20150727085338.GW3436@x1>
Message-ID: <20150730012132.642.59489@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-07-27 01:53:38)
> On Mon, 27 Jul 2015, Maxime Ripard wrote:
> 
> > On Wed, Jul 22, 2015 at 02:04:13PM +0100, Lee Jones wrote:
> > > These new API calls will firstly provide a mechanisms to tag a clock as
> > > critical and secondly allow any knowledgeable driver to (un)gate clocks,
> > > even if they are marked as critical.
> > > 
> > > Suggested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/clk/clk.c            | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/clk-provider.h |  2 ++
> > >  include/linux/clk.h          | 30 +++++++++++++++++++++++++++++
> > >  3 files changed, 77 insertions(+)
> > > 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 61c3fc5..486b1da 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -46,6 +46,21 @@ static struct clk_core *clk_core_lookup(const char *name);
> > >  
> > >  /***    private data structures    ***/
> > >  
> > > +/**
> > > + * struct critical -       Provides 'play' over critical clocks.  A clock can be
> > > + *                 marked as critical, meaning that it should not be
> > > + *                 disabled.  However, if a driver which is aware of the
> > > + *                 critical behaviour wants to control it, it can do so
> > > + *                 using clk_enable_critical() and clk_disable_critical().
> > > + *
> > > + * @enabled        Is clock critical?  Once set, doesn't change
> > > + * @leave_on       Self explanatory.  Can be disabled by knowledgeable drivers
> > > + */
> > > +struct critical {
> > > +   bool enabled;
> > > +   bool leave_on;
> > > +};
> > > +
> > >  struct clk_core {
> > >     const char              *name;
> > >     const struct clk_ops    *ops;
> > > @@ -75,6 +90,7 @@ struct clk_core {
> > >     struct dentry           *dentry;
> > >  #endif
> > >     struct kref             ref;
> > > +   struct critical         critical;
> > >  };
> > >  
> > >  struct clk {
> > > @@ -995,6 +1011,10 @@ static void clk_core_disable(struct clk_core *clk)
> > >     if (WARN_ON(clk->enable_count == 0))
> > >             return;
> > >  
> > > +   /* Refuse to turn off a critical clock */
> > > +   if (clk->enable_count == 1 && clk->critical.leave_on)
> > > +           return;
> > > +
> > 
> > I think it should be handled by a separate counting. Otherwise, if you
> > have two users that marked the clock as critical, and then one of them
> > disable it...
> > 
> > >     if (--clk->enable_count > 0)
> > >             return;
> > >  
> > > @@ -1037,6 +1057,13 @@ void clk_disable(struct clk *clk)
> > >  }
> > >  EXPORT_SYMBOL_GPL(clk_disable);
> > >  
> > > +void clk_disable_critical(struct clk *clk)
> > > +{
> > > +   clk->core->critical.leave_on = false;
> > 
> > .. you just lost the fact that it was critical in the first place.
> 
> I thought about both of these points, which is why I came up with this
> strategy.
> 
> Any device which uses the *_critical() API should a) have knowledge of
> what happens when a particular critical clock is gated and b) have
> thought about the consequences.

If this statement above is true then I fail to see the need for a new
api. A driver which has a really great idea of when it is safe or unsafe
to gate a clock should call clk_prepare_enable at probe and then only
call clk_disable_unprepare once it is safe to do so.

The existing bookkeeping in the clock framework will do the rest.

Regards,
Mike

> I don't think we can use reference
> counting, because we'd need as many critical clock owners as there are
> critical clocks.  Cast your mind back to the reasons for this critical
> clock API.  One of the most important intentions of this API is the
> requirement mitigation for each of the critical clocks to have an owner
> (driver).
> 
> With regards to your second point, that's what 'critical.enabled'
> is for.  Take a look at clk_enable_critical().
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
