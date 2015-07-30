From: mturquette@linaro.org (Michael Turquette)
Date: Thu, 30 Jul 2015 15:57:29 -0700
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <20150730092139.GB14642@x1>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
 <20150727072549.GP2564@lukather> <20150727085338.GW3436@x1>
 <20150730012132.642.59489@quantum> <20150730092139.GB14642@x1>
Message-ID: <20150730225729.23791.68604@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-07-30 02:21:39)
> On Wed, 29 Jul 2015, Michael Turquette wrote:
> > Quoting Lee Jones (2015-07-27 01:53:38)
> > > On Mon, 27 Jul 2015, Maxime Ripard wrote:
> > > 
> > > > On Wed, Jul 22, 2015 at 02:04:13PM +0100, Lee Jones wrote:
> > > > > These new API calls will firstly provide a mechanisms to tag a clock as
> > > > > critical and secondly allow any knowledgeable driver to (un)gate clocks,
> > > > > even if they are marked as critical.
> > > > > 
> > > > > Suggested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/clk/clk.c            | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/clk-provider.h |  2 ++
> > > > >  include/linux/clk.h          | 30 +++++++++++++++++++++++++++++
> > > > >  3 files changed, 77 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > index 61c3fc5..486b1da 100644
> > > > > --- a/drivers/clk/clk.c
> > > > > +++ b/drivers/clk/clk.c
> > > > > @@ -46,6 +46,21 @@ static struct clk_core *clk_core_lookup(const char *name);
> > > > >  
> > > > >  /***    private data structures    ***/
> > > > >  
> > > > > +/**
> > > > > + * struct critical -       Provides 'play' over critical clocks.  A clock can be
> > > > > + *                 marked as critical, meaning that it should not be
> > > > > + *                 disabled.  However, if a driver which is aware of the
> > > > > + *                 critical behaviour wants to control it, it can do so
> > > > > + *                 using clk_enable_critical() and clk_disable_critical().
> > > > > + *
> > > > > + * @enabled        Is clock critical?  Once set, doesn't change
> > > > > + * @leave_on       Self explanatory.  Can be disabled by knowledgeable drivers
> > > > > + */
> > > > > +struct critical {
> > > > > +   bool enabled;
> > > > > +   bool leave_on;
> > > > > +};
> > > > > +
> > > > >  struct clk_core {
> > > > >     const char              *name;
> > > > >     const struct clk_ops    *ops;
> > > > > @@ -75,6 +90,7 @@ struct clk_core {
> > > > >     struct dentry           *dentry;
> > > > >  #endif
> > > > >     struct kref             ref;
> > > > > +   struct critical         critical;
> > > > >  };
> > > > >  
> > > > >  struct clk {
> > > > > @@ -995,6 +1011,10 @@ static void clk_core_disable(struct clk_core *clk)
> > > > >     if (WARN_ON(clk->enable_count == 0))
> > > > >             return;
> > > > >  
> > > > > +   /* Refuse to turn off a critical clock */
> > > > > +   if (clk->enable_count == 1 && clk->critical.leave_on)
> > > > > +           return;
> > > > > +
> > > > 
> > > > I think it should be handled by a separate counting. Otherwise, if you
> > > > have two users that marked the clock as critical, and then one of them
> > > > disable it...
> > > > 
> > > > >     if (--clk->enable_count > 0)
> > > > >             return;
> > > > >  
> > > > > @@ -1037,6 +1057,13 @@ void clk_disable(struct clk *clk)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(clk_disable);
> > > > >  
> > > > > +void clk_disable_critical(struct clk *clk)
> > > > > +{
> > > > > +   clk->core->critical.leave_on = false;
> > > > 
> > > > .. you just lost the fact that it was critical in the first place.
> > > 
> > > I thought about both of these points, which is why I came up with this
> > > strategy.
> > > 
> > > Any device which uses the *_critical() API should a) have knowledge of
> > > what happens when a particular critical clock is gated and b) have
> > > thought about the consequences.
> > 
> > If this statement above is true then I fail to see the need for a new
> > api. A driver which has a really great idea of when it is safe or unsafe
> > to gate a clock should call clk_prepare_enable at probe and then only
> > call clk_disable_unprepare once it is safe to do so.
> > 
> > The existing bookkeeping in the clock framework will do the rest.
> 
> I think you are viewing this particular API back-to-front.  The idea
> is to mark all of the critical clocks at start-up by taking a
> reference.  Then, if there are no knowledgable drivers who wish to
> turn the clock off, the CCF will leave the clock ungated becuase the
> reference count will always be >0.

Right. So I'll ask the same question here that I asked in the other
patch: is there ever a case where a clock consumer driver would want to
call clk_enable_critical? It seems to me that in you usage of it, that
call would only ever be made by the core framework code (e.g. clk-conf.c
or perhaps somewhere in drivers/clk/clk.c).

> 
> The clk_{disable,enable}_critical() calls are to be used by
> knowledgable drivers to say "[disable] I know what I'm doing and it's
> okay for this clock to be turned off" and "[enable] right I'm done
> with this clock now, let's turn it back on and mark it back as
> critical, so no one else can turn it off".

OK, so this almost answers my question above. You have a driver that may
finish using a clock for a while (ie, rmmod knowledgeable_driver), and
you want it (critically) enabled again. Is this a real use case? Who
would come along and disable this clock later on? If the driver is to be
re-loaded then I would suggest never unloading it in the first place.

(Oh and bear in mind when answering my question above that imbalanced
clk_enable/clk_disable calls will not succeed thanks to the vaporware
patch that I have in my local tree)

If you have a second knowledgeable_driver_2 that shares that clock and
can be trusted to manage it (critically) then I would need to see that
example, as it doesn't feel like a real use to me.

> 
> To put things simply, the knowledgable driver will _not_ be enabling
> the clock in the first place.  The first interaction it has with it is
> to gate it.  Then, once it's done, it will enable it again and mark it
> back up as critical.a

I like the first part. Makes sense and fills a real need. I am fully
on-board with a provider-handoff-to-consumer solution. It is all the
weird stuff that comes after it that I'm unsure of.

Regards,
Mike

> 
> Still confused ... let's go on another Q in one of your other emails
> for another way of putting it.
> 
> > > I don't think we can use reference
> > > counting, because we'd need as many critical clock owners as there are
> > > critical clocks.  Cast your mind back to the reasons for this critical
> > > clock API.  One of the most important intentions of this API is the
> > > requirement mitigation for each of the critical clocks to have an owner
> > > (driver).
> > > 
> > > With regards to your second point, that's what 'critical.enabled'
> > > is for.  Take a look at clk_enable_critical().
> > > 
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
