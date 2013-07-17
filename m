From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 17 Jul 2013 13:28:30 +0200
Subject: [PATCH v3] clk: implement clk_unregister
In-Reply-To: <1370248626-3760-1-git-send-email-jiada_wang@mentor.com>
References: <1370248626-3760-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <51E67FDE.7000301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 06/03/2013 10:37 AM, Jiada Wang wrote:
> Currently clk_unregister is unimplemented, it is required in case
> sub modules want actually remove clk device registered by clk_register.
> This patch adds the implementation of clk_unregister.
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
>  	return ret;
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
> +	if (!clk || !clk->dentry)
> +		return;
> +
> +	debugfs_remove_recursive(clk->dentry);
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
> +	int i;
> +
> +	if (!clk)
> +		return;
> +
> +	mutex_lock(&prepare_lock);
> +	if (clk->prepare_count) {
> +		pr_debug("%s: can't unregister clk %s, it is prepared\n",
> +				__func__, clk->name);
> +		goto out;
> +	}
> +
> +	if (!hlist_empty(&clk->children)) {
> +		pr_debug("%s: clk %s has registered children\n",
> +				__func__, clk->name);
> +		goto out;

How about moving the clock to the orphan list instead, as Mike
suggested [1] ?

> +	}
> +
> +	clk_debug_unregister(clk);
> +
> +	hlist_del_init(&clk->child_node);
> +
> +	kfree(clk->parents);
> +	i = clk->num_parents;
> +	while (--i >= 0)
> +		kfree(clk->parent_names[i]);
> +	kfree(clk->parent_names);
> +	kfree(clk->name);
> +	kfree(clk);
> +out:
> +	mutex_unlock(&prepare_lock);
> +	return;

Redundant return statement.

> +}

Shouldn't we also free the clock supplier specific data structure
for the clock, i.e. the structure struct clk_hw is embedded in ?

One possible way to solve this could be to provide, e.g. destroy()
operation in struct clk_ops ? Alternatively clock providers would
need to store a list of their clock specific data structures
associated with each struct clk they have registered.

[1] http://www.spinics.net/lists/arm-kernel/msg250613.html


Thanks,
Sylwester
