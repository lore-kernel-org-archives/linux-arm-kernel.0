From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 13 Nov 2018 02:16:09 +0000
Subject: [PATCH RESEND V4 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE
 clk support
In-Reply-To: <20181105005928.12299.56045@resonance>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <1540127173-21346-2-git-send-email-aisheng.dong@nxp.com>
 <20181105005928.12299.56045@resonance>
Message-ID: <AM0PR04MB4211E05F26C059E764A1A3C580C20@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

> -----Original Message-----
> From: Michael Turquette [mailto:mturquette at baylibre.com]
[...]
> Hi Dong,
> 
> Quoting A.s. Dong (2018-10-21 06:10:48)
> > For dividers with zero indicating clock is disabled, instead of giving
> > a warning each time like "clkx: Zero divisor and
> > CLK_DIVIDER_ALLOW_ZERO not set" in exist code, we'd like to introduce
> enable/disable function for it.
> > e.g.
> > 000b - Clock disabled
> > 001b - Divide by 1
> > 010b - Divide by 2
> > ...
> 
> I feel bad to NAK this patch after it's been on the list for so long, 

Never mind, I feel better than no response about it. :-)

> but this
> implementation really should belong in your hardware specific clock provider
> driver.
> 

Got your point.

> This patch expands clk-divider to also be a gate, which is a non-starter.  Basic
> clock types were meant to remain basic. I'm already imagining how this
> precedent would cause other submissions: "why should I use composite clock
> when we can just add new clk_ops to the basic clock types!" :-(
> 
> Also the implementation becomes cleaner when you don't have to make it
> coexist with clk-divider.c. You can drop the flags and just implement a machine
> specific clock type that combines gates and dividers.

Sound good to me. The original purpose to put it in framework is in order to
save possible duplicated codes for a similar SoC as the implementation actually
is HW independent. But I think we could start from putting it in machine code first.

Thanks for the suggestion.
Will update soon and resend.

