From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 5 Dec 2012 17:13:04 +0100
Subject: [PATCH 1/2] clk: introduce optional disable_unused callback
In-Reply-To: <1354654823-1576-2-git-send-email-mturquette@linaro.org>
References: <1354654823-1576-1-git-send-email-mturquette@linaro.org>
 <1354654823-1576-2-git-send-email-mturquette@linaro.org>
Message-ID: <CAPDyKFpGR++iN1JQ+ceUq+Qa216nrwLUdMDdB+Ei4VsLrnzKTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2012 22:00, Mike Turquette <mturquette@linaro.org> wrote:
> Some gate clocks have special needs which must be handled during the
> disable-unused clocks sequence.  These needs might be driven by software
> due to the fact that we're disabling a clock outside of the normal
> clk_disable path and a clk's enable_count will not be accurate.  On the
> other hand a specific hardware programming sequence might need to be
> followed for this corner case.
>
> This change is needed for the upcoming OMAP port to the common clock
> framework.  Specifically, it is undesirable to treat the disable-unused
> path identically to the normal clk_disable path since other software
> layers are involved.  In this case OMAP's clockdomain code throws WARNs
> and bails early due to the clock's enable_count being set to zero.  A
> custom callback mitigates this problem nicely.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
>  drivers/clk/clk.c            |   13 +++++++++++--
>  include/linux/clk-provider.h |    6 ++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9955ad7..251e45d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -219,8 +219,17 @@ static void clk_disable_unused_subtree(struct clk *clk)
>         if (clk->flags & CLK_IGNORE_UNUSED)
>                 goto unlock_out;
>
> -       if (__clk_is_enabled(clk) && clk->ops->disable)
> -               clk->ops->disable(clk->hw);
> +       /*
> +        * some gate clocks have special needs during the disable-unused
> +        * sequence.  call .disable_unused if available, otherwise fall
> +        * back to .disable
> +        */
> +       if (__clk_is_enabled(clk)) {
> +               if (clk->ops->disable_unused)
> +                       clk->ops->disable_unused(clk->hw);
> +               else if (clk->ops->disable)
> +                       clk->ops->disable(clk->hw);
> +       }
>
>  unlock_out:
>         spin_unlock_irqrestore(&enable_lock, flags);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 3593a3c..1c94d18 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -57,6 +57,11 @@ struct clk_hw;
>   *             This function must not sleep. Optional, if this op is not
>   *             set then the enable count will be used.
>   *
> + * @disable_unused: Disable the clock atomically.  Only called from
> + *             clk_disable_unused for gate clocks with special needs.
> + *             Called with enable_lock held.  This function must not
> + *             sleep.
> + *
>   * @recalc_rate        Recalculate the rate of this clock, by querying hardware. The
>   *             parent rate is an input parameter.  It is up to the caller to
>   *             ensure that the prepare_mutex is held across this call.
> @@ -106,6 +111,7 @@ struct clk_ops {
>         int             (*enable)(struct clk_hw *hw);
>         void            (*disable)(struct clk_hw *hw);
>         int             (*is_enabled)(struct clk_hw *hw);
> +       void            (*disable_unused)(struct clk_hw *hw);
>         unsigned long   (*recalc_rate)(struct clk_hw *hw,
>                                         unsigned long parent_rate);
>         long            (*round_rate)(struct clk_hw *hw, unsigned long,
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Is there a need for updating the clk documentation around this?

Anyway, you have my:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>


Kind regards
Ulf Hansson
