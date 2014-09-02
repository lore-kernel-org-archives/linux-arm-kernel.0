From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 01 Sep 2014 18:10:50 -0700
Subject: [PATCH 1/2] clk: rockchip: implement the fraction divider branch
 type
In-Reply-To: <2167469.H3nkUqR3zE@diego>
References: <2167469.H3nkUqR3zE@diego>
Message-ID: <20140902011050.5251.68793@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-08-26 15:54:21)
> Rockchip SoCs may provide fraction dividers for some clocks, mostly for
> i2s and uarts. In contrast to the other registers, these do not use
> the hiword-mask paradigm, but instead split the register into the upper
> 16 bit for the nominator and the lower 16 bit for the denominator.
> 
> The common clock framework got a generic fractional divider clock type
> recently that can accomodate this setting easily. All currently known
> fraction dividers have a separate gate too, therefore implement the
> divider as composite using the ops-struct from fractional_divider clock
> and add the gate if necessary.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/rockchip/clk.c | 58 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 278cf9d..5db1ecf 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -103,6 +103,54 @@ struct clk *rockchip_clk_register_branch(const char *name,
>         return clk;
>  }
>  
> +static struct clk *rockchip_clk_register_frac_branch(const char *name,
> +               const char **parent_names, u8 num_parents, void __iomem *base,
> +               int muxdiv_offset, u8 div_flags,
> +               int gate_offset, u8 gate_shift, u8 gate_flags,
> +               unsigned long flags, spinlock_t *lock)
> +{
> +       struct clk *clk;
> +       struct clk_gate *gate = NULL;
> +       struct clk_fractional_divider *div = NULL;
> +       const struct clk_ops *div_ops = NULL, *gate_ops = NULL;
> +
> +       if (gate_offset >= 0) {
> +               gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +               if (!gate)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               gate->flags = gate_flags;
> +               gate->reg = base + gate_offset;
> +               gate->bit_idx = gate_shift;
> +               gate->lock = lock;
> +               gate_ops = &clk_gate_ops;
> +       }
> +
> +       if (muxdiv_offset < 0)
> +               return ERR_PTR(-EINVAL);
> +
> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       div->flags = div_flags;
> +       div->reg = base + muxdiv_offset;
> +       div->mshift = 16;
> +       div->mmask = 0xffff0000;
> +       div->nshift = 0;
> +       div->nmask = 0xffff;
> +       div->lock = lock;
> +       div_ops = &clk_fractional_divider_ops;
> +
> +       clk = clk_register_composite(NULL, name, parent_names, num_parents,
> +                                    NULL, NULL,
> +                                    &div->hw, div_ops,
> +                                    gate ? &gate->hw : NULL, gate_ops,
> +                                    flags);
> +
> +       return clk;
> +}
> +
>  static DEFINE_SPINLOCK(clk_lock);
>  static struct clk **clk_table;
>  static void __iomem *reg_base;
> @@ -197,8 +245,14 @@ void __init rockchip_clk_register_branches(
>                                         list->div_flags, &clk_lock);
>                         break;
>                 case branch_fraction_divider:
> -                       /* unimplemented */
> -                       continue;
> +                       /* keep all gates untouched for now */
> +                       flags |= CLK_IGNORE_UNUSED;
> +
> +                       clk = rockchip_clk_register_frac_branch(list->name,
> +                               list->parent_names, list->num_parents,
> +                               reg_base, list->muxdiv_offset, list->div_flags,
> +                               list->gate_offset, list->gate_shift,
> +                               list->gate_flags, flags, &clk_lock);
>                         break;
>                 case branch_gate:
>                         flags |= CLK_SET_RATE_PARENT;
> -- 
> 2.0.1
> 
> 
