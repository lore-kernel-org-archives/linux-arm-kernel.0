From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Apr 2011 09:22:59 +0200
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104202113250.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
Message-ID: <20110421072259.GG31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Wed, Apr 20, 2011 at 09:52:15PM +0200, Thomas Gleixner wrote:
> On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> > On Wed, Apr 20, 2011 at 06:16:39PM +0200, Thomas Gleixner wrote:
> > > And this whole mess should be written:
> > > 
> > >     ret = clk_prepare(clk->parent);
> > >     if (ret)
> > > 		return ret;
> > > 
> > > Which returns 0 when there is no parent and it also returns 0 when
> > > there is no prepare callback for the parent. Why the hell do we need
> > > all this ERRPTR checking mess and all this conditional crap ?
> >
> > struct clk has no parent member, there is only clk_get_parent(). If
> 
> Which is a complete failure to begin with. Why the heck do you need a
> callback to figure that out?
> 
> Because someone claimed, that you need a callback to make it safe from
> changing? Or what's the reason for this?
If there were a pointer tracking the parent you still needed to program
out the get_parent function anyhow to set the pointer initially. But I
agree that in other situations having a pointer is more comfortable and
saves ugly error handling e.g. in set_parent.

> > there is no parent it returns ERR_PTR(-ENOSYS) and if you pass that
> > to clk_prepare it tries to dereference it. So either it must not be
> > called with an error pointer or clk_prepare et al. need adaption to
> > handle
> 
> The whole clk struct is an utter failure.
> 
> It's simply the least common denominator of all clk madness in the
> tree. Which results in a half documented data structure and a handful
> helper functions of which most of them are exported, though the
> functionality in them is less than the overhead of the EXPORT_SYMBOL.
> 
> That's not an abstraction and neither it's a framework. It's a half
> arsed conglomorate of primitives w/o the minimal documentation how
> those primitives should be used and why they are there in the first
> place.
> 
> This is new code and it should be aimed to cleanup things not to
> shuffle things around in a frenzy.
> 
> So what's wrong with that code:
> 
> 1) struct clk is just a collection of function pointers and two locks
> 
>    It lacks:
>    
>    - a flag field for properties
Up to now there are no properties to distinguish. When the first comes
up such a field is easily added, no?

>    - a field for the parent
I can agree here, see above.

>    - a field for the current clock rate
Then you need a mechanism to notify the children if the rate or parent
of a clock changes. I assume you won't allow that for a clock that has
more than one (enabled) consumer. Knowing only very few platforms I
don't know if that is something you can forbid.

>    - a field for the base register
This is not needed for all clocks (at least not a say void __iomem *). I
think it's fine here to leave that to the platforms as it is now.

>    - a struct for the offsets of the most common registers relative to
>      base
I'm not sure I understand you right here. If this is about not
duplicating data/code for similar clocks, this works (IMHO) fine with
the current approach (ie. sharing the ops pointer).

>    optionally a set of common register accessor functions like I did
>    for the generic irq chip.
Agreed, this can (and should) come when the base API is fixed.

> 2) The "framework" API is just a set of low level primitive helper
>    functions
> 
>    It lacks:
> 
>    - proper refcounting. clk_get() / clk_put() should do that at the
>      framework level.
For most clocks it's not important if they are referenced somewhere.
What should be done with that reference count at the framework level?
The only thing I currently can come up with now is to module_get an
optional owner. I'm not convinced this is worth to include in the
framework. Still it should be possible to do, and it is.
 
>    - the ability to propagate enable/disable/prepare/unprepare down
>      through the parent tree
Ack, I'm working on that.

>    - proper mechanisms to sanity check clk_set_parent(),
>      clk_set_rate() et. al.
> 
>      This is not a implementation detail inside a specific clock. It's
>      a problem which is common at least on the tree level:
> 
>                     rootclk
>                  /          \
>               clk1          clk2   
>              /   \
>            clk3  clk4
>           /
>          clk5
> 
>     So now you want to change the rate of clk1. Can you do that?
>     
>     No, but where is the sanity check which prevents that ?
I assume your ascii art should imply that clk3 and clk4 are enabled?
What is the policy you suggest?
This was discussed at some point[1] with the result that the user of
set_rate should be aware of the clk tree and the changes it introduces
for now and that some policy could still be added later.  Ditto for
set_parent. 
It's easy enough to implement such a policy on top of Jeremy's patches.
I'm not able to see already now all the requirements of all users of the
clk-API. So I agree with you that it probably isn't (yet) the perfect
framework, but I think it's a good base to see these requirements.

>         In the clk1->set_rate() callback ?
> 
> 	Great, that's the wrong place.
> 
>     So now you want to switch the parent of clk3 from clk1 to
>     clk2. Can you do that?
> 
>     No, but where is the sanity check which prevents that ?
> 
>     	In the clk3->set_parent() callback ?
> 
> 	Again, the wrong place.
> 
>     And these are not problems of a particular clk implementation,
>     these are general problems and those want to be addressed in a
>     real framework.
> 
>     It's debatable, whether you want to be able to change clocks which
>     have active childs or not. If not the decision function is pretty
>     simple. If yes, you need a list of child clks which you want to
>     consult first before committing the change.
> 
> So unless you fix this stuff you should not even think about
> converting anything to this "framework". That's just waste of time and
> effort. Aside of declaring it stable and useful ....
With stable I didn't intend to say something about the quality (though I
still think it's a good thing), but that I won't rewrite the commits
such that others can base their work on top of them.
Before your mail nobody spoke up against these patches and some people
see a value in them and want to convert their platform to it. So
providing a branch seems sensible to me.
I don't say that this common struct clk is perfect already now and I
expect it to change here and there. It allows to consolidate some code
and so is a good thing. I think nobody disagrees that when having
converted most or all platforms to it we're not done. It's just the
first step. Maybe one of the next is to add a "class" of clocks that
looks similar to this:

	struct clk_generic {
		struct clk clk;
		unsigned long rate;
		struct clk *parent;
		void __iomem *iobase;

		sometype enable_regoffset;
		size_t enable_shift;

		struct clk **possible_parents;
		size_t num_possible_parents;
		sometype parent_regoffset;
		size_t parent_shift;
	};

and that could be used for a big part of the needed clocks.

Best regards
Uwe

[1] see for example
    http://thread.gmane.org/gmane.linux.ports.sh.devel/9755/focus=1100223
    and the replies to it.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
