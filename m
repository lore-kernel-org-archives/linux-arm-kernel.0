From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 6 Dec 2012 22:58:56 +0100
Subject: [PATCH 1/2] clk: introduce optional disable_unused callback
In-Reply-To: <CACRpkdbRK6qpO74pU=fKL8Jz0_ENV_SJjvyFXEYKEpx802rnog@mail.gmail.com>
References: <1354654823-1576-1-git-send-email-mturquette@linaro.org>
 <1354654823-1576-2-git-send-email-mturquette@linaro.org>
 <CACRpkdbRK6qpO74pU=fKL8Jz0_ENV_SJjvyFXEYKEpx802rnog@mail.gmail.com>
Message-ID: <CAPDyKFqnRQFds0=aQ5RLhU5yohfOJrCM6UBOLmKbMaD-71RWSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2012 20:07, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 4, 2012 at 10:00 PM, Mike Turquette <mturquette@linaro.org> wrote:
>
>> Some gate clocks have special needs which must be handled during the
>> disable-unused clocks sequence.  These needs might be driven by software
>> due to the fact that we're disabling a clock outside of the normal
>> clk_disable path and a clk's enable_count will not be accurate.  On the
>> other hand a specific hardware programming sequence might need to be
>> followed for this corner case.
>>
>> This change is needed for the upcoming OMAP port to the common clock
>> framework.  Specifically, it is undesirable to treat the disable-unused
>> path identically to the normal clk_disable path since other software
>> layers are involved.  In this case OMAP's clockdomain code throws WARNs
>> and bails early due to the clock's enable_count being set to zero.  A
>> custom callback mitigates this problem nicely.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>
> This semantic change:
>
>> -       if (__clk_is_enabled(clk) && clk->ops->disable)
>> -               clk->ops->disable(clk->hw);
>> +       /*
>> +        * some gate clocks have special needs during the disable-unused
>> +        * sequence.  call .disable_unused if available, otherwise fall
>> +        * back to .disable
>> +        */
>> +       if (__clk_is_enabled(clk)) {
>> +               if (clk->ops->disable_unused)
>> +                       clk->ops->disable_unused(clk->hw);
>> +               else if (clk->ops->disable)
>> +                       clk->ops->disable(clk->hw);
>> +       }
>
> Means that you should probably go into all drivers and set their
> .disable_unused to point to the clk_disable() implentation. Something
> like the below (untested, Signed-off-by: Linus Walleij
> <linus.walleij@linaro.org>
>
> diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
> index a15f792..504abde 100644
> --- a/drivers/clk/clk-u300.c
> +++ b/drivers/clk/clk-u300.c
> @@ -340,6 +340,7 @@ static const struct clk_ops syscon_clk_ops = {
>         .unprepare = syscon_clk_unprepare,
>         .enable = syscon_clk_enable,
>         .disable = syscon_clk_disable,
> +       .disable_unused = syscon_clk_disable,
>         .is_enabled = syscon_clk_is_enabled,
>         .recalc_rate = syscon_clk_recalc_rate,
>         .round_rate = syscon_clk_round_rate,
> diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
> index 7eee7f7..1d3ff60 100644
> --- a/drivers/clk/ux500/clk-prcc.c
> +++ b/drivers/clk/ux500/clk-prcc.c
> @@ -84,12 +84,14 @@ static int clk_prcc_is_enabled(struct clk_hw *hw)
>  static struct clk_ops clk_prcc_pclk_ops = {
>         .enable = clk_prcc_pclk_enable,
>         .disable = clk_prcc_pclk_disable,
> +       .disable_unused = clk_prcc_pclk_disable,
>         .is_enabled = clk_prcc_is_enabled,
>  };
>
>  static struct clk_ops clk_prcc_kclk_ops = {
>         .enable = clk_prcc_kclk_enable,
>         .disable = clk_prcc_kclk_disable,
> +       .disable_unused = clk_prcc_kclk_disable,
>         .is_enabled = clk_prcc_is_enabled,
>  };
>
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
> index 74faa7e..00498f2 100644
> --- a/drivers/clk/ux500/clk-prcmu.c
> +++ b/drivers/clk/ux500/clk-prcmu.c
> @@ -172,6 +172,7 @@ static struct clk_ops clk_prcmu_scalable_ops = {
>         .unprepare = clk_prcmu_unprepare,
>         .enable = clk_prcmu_enable,
>         .disable = clk_prcmu_disable,
> +       .disable_unused = clk_prcmu_disable,
>         .is_enabled = clk_prcmu_is_enabled,
>         .recalc_rate = clk_prcmu_recalc_rate,
>         .round_rate = clk_prcmu_round_rate,
> @@ -183,6 +184,7 @@ static struct clk_ops clk_prcmu_gate_ops = {
>         .unprepare = clk_prcmu_unprepare,
>         .enable = clk_prcmu_enable,
>         .disable = clk_prcmu_disable,
> +       .disable_unused = clk_prcmu_disable,
>         .is_enabled = clk_prcmu_is_enabled,
>         .recalc_rate = clk_prcmu_recalc_rate,
>  };
> @@ -204,6 +206,7 @@ static struct clk_ops clk_prcmu_opp_gate_ops = {
>         .unprepare = clk_prcmu_opp_unprepare,
>         .enable = clk_prcmu_enable,
>         .disable = clk_prcmu_disable,
> +       .disable_unused = clk_prcmu_disable,
>         .is_enabled = clk_prcmu_is_enabled,
>         .recalc_rate = clk_prcmu_recalc_rate,
>  };
> @@ -213,6 +216,7 @@ static struct clk_ops clk_prcmu_opp_volt_scalable_ops = {
>         .unprepare = clk_prcmu_opp_volt_unprepare,
>         .enable = clk_prcmu_enable,
>         .disable = clk_prcmu_disable,
> +       .disable_unused = clk_prcmu_disable,
>         .is_enabled = clk_prcmu_is_enabled,
>         .recalc_rate = clk_prcmu_recalc_rate,
>         .round_rate = clk_prcmu_round_rate,
>
>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I am not sure such change is needed. It kind of depends on what Mike
decides to put in the clk documentation. :-)

According to commit msg, it seems like the .disable_unused function
will be optional and must only be implemented for those clks that has
has special issues to consider.

Kind regards
Ulf Hansson
