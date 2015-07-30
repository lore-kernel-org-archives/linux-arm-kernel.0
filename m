From: mturquette@linaro.org (Michael Turquette)
Date: Thu, 30 Jul 2015 15:47:20 -0700
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <20150730095014.GD14642@x1>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
 <20150727072549.GP2564@lukather> <20150727085338.GW3436@x1>
 <20150728114022.GW2564@lukather> <20150728130055.GV14943@x1>
 <20150730011932.642.85168@quantum> <20150730095014.GD14642@x1>
Message-ID: <20150730224720.23791.6722@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-07-30 02:50:14)
> On Wed, 29 Jul 2015, Michael Turquette wrote:
> > Quoting Lee Jones (2015-07-28 06:00:55)
> > > On Tue, 28 Jul 2015, Maxime Ripard wrote:
> > > 
> > > > On Mon, Jul 27, 2015 at 09:53:38AM +0100, Lee Jones wrote:
> > > > > On Mon, 27 Jul 2015, Maxime Ripard wrote:
> > > > > 
> > > > > > On Wed, Jul 22, 2015 at 02:04:13PM +0100, Lee Jones wrote:
> > > > > > > These new API calls will firstly provide a mechanisms to tag a clock as
> > > > > > > critical and secondly allow any knowledgeable driver to (un)gate clocks,
> > > > > > > even if they are marked as critical.
> > > > > > > 
> > > > > > > Suggested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/clk/clk.c            | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  include/linux/clk-provider.h |  2 ++
> > > > > > >  include/linux/clk.h          | 30 +++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 77 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > > > index 61c3fc5..486b1da 100644
> > > > > > > --- a/drivers/clk/clk.c
> > > > > > > +++ b/drivers/clk/clk.c
> > > > > > > @@ -46,6 +46,21 @@ static struct clk_core *clk_core_lookup(const char *name);
> > > > > > >  
> > > > > > >  /***    private data structures    ***/
> > > > > > >  
> > > > > > > +/**
> > > > > > > + * struct critical -   Provides 'play' over critical clocks.  A clock can be
> > > > > > > + *                     marked as critical, meaning that it should not be
> > > > > > > + *                     disabled.  However, if a driver which is aware of the
> > > > > > > + *                     critical behaviour wants to control it, it can do so
> > > > > > > + *                     using clk_enable_critical() and clk_disable_critical().
> > > > > > > + *
> > > > > > > + * @enabled    Is clock critical?  Once set, doesn't change
> > > > > > > + * @leave_on   Self explanatory.  Can be disabled by knowledgeable drivers
> > > > > > > + */
> > > > > > > +struct critical {
> > > > > > > +       bool enabled;
> > > > > > > +       bool leave_on;
> > > > > > > +};
> > > > > > > +
> > > > > > >  struct clk_core {
> > > > > > >         const char              *name;
> > > > > > >         const struct clk_ops    *ops;
> > > > > > > @@ -75,6 +90,7 @@ struct clk_core {
> > > > > > >         struct dentry           *dentry;
> > > > > > >  #endif
> > > > > > >         struct kref             ref;
> > > > > > > +       struct critical         critical;
> > > > > > >  };
> > > > > > >  
> > > > > > >  struct clk {
> > > > > > > @@ -995,6 +1011,10 @@ static void clk_core_disable(struct clk_core *clk)
> > > > > > >         if (WARN_ON(clk->enable_count == 0))
> > > > > > >                 return;
> > > > > > >  
> > > > > > > +       /* Refuse to turn off a critical clock */
> > > > > > > +       if (clk->enable_count == 1 && clk->critical.leave_on)
> > > > > > > +               return;
> > > > > > > +
> > > > > > 
> > > > > > I think it should be handled by a separate counting. Otherwise, if you
> > > > > > have two users that marked the clock as critical, and then one of them
> > > > > > disable it...
> > > > > > 
> > > > > > >         if (--clk->enable_count > 0)
> > > > > > >                 return;
> > > > > > >  
> > > > > > > @@ -1037,6 +1057,13 @@ void clk_disable(struct clk *clk)
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(clk_disable);
> > > > > > >  
> > > > > > > +void clk_disable_critical(struct clk *clk)
> > > > > > > +{
> > > > > > > +       clk->core->critical.leave_on = false;
> > > > > > 
> > > > > > .. you just lost the fact that it was critical in the first place.
> > > > > 
> > > > > I thought about both of these points, which is why I came up with this
> > > > > strategy.
> > > > > 
> > > > > Any device which uses the *_critical() API should a) have knowledge of
> > > > > what happens when a particular critical clock is gated and b) have
> > > > > thought about the consequences.
> > > > 
> > > > Indeed.
> > > > 
> > > > > I don't think we can use reference counting, because we'd need as
> > > > > many critical clock owners as there are critical clocks.
> > > > 
> > > > Which we can have if we replace the call to clk_prepare_enable you add
> > > > in your fourth patch in __set_critical_clocks.
> > > 
> > > What should it be replaced with?
> > > 
> > > > > Cast your mind back to the reasons for this critical clock API.  One
> > > > > of the most important intentions of this API is the requirement
> > > > > mitigation for each of the critical clocks to have an owner
> > > > > (driver).
> > > > > 
> > > > > With regards to your second point, that's what 'critical.enabled'
> > > > > is for.  Take a look at clk_enable_critical().
> > > > 
> > > > I don't think this addresses the issue, if you just throw more
> > > > customers at it, the issue remain with your implementation.
> > > > 
> > > > If you have three customers that used the critical API, and if on of
> > > > these calls clk_disable_critical, you're losing leave_on.
> > > 
> > > That's the idea.  See my point above, the one you replied "Indeed"
> > > to.  So when a driver uses clk_disable_critical() it's saying, "I know
> > > why this clock is a critical clock, and I know that nothing terrible
> > > will happen if I disable it, as I have that covered".  So then if it's
> > > not the last user to call clk_disable(), the last one out the door
> > > will be allowed to finally gate the clock, regardless whether it's
> > > critical aware or not.
> > > 
> > > Then, when we come to enable the clock again, the critical aware user
> > > then re-marks the clock as leave_on, so not critical un-aware user can
> > > take the final reference and disable the clock.
> > > 
> > > > Which means that if there's one of the two users left that calls
> > > > clk_disable on it, the clock will actually be disabled, which is
> > > > clearly not what we want to do, as we have still a user that want the
> > > > clock to be enabled.
> > > 
> > > That's not what happens (at least it shouldn't if I've coded it up
> > > right).  The API _still_ requires all of the users to give-up their
> > > reference.
> > > 
> > > > It would be much more robust to have another count for the critical
> > > > stuff, initialised to one by the __set_critical_clocks function.
> > > 
> > > If I understand you correctly, we already have a count.  We use the
> > > original reference count.  No need for one of our own.
> > > 
> > > Using your RAM Clock (Clock 4) as an example
> > > --------------------------------------------
> > > 
> > > Early start-up:
> > >   Clock 4 is marked as critical and a reference is taken (ref == 1)
> > > 
> > > Driver probe:
> > >   SPI enables Clock 4 (ref == 2)
> > >   I2C enables Clock 4 (ref == 3)
> > > 
> > > Suspend (without RAM driver's permission):
> > >   SPI disables Clock 4 (ref == 2)
> > >   I2C disables Clock 4 (ref == 1)
> > >   /*
> > >    * Clock won't be gated because:
> > >    *   .leave_on is True - can't dec final reference
> > 
> > I am clearly missing the point. The clock won't be gated because the
> > enable_count is still 1! What does .leave_on do here?
> 
> The point of _this_ (the extended) part of the API is so that the
> clock _can_ be turned off.  Without the possibility to disable
> .leave_on and the logic with accompanies it (i.e.
> clk_disable_critical()) the clock will _never_ be gated.
> 
> > >    */
> > > 
> > > Suspend (with RAM driver's permission):
> > >   /* Order is unimportant */
> > >   SPI disables Clock 4 (ref == 2)
> > >   RAM disables Clock 4 (ref == 1) /* Won't turn off here (ref > 0)
> > >   I2C disables Clock 4 (ref == 0) /* (.leave_on == False) last ref can be taken */
> > >   /*
> > >    * Clock will be gated because:
> > >    *   .leave_on is False, so (ref == 0)
> > 
> > Again, .leave_on does nothing new here. We gate the clock because the
> > reference count is 0.
> 
> It's the fact that .leave_on has been disabled in
> clk_disable_critical() that allows the final reference to be taken.
> 
> > >    */
> > > 
> > > Resume:
> > >   /* Order is unimportant */
> > >   SPI enables Clock 4 (ref == 1)
> > >   RAM enables Clock 4 and re-enables .leave_on (ref == 2)
> > >   I2C enables Clock 4 (ref == 3)
> > 
> > Same again. As soon as RAM calls clk_enable_critical the ref count goes
> > up. .leave_on does nothing as far as I can tell. The all works because
> > of the reference counting, which already exists before this patch
> > series.
> 
> So fundamentally you're right in what you say.  All you really need to
> disable a critical clock is write a knowledgeable driver, which is
> intentionally unbalanced i.e. just calls clk_disable().  All this

OK, the line above is helpful. What you really want is a formalized
hand-off mechanism, whereby the clock is enabled at registration-time
and it cannot be turned off until the right driver claims it and decides
turning it off is OK (with a priori knowledge that the clock is already
enabled).

Note that I don't think this implementation can really work in the near
future. Today we do not catch unbalanced calls to clk_enable and
clk_disable, but I have a patch that catches this and WARNs loudly in my
private tree. More on that in the next stanza.

What I don't understand is if there is ever a case for a clock consumer
driver to ever call clk_enable_critical... I do not think there is. What
you're trying to protect against is having the clock disabled BEFORE
that "knowledgeable driver" has a chance to enable it.

Let me know if I've got that right. The only user of this function in
your series is the clk-conf.c stuff, which matches my summary above.

> extended API really does is makes the process more official and
> ensures that an unintentionally unbalanced driver doesn't bugger up
> the running platform.  We could also add a new WARN() to say that said
> driver is unbalanced, as it just tried to turn off a critical clock.

As I mentioned up above I am working on this right now. Our per-user
struct clk stuff makes it trivial to track prepare_count and
enable_count values on a per-user basis. Consequently a naive approach
that simply calls clk_disable an extra time will not work once this code
is merged. This is because the struct clk used in clk-conf.c and in your
knowledgeable driver will be two distinct instances.

Regards,
Mike

> 
> What do you think is best?
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
