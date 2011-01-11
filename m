From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 10:03:11 +0100
Subject: Locking in the clk API
In-Reply-To: <201101111211.30172.jeremy.kerr@canonical.com>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org>
	<201101111211.30172.jeremy.kerr@canonical.com>
Message-ID: <20110111090311.GM12078@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 12:11:29PM +0800, Jeremy Kerr wrote:
> Hi Paul,
> 
> > This looks like a complete disaster, and is also completely inconsistent
> > with how the API is being used by the vast majority of users today.
> 
> I've been basing this on the mxc clock code, which acquires a mutex for all 
> clk_enable()s. This may not be representative of the majority of clock usage.

For i.MX we can generally turn this into a spinlock. There are some exceptions
though. Most clocks directly visible for drivers are simple clock gates
which can be made atomic. The root clocks are often enough plls which
can't be enabled atomically, but where we have to spin until the pll is
locked. So we we have exactly the case Russell described: Whether we can
enable a clocks atomically depends on the parent (pll) being enabled or
disabled. We can work around this by calling clk_enable to the pll
explicitely from the platform code.

> 
> From a quick search there are a few other cases of non-atomic clock usage:
> 
> tcc:		clk_enable() acquires a global clocks_mutex
> tegra:	has a clk_enable_cansleep()
> davinci: clk_set_parent() aquires a global clocks_mutex
> 
> Excluding the davinci code (we won't worry about set_parent for now...), if we 
> can port mxc and tcc to a sleepable clk_enable, perhaps we could just go with 
> purely atomic operations.
> 
> We'd still need some method of using sleeping clocks though. How about making 
> clk_enable() BUG if the clock is not atomic, and add clk_enable_cansleep() for 
> the cases where clk->ops.enable may sleep.

Quoting Russell:

> I hate the GPIO APIs for doing this _cansleep crap as the decision of
> whether to use the _cansleep or normal APIs normally can't be made at
> the time when the API is used, but sometime later.  Many people just use
> the non-_cansleep versions irrespective of the context they're in -
> which is unnecessarily restrictive - consider what happens if you then
> have that driver use a GPIO on an I2C peripheral...

Sounds like we should rather have s sleeping clk_enable and a
clk_enable_atomic. This way people can use standard clk_enable until
a 'scheduling while atomic' gives a hint in the right direction.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
