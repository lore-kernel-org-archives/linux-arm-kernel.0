From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 17:49:16 -0700
Subject: [PATCH 2/4] clk: add clk_is_orphan() to check if a clocks inherits
 from an orphan clock
In-Reply-To: <1427988853-9549-3-git-send-email-heiko@sntech.de>
References: <1427988853-9549-1-git-send-email-heiko@sntech.de>
 <1427988853-9549-3-git-send-email-heiko@sntech.de>
Message-ID: <55286F8C.1030008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/15 08:34, Heiko Stuebner wrote:
> There are cases where it is helpful to know if the full clock path can be
> trusted or if there is a parent clock missing somewhere in the parent-path.
>
> We keep it confined to the ccf area for now, if later users outside the ccf
> surface it can be made more publically available.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/clk.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 512323f..476f491 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2271,6 +2271,44 @@ bool clk_is_match(const struct clk *p, const struct clk *q)
>  EXPORT_SYMBOL_GPL(clk_is_match);
>  
>  /**
> + * __clk_is_orphan - check if a clock or its parent is an orphan

@clk?

> + *
> + * Walks up the clock parents until it reaches a root-clock or
> + * a clock contained in the orphan list. Returns true if there is
> + * an orphan in the parent-path otherwise false.
> + */
> +static bool __clk_is_orphan(struct clk_core *clk)
> +{
> +	struct clk_core *orphan;
> +
> +	if (clk->flags & CLK_IS_ROOT)
> +		return false;
> +
> +	hlist_for_each_entry(orphan, &clk_orphan_list, child_node) {
> +		if (clk == orphan)
> +			return true;
> +	}

Nitpick: Please drop braces

> +
> +	if (clk->num_parents)
> +		return __clk_is_orphan(clk->parent);

This looks inefficient. Hopefully we're not calling this all the time?
Except we call it from clk_get().

Maybe it would make sense to mark the clock as orphaned or not. When we
regsiter the clock we can see if the parent is there and if so, check
the parent's flag to see if it's orphaned or not. If it isn't orphaned
everything is good, cheap lookup to figure it out and we don't set the
flag. If it is orphaned, again cheap lookup and we set the flag. When we
adopt the clock (deorphan?) we would have to go through the clock and
all it's children to clear the flag. The cost is paid once. Then this
function becomes a cheap flag check that we can do whenever we want.

> +
> +	return false;
> +}
> +
> +static bool clk_is_orphan(struct clk *clk)
> +{
> +	bool ret;
> +
> +	if (!clk)
> +		return false;
> +
> +	clk_prepare_lock();
> +	ret = __clk_is_orphan(clk->core);
> +	clk_prepare_unlock();

Unfortunately we still have to take some sort of lock here. If we had a
new lock, orphan_lock or something, then we could lock the adoption
phase and the flag setting of all clocks under that lock. When we go to
per-clock locks we could change that to use the lock for a particular clock.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
