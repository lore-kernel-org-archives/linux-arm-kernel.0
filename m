From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Dec 2010 15:31:13 +0100
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <201011291559.21928.jeremy.kerr@canonical.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<1284522014.517347.33297989274.1.gpush@pororo>
	<AANLkTimuw=FfHn7KtbkNSgwqAkS-6CKA4Rx=-dac-dhg@mail.gmail.com>
	<201011291559.21928.jeremy.kerr@canonical.com>
Message-ID: <20101207143113.GJ21020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 03:59:21PM +0800, Jeremy Kerr wrote:
> Hi Jassi,
> 
> >   Are you planning to revise the patch-set or just taking time to
> > resubmit as such?
> 
> I've reworked this patch to allow clocks that are enabled/disabled in atomic 
> contexts, it's here if you'd like a preview:
> 
> http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=commitdiff;h=33220e119d3213282d4234fec7438baa6d04b5f0
> 
> I'm just waiting on some initial feedback, will post to l-a-k once that's in.
I assume the initial feedback should be provided from someone internal
to Canonical or Linaro?  Can you give an estimate when you can post it,
I really thing that's the way to go for simplifying the clock code on
imx which is on my todo list.

While reading quickly over the patch I wondered if there isn't a better
way to get that spinlock/mutex thingy implemented.

You currently have:

	struct clk {
	       const struct clk_ops    *ops;
	       unsigned int            enable_count;
	       int                     flags;
	       union {
	               struct mutex    mutex;
	               spinlock_t      spinlock;
	       } lock;
	};

What about using this one instead?:

	struct clk_base {
		/* merge that with ops?  Probably not */
		const struct clk_lock_ops *lock_ops;
		const struct clk_ops *ops;
		unsigned int enable_count;
	};

	struct clk {
		struct clk_base base;
		struct mutex lock;
	};

	struct clk_atomic {
		struct clk_base base;
		spinlock_t lock;
	};


with the obvious definition of struct clk_lock_ops and the two instances
for clk and clk_atomic etc. pp.

This way and when I prefer to use the sleeping variant only I don't need
to bother with spinlocks at all.

Just an idea ...

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
