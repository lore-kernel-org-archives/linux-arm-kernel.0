From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 8 Jan 2011 14:15:21 +0100
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <1294199462.348449.192344022926.1.gpush@pororo>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
Message-ID: <20110108131520.GE26617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Wed, Jan 05, 2011 at 11:51:02AM +0800, Jeremy Kerr wrote:
> We currently have ~21 definitions of struct clk in the ARM architecture,
> each defined on a per-platform basis. This makes it difficult to define
> platform- (or architecture-) independent clock sources without making
> assumptions about struct clk, and impossible to compile two
> platforms with different struct clks into a single image.
> 
> This change is an effort to unify struct clk where possible, by defining
> a common struct clk, containing a set of clock operations. Different
> clock implementations can set their own operations, and have a standard
> interface for generic code. The callback interface is exposed to the
> kernel proper, while the clock implementations only need to be seen by
> the platform internals.
> 
> This allows us to share clock code among platforms, and makes it
> possible to dynamically create clock devices in platform-independent
> code.
> 
> Platforms can enable the generic struct clock through
> CONFIG_USE_COMMON_STRUCT_CLK. In this case, the clock infrastructure
> consists of a common struct clk:
> 
> struct clk {
> 	const struct clk_ops	*ops;
> 	unsigned int		enable_count;
> 	int			flags;
> 	union {
> 		struct mutex	mutex;
> 		spinlock_t	spinlock;
> 	} lock;
> };

I'm currently thinking about how to get the locking right with this
approach. In the current i.MX implementation we have a global lock which
protects the clock enable counter and also the register accesses in the
clock code. With the common struct clock we have a lock per clock which
only protects the enable counter, so we have to introduce a second lock
to protect the register accesses.
The problem comes with nested calls to for example clk_enable which
happens when the parent clock gets enabled. currently we do this with
clk->enable(clk->parent) which results in an unlocked clk_enable of the
parent. With common struct clk we would have to call
clk_enable(clk_get_parent(clk) which results in taking the lock a second
time.
Any ideas how to solve this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
