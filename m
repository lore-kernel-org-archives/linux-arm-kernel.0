From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 30 May 2014 16:37:02 -0700
Subject: [PATCH v4 3/7] clk: kona: don't init clocks at startup time
In-Reply-To: <1401483188-5395-4-git-send-email-elder@linaro.org>
References: <1401483188-5395-1-git-send-email-elder@linaro.org>
 <1401483188-5395-4-git-send-email-elder@linaro.org>
Message-ID: <20140530233702.10062.60452@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alex Elder (2014-05-30 13:53:04)
> +static int kona_clk_prepare(struct clk_hw *hw)
>  {
> +       struct kona_clk *bcm_clk = to_kona_clk(hw);
> +       struct ccu_data *ccu = bcm_clk->ccu;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       flags = ccu_lock(ccu);
> +       __ccu_write_enable(ccu);
> +
>         switch (bcm_clk->type) {
>         case bcm_clk_peri:
> -               return __peri_clk_init(bcm_clk);
> +               if (!__peri_clk_init(bcm_clk))
> +                       ret = -EINVAL;
> +               break;
>         default:
>                 BUG();
>         }

The switch-case only has one match, plus a default. Will there be others
in the future?  Otherwise it can be replaced with an if-statement.

> -       return -EINVAL;
> -}
> -
> -/* Set a CCU and all its clocks into their desired initial state */
> -bool __init kona_ccu_init(struct ccu_data *ccu)
> -{
> -       unsigned long flags;
> -       unsigned int which;
> -       struct clk **clks = ccu->clk_data.clks;
> -       bool success = true;
> -
> -       flags = ccu_lock(ccu);
> -       __ccu_write_enable(ccu);
> -
> -       for (which = 0; which < ccu->clk_data.clk_num; which++) {
> -               struct kona_clk *bcm_clk;
> -
> -               if (!clks[which])
> -                       continue;
> -               bcm_clk = to_kona_clk(__clk_get_hw(clks[which]));
> -               success &= __kona_clk_init(bcm_clk);
> -       }
>  
>         __ccu_write_disable(ccu);
>         ccu_unlock(ccu, flags);
> -       return success;
> +
> +       return ret;
>  }

Does this prepare callback "enable" a clock? E.g does a line NOT toggle
at a rate prior to this call, and then after this call completes that
same line is now toggling at a rate?

>  
> -/* Clock operations */
> +static void kona_clk_unprepare(struct clk_hw *hw)
> +{
> +       /* Nothing to do. */
> +}

Is doing nothing the right thing to do? Could power be saved somehow if
the .unprepare callback really gets called? Remember that if .unprepare
actually runs (because struct clk->prepare_count == 0) then the next
call to clk_prepare will actually call your .prepare callback and set up
the prereq clocks again. So the prereq clock initialization is no longer
a one-time thing, which might afford you some optimizations.

Regards,
Mike

>  
>  static int kona_peri_clk_enable(struct clk_hw *hw)
>  {
> @@ -1264,6 +1258,8 @@ static int kona_peri_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>  }
>  
>  struct clk_ops kona_peri_clk_ops = {
> +       .prepare = kona_clk_prepare,
> +       .unprepare = kona_clk_unprepare,
>         .enable = kona_peri_clk_enable,
>         .disable = kona_peri_clk_disable,
>         .is_enabled = kona_peri_clk_is_enabled,
> diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
> index e9a8466..3409111 100644
> --- a/drivers/clk/bcm/clk-kona.h
> +++ b/drivers/clk/bcm/clk-kona.h
> @@ -511,6 +511,5 @@ extern u64 scaled_div_build(struct bcm_clk_div *div, u32 div_value,
>  extern struct clk *kona_clk_setup(struct kona_clk *bcm_clk);
>  extern void __init kona_dt_ccu_setup(struct ccu_data *ccu,
>                                 struct device_node *node);
> -extern bool __init kona_ccu_init(struct ccu_data *ccu);
>  
>  #endif /* _CLK_KONA_H */
> -- 
> 1.9.1
> 
