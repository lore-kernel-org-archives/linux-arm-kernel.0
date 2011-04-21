From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Apr 2011 09:42:14 +0200
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104202113250.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
Message-ID: <20110421074214.GE15233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 09:52:15PM +0200, Thomas Gleixner wrote:
> On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> > On Wed, Apr 20, 2011 at 06:16:39PM +0200, Thomas Gleixner wrote:
> > > On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> > > 
> > > Very useful changelog.
> > IMHO OK for a RFC patch.
> 
> Not at all.
> 
> > > 
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
> 
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

>    - a field for the parent
>    - a field for the current clock rate

Currently there is no possibility to bring the clock tree in sync with
the hardware. clocks are not registered at all, they are just there. So
there is no instance who could iterate over the tree in order to bring
it in sync. Unless we create that (which I would like) there is no point
in adding rate and parent fields.
Hm, thinking about this maybe we could add a CLK_IN_SYNC field which
is initially cleared and gets set once the get_parent()/get_rate()
callback has been called for a clock.

>    - a field for the base register
>    - a struct for the offsets of the most common registers relative to
>      base

What's wrong with embedding struct clk into a more specific clock and
access it with container_of()? It must be done anyway once a field is
missing in struct clk, or we end up with a lot of fields in struct clk
which are used in only few types of clocks.

> 
> The least thing which we need now are half baken "abstractions" which
> just shuffle code around for no value.

While I agree with several things you say even the half baken
abstractions help to bring the problems into the light. What we have now
is that all these problems are hidden in SoC specific abstractions which
all have their own problems and bugs.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
