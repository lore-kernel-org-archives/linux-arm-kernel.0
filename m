From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 6 Jan 2011 17:07:52 +0100
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <1294199462.348449.192344022926.1.gpush@pororo>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
Message-ID: <20110106160752.GA2775@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 11:51:02AM +0800, Jeremy Kerr wrote:

> + * The @lock member provides either a spinlock or a mutex to protect (at least)
> + * @enable_count. The type of lock used will depend on @flags; if CLK_ATOMIC is
> + * set, then the core clock code will use a spinlock, otherwise a mutex. This
> + * lock will be acquired during clk_enable and clk_disable, so for atomic
> + * clocks, these ops callbacks must not sleep.
> + *
> + * The choice of atomic or non-atomic clock depends on how the clock is enabled.
> + * Typically, you'll want to use a non-atomic clock. For clocks that need to be
> + * enabled/disabled in interrupt context, use CLK_ATOMIC. Note that atomic
> + * clocks with parents will typically cascade enable/disable operations to
> + * their parent, so the parent of an atomic clock *must* be atomic too.

...

> +struct clk {
> +	const struct clk_ops	*ops;
> +	unsigned int		enable_count;
> +	int			flags;
> +	union {
> +		struct mutex	mutex;
> +		spinlock_t	spinlock;
> +	} lock;
> +};

Here you have a "polymorphic" lock, where the clock instance knows
which type it is supposed to be.  I got flak from David Miller and
others trying to do the same thing with the mdio_bus:

   http://kerneltrap.org/mailarchive/linux-netdev/2010/7/6/6280618

The criticism, applied to your case, is that the clk_enable() caller
cannot know whether it is safe to make the call or not. I was told,
"there has got to be a better way."

Richard
