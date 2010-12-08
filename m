From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 09:45:54 +0100
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <201012080902.37859.jeremy.kerr@canonical.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<201011291559.21928.jeremy.kerr@canonical.com>
	<20101207143113.GJ21020@pengutronix.de>
	<201012080902.37859.jeremy.kerr@canonical.com>
Message-ID: <20101208084554.GC18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jeremy,

On Wed, Dec 08, 2010 at 09:02:37AM +0800, Jeremy Kerr wrote:
> > I assume the initial feedback should be provided from someone internal
> > to Canonical or Linaro?  Can you give an estimate when you can post it,
> > I really thing that's the way to go for simplifying the clock code on
> > imx which is on my todo list.
> 
> No, I was waiting on feedback from the ST-E platform folks, who will need the 
> atomic clocks. However, I've been out of action for a couple of weeks, hence 
> the delay.
> 
> I'll get the next revision posted this week.
Great.
 
> > While reading quickly over the patch I wondered if there isn't a better
> > way to get that spinlock/mutex thingy implemented.
> > 
> > You currently have:
> > 
> > 	struct clk {
> > 	       const struct clk_ops    *ops;
> > 	       unsigned int            enable_count;
> > 	       int                     flags;
> > 	       union {
> > 	               struct mutex    mutex;
> > 	               spinlock_t      spinlock;
> > 	       } lock;
> > 	};
> > 
> > What about using this one instead?:
> > 
> > 	struct clk_base {
> > 		/* merge that with ops?  Probably not */
> > 		const struct clk_lock_ops *lock_ops;
> > 		const struct clk_ops *ops;
> > 		unsigned int enable_count;
> > 	};
> > 
> > 	struct clk {
> > 		struct clk_base base;
> > 		struct mutex lock;
> > 	};
> > 
> > 	struct clk_atomic {
> > 		struct clk_base base;
> > 		spinlock_t lock;
> > 	};
> 
> This means we'll need a separate API (clk_get_rate, etc) for the atomic 
> clocks, or change the API to take a clk_base (and then fix up all the users of 
> the API).
Ah, that's true.  As I said, I didnt' thought it to an end, just seemed
to be clearer to me.
 
> Regardless, I'd prefer to keep the separation to just the lock itself, rather 
> than percolating down to other interfaces.
> 
> 
> > This way and when I prefer to use the sleeping variant only I don't need
> > to bother with spinlocks at all.
> 
> How do you mean? You shouldn't need to deal with spinlocks with the current 
> code if you're just using non-atomic clocks.
Of course I can ignore them, this is more that I don't like having
members in structs or unions that are unused.  (As a mutex contains a
spinlock anyhow this is admittedly a bit strange when thinking again.
:-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
