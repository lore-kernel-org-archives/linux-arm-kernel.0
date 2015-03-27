From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 27 Mar 2015 10:08:42 +0800
Subject: [PATCH 3/4] clk: hisi: add stub clk driver
In-Reply-To: <20150326142226.GJ8656@n2100.arm.linux.org.uk>
References: <1427368419-22222-1-git-send-email-leo.yan@linaro.org>
 <1427368419-22222-4-git-send-email-leo.yan@linaro.org>
 <20150326142226.GJ8656@n2100.arm.linux.org.uk>
Message-ID: <20150327020842.GD4902@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 02:22:26PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 26, 2015 at 07:13:38PM +0800, Leo Yan wrote:
> > +static unsigned long hisi_stub_clk_recalc_rate(struct clk_hw *hw,
> > +		unsigned long parent_rate)
> > +{
> ...
> > +	BUG_ON(!stub_clk->lock);
> ...
> 
> > +static int hisi_stub_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                    unsigned long parent_rate)
> > +{
> ...
> > +	BUG_ON(!stub_clk->lock);
> ...
> 
> > +static long hisi_stub_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> > +		unsigned long *parent_rate)
> > +{
> ...
> > +	BUG_ON(!stub_clk->lock);
> ...
> 
> > +static struct clk_ops hisi_stub_clk_ops = {
> > +	.recalc_rate	= hisi_stub_clk_recalc_rate,
> > +	.round_rate	= hisi_stub_clk_round_rate,
> > +	.set_rate	= hisi_stub_clk_set_rate,
> > +};
> ...
> > +static struct clk *_register_stub_clk(struct device *dev, unsigned int id,
> > +	const char *name, const char *parent_name, unsigned long flags,
> > +	spinlock_t *lock)
> > +{
> > +	struct hisi_stub_clk *stub_clk;
> > +	struct clk *clk;
> > +	struct clk_init_data init;
> > +
> > +	stub_clk = kzalloc(sizeof(*stub_clk), GFP_KERNEL);
> > +	if (!stub_clk) {
> > +		pr_err("%s: fail to alloc stub clk!\n", __func__);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	init.name = name;
> > +	init.ops = &hisi_stub_clk_ops;
> > +	init.parent_names = parent_name ? &parent_name : NULL;
> > +	init.num_parents = parent_name ? 1 : 0;
> > +	init.flags = flags;
> > +
> > +	stub_clk->hw.init = &init;
> > +	stub_clk->id = id;
> > +	stub_clk->lock = lock;
> 
> Under what scenario is it safe to call _register_stub_clk() with a NULL
> lock argument?
> 
> If lock is NULL, then every function callable via the ops structure
> will bug.
> 
> Rather than doing a test in each method function, do it in
> _register_stub_clk() - this means we aren't waiting for a NULL pointer
> deref when one of these method functions gets called.

Will fix to check lock pointer in the function _register_stub_clk().

Thanks,
Leo Yan
