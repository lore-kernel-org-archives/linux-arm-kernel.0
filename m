From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Apr 2011 17:38:24 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110421120656.GF15233@pengutronix.de>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421120656.GF15233@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1104211632240.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Sascha Hauer wrote:
> On Thu, Apr 21, 2011 at 11:21:53AM +0200, Thomas Gleixner wrote:
> That's why I tried to sort out some common patterns (divider, gates,
> muxes) and put them into drivers/clk for other people to use it. It's
> enough to build a whole clock tree out of it (except plls and special
> stuff). All things you mentioned which are missing in the common clock
> stuff can be added without touching the i.MX specific parts. You want
> the framework (once it actually is one) to handle the parents? just move
> the parent handling out of drivers/clk/clk-[divider|mux|gate].c to
> drivers/clk/clk.c. Refcounting shall be fixed? do so in
> drivers/clk/clkdev.c.

The point is that we want to do stuff like that now - BEFORE anyone
starts using struct clk and the helper functions.

> I didn't say that the patches I posted shall be moved upstream as-is. I
> only wanted to show how a clock tree can look like when we sort out
> common patterns.

We really want to get some sensible functionality for starting.

So what I can see now from the discussion is that we should at least
add the following fields to struct clk:

       unsigned long  flags;
       unsigned long   rate;
       struct clk     *parent;
       unsigned int   users;

Add the parent propagation to the clk_enable disable prepare unprepare
functions.

And we should add right away:

       struct hlist_head childs;
       struct hlist_node node;

Plus infrastructure to register clocks with the parent. Advanced
things like bottom up propagation of clock rate changes is something
we can do later, but we really want to make proper registration a
required change for users of the new stuff.

That brings in another question and this really needs to be answered
now: Locking

I'm pushing hard on this because I know that retrofitting proper
locking schemes is going to be a nightmare.

You already have a lock nesting problem when you do parent
propagation. With your code you do the parent propagation in the child
callback under the prepare_mutex or the enable_lock.

This is going to end up in lockdep being quite unhappy unless you want
tons of different lock classes for this stuff. i.e.

     clk_prepare(clk2)
	mutex_lock(clk2->mutex);
	   clk->prepare(clk);
		clk_prepare(clk1)
		    mutex_lock(clk1->mutex);	

And you _CANNOT_ call clk1->prepare() from your clk2 prepare function
as it would forgo the serialization and the prepare refcounting. And
this kind of scheme is going to be even more problematic if you do
bottom up propagation because you will run into lock inversion.

I seriously doubt that the fine grained per clock locking is going to
work out at all.

How do you protect changes to the tree hierarchy against a traversal
of a concurrent clk->prepare... propagation? Not at all, because you
CANNOT. And you cannot use RCU for this either.

So what's the point of the per clk locks? I can't see one at all.

All those callbacks are not high frequency called functions, so if you
want to make this a true framework which deals with tons of
interesting stuff like propagation, reparenting and rate changes from
bottom up then there is only one way to do that: global serialization.

There is no way around that. Everything else is going to be the
locking hell and racy all over the place.

Thanks,

	tglx
