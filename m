From: ccross@google.com (Colin Cross)
Date: Thu, 21 Apr 2011 17:23:48 -0700
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104211632240.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421120656.GF15233@pengutronix.de>
	<alpine.LFD.2.02.1104211632240.3323@ionos>
Message-ID: <BANLkTikU9RLy9VR+tOPMt0u6zJp-bW5_Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 8:38 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> That brings in another question and this really needs to be answered
> now: Locking
>
> I'm pushing hard on this because I know that retrofitting proper
> locking schemes is going to be a nightmare.
>
> You already have a lock nesting problem when you do parent
> propagation. With your code you do the parent propagation in the child
> callback under the prepare_mutex or the enable_lock.
>
> This is going to end up in lockdep being quite unhappy unless you want
> tons of different lock classes for this stuff. i.e.
>
> ? ? clk_prepare(clk2)
> ? ? ? ?mutex_lock(clk2->mutex);
> ? ? ? ? ? clk->prepare(clk);
> ? ? ? ? ? ? ? ?clk_prepare(clk1)
> ? ? ? ? ? ? ? ? ? ?mutex_lock(clk1->mutex);
>
> And you _CANNOT_ call clk1->prepare() from your clk2 prepare function
> as it would forgo the serialization and the prepare refcounting. And
> this kind of scheme is going to be even more problematic if you do
> bottom up propagation because you will run into lock inversion.
>
> I seriously doubt that the fine grained per clock locking is going to
> work out at all.
>
> How do you protect changes to the tree hierarchy against a traversal
> of a concurrent clk->prepare... propagation? Not at all, because you
> CANNOT. And you cannot use RCU for this either.
>
> So what's the point of the per clk locks? I can't see one at all.
>
> All those callbacks are not high frequency called functions, so if you
> want to make this a true framework which deals with tons of
> interesting stuff like propagation, reparenting and rate changes from
> bottom up then there is only one way to do that: global serialization.
>
> There is no way around that. Everything else is going to be the
> locking hell and racy all over the place.

Per clock locks are useful if you have some very slow clocks and some
very fast clocks.  PLLs may take 20 ms to lock, and preventing any
other call to clk_prepare for that long could be problematic.  The
problem was worse before the clk_enable/clk_prepare split, maybe it's
not necessary at all any more.

For Tegra, I solved my clock locking problems by (almost) always
locking from child to parent, the normal case for
clk_enable/clk_prepare.  In general, you only need to lock parent and
then child if you store the rate of the child in the child's clk
struct and need to update it when the parent changes, or when
traversing the tree for debugging output.  I solved the first problem
by storing the relation between the child and the parent in the child
struct and locking from child to parent on clk_get_rate calls to
calculate the rate, and the second by using a trylock loop over the
list of clocks (see arch/arm/mach-tegra/clock.c).

Now that clk_prepare and clk_enable are split, the long-held locks
(for plls, maybe dvfs?) are separated from the short-held locks for
clk_enable/clk_disable, and the cost of global serialization is much
more acceptable.
