From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 10 Jan 2011 10:43:04 +0800
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <20110108131520.GE26617@pengutronix.de>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
	<20110108131520.GE26617@pengutronix.de>
Message-ID: <201101101043.05406.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> I'm currently thinking about how to get the locking right with this
> approach. In the current i.MX implementation we have a global lock which
> protects the clock enable counter and also the register accesses in the
> clock code. With the common struct clock we have a lock per clock which
> only protects the enable counter, so we have to introduce a second lock
> to protect the register accesses.

Are the registers shared between clocks? If not, you can just use the existing 
per-clk lock. Otherwise it'd be reasonable to add a global register lock, 
protecting accesses to the shared register set (and *only* protecting these 
registers).

> The problem comes with nested calls to for example clk_enable which
> happens when the parent clock gets enabled. currently we do this with
> clk->enable(clk->parent) which results in an unlocked clk_enable of the
> parent. With common struct clk we would have to call
> clk_enable(clk_get_parent(clk) which results in taking the lock a second
> time.
> Any ideas how to solve this?

With the shared register lock, you just need to make sure that you don't 
recurse to the parent while holding the lock.

For clocks with a shared register set, the general pattern would be something 
like:

struct clk_foo {
	struct clk clk;
	u32        enable_reg;
	u32        enable_mask;
	struct clk *parent;
};

static DEFINE_SPINLOCK(clk_foo_register_lock);

/* called with _clk->lock held */
static int clk_foo_enable(struct clk *_clk)
{
	struct clk_foo *clk = to_clk_foo(_clk);
	int reg, rc;

	/* enable parent - will acquire and release the parent's per-clk lock */
	rc = clk_enable(clk->parent);
	if (rc)
		return rc;

	/* do register update, under global register lock */
	spin_lock(&clk_foo_register_lock);

	reg = __raw_readl(clk->reg);
	__raw_writel(clk->reg, reg | clk->enable_mask);

	spin_unlock(&clk_foo_register_lock);

	return 0;
}

struct clk_foo_ops = {
	.enable = clk_foo_enable;
	[...]
};

However, because clk_mxc introduces its own set of abstractions, there may be 
some merging to do here. For my work on mx51, I've done a very basic port:

 * changed plat-mxc's struct clk to struct clk_mxc
 * embedded struct clk into struct clk_mxc (ie, making it use the common API)
 * separated some of the simpler clocks to separate types (eg clk_fixed,
   clk_pll, clk_ccgr).

The goal here is to separate all of the clocks into their most basic types, 
leaving no clk_mxc clocks remaining, then the locking should be much simpler.

Cheers,


Jeremy
