From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 27 Sep 2014 19:41:31 -0700
Subject: [PATCH v2 4/4] clk: Use ww_mutexes for clk_prepare_{lock/unlock}
In-Reply-To: <1409792466-5092-5-git-send-email-sboyd@codeaurora.org>
References: <1409792466-5092-1-git-send-email-sboyd@codeaurora.org>
 <1409792466-5092-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140928024131.19023.40641@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-09-03 18:01:06)
> @@ -1069,11 +1305,24 @@ static void __clk_recalc_accuracies(struct clk *clk)
>   */
>  long clk_get_accuracy(struct clk *clk)
>  {
> +       struct ww_acquire_ctx ctx;
> +       LIST_HEAD(list);
>         unsigned long accuracy;
>  
> -       clk_prepare_lock();
> +       if (clk && !(clk->flags & CLK_GET_ACCURACY_NOCACHE)) {
> +               ww_mutex_lock(&clk->lock, NULL);
> +       } else {
> +               ww_acquire_init(&ctx, &prepare_ww_class);
> +               clk_lock_subtree(clk, &list, &ctx);
> +               ww_acquire_done(&ctx);
> +       }

It looks a little weird to access clk->flags outside of the lock, but
flags is immutable after registration-time, so I guess it is OK. Let me
know if I'm wrong.

> +
>         accuracy = __clk_get_accuracy(clk);
> -       clk_prepare_unlock();
> +
> +       if (clk && !(clk->flags & CLK_GET_ACCURACY_NOCACHE))
> +               ww_mutex_unlock(&clk->lock);
> +       else
> +               clk_unlock(&list, &ctx);
>  
>         return accuracy;
>  }
> @@ -1134,11 +1383,24 @@ static void __clk_recalc_rates(struct clk *clk, unsigned long msg)
>   */
>  unsigned long clk_get_rate(struct clk *clk)
>  {
> +       struct ww_acquire_ctx ctx;
> +       LIST_HEAD(list);
>         unsigned long rate;
>  
> -       clk_prepare_lock();
> +       if (clk && !(clk->flags & CLK_GET_RATE_NOCACHE)) {
> +               ww_mutex_lock(&clk->lock, NULL);
> +       } else {
> +               ww_acquire_init(&ctx, &prepare_ww_class);
> +               clk_lock_subtree(clk, &list, &ctx);
> +               ww_acquire_done(&ctx);
> +       }

Ditto.

> +
>         rate = __clk_get_rate(clk);
> -       clk_prepare_unlock();
> +
> +       if (clk && !(clk->flags & CLK_GET_RATE_NOCACHE))
> +               ww_mutex_unlock(&clk->lock);
> +       else
> +               clk_unlock(&list, &ctx);
>  
>         return rate;
>  }
> @@ -1317,9 +1579,11 @@ out:
>         return ret;
>  }
>  
> -static void clk_calc_subtree(struct clk *clk, unsigned long new_rate,
> -                            struct clk *new_parent, u8 p_index)
> +static int clk_calc_subtree(struct clk *clk, unsigned long new_rate,
> +                            struct clk *new_parent, u8 p_index,
> +                            struct list_head *list, struct ww_acquire_ctx *ctx)
>  {
> +       int ret;
>         struct clk *child;
>  
>         clk->new_rate = new_rate;
> @@ -1331,27 +1595,43 @@ static void clk_calc_subtree(struct clk *clk, unsigned long new_rate,
>                 new_parent->new_child = clk;
>  
>         hlist_for_each_entry(child, &clk->children, child_node) {
> +               ret = clk_lock_one(child, list, ctx);
> +               if (ret == -EDEADLK)
> +                       return ret;

Why bother with any locking here at all? Why not call clk_lock_subtree
from clk_calc_new_rates? I guess you avoid an extra tree walk?

> +
>                 child->new_rate = clk_recalc(child, new_rate);
> -               clk_calc_subtree(child, child->new_rate, NULL, 0);
> +               ret = clk_calc_subtree(child, child->new_rate, NULL, 0, list,
> +                                       ctx);
> +               if (ret)
> +                       return ret;
>         }
> +
> +       return 0;
>  }
>  
>  /*
>   * calculate the new rates returning the topmost clock that has to be
>   * changed.
>   */
> -static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
> +static struct clk *
> +clk_calc_new_rates(struct clk *clk, unsigned long rate, struct list_head *list,
> +                  struct ww_acquire_ctx *ctx)
>  {
>         struct clk *top = clk;
>         struct clk *old_parent, *parent;
>         unsigned long best_parent_rate = 0;
>         unsigned long new_rate;
>         int p_index = 0;
> +       int ret;
>  
>         /* sanity */
>         if (IS_ERR_OR_NULL(clk))
>                 return NULL;
>  
> +       ret = clk_lock_one(clk, list, ctx);
> +       if (ret == -EDEADLK)
> +               return ERR_PTR(ret);

It seems to me that we should call clk_parent_lock here instead, since
we access the parent's rate. I know that any concurrent access to the
parent which would change its rate would fail, since we can't lock the
subtree (including *this* lock). But it still seems more correct to lock
the parent to me. Let me know what you think.

It might also help the collision case fail faster since you will fail
trying to grab the parent lock instead of grabbing the parent lock, then
failing to lock the subtree.

Though in all honestly, I haven't finished thinking it through. The
wait/wound algorithm opens up a lot of possibilities around very
aggressive locking strategies to prevent contention. For example if we
call clk_parent_lock it will lock the subtree starting from the parent,
thus holding potentially a LOT more child locks, which only need to be
updated during the recalc rate phase.  We could avoid holding those
children until the moment that we need to lock them... I'll think about
it some more.

Oh wait, no we couldn't. We have to take all of our locks up front via
ww_acquire_done(), which happens below.

> +
>         /* save parent rate, if it exists */
>         parent = old_parent = clk->parent;
>         if (parent)

The context cuts it off, but the next line down accesses parent->rate.
Again I think this happens without first having locked parent?

> @@ -1371,7 +1651,7 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>                 return NULL;
>         } else {
>                 /* pass-through clock with adjustable parent */
> -               top = clk_calc_new_rates(parent, rate);
> +               top = clk_calc_new_rates(parent, rate, list, ctx);
>                 new_rate = parent->new_rate;
>                 goto out;
>         }
> @@ -1394,16 +1674,84 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>                 }
>         }
>  
> +       /* Lock old and new parent if we're doing a parent switch */
> +       if (parent != old_parent) {
> +               /*
> +                * Lock any ancestor clocks that will be prepared/unprepared if
> +                * this clock is enabled
> +                */
> +               if (clk->prepare_count) {
> +                       ret = __clk_unprepare_lock(old_parent, list, ctx);
> +                       if (ret == -EDEADLK)
> +                               return ERR_PTR(ret);
> +                       ret = __clk_prepare_lock(parent, list, ctx);
> +                       if (ret == -EDEADLK)
> +                               return ERR_PTR(ret);
> +               } else {
> +                       ret = clk_lock_one(old_parent, list, ctx);
> +                       if (ret == -EDEADLK)
> +                               return ERR_PTR(ret);
> +                       ret = clk_lock_one(parent, list, ctx);
> +                       if (ret == -EDEADLK)
> +                               return ERR_PTR(ret);
> +               }
> +       }
> +
>         if ((clk->flags & CLK_SET_RATE_PARENT) && parent &&
>             best_parent_rate != parent->rate)
> -               top = clk_calc_new_rates(parent, best_parent_rate);
> +               top = clk_calc_new_rates(parent, best_parent_rate, list, ctx);
>  
>  out:
> -       clk_calc_subtree(clk, new_rate, parent, p_index);
> +       if (!IS_ERR(top)) {
> +               ret = clk_calc_subtree(clk, new_rate, parent, p_index, list,
> +                                       ctx);
> +               if (ret)
> +                       top = ERR_PTR(ret);
> +       }
>  
>         return top;
>  }
>  
> +static struct clk *clk_set_rate_lock(struct clk *clk, unsigned long rate,
> +                                    struct list_head *list,
> +                                    struct ww_acquire_ctx *ctx)
> +{
> +       int ret;
> +       struct clk *top;
> +
> +       ww_acquire_init(ctx, &prepare_ww_class);
> +retry:
> +       ret = clk_lock_one(clk, list, ctx);
> +       if (ret == -EDEADLK)
> +               goto retry;
> +
> +       if ((clk->flags & CLK_SET_RATE_GATE) && clk->prepare_count) {
> +               ret = -EBUSY;
> +               goto err;
> +       }
> +
> +       top = clk_calc_new_rates(clk, rate, list, ctx);
> +       if (!top) {
> +               ret = -EINVAL;
> +               goto err;
> +       }
> +       if (IS_ERR(top)) {
> +               if (PTR_ERR(top) == -EDEADLK) {
> +                       goto retry;
> +               } else {
> +                       ret = -EINVAL;
> +                       goto err;
> +               }
> +       }
> +       ww_acquire_done(ctx);

ww_acquire_done() happens here. OK. Neverrmind, just thinking through
out loud.  This looks good.

Let me know what you think about the questions above. I've also Cc'd
Colin Cross who has experimented with per-clock locking before as well.
He may or may not have an interest in this now.

Regards,
Mike
