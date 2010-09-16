From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 16 Sep 2010 16:19:24 +0800
Subject: [PATCH 0/3] Common struct clk implementation, v7
In-Reply-To: <AANLkTim++mNF=KDabCBCk=jDxbwNFWu=hrDQq=UWR=yM@mail.gmail.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<AANLkTim++mNF=KDabCBCk=jDxbwNFWu=hrDQq=UWR=yM@mail.gmail.com>
Message-ID: <1284625164.3350.62.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

> Having just finished implementing the clock tree support on Tegra, I
> have a few concerns about these patches, and how they relate to the
> clk api.
> 
Thanks for taking a look through the patches - I'm definitely keen to
hear more from those doing implementations of either clock API.

> On the spinlock vs. mutex issue (I know, it's been beaten to death).

I wouldn't say beaten to death, I just haven't heard a good case for the
atomic lock option yet (well, until your email..) :)

> The clk api does not specify whether or not implementations can sleep.
>  In fact, it explicitly states that clk_get and clk_put can't be
> called from atomic context, but does not say anything about the rest
> of the api, which vaguely implies that they can be called from atomic
> context.

At present, clk_enable and clk_disable can only be called from
non-atomic contexts.

All other operations can be called from atomic contexts, *provided that*
the underlying clock implementation does not block. I'm not planning to
enforce any rules about the implementations, so this will probably stay
as an "it depends".

> There are situations in which a non-sleeping clk api is useful, if not
> necessary.  On msm with a smart panel, the vsync is connected to a
> gpio, and the vsync interrupt enables the dma controller clock is to
> start the dma of the framebuffer to the display block.  A similar
> problem can happen in dma audio, where a low watermark interrupt from
> the audio block needs to trigger dma to refill the buffer.

Just to clarify - these two examples definitely can't defer the enable,
right?

> Because of the refcounting in
> clk_disable, this is not particularly difficult, but a
> clk_disable_later helper function might simplify it.

Sounds reasonable; something like clk_disable_later would be good.

> Additionally, using a lock per clk struct can cause AB-BA locking
> issues.  In my implementation, calling clk_enable on a child clock in
> the clock tree can call clk_enable on its parent if the child clock
> was not already enabled.

Yep, and my implementation does the same.

>   This leads to the child clock lock being
> taken, followed by the parent clock lock.  Calling clk_set_rate on the
> parent requires recalculating the rate of all of the children, which
> leads to the parent clock lock being taken first, followed by the
> child clock lock.  Deadlock.

I don't currently enforce any locking in set_rate; if a clock
implementation does locking in this order (child before parent), then
it'd have to use a separate lock, rather than acquiring the clk->mutex
in the set_rate operation.

> I solved these problems by using a single spinlock around all of the
> clocks, plus an additional mutex around the clocks that need to sleep.
>  I also locally added clk_*_cansleep functions to the clk api, and
> used might_sleep to prevent calls to the non-cansleep clk api on
> clocks that require sleeping.  I'm not happy with this solution, as it
> uses a local extension to a cross-platform api, but I don't see any
> way around it.  Some clocks really need to be enabled or disabled from
> atomic context, and some clocks are impossible to use in atomic
> context.
> 
> I think something a little like the gpio api style of cansleep and non
> cansleep functions would help would preserve the ability for clocks to
> avoid sleeping on platforms that don't need to sleep, while allowing
> drivers that can handle sleeping clocks to remain as widely
> cross-platform as possible.  Instead of changing all the calls, add a
> clk_get_nosleep for drivers that will call the clk apis in atomic
> context, which will catch drivers that are not compatible with the
> clock they are requesting early on during probe.
> 
> Either way, the clk api could use some notes on the restrictions for
> both the callers and the implementers to ensure compatibility between
> architectures.

Yes, agreed.

Basically, the reason for choosing a mutex rather than a spinlock is
based on how easy it is to workaround and use it in the "other" context;
ie, how we can use a mutex-based clock in an atomic environment, or use
a spinlock in a non-atomic environment.

With the mutex-based clock, enabling from a atomic environment means
that the callee needs to defer work to non-atomic context, a fairly
standard design pattern which (up until your email) I thought would
cater for all cases.

With a spinlock-based clock, the callee does not need to defer any work,
but it means that the clock implementation needs to enable/disable the
clock atomically. For clock implementations that need to sleep, we can
defer the enabling, but this means that clk_enable() returns before the
clock is actually enabled, which is not acceptable.

If we really do need both locking semantics, it'd be ugly, we could do
something like:

struct clk {
	union {
		struct mutex mutex;
		spintlock_t spinlock;
	} lock;
	const struct clk_ops *ops;
	[...]
};

struct clk_ops {
	void (*lock)(struct clk *clk);
	void (*unlock)(struct clk *clk);
	[ existing clk_ops function pointers ]
};

And provide the corresponding implementations for lock/unlock:

void clk_mutex_lock(struct clk *clk)
{
	mutex_acquire(&clk->lock.mutex);
}

void clk_spinlock_lock(struct clk *clk)
{
	spin_lock(&clk->lock.spinlock);
}

void clk_noop_lock(struct clk *clk)
{
}

Then the implementation can choose the appropriate lock for the clock,
based on whether it needs to sleep to enable & disable. The core code
would then call clk->lock() and clk->unlock() instead of manipulating
clk->mutex directly.

[I've used a union for clarity here - we'd need to do some trickery to
properly initialise the clock's lock statically, or we could drop the
union and steal the mutex's spinlock for the atomic case]

The big downside of this is that the locking semantics are no longer
obvious to the device driver API, which may be getting an atomic clock
or a non-atomic one. As you suggest, we could add a helper:

 clk_get_atomic()

- which would just do a clk_get() and then BUG_ON() if we have the wrong
type.

Any thoughts?

Cheers,


Jeremy
