From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 May 2013 00:18:09 -0700
Subject: [Patch 3/3] clk: Avoid re-parenting orphan clk's having invalid
 parent index.
In-Reply-To: <1367475929-32166-4-git-send-email-ambresh@ti.com>
References: <1367475929-32166-1-git-send-email-ambresh@ti.com>
 <1367475929-32166-4-git-send-email-ambresh@ti.com>
Message-ID: <20130529071809.6058.24017@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ambresh K (2013-05-01 23:25:29)
> From: Ambresh K <ambresh@ti.com>
> 
> Add orhan clk nodes having invalid parent index to list and use
> the list to skip re-parenting orphan clk having invalid parents.
> 
> Signed-off-by: Ambresh K <ambresh@ti.com>
> ---
>  drivers/clk/clk.c |   21 +++++++++++++++++++--
>  1 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f4d2c73..54d2aa3 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -32,6 +32,7 @@ static int enable_refcnt;
>  
>  static HLIST_HEAD(clk_root_list);
>  static HLIST_HEAD(clk_orphan_list);
> +static HLIST_HEAD(clk_orphan_invalid_parent);

Why not re-use the clk_orphan_list?  Having an invalid value programmed
into the hardware for selecting a parent essetially orphans a clock
from a software point of view.  Is there a specific need for the new
list?

Regards,
Mike

>  static LIST_HEAD(clk_notifier_list);
>  
>  /***           locking             ***/
> @@ -1532,8 +1533,8 @@ EXPORT_SYMBOL_GPL(clk_set_parent);
>   */
>  int __clk_init(struct device *dev, struct clk *clk)
>  {
> -       int i, ret = 0;
> -       struct clk *orphan;
> +       int i, ret = 0, skip = 0;
> +       struct clk *orphan, *has_invalid_parent;
>         struct hlist_node *tmp2;
>  
>         if (!clk)
> @@ -1639,11 +1640,27 @@ int __clk_init(struct device *dev, struct clk *clk)
>                 if (!strcmp(clk->name, orphan->name))
>                         continue;
>  
> +               /* Skip iteration if orphan has invalid parent */
> +               hlist_for_each_entry(has_invalid_parent,
> +                               &clk_orphan_invalid_parent, child_node) {
> +                       if (!strcmp(orphan->name, has_invalid_parent->name)) {
> +                               skip = 1;
> +                               break;
> +                       }
> +               }
> +
> +               if (skip) {
> +                       skip = 0;
> +                       continue;
> +               }
> +
>                 if (orphan->ops->get_parent) {
>                         i = orphan->ops->get_parent(orphan->hw);
>                         if (i < 0) {
>                                 pr_err("%s: orphan clk(%s) invalid parent\n",
>                                                 __func__, orphan->name);
> +                               hlist_add_head(&orphan->child_node,
> +                                               &clk_orphan_invalid_parent);
>                                 continue;
>                         }
>                         if (!strcmp(clk->name, orphan->parent_names[i]))
> -- 
> 1.7.4.1
