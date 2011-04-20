From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Apr 2011 21:52:15 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110420185922.GD31131@pengutronix.de>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1104202113250.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> On Wed, Apr 20, 2011 at 06:16:39PM +0200, Thomas Gleixner wrote:
> > On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> > 
> > Very useful changelog.
> IMHO OK for a RFC patch.

Not at all.

> > 
> > And this whole mess should be written:
> > 
> >     ret = clk_prepare(clk->parent);
> >     if (ret)
> > 		return ret;
> > 
> > Which returns 0 when there is no parent and it also returns 0 when
> > there is no prepare callback for the parent. Why the hell do we need
> > all this ERRPTR checking mess and all this conditional crap ?
>
> struct clk has no parent member, there is only clk_get_parent(). If

Which is a complete failure to begin with. Why the heck do you need a
callback to figure that out?

Because someone claimed, that you need a callback to make it safe from
changing? Or what's the reason for this?

> there is no parent it returns ERR_PTR(-ENOSYS) and if you pass that
> to clk_prepare it tries to dereference it. So either it must not be
> called with an error pointer or clk_prepare et al. need adaption to
> handle

The whole clk struct is an utter failure.

It's simply the least common denominator of all clk madness in the
tree. Which results in a half documented data structure and a handful
helper functions of which most of them are exported, though the
functionality in them is less than the overhead of the EXPORT_SYMBOL.

That's not an abstraction and neither it's a framework. It's a half
arsed conglomorate of primitives w/o the minimal documentation how
those primitives should be used and why they are there in the first
place.

This is new code and it should be aimed to cleanup things not to
shuffle things around in a frenzy.

So what's wrong with that code:

1) struct clk is just a collection of function pointers and two locks

   It lacks:
   
   - a flag field for properties
   - a field for the parent
   - a field for the current clock rate
   - a field for the base register
   - a struct for the offsets of the most common registers relative to
     base

   optionally a set of common register accessor functions like I did
   for the generic irq chip.

2) The "framework" API is just a set of low level primitive helper
   functions

   It lacks:

   - proper refcounting. clk_get() / clk_put() should do that at the
     framework level.

   - the ability to propagate enable/disable/prepare/unprepare down
     through the parent tree

   - proper mechanisms to sanity check clk_set_parent(),
     clk_set_rate() et. al.

     This is not a implementation detail inside a specific clock. It's
     a problem which is common at least on the tree level:

                    rootclk
                 /          \
              clk1          clk2   
             /   \
           clk3  clk4
	   /
         clk5

    So now you want to change the rate of clk1. Can you do that?
    
    No, but where is the sanity check which prevents that ?
    
        In the clk1->set_rate() callback ?

	Great, that's the wrong place.

    So now you want to switch the parent of clk3 from clk1 to
    clk2. Can you do that?

    No, but where is the sanity check which prevents that ?

    	In the clk3->set_parent() callback ?

	Again, the wrong place.

    And these are not problems of a particular clk implementation,
    these are general problems and those want to be addressed in a
    real framework.

    It's debatable, whether you want to be able to change clocks which
    have active childs or not. If not the decision function is pretty
    simple. If yes, you need a list of child clks which you want to
    consult first before committing the change.

So unless you fix this stuff you should not even think about
converting anything to this "framework". That's just waste of time and
effort. Aside of declaring it stable and useful ....

The least thing which we need now are half baken "abstractions" which
just shuffle code around for no value.

Thanks,

	tglx
