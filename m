From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Apr 2011 11:21:53 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110421074214.GE15233@pengutronix.de>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1104211113030.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Sascha Hauer wrote:
> On Wed, Apr 20, 2011 at 09:52:15PM +0200, Thomas Gleixner wrote:
> >    - a field for the parent
> >    - a field for the current clock rate
> 
> Currently there is no possibility to bring the clock tree in sync with
> the hardware. clocks are not registered at all, they are just there. So
> there is no instance who could iterate over the tree in order to bring
> it in sync. Unless we create that (which I would like) there is no point
> in adding rate and parent fields.

And that's where the problem starts. What's the point of that current
conglomorate of function pointers and half baken helper wrappers if we
don't have answers for how to populate the clk tree, how to simplify
stuff w/o the need of tons of callbacks which have to be implemented
all over the place ?

> Hm, thinking about this maybe we could add a CLK_IN_SYNC field which
> is initially cleared and gets set once the get_parent()/get_rate()
> callback has been called for a clock.
> 
> >    - a field for the base register
> >    - a struct for the offsets of the most common registers relative to
> >      base
> 
> What's wrong with embedding struct clk into a more specific clock and
> access it with container_of()? It must be done anyway once a field is
> missing in struct clk, or we end up with a lot of fields in struct clk
> which are used in only few types of clocks.

As I explained already, that's the whole purpose of frameworks. See
clockevents, clocksource, genirq. Lots of stuff is only used by a very
small subset, but it's better to have that in common code than growing
warts at all ends.

> > 
> > The least thing which we need now are half baken "abstractions" which
> > just shuffle code around for no value.
> 
> While I agree with several things you say even the half baken
> abstractions help to bring the problems into the light. What we have now
> is that all these problems are hidden in SoC specific abstractions which
> all have their own problems and bugs.

And sadly enough the proposed solution keeps 90% of that crap where it
is. So it's not a real improvement, just shuffling code around.

Thanks,

	tglx
