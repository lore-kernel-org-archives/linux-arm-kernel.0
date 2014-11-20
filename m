From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Nov 2014 18:30:50 -0800
Subject: [PATCH v2] clk: Propagate prepare and enable when reparenting
 orphans
In-Reply-To: <1415408818-28028-1-git-send-email-dianders@chromium.org>
References: <1415408818-28028-1-git-send-email-dianders@chromium.org>
Message-ID: <20141120023050.12298.26964@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Doug Anderson (2014-11-07 17:06:58)
> With the existing code, if you find a parent for an orhpan that has
> already been prepared / enabled, you won't enable the parent.  That
> can cause later problems since the clock tree isn't in a consistent
> state.  Fix by propagating the prepare and enable.
> 
> NOTE: this does bring up the question about whether the enable of the
> orphan actually made sense.  If the orphan's parent wasn't enabled by
> default (by the bootloader or the default state of the hardware) then
> the original enable of the orphan probably didn't do what the caller
> though it would.  Some users of the orphan might have preferred an
> EPROBE_DEFER be returned until we had a full path to a root clock.
> This patch doesn't address those concerns and really just syncs up the
> state.

-ECANOFWORMS

I'm thinking about this patch but I haven't quite made up my mind. It is
reasonable, but also some nice kind of error might be preferable when
preparing/enabling an orphaned clock.

Under what conditions might a clock be orphaned? An obvious example is
just bad luck during the thundering herd of clock registrations from a
driver. In this case deferring the probe might be a good idea.

However what about the case where a loadable module provides the parent
clock? It might be a long time before the orphan clocks gets picked up
from the orphanage. Is deferring probe the right thing here as well?

Regards,
Mike

> 
> Tested on rk3288-evb-rk808 by temporarily considering "sclk_tsadc" as
> a critical clock (to simulate a driver enabling it at bootup).
> 
> Before:
> 
>    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>  xin32k                                   0            0       32768          0 0
>     sclk_hdmi_cec                         0            0       32768          0 0
>     sclk_otg_adp                          0            0       32768          0 0
>     sclk_tsadc                            1            1         993          0 0
> 
> After:
> 
>    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>  xin32k                                   1            1       32768          0 0
>     sclk_hdmi_cec                         0            0       32768          0 0
>     sclk_otg_adp                          0            0       32768          0 0
>     sclk_tsadc                            1            1         993          0 0
> 
> Note that xin32k on rk808 is a clock that cannot be disabled in
> hardware (it's an always on clock), so really all we needed to do was
> to sync up the state.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Only do the work for orphans, not for other users of __clk_reparent().
> 
>  drivers/clk/clk.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 4896ae9..0f04b7c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1652,6 +1652,22 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
>         __clk_recalc_rates(clk, POST_RATE_CHANGE);
>  }
>  
> +static void __clk_reparent_orphan(struct clk *clk, struct clk *new_parent)
> +{
> +       __clk_reparent(clk, new_parent);
> +
> +       if (clk->prepare_count) {
> +               unsigned long flags;
> +
> +               __clk_prepare(new_parent);
> +
> +               flags = clk_enable_lock();
> +               if (clk->enable_count)
> +                       __clk_enable(new_parent);
> +               clk_enable_unlock(flags);
> +       }
> +}
> +
>  /**
>   * clk_set_parent - switch the parent of a mux clk
>   * @clk: the mux clk whose input we are switching
> @@ -1953,13 +1969,13 @@ int __clk_init(struct device *dev, struct clk *clk)
>                 if (orphan->num_parents && orphan->ops->get_parent) {
>                         i = orphan->ops->get_parent(orphan->hw);
>                         if (!strcmp(clk->name, orphan->parent_names[i]))
> -                               __clk_reparent(orphan, clk);
> +                               __clk_reparent_orphan(orphan, clk);
>                         continue;
>                 }
>  
>                 for (i = 0; i < orphan->num_parents; i++)
>                         if (!strcmp(clk->name, orphan->parent_names[i])) {
> -                               __clk_reparent(orphan, clk);
> +                               __clk_reparent_orphan(orphan, clk);
>                                 break;
>                         }
>          }
> -- 
> 2.1.0.rc2.206.gedb03e5
> 
