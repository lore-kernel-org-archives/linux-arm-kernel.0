From: carlo@caione.org (Carlo Caione)
Date: Fri, 29 May 2015 19:45:10 +0200
Subject: [PATCH v2 1/3] clk: meson: Add support for Meson clock controller
In-Reply-To: <20150528215534.GC24204@codeaurora.org>
References: <1431773333-23567-1-git-send-email-carlo@caione.org>
 <1431773333-23567-2-git-send-email-carlo@caione.org>
 <20150528215534.GC24204@codeaurora.org>
Message-ID: <CAOQ7t2bqUwj72kN9gOjR2qbPPc+d=XFJh2SwMsDH4Gj4bFECJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 11:55 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>
> Is this include used?
>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>
> Is this include used?
>
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>
> Is this include used?
>
> Missing
>
> #include <linux/spinlock.h>
>
> ?

I'll fix all the headers in v3.

>> +static int meson_clk_cpu_get_div(struct clk_hw *hw, unsigned long rate,
>> +                              unsigned long *best_parent_rate)
>> +{
>> +     unsigned long maxdiv, parent_rate, now;
>> +     unsigned long best = 0;
>> +     unsigned long parent_rate_saved = *best_parent_rate;
>> +     int i, bestdiv = 0;
>> +
>> +     maxdiv = 2 * PMASK(MESON_N_WIDTH);
>> +     maxdiv = min(ULONG_MAX / rate, maxdiv);
>> +
>> +     for (i = 1; i <= maxdiv; i++) {
>> +             if (!is_valid_div(i))
>> +                     continue;
>> +             if (rate * i == parent_rate_saved) {
>> +                     *best_parent_rate = parent_rate_saved;
>> +                     return i;
>> +             }
>> +             parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
>> +                             MULT_ROUND_UP(rate, i));
>> +             now = DIV_ROUND_UP(parent_rate, i);
>> +             if (is_best_div(rate, now, best)) {
>> +                     bestdiv = i;
>> +                     best = now;
>> +                     *best_parent_rate = parent_rate;
>> +             }
>> +     }
>> +
>> +     return bestdiv;
>> +}
>> +
>> +static long meson_clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                  unsigned long *prate)
>> +{
>> +     int div;
>> +
>> +     div = meson_clk_cpu_get_div(hw, rate, prate);
>> +
>> +     return DIV_ROUND_UP(*prate, div);
>> +}
>
> How much of this is the same as the generic divider code? Can you
> use the divider_*() functions for this code?

Yes. When I submitted the v1 the divider_*() functions weren't exported yet.

