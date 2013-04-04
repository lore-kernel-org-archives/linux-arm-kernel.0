From: rajagopal.venkat@linaro.org (Rajagopal Venkat)
Date: Thu, 4 Apr 2013 16:05:38 +0530
Subject: [PATCH V4 3/3] clk: Fixup locking issues for clk_set_parent
In-Reply-To: <1364936979-20805-4-git-send-email-ulf.hansson@stericsson.com>
References: <1364936979-20805-1-git-send-email-ulf.hansson@stericsson.com>
 <1364936979-20805-4-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CA+Z25wWi7S1fcTmhs=63sOVbzjN9q8rtNJF67eNCLT70YZpPFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2013 02:39, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Updating the clock tree topology must be protected with the spinlock
> when doing clk_set_parent, otherwise we can not handle the migration
> of the enable_count in a safe manner.

Why is not safe to update tree topology with no spinlock?

>
> While issuing the .set_parent callback to make the clk-hw perform the
> switch to the new parent, we can not hold the spinlock since it is must
> be allowed to be slow path. This complicates error handling, but is still
> possible to achieve.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
> ---
>  drivers/clk/clk.c |   67 +++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c83e8e5..de6b459 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1363,31 +1363,71 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent, u8 p_index)
>         unsigned long flags;
>         int ret = 0;
>         struct clk *old_parent = clk->parent;
> +       bool migrated_enable = false;
>
> -       /* migrate prepare and enable */
> +       /* migrate prepare */
>         if (clk->prepare_count)
>                 __clk_prepare(parent);
>
> -       /* FIXME replace with clk_is_enabled(clk) someday */
>         flags = clk_enable_lock();
> -       if (clk->enable_count)
> +
> +       /* migrate enable */
> +       if (clk->enable_count) {
>                 __clk_enable(parent);
> +               migrated_enable = true;
> +       }
> +
> +       /* update the clk tree topology */
> +       clk_reparent(clk, parent);
> +
>         clk_enable_unlock(flags);
>
>         /* change clock input source */
>         if (parent && clk->ops->set_parent)
>                 ret = clk->ops->set_parent(clk->hw, p_index);
>
> -       /* clean up old prepare and enable */
> -       flags = clk_enable_lock();
> -       if (clk->enable_count)
> +       if (ret) {
> +               /*
> +                * The error handling is tricky due to that we need to release
> +                * the spinlock while issuing the .set_parent callback. This
> +                * means the new parent might have been enabled/disabled in

But then new parent is reference counted with  __clk_enable(parent)
isn't it? Even if other children are disabling newparent, it is still
alive. Am I missing anything here?

> +                * between, which must be considered when doing rollback.
> +                */
> +               flags = clk_enable_lock();
> +
> +               clk_reparent(clk, old_parent);
> +
> +               if (migrated_enable && clk->enable_count) {
> +                       __clk_disable(parent);
> +               } else if (migrated_enable && (clk->enable_count == 0)) {

Will this condition happen at all? the reference counting should
prevent this AFAICT. Can this error path be simplified?

> +                       __clk_disable(old_parent);
> +               } else if (!migrated_enable && clk->enable_count) {
> +                       __clk_disable(parent);
> +                       __clk_enable(old_parent);
> +               }
> +
> +               clk_enable_unlock(flags);
> +
> +               if (clk->prepare_count)
> +                       __clk_unprepare(parent);
> +
> +               return ret;
> +       }
> +
> +       /* clean up enable for old parent if migration was done */
> +       if (migrated_enable) {

Reaching here, the old_parent should be disabled in any case. Is this
'if (migrated_enable)' check required?

> +               flags = clk_enable_lock();
>                 __clk_disable(old_parent);
> -       clk_enable_unlock(flags);
> +               clk_enable_unlock(flags);
> +       }
>
> +       /* clean up prepare for old parent if migration was done */
>         if (clk->prepare_count)
>                 __clk_unprepare(old_parent);
>
> -       return ret;
> +       /* update debugfs with new clk tree topology */
> +       clk_debug_reparent(clk, parent);
> +       return 0;
>  }
>
>  /**
> @@ -1450,14 +1490,11 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>         /* do the re-parent */
>         ret = __clk_set_parent(clk, parent, p_index);
>
> -       /* propagate ABORT_RATE_CHANGE if .set_parent failed */
> -       if (ret) {
> +       /* propagate rate recalculation accordingly */
> +       if (ret)
>                 __clk_recalc_rates(clk, ABORT_RATE_CHANGE);
> -               goto out;
> -       }
> -
> -       /* propagate rate recalculation downstream */
> -       __clk_reparent(clk, parent);
> +       else
> +               __clk_recalc_rates(clk, POST_RATE_CHANGE);
>
>  out:
>         clk_prepare_unlock();
> --
> 1.7.10
>



-- 
Regards,
Rajagopal
