From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 10 Sep 2010 10:10:55 +0800
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <20100613222349.GD31045@fluff.org.uk>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<1275636608.607067.417709988883.1.gpush@pororo>
	<20100611042046.GA31045@fluff.org.uk>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<20100613222349.GD31045@fluff.org.uk>
Message-ID: <1284084655.2877.23.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

> > > > +#define INIT_CLK(name, o) \
> > > > +	{ .ops = &o, .enable_count = 0, \
> > > > +		.mutex = __MUTEX_INITIALIZER(name.mutex) }
> > > 
> > > how about doing the mutex initinitialisation at registration
> > > time, will save a pile of non-zero code in the image to mess up
> > > the compression.
> > 
> > I've just yesterday added the following to my tree, to allow dynamic 
> > initialisation:
> > 
> > static inline void clk_init(struct clk *clk, const struct clk_ops *ops)
> > {
> > 	clk->ops = ops;
> > 	clk->enable_count = 0;
> > 	mutex_init(&clk->mutex);
> > }
> > 
> > So we can do this either way.
> 
> the above is in my view better.

After implementing this, it turns out it won't work - we don't have
access to all clocks in order to do the mutex init (thanks to Jason Hui
for pointing this out).

At present, I'm calling clk_init_common() (which initialises the mutex)
from clkdev_add, but there are clocks that don't get initialised. For
example:

	struct clk_fixed parent_clk = INIT_CLK(32768);
	struct clk_foo child_clk = INIT_CLK_FOO(parent.clk);

	struct clk_lookup lookup = {
		.dev_id = "foo",
		.clk = child_clk,
	};

	function platform_clk_init(void)
	{
		clkdev_add(lookup);
	}

In this case, the child_clk's mutex will get initialised, but
parent_clk's won't. We can't walk the parents of child_clk and
initialise, as we may re-initialise the mutexes of parents with > 1
child.

Now, we *could* do the clk_common_init() from board-specific code, and
require that that code guarantees to call clk_common_init() on every
clock defined. I think that's a recipe for pain, as there will
undoubtedly be clocks missed, causing an oops when the clock is first
used.

So I think the solution will have to be to do the mutex initialisation
statically. I'm planning to leave clk_common_init() available for clocks
initalised at runtime, but it will no longer be called automatically
from core code.

Any thoughts?

Cheers,


Jeremy
