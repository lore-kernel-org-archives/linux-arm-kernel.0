From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 17 Apr 2012 18:05:51 -0700
Subject: [PATCH 2/3] clk: pass parent_rate into .set_rate
In-Reply-To: <1334235019-15553-2-git-send-email-shawn.guo@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334235019-15553-1-git-send-email-shawn.guo@linaro.org>
 <1334235019-15553-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zNZE+LPvzC7V20T19hOEQKqhYJg9HRyEBx7a5rQur3s6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 5:50 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> For most of .set_rate implementation, parent_rate will be used, so just
> like passing parent_rate into .recalc_rate, let's pass parent_rate into
> .set_rate too.
>
> It also updates the kernel doc for .set_rate ops.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for the patch Shawn.  I've pulled this into my -next branch.

Regards,
Mike

> ---
> ?drivers/clk/clk-divider.c ? ?| ? ?5 +++--
> ?drivers/clk/clk.c ? ? ? ? ? ?| ? ?2 +-
> ?include/linux/clk-provider.h | ? 21 +++++++--------------
> ?3 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 04439f1..1793095 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -111,14 +111,15 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> ? ? ? ?return *prate / div;
> ?}
>
> -static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate)
> +static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long parent_rate)
> ?{
> ? ? ? ?struct clk_divider *divider = to_clk_divider(hw);
> ? ? ? ?unsigned int div;
> ? ? ? ?unsigned long flags = 0;
> ? ? ? ?u32 val;
>
> - ? ? ? div = __clk_get_rate(__clk_get_parent(hw->clk)) / rate;
> + ? ? ? div = parent_rate / rate;
>
> ? ? ? ?if (!(divider->flags & CLK_DIVIDER_ONE_BASED))
> ? ? ? ? ? ? ? ?div--;
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 19caa0a..d04e1e4 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -848,7 +848,7 @@ static void clk_change_rate(struct clk *clk)
> ? ? ? ?old_rate = clk->rate;
>
> ? ? ? ?if (clk->ops->set_rate)
> - ? ? ? ? ? ? ? clk->ops->set_rate(clk->hw, clk->new_rate);
> + ? ? ? ? ? ? ? clk->ops->set_rate(clk->hw, clk->new_rate, clk->parent->rate);
>
> ? ? ? ?if (clk->ops->recalc_rate)
> ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk->hw,
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 3323d24..cb82918 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -88,19 +88,11 @@ struct clk_hw {
> ?* ? ? ? ? ? ? array index into the value programmed into the hardware.
> ?* ? ? ? ? ? ? Returns 0 on success, -EERROR otherwise.
> ?*
> - * @set_rate: ?Change the rate of this clock. If this callback returns
> - * ? ? ? ? ? ? CLK_SET_RATE_PARENT, the rate change will be propagated to the
> - * ? ? ? ? ? ? parent clock (which may propagate again if the parent clock
> - * ? ? ? ? ? ? also sets this flag). The requested rate of the parent is
> - * ? ? ? ? ? ? passed back from the callback in the second 'unsigned long *'
> - * ? ? ? ? ? ? argument. ?Note that it is up to the hardware clock's set_rate
> - * ? ? ? ? ? ? implementation to insure that clocks do not run out of spec
> - * ? ? ? ? ? ? when propgating the call to set_rate up to the parent. ?One way
> - * ? ? ? ? ? ? to do this is to gate the clock (via clk_disable and/or
> - * ? ? ? ? ? ? clk_unprepare) before calling clk_set_rate, then ungating it
> - * ? ? ? ? ? ? afterward. ?If your clock also has the CLK_GATE_SET_RATE flag
> - * ? ? ? ? ? ? set then this will insure safety. ?Returns 0 on success,
> - * ? ? ? ? ? ? -EERROR otherwise.
> + * @set_rate: ?Change the rate of this clock. The requested rate is specified
> + * ? ? ? ? ? ? by the second argument, which should typically be the return
> + * ? ? ? ? ? ? of .round_rate call. ?The third argument gives the parent rate
> + * ? ? ? ? ? ? which is likely helpful for most .set_rate implementation.
> + * ? ? ? ? ? ? Returns 0 on success, -EERROR otherwise.
> ?*
> ?* The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
> ?* implementations to split any work between atomic (enable) and sleepable
> @@ -125,7 +117,8 @@ struct clk_ops {
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long *);
> ? ? ? ?int ? ? ? ? ? ? (*set_parent)(struct clk_hw *hw, u8 index);
> ? ? ? ?u8 ? ? ? ? ? ? ?(*get_parent)(struct clk_hw *hw);
> - ? ? ? int ? ? ? ? ? ? (*set_rate)(struct clk_hw *hw, unsigned long);
> + ? ? ? int ? ? ? ? ? ? (*set_rate)(struct clk_hw *hw, unsigned long,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long);
> ? ? ? ?void ? ? ? ? ? ?(*init)(struct clk_hw *hw);
> ?};
>
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
