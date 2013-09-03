From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 03 Sep 2013 23:47:23 +0200
Subject: [RFC Patch v2 1/3] clk: add support for temporary parent clock
 migration
In-Reply-To: <1378208072-10173-2-git-send-email-chander.kashyap@linaro.org>
References: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
 <1378208072-10173-2-git-send-email-chander.kashyap@linaro.org>
Message-ID: <522658EB.3090408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

On 09/03/2013 01:34 PM, Chander Kashyap wrote:
> Some platforms use to migrate temporarily to another parent during cpu frequency
> scaling, e.g. Exynos and Tegra. Once the frequency is changed the latch on to
> original parent.
>
> The generic cpufreq-cpu0 driver use clk_set_rate API to scale cpu frequency.
> This patch is an attempt to address the above mentioned requirement.
>
> This is achieved as follows:
>
> Add a clk flag "CLK_SET_RATE_TEMP_PARENT" for clocks which need to migrate to
> another parent during set_rate operation on them.
>
> Add "temp_parent_name" and "tmp_parent" fields to clk structure i.e the name of
> temp_parent_clock and reference to temp_parent_clock.
>
> Hence in clk_set_rate API check for the "CLK_SET_RATE_TEMP_PARENT" flag, then
> latch on to alternate parent clock temporarily. Once the requested rate is set
> on the clk, re-parent back to original parent clock.
>
> Signed-off-by: Chander Kashyap<chander.kashyap@linaro.org>
> ---
>   drivers/clk/clk-mux.c        |   13 +++++++------
>   drivers/clk/clk.c            |   43 ++++++++++++++++++++++++++++++++++++++++--
>   include/linux/clk-private.h  |   19 +++++++++++--------
>   include/linux/clk-provider.h |   10 ++++++----
>   4 files changed, 65 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 4f96ff3..854b3ac 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -115,8 +115,8 @@ EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
>
>   struct clk *clk_register_mux_table(struct device *dev, const char *name,
>   		const char **parent_names, u8 num_parents, unsigned long flags,
> -		void __iomem *reg, u8 shift, u32 mask,
> -		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
> +		const char *temp_parent_name, void __iomem *reg, u8 shift,
> +		u32 mask, u8 clk_mux_flags, u32 *table, spinlock_t *lock)

I'm not sure this is a good idea to split the changes like this. Applying
this patch alone would cause a build break, wouldn't it ?

The users need to be updated in same patch, so patch 2/3 should be normally
folded into this one.

[...]
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2db08c0..0e29a5b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1425,8 +1425,8 @@ static void clk_change_rate(struct clk *clk)
>    */
>   int clk_set_rate(struct clk *clk, unsigned long rate)
>   {
> -	struct clk *top, *fail_clk;
> -	int ret = 0;
> +	struct clk *top, *fail_clk, *parent = NULL;
> +	int ret = 0, index;
>
>   	if (!clk)
>   		return 0;
> @@ -1450,6 +1450,35 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>   		goto out;
>   	}
>
> +	/* Latch on to alternate parent temporarily if needed */
> +	if ((clk->flags&  CLK_SET_RATE_TEMP_PARENT)&&  clk->temp_parent_name) {
> +		/* Save current parent before latching on to alternate parent */
> +		parent = clk->parent;
> +
> +		if (!clk->temp_parent) {
> +			for (index = 0; index<  clk->num_parents; index++) {
> +				if (!strcmp(clk->parent_names[index],
> +						clk->temp_parent_name))
> +					clk->temp_parent =
> +					__clk_lookup(clk->temp_parent_name);
> +			}
> +
> +			if (!clk->temp_parent) {
> +				pr_warn("%s: wrong temp_parent_name %s",
> +					__func__, clk->temp_parent_name);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +
> +		ret = clk_set_parent(clk, clk->temp_parent);
> +		if (ret) {
> +			pr_warn("%s: failed to set %s parent\n",
> +				__func__, clk->temp_parent->name);
> +			goto out;
> +		}
> +	}
> +
>   	/* notify that we are about to change rates */
>   	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>   	if (fail_clk) {
> @@ -1464,6 +1493,14 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>   	clk_change_rate(top);
>
>   out:
> +	/* Reparent back to original parent */
> +	if (parent) {
> +		ret = clk_set_parent(clk, parent);
> +		if (ret)
> +			pr_warn("%s: failed to set %s parent\n",
> +					__func__, parent->name);
> +	}
> +
>   	clk_prepare_unlock();
>
>   	return ret;
[...]
> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
> index 8138c94..b70ba4d 100644
> --- a/include/linux/clk-private.h
> +++ b/include/linux/clk-private.h
> @@ -47,6 +47,8 @@ struct clk {
>   #ifdef CONFIG_COMMON_CLK_DEBUG
>   	struct dentry		*dentry;
>   #endif
> +	const char		*temp_parent_name;
> +	struct clk		*temp_parent;

Shouldn't such data rather be on struct clk_mux level ? It's only needed
for _some_ mux clocks, while it's being added for all the clock types.

Or wouldn't just a single "u8 temp_parent_index" field do ? The order of
struct clk::parents and struct clk::parent_names is always same, isn't it ?
Then if, e.g.

parent_names[] = "clk_a", "clk_b", "clk_c";

and "clk_c" is the temporary parent clock name, the corresponding clock
pointer storage is clk->parents[2] ? It could be used instead of
clk->temp_parent, couldn't it ?

--
Regards,
Sylwester
