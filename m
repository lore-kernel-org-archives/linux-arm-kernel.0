From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 11 Jun 2013 13:13:29 -0700
Subject: [PATCH v2] clk: implement clk_unregister
In-Reply-To: <1370247855-3547-1-git-send-email-jiada_wang@mentor.com>
References: <1370247855-3547-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20130611201329.8816.57983@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jiada Wang (2013-06-03 01:24:15)
> Currently clk_unregister is unimplemented, it is required in case
> sub modules want actually remove clk device registered by clk_register.
> This patch adds the implementation of clk_unregiser.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/clk/clk.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 934cfd1..0b9e13c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -342,6 +342,25 @@ out:
>         return ret;
>  }
>  
> + /**
> + * clk_debug_unregister - remove a clk node from the debugfs clk tree
> + * @clk: the clk being removed from the debugfs clk tree
> + *
> + * Dynamically removes a clk and all it's children clk nodes from the
> + * debugfs clk tree if clk->dentry points to debugfs created by
> + * clk_debug_register in __clk_init.
> + *
> + * Caller must hold prepare_lock.
> + *
> + */
> +static void clk_debug_unregister(struct clk *clk)
> +{
> +       if (!clk || !clk->dentry)
> +               return;
> +
> +       debugfs_remove_recursive(clk->dentry);
> +}
> +
>  /**
>   * clk_debug_reparent - reparent clk node in the debugfs clk tree
>   * @clk: the clk being reparented
> @@ -432,6 +451,9 @@ static inline int clk_debug_register(struct clk *clk) { return 0; }
>  static inline void clk_debug_reparent(struct clk *clk, struct clk *new_parent)
>  {
>  }
> +static inline void clk_debug_unregister(struct clk *clk)
> +{
> +}
>  #endif
>  
>  /* caller must hold prepare_lock */
> @@ -1790,9 +1812,42 @@ EXPORT_SYMBOL_GPL(clk_register);
>   * clk_unregister - unregister a currently registered clock
>   * @clk: clock to unregister
>   *
> - * Currently unimplemented.
>   */
> -void clk_unregister(struct clk *clk) {}
> +void clk_unregister(struct clk *clk)
> +{
> +       int i;
> +
> +       if (!clk)
> +               return;
> +
> +       mutex_lock(&prepare_lock);
> +       if (clk->prepare_count) {
> +               pr_debug("%s: can't unregister clk %s, it is prepared\n",
> +                               __func__, clk->name);
> +               goto out;
> +       }
> +
> +       if (!hlist_empty(&clk->children)) {
> +               pr_debug("%s: clk %s has registered children\n",
> +                               __func__, clk->name);
> +               goto out;
> +       }

We could migrate the children to the orphan list instead of leaving the
clock in place.  Maybe something like:

	struct clk *child;

	/* reparent all children to the orphan list */
	hlist_for_each_entry(child, &clk->children, child_node)
	        clk_set_parent(child, NULL);


What do you think?  Does this cause any issues in your module
load/unload testing?

Regards,
Mike

> +
> +       clk_debug_unregister(clk);
> +
> +       hlist_del_init(&clk->child_node);
> +
> +       kfree(clk->parents);
> +       i = clk->num_parents;
> +       while (--i >= 0)
> +               kfree(clk->parent_names[i]);
> +       kfree(clk->parent_names);
> +       kfree(clk->name);
> +       kfree(clk);
> +out:
> +       mutex_unlock(&prepare_lock);
> +       return;
> +}
>  EXPORT_SYMBOL_GPL(clk_unregister);
>  
>  static void devm_clk_release(struct device *dev, void *res)
> -- 
> 1.8.1.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
