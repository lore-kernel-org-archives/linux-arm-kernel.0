From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 03 Sep 2014 16:39:37 -0700
Subject: [PATCH v9 5/6] clk: Add floor and ceiling constraints to clock
 rates
In-Reply-To: <1409758434-20810-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1409758148-20104-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409758434-20810-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409758434-20810-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5407A6B9.1080606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/14 08:33, Tomeu Vizoso wrote:
> Adds a way for clock consumers to set maximum and minimum rates. This can be
> used for thermal drivers to set ceiling rates, or by misc. drivers to set
> floor rates to assure a minimum performance level.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
> ---
>
> v9: * Apply first all the floor constraints, then the ceiling constraints.
>     * WARN on ceiling constraints below the current floor, for a given user clk
>
> v5: * Move the storage of constraints to the per-user clk struct, as suggested
>       by Stephen Warren.
> ---
>  drivers/clk/clk.c           | 43 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk.h           |  1 +
>  drivers/clk/clkdev.c        |  2 +-
>  include/linux/clk-private.h |  5 +++++
>  include/linux/clk.h         | 18 ++++++++++++++++++
>  5 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 61a3492..3a961c6 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -560,6 +560,8 @@ struct clk *__clk_create_clk(struct clk_core *clk_core, const char *dev,
>  	clk->dev_id = dev;
>  	clk->con_id = con;
>  
> +	hlist_add_head(&clk->child_node, &clk_core->per_user_clks);
> +

How is this safe with another thread that may be traversing the list? Or
even two threads calling clk_get_parent() at the same time?

>  	return clk;
>  }
>  
> @@ -1625,6 +1627,7 @@ static void clk_change_rate(struct clk_core *clk)
>  int clk_provider_set_rate(struct clk_core *clk, unsigned long rate)
>  {
>  	struct clk_core *top, *fail_clk;
> +	struct clk *clk_user;
>  	int ret = 0;
>  
>  	if (!clk)
> @@ -1633,6 +1636,15 @@ int clk_provider_set_rate(struct clk_core *clk, unsigned long rate)
>  	/* prevent racing with updates to the clock topology */
>  	clk_prepare_lock();
>  
> +	hlist_for_each_entry(clk_user, &clk->per_user_clks, child_node) {
> +		rate = max(rate, clk_user->floor_constraint);
> +	}
> +
> +	hlist_for_each_entry(clk_user, &clk->per_user_clks, child_node) {
> +		if (clk_user->ceiling_constraint > 0)
> +			rate = min(rate, clk_user->ceiling_constraint);
> +	}
> +
>  	/* bail early if nothing to do */
>  	if (rate == clk_provider_get_rate(clk))
>  		goto out;
> @@ -1699,6 +1711,29 @@ int clk_set_rate(struct clk *clk_user, unsigned long rate)
>  }
>  EXPORT_SYMBOL_GPL(clk_set_rate);
>  
> +int clk_set_floor_rate(struct clk *clk_user, unsigned long rate)
> +{
> +	struct clk_core *clk = clk_to_clk_core(clk_user);
> +
> +	clk_user->floor_constraint = rate;
> +	return clk_provider_set_rate(clk, clk_provider_get_rate(clk));

It would be nice if this was also locked around so that the
floor_constraint or ceiling_constraint doesn't change while another
thread is iterating the list. I guess we'll get by though because
eventually things will settle and either this thread here will set the
"final" rate, or the other thread in clk_provider_set_rate() will have
already set the final rate. It just seems wrong to not hold the lock
while updating what is supposed to be protected by the prepare lock.

> +}
> +EXPORT_SYMBOL_GPL(clk_set_floor_rate);
> +
> +int clk_set_ceiling_rate(struct clk *clk_user, unsigned long rate)
> +{
> +	struct clk_core *clk = clk_to_clk_core(clk_user);
> +
> +	WARN(rate > 0 && rate < clk_user->floor_constraint,
> +	     "clk %s dev %s con %s: new ceiling %lu lower than existing floor %lu\n",
> +	     __clk_get_name(clk), clk_user->dev_id, clk_user->con_id, rate,
> +	     clk_user->floor_constraint);
> +
> +	clk_user->ceiling_constraint = rate;
> +	return clk_provider_set_rate(clk, clk_provider_get_rate(clk));
> +}
> +EXPORT_SYMBOL_GPL(clk_set_ceiling_rate);

Maybe I'm late to this patch series given that Mike applied it, but I
wonder why we wouldn't just have one API that takes a min and a max,
i.e. clk_set_rate_range(clk, min, max)? Then clk_set_rate() is a small
wrapper on top that just sets min and max to the same value.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
