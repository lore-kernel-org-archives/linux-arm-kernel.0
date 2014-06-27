From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 16:57:42 -0600
Subject: [RFC 5/5] clk: Add floor and ceiling constraints to clock rates
In-Reply-To: <1403855872-14749-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
 <1403855872-14749-6-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <53ADF6E6.6090705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 01:57 AM, Tomeu Vizoso wrote:
> Adds a way for clock consumers to set maximum and minimum rates. This can be
> used for thermal drivers to set ceiling rates, or by misc. drivers to set
> floor rates to assure a minimum performance level.

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c

> +static struct rate_constraint *__ensure_constraint(struct clk *clk_user,
> +						   enum constraint_type type)

> +	if (!found) {
> +		constraint = kzalloc(sizeof(*constraint), GFP_KERNEL);
> +		if (!constraint) {
> +			pr_err("%s: could not allocate constraint\n", __func__);

Doesn't kzalloc print an error itself if the allocation fails? I've
certainly seen quite a few patches ripping out custom "allocation
failed" errors in code.

> +void __clk_free_clk(struct clk *clk_user)
> +{
> +	struct clk_core *clk = clk_to_clk_core(clk_user);
> +	struct rate_constraint *constraint;
> +	struct hlist_node *tmp;
> +
> +	hlist_for_each_entry_safe(constraint, tmp, &clk->rate_constraints, node) {
> +		if (constraint->dev_id == clk_user->dev_id &&
> +		    constraint->con_id == clk_user->con_id) {
> +			hlist_del(&constraint->node);
> +			kfree(constraint);

Perhaps the list of constraints should be indexed by the client clk
structure, so that test should be:

if (constraint->clk_user == clk_user)

It might be a bit more work, but perhaps the constraints should simply
be stored directly in the struct clk rater than the struct clk_core.
That would require a nested loop to apply constraints though; first over
each struct clk associated with a struct clk_core, then over each
constraints in that struct clk. It would slightly simplify
adding/removing constraints though, and store the constraints at their
"source".

> diff --git a/include/linux/clk.h b/include/linux/clk.h

> +int clk_set_floor_rate(struct clk *clk, unsigned long rate);

> +int clk_set_ceiling_rate(struct clk *clk, unsigned long rate);

Additions functions to explicitly remove any previously requested
floor/ceiling rate might be useful. The same effect could be achieved by
a floor of 0 or a very high ceiling, but it feels cleaner to remove them.

Overall, this series seems to implement the right kind of concept to me.
It'll certainly stop us (NVIDIA at least) wanting to create all kinds of
"virtual" clock objects (and associated clock IDs and device tree clock
IDs) to achieve a similar effect.
