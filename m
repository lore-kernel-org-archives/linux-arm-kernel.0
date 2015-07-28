From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Jul 2015 13:40:22 +0200
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <20150727085338.GW3436@x1>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
 <20150727072549.GP2564@lukather> <20150727085338.GW3436@x1>
Message-ID: <20150728114022.GW2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 09:53:38AM +0100, Lee Jones wrote:
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
> > > + * struct critical -	Provides 'play' over critical clocks.  A clock can be
> > > + *			marked as critical, meaning that it should not be
> > > + *			disabled.  However, if a driver which is aware of the
> > > + *			critical behaviour wants to control it, it can do so
> > > + *			using clk_enable_critical() and clk_disable_critical().
> > > + *
> > > + * @enabled	Is clock critical?  Once set, doesn't change
> > > + * @leave_on	Self explanatory.  Can be disabled by knowledgeable drivers
> > > + */
> > > +struct critical {
> > > +	bool enabled;
> > > +	bool leave_on;
> > > +};
> > > +
> > >  struct clk_core {
> > >  	const char		*name;
> > >  	const struct clk_ops	*ops;
> > > @@ -75,6 +90,7 @@ struct clk_core {
> > >  	struct dentry		*dentry;
> > >  #endif
> > >  	struct kref		ref;
> > > +	struct critical		critical;
> > >  };
> > >  
> > >  struct clk {
> > > @@ -995,6 +1011,10 @@ static void clk_core_disable(struct clk_core *clk)
> > >  	if (WARN_ON(clk->enable_count == 0))
> > >  		return;
> > >  
> > > +	/* Refuse to turn off a critical clock */
> > > +	if (clk->enable_count == 1 && clk->critical.leave_on)
> > > +		return;
> > > +
> > 
> > I think it should be handled by a separate counting. Otherwise, if you
> > have two users that marked the clock as critical, and then one of them
> > disable it...
> > 
> > >  	if (--clk->enable_count > 0)
> > >  		return;
> > >  
> > > @@ -1037,6 +1057,13 @@ void clk_disable(struct clk *clk)
> > >  }
> > >  EXPORT_SYMBOL_GPL(clk_disable);
> > >  
> > > +void clk_disable_critical(struct clk *clk)
> > > +{
> > > +	clk->core->critical.leave_on = false;
> > 
> > .. you just lost the fact that it was critical in the first place.
> 
> I thought about both of these points, which is why I came up with this
> strategy.
> 
> Any device which uses the *_critical() API should a) have knowledge of
> what happens when a particular critical clock is gated and b) have
> thought about the consequences.

Indeed.

> I don't think we can use reference counting, because we'd need as
> many critical clock owners as there are critical clocks.

Which we can have if we replace the call to clk_prepare_enable you add
in your fourth patch in __set_critical_clocks.

> Cast your mind back to the reasons for this critical clock API.  One
> of the most important intentions of this API is the requirement
> mitigation for each of the critical clocks to have an owner
> (driver).
> 
> With regards to your second point, that's what 'critical.enabled'
> is for.  Take a look at clk_enable_critical().

I don't think this addresses the issue, if you just throw more
customers at it, the issue remain with your implementation.

If you have three customers that used the critical API, and if on of
these calls clk_disable_critical, you're losing leave_on.

Which means that if there's one of the two users left that calls
clk_disable on it, the clock will actually be disabled, which is
clearly not what we want to do, as we have still a user that want the
clock to be enabled.

It would be much more robust to have another count for the critical
stuff, initialised to one by the __set_critical_clocks function.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/f38b6aaf/attachment-0001.sig>
