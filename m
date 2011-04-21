From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Apr 2011 11:12:36 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110421072259.GG31131@pengutronix.de>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1104211045220.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Uwe Kleine-K?nig wrote:
> > Which is a complete failure to begin with. Why the heck do you need a
> > callback to figure that out?
> > 
> > Because someone claimed, that you need a callback to make it safe from
> > changing? Or what's the reason for this?
> If there were a pointer tracking the parent you still needed to program
> out the get_parent function anyhow to set the pointer initially. But I
> agree that in other situations having a pointer is more comfortable and
> saves ugly error handling e.g. in set_parent.

That's nonsense. Why do you want a get_parent() function at all?
parent is set up when the clock is established in the clock tree. And
that's not done by some random driver. That's a property of the clock.

> >    It lacks:
> >    
> >    - a flag field for properties
> Up to now there are no properties to distinguish. When the first comes
> up such a field is easily added, no?

Crap. FIXED_CLOCK_RATE is the first thing which comes to my mind
 
> >    - a field for the parent
> I can agree here, see above.
> 
> >    - a field for the current clock rate
> Then you need a mechanism to notify the children if the rate or parent
> of a clock changes. I assume you won't allow that for a clock that has
> more than one (enabled) consumer. 

Here we go. That's why I say that this code is not a framework at
all. It's a random conglomorate of random functions with no
functionality at all.

> Knowing only very few platforms I
> don't know if that is something you can forbid.
 
Did you ever take the time to look over the various clk
implementations and try to see the patterens there? Obviously not, so
what are you arguing about?

> >    - a field for the base register
> This is not needed for all clocks (at least not a say void __iomem *). I
> think it's fine here to leave that to the platforms as it is now.

Crap. All clocks which are configurable in some way or can be
enabled/disabled need access register(s) so you need a base address.

> >    - a struct for the offsets of the most common registers relative to
> >      base
> I'm not sure I understand you right here. If this is about not
> duplicating data/code for similar clocks, this works (IMHO) fine with
> the current approach (ie. sharing the ops pointer).

Right and have tons of duplicated 

      struct myclock {
      	     struct clk;
	     void *base;
	     unsigned long enable_reg;
	     unsigned long enable_reg_cache;
     };

all over the place. Brilliant.
 
> >    optionally a set of common register accessor functions like I did
> >    for the generic irq chip.
> Agreed, this can (and should) come when the base API is fixed.

Base API ?
 
> > 2) The "framework" API is just a set of low level primitive helper
> >    functions
> > 
> >    It lacks:
> > 
> >    - proper refcounting. clk_get() / clk_put() should do that at the
> >      framework level.
> For most clocks it's not important if they are referenced somewhere.
> What should be done with that reference count at the framework level?
> The only thing I currently can come up with now is to module_get an
> optional owner. I'm not convinced this is worth to include in the
> framework. Still it should be possible to do, and it is.

For most clocks it's not important to be protected by a spinlock
either, for many clocks even the prepare mutex is not needed.

The whole point of frameworks is to figure out common patterns and
implement them in a common place. That includes code which is not
needed for many of the users of the code. See all the other
infrastructure stuff: clocksources, clockevents, genirq. Strictly most
of arch/* could do with half of the functionality, but that's not an
argument to implement only half of it and keep the rest somewhere in
the arch/ driver/ implementation.

> >    - proper mechanisms to sanity check clk_set_parent(),
> >      clk_set_rate() et. al.
> > 
> >      This is not a implementation detail inside a specific clock. It's
> >      a problem which is common at least on the tree level:
> > 
> >                     rootclk
> >                  /          \
> >               clk1          clk2   
> >              /   \
> >            clk3  clk4
> >           /
> >          clk5
> > 
> >     So now you want to change the rate of clk1. Can you do that?
> >     
> >     No, but where is the sanity check which prevents that ?
> I assume your ascii art should imply that clk3 and clk4 are enabled?
> What is the policy you suggest?
> This was discussed at some point[1] with the result that the user of
> set_rate should be aware of the clk tree and the changes it introduces
> for now and that some policy could still be added later.  Ditto for
> set_parent. 

Crap. We add a new framework now and we better think twice before
starting to grow any user at all.

> It's easy enough to implement such a policy on top of Jeremy's patches.
> I'm not able to see already now all the requirements of all users of the
> clk-API. So I agree with you that it probably isn't (yet) the perfect
> framework, but I think it's a good base to see these requirements.

Stop calling this a framework and stop telling me that it's easy to
implement stuff on top of it.

> > So unless you fix this stuff you should not even think about
> > converting anything to this "framework". That's just waste of time and
> > effort. Aside of declaring it stable and useful ....
> With stable I didn't intend to say something about the quality (though I
> still think it's a good thing), but that I won't rewrite the commits
> such that others can base their work on top of them.

Stop that bullshit already. We don't add stuff which has questionable
quality and questionable functionality.

> Before your mail nobody spoke up against these patches and some people
> see a value in them and want to convert their platform to it. So

Yes, because most involved people have the same narrow mindset as you
and all you could agree on was the least common denominator of non
functionality. People who have taste and see the big picture gave up
on that. But that does not mean that it's good and something which
should go near the tree or be provided for anyone to convert his
platform to it.

> providing a branch seems sensible to me.

Provide as much branches as you see fit. They wont go near anything.

> I don't say that this common struct clk is perfect already now and I
> expect it to change here and there. It allows to consolidate some code
> and so is a good thing. I think nobody disagrees that when having
> converted most or all platforms to it we're not done. It's just the
> first step. Maybe one of the next is to add a "class" of clocks that
> looks similar to this:

Wrong. We make a sensible functionality first and then convert bulk
instead of doing it over and over again.

Thanks,

	tglx
