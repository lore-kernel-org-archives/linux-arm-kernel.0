From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 14 Dec 2011 14:18:16 +0100 (CET)
Subject: [PATCH v4 3/6] clk: introduce the common clock framework
In-Reply-To: <1323834838-2206-4-git-send-email-mturquette@linaro.org>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-4-git-send-email-mturquette@linaro.org>
Message-ID: <alpine.LFD.2.02.1112141007550.3020@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Dec 2011, Mike Turquette wrote:
> +void __clk_unprepare(struct clk *clk)
> +{
> +	if (!clk)
> +		return;
> +
> +	if (WARN_ON(clk->prepare_count == 0))
> +		return;
> +
> +	if (--clk->prepare_count > 0)
> +		return;
> +
> +	WARN_ON(clk->enable_count > 0);

So this leaves the clock enable count set. I'm a bit wary about
that. Shouldn't it either return (including bumping the prepare_count
again) or call clk_disable() ?

> +/**
> + * clk_get_parent - return the parent of a clk
> + * @clk: the clk whose parent gets returned
> + *
> + * Simply returns clk->parent.  It is up to the caller to hold the
> + * prepare_lock, if desired.  Returns NULL if clk is NULL.

Holding the prepare lock in the caller will deadlock. So it's not a
real good idea to document it as an option :)

> + */
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	struct clk *parent;
> +
> +	if (!clk)
> +		return NULL;
> +
> +	mutex_lock(&prepare_lock);

> +/**
> + * clk_init - initialize the data structures in a struct clk
> + * @dev: device initializing this clk, placeholder for now
> + * @clk: clk being initialized
> + *
> + * Initializes the lists in struct clk, queries the hardware for the
> + * parent and rate and sets them both.  Adds the clk to the sysfs tree
> + * topology.
> + *
> + * Caller must populate clk->name and clk->flags before calling

I'm not too happy about this construct. That leaves struct clk and its
members exposed to the world instead of making it a real opaque
cookie. I know from my own painful experience, that this will lead to
random fiddling in that data structure in drivers and arch code just
because the core code has a shortcoming.

Why can't we make struct clk a real cookie and confine the data
structure to the core code ?

That would change the init call to something like:

struct clk *clk_init(struct device *dev, const struct clk_hw *hw,
                     struct clk *parent)

And have:
struct clk_hw {
       struct clk_hw_ops *ops;
       const char 	 *name;
       unsigned long	 flags;
};       

Implementers can do:
struct my_clk_hw {
       struct clk_hw	hw;
       mydata;
};

And then change the clk ops callbacks to take struct clk_hw * as an
argument.

So the core code can allocate the clk data structure and you return a
real opaque cookie. You do the same thing for the basic gated clock in
one of the next patches, so doing it for struct clk itself is just
consequent.

> + * clk_init.  A key assumption in the call to .get_parent is that clks
> + * are being initialized in-order.

We should not require that, see below.

> + */

> +void clk_init(struct device *dev, struct clk *clk)
> +{
> +	if (!clk)
> +		return;
> +
> +	INIT_HLIST_HEAD(&clk->children);
> +	INIT_HLIST_NODE(&clk->child_node);
> +
> +	mutex_lock(&prepare_lock);
> +
> +	/*
> +	 * .get_parent is mandatory for populating .parent for clks with
> +	 * multiple possible parents.  For clks with a fixed parent
> +	 * .get_parent is not mandatory and .parent can be statically
> +	 * initialized
> +	 */
> +	if (clk->ops->get_parent)
> +		clk->parent = clk->ops->get_parent(clk);
> +
> +	/* clks without a parent are considered root clks */

I'd rather prefer that root clocks are explicitely marked with a flag
instead of relying on clk->parent being NULL.

> +	if (clk->parent)
> +		hlist_add_head(&clk->child_node,
> +				&clk->parent->children);
> +	else
> +		hlist_add_head(&clk->child_node, &clk_root_list);

You could put clocks which have no parent and are not marked as root
clock onto a separate list clk_orphaned or such. You might need this
for handling clocks which are disconnected from any parent runtime as
well.

And to avoid the whole in-order initialization issue, you could change
clk_init to:

struct clk *clk_init(struct device *dev, const struct clk_hw *hw,
                     unsigned long flags, const char *parent_name)

Then you can lookup the requested parent by name. If that fails, you
put the clock into the orphaned list. When a new clock is initialized,
then you walk the orphaned list and check whether something is waiting
for that clock.

To handle multi-parent clocks you need to go one step further and add:

struct clk_hw {
       struct clk_hw_ops *ops;
       const char 	 *name;
       const char	 **possible_parents;
};

You also require a get_parent_idx() function in clk_hw_ops. So when
clk_init() is called with parent_name = NULL and get_parent_idx() is
implemented, then you call it and the clock returns you the index of
the possible_parents array. If that parent clock is not yet
registered, you store the requested name and do the lookup when new
clocks are registered.

That has also the advantage, that you can validate parent settings
upfront and for setting the parent during runtime, you don't have to
acquire a pointer to the parent clock. It's enough to call
clk_set_named_parent().

Thoughts ?

	 tglx
