From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 06 Sep 2013 14:17:08 -0700
Subject: [PATCH] clk: only call get_parent if there is one
In-Reply-To: <52288824.1060905@linaro.org>
References: <52288824.1060905@linaro.org>
Message-ID: <20130906211708.10934.58897@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alex Elder (2013-09-05 06:33:24)
> In __clk_init(), after a clock is mostly initialized, a scan is done
> of the orphan clocks to see if the clock being registered is the
> parent of any of them.
> 
> This code assumes that any clock that provides a get_parent method
> actually has at least one parent, and that's not a valid assumption.
> 
> As a result, an orphan clock with no parent can return *something*
> as the parent index, and that value is blindly used to dereference
> the orphan's parent_names[] array (which will be ZERO_SIZE_PTR or
> NULL).
> 
> Fix this by ensuring get_parent is only called for orphans with at
> least one parent.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Thanks for the fix Alex. I'll take this in towards 3.13.

Regards,
Mike

> ---
>  drivers/clk/clk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 54a191c..ea8ff15 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1628,7 +1628,7 @@ int __clk_init(struct device *dev, struct clk *clk)
>          * this clock
>          */
>         hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
> -               if (orphan->ops->get_parent) {
> +               if (orphan->num_parents && orphan->ops->get_parent) {
>                         i = orphan->ops->get_parent(orphan->hw);
>                         if (!strcmp(clk->name, orphan->parent_names[i]))
>                                 __clk_reparent(orphan, clk);
> -- 
> 1.7.9.5
