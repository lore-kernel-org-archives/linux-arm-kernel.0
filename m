From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 04 Sep 2013 17:43:19 +0200
Subject: [PATCH v6 5/5] clk: Implement clk_unregister
In-Reply-To: <1377874402-2944-6-git-send-email-s.nawrocki@samsung.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
 <1377874402-2944-6-git-send-email-s.nawrocki@samsung.com>
Message-ID: <52275517.2090906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2013 04:53 PM, Sylwester Nawrocki wrote:
> clk_unregister() is currently not implemented and it is required when
> a clock provider module needs to be unloaded.
> 
> Normally the clock supplier module is prevented to be unloaded by
> taking reference on the module in clk_get().
> 
> For cases when the clock supplier module deinitializes despite the
> consumers of its clocks holding a reference on the module, e.g. when
> the driver is unbound through "unbind" sysfs attribute, there are
> empty clock ops added. These ops are assigned temporarily to struct
> clk and used until all consumers release the clock, to avoid invoking
> callbacks from the module which just got removed.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
[...]
>  /**
>   * clk_unregister - unregister a currently registered clock
>   * @clk: clock to unregister
> - *
> - * Currently unimplemented.
>   */
> -void clk_unregister(struct clk *clk) {}
> +void clk_unregister(struct clk *clk)
> +{
> +	unsigned long flags;
> +
> +	clk_prepare_lock();
> +
> +	if (!clk || IS_ERR(clk)) {
> +		pr_err("%s: invalid clock: %p\n", __func__, clk);
> +		goto out;
> +	}

Actually this check could be done before taking the mutex. And to handle
NULL clocks properly it should be something like:

       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
               return;

I will hold on with posting a corrected version until there are any
further comments.

> +	if (clk->ops == &clk_nodrv_ops) {
> +		pr_err("%s: unregistered clock: %s\n", __func__, clk->name);
> +		goto out;
> +	}
> +	/*
> +	 * Assign empty clock ops for consumers that might still hold
> +	 * a reference to this clock.
> +	 */
> +	flags = clk_enable_lock();
> +	clk->ops = &clk_nodrv_ops;
> +	clk_enable_unlock(flags);
> +
> +	if (!hlist_empty(&clk->children)) {
> +		struct clk *child;
> +
> +		/* Reparent all children to the orphan list. */
> +		hlist_for_each_entry(child, &clk->children, child_node)
> +			clk_set_parent(child, NULL);
> +	}
> +
> +	clk_debug_unregister(clk);
> +
> +	hlist_del_init(&clk->child_node);
> +
> +	if (clk->prepare_count)
> +		pr_warn("%s: unregistering prepared clock: %s\n",
> +					__func__, clk->name);
> +
> +	kref_put(&clk->ref, __clk_release);
> +out:
> +	clk_prepare_unlock();
> +}
>  EXPORT_SYMBOL_GPL(clk_unregister);