Regards
Dong Aisheng
> 
> Best regards,
> Mike
> 
> >
> > Set rate when the clk is disabled will cache the rate request and only
> > when the clk is enabled will the driver actually program the hardware
> > to have the requested divider value. Similarly, when the clk is
> > disabled we'll write a 0 there, but when the clk is enabled we'll
> > restore whatever rate
> > (divider) was chosen last.
> >
> > It does mean that recalc rate will be sort of odd, because when the
> > clk is off it will return 0, and when the clk is on it will return the right rate.
> > So to make things work, we'll need to return the cached rate in recalc
> > rate when the clk is off and read the hardware when the clk is on.
> >
> > NOTE for the default off divider, the recalc rate will still return 0
> > as there's still no proper preset rate. Enable such divider will give
> > user a reminder error message.
> >
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > ---
> > ChangeLog:
> > v3->v4:
> >  * no changes
> > v2->v3:
> >  * split normal and gate ops
> >  * fix the possible racy
> > v1->v2:
> >  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
> > ---
> >  drivers/clk/clk-divider.c    | 152
> +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk-provider.h |   9 +++
> >  2 files changed, 161 insertions(+)
> >
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index b6234a5..b3566fd 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -122,6 +122,9 @@ unsigned long divider_recalc_rate(struct clk_hw
> > *hw, unsigned long parent_rate,
> >
> >         div = _get_div(table, val, flags, width);
> >         if (!div) {
> > +               if (flags & CLK_DIVIDER_ZERO_GATE)
> > +                       return 0;
> > +
> >                 WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
> >                         "%s: Zero divisor and
> CLK_DIVIDER_ALLOW_ZERO not set\n",
> >                         clk_hw_get_name(hw)); @@ -145,6 +148,34
> @@
> > static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >                                    divider->flags, divider->width);  }
> >
> > +static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
> > +                                                 unsigned long
> > +parent_rate) {
> > +       struct clk_divider *divider = to_clk_divider(hw);
> > +       unsigned long flags = 0;
> > +       unsigned int val;
> > +
> > +       if (divider->lock)
> > +               spin_lock_irqsave(divider->lock, flags);
> > +       else
> > +               __acquire(divider->lock);
> > +
> > +       if (!clk_hw_is_enabled(hw)) {
> > +               val = divider->cached_val;
> > +       } else {
> > +               val = clk_readl(divider->reg) >> divider->shift;
> > +               val &= clk_div_mask(divider->width);
> > +       }
> > +
> > +       if (divider->lock)
> > +               spin_unlock_irqrestore(divider->lock, flags);
> > +       else
> > +               __release(divider->lock);
> > +
> > +       return divider_recalc_rate(hw, parent_rate, val, divider->table,
> > +                                  divider->flags, divider->width); }
> > +
> >  static bool _is_valid_table_div(const struct clk_div_table *table,
> >                                                          unsigned
> int
> > div)  { @@ -437,6 +468,108 @@ static int clk_divider_set_rate(struct
> > clk_hw *hw, unsigned long rate,
> >         return 0;
> >  }
> >
> > +static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                               unsigned long parent_rate) {
> > +       struct clk_divider *divider = to_clk_divider(hw);
> > +       unsigned long flags = 0;
> > +       int value;
> > +       u32 val;
> > +
> > +       value = divider_get_val(rate, parent_rate, divider->table,
> > +                               divider->width, divider->flags);
> > +       if (value < 0)
> > +               return value;
> > +
> > +       if (divider->lock)
> > +               spin_lock_irqsave(divider->lock, flags);
> > +       else
> > +               __acquire(divider->lock);
> > +
> > +       if (clk_hw_is_enabled(hw)) {
> > +               if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
> > +                       val = clk_div_mask(divider->width) <<
> (divider->shift + 16);
> > +               } else {
> > +                       val = clk_readl(divider->reg);
> > +                       val &= ~(clk_div_mask(divider->width) <<
> divider->shift);
> > +               }
> > +               val |= (u32)value << divider->shift;
> > +               clk_writel(val, divider->reg);
> > +       } else {
> > +               divider->cached_val = value;
> > +       }
> > +
> > +       if (divider->lock)
> > +               spin_unlock_irqrestore(divider->lock, flags);
> > +       else
> > +               __release(divider->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int clk_divider_enable(struct clk_hw *hw) {
> > +       struct clk_divider *divider = to_clk_divider(hw);
> > +       unsigned long flags = 0;
> > +       u32 val;
> > +
> > +       if (!divider->cached_val) {
> > +               pr_err("%s: no valid preset rate\n",
> clk_hw_get_name(hw));
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (divider->lock)
> > +               spin_lock_irqsave(divider->lock, flags);
> > +       else
> > +               __acquire(divider->lock);
> > +
> > +       /* restore div val */
> > +       val = clk_readl(divider->reg);
> > +       val |= divider->cached_val << divider->shift;
> > +       clk_writel(val, divider->reg);
> > +
> > +       if (divider->lock)
> > +               spin_unlock_irqrestore(divider->lock, flags);
> > +       else
> > +               __release(divider->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static void clk_divider_disable(struct clk_hw *hw) {
> > +       struct clk_divider *divider = to_clk_divider(hw);
> > +       unsigned long flags = 0;
> > +       u32 val;
> > +
> > +       if (divider->lock)
> > +               spin_lock_irqsave(divider->lock, flags);
> > +       else
> > +               __acquire(divider->lock);
> > +
> > +       /* store the current div val */
> > +       val = clk_readl(divider->reg) >> divider->shift;
> > +       val &= clk_div_mask(divider->width);
> > +       divider->cached_val = val;
> > +       clk_writel(0, divider->reg);
> > +
> > +       if (divider->lock)
> > +               spin_unlock_irqrestore(divider->lock, flags);
> > +       else
> > +               __release(divider->lock); }
> > +
> > +static int clk_divider_is_enabled(struct clk_hw *hw) {
> > +       struct clk_divider *divider = to_clk_divider(hw);
> > +       u32 val;
> > +
> > +       val = clk_readl(divider->reg) >> divider->shift;
> > +       val &= clk_div_mask(divider->width);
> > +
> > +       return val ? 1 : 0;
> > +}
> > +
> >  const struct clk_ops clk_divider_ops = {
> >         .recalc_rate = clk_divider_recalc_rate,
> >         .round_rate = clk_divider_round_rate, @@ -444,6 +577,16 @@
> > const struct clk_ops clk_divider_ops = {  };
> > EXPORT_SYMBOL_GPL(clk_divider_ops);
> >
> > +const struct clk_ops clk_divider_gate_ops = {
> > +       .recalc_rate = clk_divider_gate_recalc_rate,
> > +       .round_rate = clk_divider_round_rate,
> > +       .set_rate = clk_divider_gate_set_rate,
> > +       .enable = clk_divider_enable,
> > +       .disable = clk_divider_disable,
> > +       .is_enabled = clk_divider_is_enabled, };
> > +EXPORT_SYMBOL_GPL(clk_divider_gate_ops);
> > +
> >  const struct clk_ops clk_divider_ro_ops = {
> >         .recalc_rate = clk_divider_recalc_rate,
> >         .round_rate = clk_divider_round_rate, @@ -459,6 +602,7 @@
> > static struct clk_hw *_register_divider(struct device *dev, const char *name,
> >         struct clk_divider *div;
> >         struct clk_hw *hw;
> >         struct clk_init_data init;
> > +       u32 val;
> >         int ret;
> >
> >         if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) { @@ -476,6
> > +620,8 @@ static struct clk_hw *_register_divider(struct device *dev, const
> char *name,
> >         init.name = name;
> >         if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
> >                 init.ops = &clk_divider_ro_ops;
> > +       else if (clk_divider_flags & CLK_DIVIDER_ZERO_GATE)
> > +               init.ops = &clk_divider_gate_ops;
> >         else
> >                 init.ops = &clk_divider_ops;
> >         init.flags = flags | CLK_IS_BASIC; @@ -491,6 +637,12 @@ static
> > struct clk_hw *_register_divider(struct device *dev, const char *name,
> >         div->hw.init = &init;
> >         div->table = table;
> >
> > +       if (div->flags & CLK_DIVIDER_ZERO_GATE) {
> > +               val = clk_readl(reg) >> shift;
> > +               val &= clk_div_mask(width);
> > +               div->cached_val = val;
> > +       }
> > +
> >         /* register the clock */
> >         hw = &div->hw;
> >         ret = clk_hw_register(dev, hw); diff --git
> > a/include/linux/clk-provider.h b/include/linux/clk-provider.h index
> > 08b1aa7..08f135a 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -387,6 +387,7 @@ struct clk_div_table {
> >   * @shift:     shift to the divider bit field
> >   * @width:     width of the divider bit field
> >   * @table:     array of value/divider pairs, last entry should have div = 0
> > + * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
> >   * @lock:      register lock
> >   *
> >   * Clock with an adjustable divider affecting its output frequency.
> > Implements @@ -415,6 +416,12 @@ struct clk_div_table {
> >   * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like
> CLK_DIVIDER_ONE_BASED
> >   *     except when the value read from the register is zero, the divisor is
> >   *     2^width of the field.
> > + * CLK_DIVIDER_ZERO_GATE - For dividers which are like
> CLK_DIVIDER_ONE_BASED
> > + *     when the value read from the register is zero, it means the divisor
> > + *     is gated. For this case, the cached_val will be used to store the
> > + *     intermediate div for the normal rate operation, like
> set_rate/get_rate/
> > + *     recalc_rate. When the divider is ungated, the driver will actually
> > + *     program the hardware to have the requested divider value.
> >   */
> >  struct clk_divider {
> >         struct clk_hw   hw;
> > @@ -423,6 +430,7 @@ struct clk_divider {
> >         u8              width;
> >         u8              flags;
> >         const struct clk_div_table      *table;
> > +       u32             cached_val;
> >         spinlock_t      *lock;
> >  };
> >
> > @@ -436,6 +444,7 @@ struct clk_divider {
> >  #define CLK_DIVIDER_ROUND_CLOSEST      BIT(4)
> >  #define CLK_DIVIDER_READ_ONLY          BIT(5)
> >  #define CLK_DIVIDER_MAX_AT_ZERO                BIT(6)
> > +#define CLK_DIVIDER_ZERO_GATE          BIT(7)
> >
> >  extern const struct clk_ops clk_divider_ops;  extern const struct
> > clk_ops clk_divider_ro_ops;
> > --
> > 2.7.4
> >