>> +static int meson_clk_cpu_pre_rate_change(struct meson_clk_cpu *clk_cpu,
>> +                                      struct clk_notifier_data *ndata)
>> +{
>> +     u32 cpu_clk_cntl;
>> +
>> +     spin_lock(clk_cpu->lock);
>
> We don't need irqsave? What is this locking against? I only see
> notifiers using it and notifiers are synchronized already.

Didn't notice that. I'll fix it.

>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>
> Is this include used?

It isn't.

>> +
>> +static int meson_clk_pll_wait_lock(struct meson_clk_pll *pll,
>> +                                struct parm *p_n)
>> +{
>> +     int delay = 24000000;
>> +     u32 reg;
>> +
>> +     while (delay > 0) {
>> +             reg = readl(pll->base + p_n->reg_off);
>> +
>> +             if (reg & MESON_PLL_LOCK)
>> +                     return 0;
>> +             delay--;
>
> Do we somehow know that a delay-- takes so much time? It would
> seem better to have a udelay() here. Otherwise we're left to the
> speed of the CPU to execute these instructions.

Actually this is not a delay cycle but we exit as soon as the
MESON_PLL_LOCK bit is flipped so in theory we want to cycle as fast as
possible.

>> +
>> +     /* We usually don't touch PLLs */
>> +     init.flags |= CLK_IGNORE_UNUSED;
>
> Is this even important if the ops don't have an enable/disable
> (read-only ops)?

Yeah, not really important.

>> +
>> +struct clk __init **meson_clk_init(struct device_node *np,
>
> This should be
>
> struct clk ** __init meson_clk_init(struct ...)

Agree

>> +                                unsigned long nr_clks)
>> +{
>> +     clks = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
>
> sizeof(**clks) ?

yeah ( sizeof(*clks) )

>> +     if (!clks) {
>> +             pr_err("%s: could not allocate clock lookup table\n", __func__);
>
> No need for error messages on allocation failures. Please run
> checkpatch.

I did. Probably missed that.

>> +     if (MESON_PARM_APPLICABLE(&composite_conf->div_parm)) {
>> +             div = kzalloc(sizeof(*div), GFP_KERNEL);
>> +             if (!div)
>> +                     return ERR_PTR(-ENOMEM);
>
> Did we just leak memory if we had a mux?
>
>> +
>> +             div->reg = clk_base + clk_conf->reg_off
>> +                             + composite_conf->div_parm.reg_off;
>> +             div->shift = composite_conf->div_parm.shift;
>> +             div->width = composite_conf->div_parm.width;
>> +             div->lock = &clk_lock;
>> +             div->flags = composite_conf->div_flags;
>> +             div->table = composite_conf->div_table;
>> +     }
>> +
>> +     if (MESON_PARM_APPLICABLE(&composite_conf->gate_parm)) {
>> +             gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>> +             if (!gate)
>> +                     return ERR_PTR(-ENOMEM);
>
> ditto

Error path in v3.

>> +
>> +     clk = clk_register_composite(NULL, clk_conf->clk_name,
>> +                                 clk_conf->clks_parent,
>> +                                 clk_conf->num_parents,
>> +                                 mux ? &mux->hw : NULL, mux_ops,
>> +                                 div ? &div->hw : NULL, &clk_divider_ops,
>> +                                 gate ? &gate->hw : NULL, &clk_gate_ops,
>> +                                 clk_conf->flags);
>> +
>> +     return clk;
>
> Why not just return clk_register_composite() then?

Because it is missing the error checking on clk. I'll fix it.

>> +
>> +void __init meson_clk_register_clks(struct clk_conf *clk_confs,
>> +                                 unsigned int nr_confs,
>
> size_t?

Ok

>> +             case clk_pll:
>> +                     clk = meson_clk_register_pll(clk_conf, clk_base,
>> +                                                  &clk_lock);
>> +                     break;
>
> default:
>         clk = NULL;
>         break;

Agree

>> +
>> +#include <linux/clk.h>
>
> What is this include for?

Nothing, I guess?

>> +
>> +#define PMASK(width)                 ((1U << (width)) - 1)
>> +#define SETPMASK(width, shift)               (PMASK(width) << (shift))
>> +#define CLRPMASK(width, shift)               (~(SETPMASK(width, shift)))
>> +
>
> We have GENMASK for these sorts of things, please use it.

Oh, nice to have that.

>> +
>> +#define PNAME(x) static const char *x[] __initconst
>
> Is this used?

Yep, it is in meson8b-clkc.c

>> +
>> +enum clk_type {
>> +     clk_fixed_factor,
>> +     clk_fixed_rate,
>> +     clk_composite,
>> +     clk_cpu,
>> +     clk_pll,
>> +};
>
> Please use upper case for enums

Agree

>> +
>> +#define FIXED_RATE_P(_ro, _ci, _cn, _f, _c)                          \
>> +     {                                                               \
>> +             .reg_off                        = (_ro),                \
>> +             .clk_type                       = clk_fixed_rate,       \
>> +             .clk_id                         = (_ci),                \
>> +             .clk_name                       = (_cn),                \
>> +             .flags                          = (_f),                 \
>> +             .conf.fixed_rate.rate_parm      = _c,                   \
>> +     }                                                               \
>> +
>> +#define FIXED_RATE(_ci, _cn, _f, _r)                                 \
>> +     {                                                               \
>> +             .clk_type                       = clk_fixed_rate,       \
>> +             .clk_id                         = (_ci),                \
>> +             .clk_name                       = (_cn),                \
>> +             .flags                          = (_f),                 \
>> +             .conf.fixed_rate.rate           = (_r),                 \
>> +     }                                                               \
>> +
>> +#define PLL(_ro, _ci, _cn, _cp, _f, _c)                                      \
>> +     {                                                               \
>> +             .reg_off                        = (_ro),                \
>> +             .clk_type                       = clk_pll,              \
>> +             .clk_id                         = (_ci),                \
>> +             .clk_name                       = (_cn),                \
>> +             .clks_parent                    = (_cp),                \
>> +             .num_parents                    = ARRAY_SIZE(_cp),      \
>> +             .flags                          = (_f),                 \
>> +             .conf.pll                       = (_c),                 \
>> +     }                                                               \
>> +
>> +#define FIXED_FACTOR_DIV(_ci, _cn, _cp, _f, _d)                              \
>> +     {                                                               \
>> +             .clk_type                       = clk_fixed_factor,     \
>> +             .clk_id                         = (_ci),                \
>> +             .clk_name                       = (_cn),                \
>> +             .clks_parent                    = (_cp),                \
>> +             .num_parents                    = ARRAY_SIZE(_cp),      \
>> +             .conf.fixed_fact.div            = (_d),                 \
>> +     }                                                               \
>> +
>> +#define CPU(_ro, _ci, _cn, _cp)                                              \
>> +     {                                                               \
>> +             .reg_off                        = (_ro),                \
>> +             .clk_type                       = clk_cpu,              \
>> +             .clk_id                         = (_ci),                \
>> +             .clk_name                       = (_cn),                \
>> +             .clks_parent                    = (_cp),                \
>> +             .num_parents                    = ARRAY_SIZE(_cp),      \
>> +     }                                                               \
>> +
>> +#define COMPOSITE(_ro, _ci, _cn, _cp, _f, _c)                                \
>> +     {                                                               \
>> +             .reg_off                        = (_ro),                \
>> +             .clk_type                       = clk_composite,        \
>> +             .clk_id                         = (_ci),                \
>> +             .clk_name                       = (_cn),                \
>> +             .clks_parent                    = (_cp),                \
>> +             .num_parents                    = ARRAY_SIZE(_cp),      \
>> +             .flags                          = (_f),                 \
>> +             .conf.composite                 = (_c),                 \
>> +     }                                                               \
>
> I couldn't find any usage of these defines. If they're used later
> in the series, please add them when they're used.

These defines are used later in the Meson8b specific file and I think
they belong to this patch since they define all the basic clock types
we can find on all the Meson SoCs.

>> +
>> +#endif /* __CLKC_H */
>> diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
>> new file mode 100644
>> index 0000000..9986c38
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/meson8b-clkc.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * Meson8b clock tree IDs
>> + */
>
> Does this need an ifdef guard?

Yep.

Thank you for your review.

-- 
Carlo Caione
