From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 10 Apr 2013 16:51:15 -0700
Subject: [PATCH] clk: Properly handle notifier return values
In-Reply-To: <a2f153b2-9266-4ddc-94a9-3efbcbe9768c@CH1EHSMHS018.ehs.local>
References: <a2f153b2-9266-4ddc-94a9-3efbcbe9768c@CH1EHSMHS018.ehs.local>
Message-ID: <20130410235115.14528.14648@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Soren Brinkmann (2013-04-03 12:17:12)
> Notifiers may return NOTIFY_(OK|DONE|STOP|BAD). The CCF uses an
> inconsistent mix of checking against NOTIFY_STOP or NOTIFY_BAD.
> This inconsistency leaves errors undetected in some cases:
> clk_set_parent() calls __clk_speculate_rates(), which stops when it
> hits a NOTIFIER_BAD (STOP is ignored), and passes this value back to the
> caller.
> clk_set_parent() compares this return value against NOTIFY_STOP only,
> ignoring NOTIFY_BAD returns.
> 
> Use NOTIFY_STOP_MASK to detect a negative notifier return value and
> document all four return value options.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Taken into clk-next.

Thanks for the fix,
Mike

> ---
>  drivers/clk/clk.c   | 10 +++++-----
>  include/linux/clk.h |  8 ++++----
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ed87b24..68bd38c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -876,16 +876,16 @@ static int __clk_speculate_rates(struct clk *clk, unsigned long parent_rate)
>         else
>                 new_rate = parent_rate;
>  
> -       /* abort the rate change if a driver returns NOTIFY_BAD */
> +       /* abort rate change if a driver returns NOTIFY_BAD or NOTIFY_STOP */
>         if (clk->notifier_count)
>                 ret = __clk_notify(clk, PRE_RATE_CHANGE, clk->rate, new_rate);
>  
> -       if (ret == NOTIFY_BAD)
> +       if (ret & NOTIFY_STOP_MASK)
>                 goto out;
>  
>         hlist_for_each_entry(child, &clk->children, child_node) {
>                 ret = __clk_speculate_rates(child, new_rate);
> -               if (ret == NOTIFY_BAD)
> +               if (ret & NOTIFY_STOP_MASK)
>                         break;
>         }
>  
> @@ -978,7 +978,7 @@ static struct clk *clk_propagate_rate_change(struct clk *clk, unsigned long even
>  
>         if (clk->notifier_count) {
>                 ret = __clk_notify(clk, event, clk->rate, clk->new_rate);
> -               if (ret == NOTIFY_BAD)
> +               if (ret & NOTIFY_STOP_MASK)
>                         fail_clk = clk;
>         }
>  
> @@ -1296,7 +1296,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>                 ret = __clk_speculate_rates(clk, parent->rate);
>  
>         /* abort if a driver objects */
> -       if (ret == NOTIFY_STOP)
> +       if (ret & NOTIFY_STOP_MASK)
>                 goto out;
>  
>         /* only re-parent if the clock is not in use */
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index b3ac22d..9a6d045 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -28,16 +28,16 @@ struct clk;
>   * PRE_RATE_CHANGE - called immediately before the clk rate is changed,
>   *     to indicate that the rate change will proceed.  Drivers must
>   *     immediately terminate any operations that will be affected by the
> - *     rate change.  Callbacks may either return NOTIFY_DONE or
> - *     NOTIFY_STOP.
> + *     rate change.  Callbacks may either return NOTIFY_DONE, NOTIFY_OK,
> + *     NOTIFY_STOP or NOTIFY_BAD.
>   *
>   * ABORT_RATE_CHANGE: called if the rate change failed for some reason
>   *     after PRE_RATE_CHANGE.  In this case, all registered notifiers on
>   *     the clk will be called with ABORT_RATE_CHANGE. Callbacks must
> - *     always return NOTIFY_DONE.
> + *     always return NOTIFY_DONE or NOTIFY_OK.
>   *
>   * POST_RATE_CHANGE - called after the clk rate change has successfully
> - *     completed.  Callbacks must always return NOTIFY_DONE.
> + *     completed.  Callbacks must always return NOTIFY_DONE or NOTIFY_OK.
>   *
>   */
>  #define PRE_RATE_CHANGE                        BIT(0)
> -- 
> 1.8.2
