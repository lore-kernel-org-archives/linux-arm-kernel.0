From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 22 Sep 2014 21:21:09 +0200
Subject: [PATCH v3 6/8] clk: rockchip: add new clock-type for the cpuclk
In-Reply-To: <CAD=FV=Xtd9F23vePiDOKbn8GMpS615qrs6FDCep_cdGNC=KP0w@mail.gmail.com>
References: <1410991974-12235-1-git-send-email-heiko@sntech.de>
 <1410991974-12235-7-git-send-email-heiko@sntech.de>
 <CAD=FV=Xtd9F23vePiDOKbn8GMpS615qrs6FDCep_cdGNC=KP0w@mail.gmail.com>
Message-ID: <2964934.WLjiJxGorQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 22. September 2014, 10:47:25 schrieb Doug Anderson:
> Heiko,
> 
> On Wed, Sep 17, 2014 at 3:12 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > When changing the armclk on Rockchip SoCs it is supposed to be reparented
> > to an alternate parent before changing the underlying pll and back after
> > the change. Additionally there exist clocks that are very tightly bound to
> > the armclk whose divider values are set according to the armclk rate.
> > 
> > Add a special clock-type to handle all that. The rate table and divider
> > values will be supplied from the soc-specific clock controllers.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/clk/rockchip/Makefile  |   1 +
> >  drivers/clk/rockchip/clk-cpu.c | 330
> >  +++++++++++++++++++++++++++++++++++++++++ drivers/clk/rockchip/clk.c    
> >  |  20 +++
> >  drivers/clk/rockchip/clk.h     |  36 +++++
> >  4 files changed, 387 insertions(+)
> >  create mode 100644 drivers/clk/rockchip/clk-cpu.c
> > 
> > diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> > index ee6b077..bd8514d 100644
> > --- a/drivers/clk/rockchip/Makefile
> > +++ b/drivers/clk/rockchip/Makefile
> > @@ -5,6 +5,7 @@
> > 
> >  obj-y  += clk-rockchip.o
> >  obj-y  += clk.o
> >  obj-y  += clk-pll.o
> > 
> > +obj-y  += clk-cpu.o
> > 
> >  obj-$(CONFIG_RESET_CONTROLLER) += softrst.o
> >  
> >  obj-y  += clk-rk3188.o
> > 
> > diff --git a/drivers/clk/rockchip/clk-cpu.c
> > b/drivers/clk/rockchip/clk-cpu.c new file mode 100644
> > index 0000000..8f0aaeb
> > --- /dev/null
> > +++ b/drivers/clk/rockchip/clk-cpu.c
> > @@ -0,0 +1,330 @@
> > +/*
> > + * Copyright (c) 2014 MundoReader S.L.
> > + * Author: Heiko Stuebner <heiko@sntech.de>
> > + *
> > + * based on clk/samsung/clk-cpu.c
> > + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> > + * Author: Thomas Abraham <thomas.ab@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This file contains the utility function to register CPU clock for
> > Samsung
> I think on the last review someone pointed out that this part of the
> comment is wrong.  Perhaps you could remove it or fix it?
> Specifically, this is not for Samsung Exynos...
> 
> > + * Exynos platforms. A CPU clock is defined as a clock supplied to a CPU
> > or a + * group of CPUs. The CPU clock is typically derived from a
> > hierarchy of clock + * blocks which includes mux and divider blocks.
> > There are a number of other + * auxiliary clocks supplied to the CPU
> > domain such as the debug blocks and AXI + * clock for CPU domain. The
> > rates of these auxiliary clocks are related to the + * CPU clock rate and
> > this relation is usually specified in the hardware manual + * of the SoC
> > or supplied after the SoC characterization.
> > + *
> > + * The below implementation of the CPU clock allows the rate changes of
> > the CPU + * clock and the corresponding rate changes of the auxillary
> > clocks of the CPU + * domain. The platform clock driver provides a clock
> > register configuration + * for each configurable rate which is then used
> > to program the clock hardware + * registers to acheive a fast
> > co-oridinated rate change for all the CPU domain + * clocks.
> > + *
> > + * On a rate change request for the CPU clock, the rate change is
> > propagated + * upto the PLL supplying the clock to the CPU domain clock
> > blocks. While the + * CPU domain PLL is reconfigured, the CPU domain
> > clocks are driven using an + * alternate clock source. If required, the
> > alternate clock source is divided + * down in order to keep the output
> > clock rate within the previous OPP limits. + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/slab.h>
> > +#include <linux/io.h>
> > +#include <linux/clk-provider.h>
> > +#include "clk.h"
> > +
> > +/**
> > + * struct rockchip_cpuclk: information about clock supplied to a CPU
> > core.
> > + * @hw:                handle between ccf and cpu clock.
> > + * @alt_parent:        alternate parent clock to use when switching the
> > speed + *             of the primary parent clock.
> > + * @reg_base:  base register for cpu-clock values.
> > + * @clk_nb:    clock notifier registered for changes in clock speed of
> > the
> > + *             primary parent clock.
> > + * @rate_count:        number of rates in the rate_table
> > + * @rate_table:        pll-rates and their associated dividers
> > + * @reg_data:  cpu-specific register settings
> > + * @lock:      clock lock
> > + */
> > +struct rockchip_cpuclk {
> > +       struct clk_hw                           hw;
> > +
> > +       struct clk_mux                          cpu_mux;
> > +       const struct clk_ops                    *cpu_mux_ops;
> > +
> > +       struct clk                              *alt_parent;
> > +       void __iomem                            *reg_base;
> > +       struct notifier_block                   clk_nb;
> > +       unsigned int                            rate_count;
> > +       struct rockchip_cpuclk_rate_table       *rate_table;
> > +       const struct rockchip_cpuclk_reg_data   *reg_data;
> > +       spinlock_t                              *lock;
> > +};
> > +
> > +#define to_rockchip_cpuclk_hw(hw) container_of(hw, struct
> > rockchip_cpuclk, hw) +#define to_rockchip_cpuclk_nb(nb) \
> > +                       container_of(nb, struct rockchip_cpuclk, clk_nb)
> > +
> > +static const struct rockchip_cpuclk_rate_table
> > *rockchip_get_cpuclk_settings( +                           struct
> > rockchip_cpuclk *cpuclk, unsigned long rate) +{
> > +       const struct rockchip_cpuclk_rate_table *rate_table =
> > +                                                      
> > cpuclk->rate_table;
> > +       int i;
> > +
> > +       for (i = 0; i < cpuclk->rate_count; i++) {
> > +               if (rate == rate_table[i].prate)
> > +                       return &rate_table[i];
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +static unsigned long rockchip_cpuclk_recalc_rate(struct clk_hw *hw,
> > +                                       unsigned long parent_rate)
> > +{
> > +       struct rockchip_cpuclk *cpuclk = to_rockchip_cpuclk_hw(hw);
> > +       const struct rockchip_cpuclk_reg_data *reg_data =
> > cpuclk->reg_data;
> > +       u32 clksel0 = readl_relaxed(cpuclk->reg_base +
> > reg_data->core_reg);
> > +
> > +       clksel0 >>= reg_data->div_core_shift;
> > +       clksel0 &= reg_data->div_core_mask;
> > +       return parent_rate / (clksel0 + 1);
> > +}
> > +
> > +static const struct clk_ops rockchip_cpuclk_ops = {
> > +       .recalc_rate = rockchip_cpuclk_recalc_rate,
> > +};
> > +
> > +static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk
> > *cpuclk,
> > +                                          struct clk_notifier_data
> > *ndata)
> > +{
> > +       const struct rockchip_cpuclk_reg_data *reg_data =
> > cpuclk->reg_data;
> > +       const struct rockchip_cpuclk_rate_table *rate;
> > +       unsigned long alt_prate, alt_div;
> > +       int i;
> > +
> > +       rate = rockchip_get_cpuclk_settings(cpuclk, ndata->new_rate);
> > +       if (!rate) {
> > +               pr_err("%s: Invalid rate : %lu for cpuclk\n",
> > +                      __func__, ndata->new_rate);
> > +               return -EINVAL;
> > +       }
> > +
> > +       alt_prate = clk_get_rate(cpuclk->alt_parent);
> > +
> > +       spin_lock(cpuclk->lock);
> > +
> > +       /*
> > +        * If the old parent clock speed is less than the clock speed
> > +        * of the alternate parent, then it should be ensured that at no
> > point +        * the armclk speed is more than the old_rate until the
> > dividers are +        * set.
> > +        */
> > +       if (alt_prate > ndata->old_rate) {
> > +               /* calculate dividers */
> > +               alt_div =  DIV_ROUND_UP(alt_prate, ndata->old_rate) - 1;
> > +               if (alt_div > reg_data->div_core_mask) {
> > +                       pr_warn("%s: limiting alt-divider %lu to %d\n",
> > +                               __func__, alt_div,
> > reg_data->div_core_mask); +                       alt_div =
> > reg_data->div_core_mask;
> > +               }
> > +
> > +               /*
> > +                * Change parents and add dividers in a single
> > transaction.
> > +                *
> > +                * NOTE: we do this in a single transaction so we're never
> > +                * dividing the primary parent by the extra dividers that
> > were +                * needed for the alt.
> > +                */
> > +               pr_debug("%s: setting div %lu as alt-rate %lu > old-rate
> > %lu\n", +                        __func__, alt_div, alt_prate,
> > ndata->old_rate); +
> > +               writel(HIWORD_UPDATE(alt_div, reg_data->div_core_mask,
> > +                                             reg_data->div_core_shift) |
> > +                      HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
> > +                      cpuclk->reg_base + reg_data->core_reg);
> > +       } else {
> > +               /* select alternate parent */
> > +               writel(HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
> > +                       cpuclk->reg_base + reg_data->core_reg);
> > +       }
> > +
> > +       /* alternate parent is active now. set the dividers */
> > +       for (i = 0; i < ARRAY_SIZE(rate->divs); i++) {
> > +               const struct rockchip_cpuclk_clksel *clksel =
> > &rate->divs[i]; +
> > +               if (!clksel->reg)
> > +                       continue;
> > +
> > +               pr_debug("%s: setting reg 0x%x to 0x%x\n",
> > +                        __func__, clksel->reg, clksel->val);
> > +               writel(clksel->val , cpuclk->reg_base + clksel->reg);
> > +       }
> 
> I'm not 100% certain that you can always set the dividers here and
> still be safe.
> 
> Let's imagine that we're going 800MHz => 300MHz.  Let's say that we
> have "divide by 3" for 800Mhz and "divide by 1" for 300Mhz.  Let's say
> that the alternate PLL is 500Mhz.
> 
> ...so at this point in the transition we've switched to the alternate
> PLL (500Mhz) but we're now setting the dividers for 300MHz.  That
> doesn't seem quite right.

So setting dividers here when increasing the rate and in the post_rate notifier 
when lowering the rate?

I think the samsung cpuclk had the same discussion at some point, but am not 
sure what the outcome was.


> I also _think_ that these dividers are based on the PLL, not based on
> the armclock, right.  In other words:
> 
> 200MHz -> 300MHz with 500Mhz alternate PLL will do:
> 
> 1. Switch core PLL to 500MHz alt with "div by 3", so 166MHz arm clock.  OK.
> 
> 2. ...but the "div by 3" doesn't apply to MP AXI clock divider, M0 AXI
> clock divider, etc.  That means _those_ are now based on 500MHz and
> are now running faster than they were.
> 

Nope, the dividers are clocks that are really children of the armclk. In the 
rk3288 trm on page 44 you can see the mux from apll and gpll, followed by the 
divider we use to keep the temporary rate below the old apll rate.

The result of this is then supplied to the armclk [*] and the tightly bound 
clocks. So the "div by 3" when using the alternate parent will be used by both 
the arm-cores as well as the dependent clocks.



[*] There is a slight variance between rk3288 and the Cortex-A9 SoCs. On 
rk3188 and before the result of the mux+divider described above are fed 
directly and unmodified to the arm cores, while the core clocks on rk3288 could 
use another divider on a per-core basis (see clk_core0..clk_core3 on the page 
44 cited above).

But it also doesn't matter much for this, as the coupled clocks are dependent 
on the shared parent of clk_coreX.


> 
> None of that terribly matters for rk3288 which (currently) has the
> same dividers for every rate point, but it seems like it might be
> relevant for 3066 and 3188.  ...or if they ever need to change
> dividers for rk3288.
> 
> > +
> > +       spin_unlock(cpuclk->lock);
> > +       return 0;
> > +}
> > +
> > +static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk
> > *cpuclk, +                                           struct
> > clk_notifier_data *ndata) +{
> > +       const struct rockchip_cpuclk_reg_data *reg_data =
> > cpuclk->reg_data;
> > +
> > +       spin_lock(cpuclk->lock);
> > +
> > +       /*
> > +        * post-rate change event, re-mux to primary parent and remove
> > dividers. +        *
> > +        * NOTE: we do this in a single transaction so we're never
> > dividing the +        * primary parent by the extra dividers that were
> > needed for the alt. +        */
> > +
> > +       writel(HIWORD_UPDATE(0, reg_data->div_core_mask,
> > +                               reg_data->div_core_shift) |
> > +              HIWORD_UPDATE(0, 1, reg_data->mux_core_shift),
> > +              cpuclk->reg_base + reg_data->core_reg);
> > +
> > +       spin_unlock(cpuclk->lock);
> > +       return 0;
> > +}
> > +
> > +/*
> > + * This clock notifier is called when the frequency of the parent clock
> > + * of cpuclk is to be changed. This notifier handles the setting up all
> > + * the divider clocks, remux to temporary parent and handling the safe
> > + * frequency levels when using temporary parent.
> > + */
> > +static int rockchip_cpuclk_notifier_cb(struct notifier_block *nb,
> > +                                       unsigned long event, void *data)
> > +{
> > +       struct clk_notifier_data *ndata = data;
> > +       struct rockchip_cpuclk *cpuclk = to_rockchip_cpuclk_nb(nb);
> > +       int ret = 0;
> > +
> > +       pr_debug("%s: event %lu, old_rate %lu, new_rate: %lu\n",
> > +                __func__, event, ndata->old_rate, ndata->new_rate);
> > +       if (event == PRE_RATE_CHANGE)
> > +               ret = rockchip_cpuclk_pre_rate_change(cpuclk, ndata);
> > +       else if (event == POST_RATE_CHANGE)
> > +               ret = rockchip_cpuclk_post_rate_change(cpuclk, ndata);
> > +
> > +       return notifier_from_errno(ret);
> > +}
> > +
> > +struct clk *rockchip_clk_register_cpuclk(const char *name,
> > +                       const char **parent_names, u8 num_parents,
> > +                       const struct rockchip_cpuclk_reg_data *reg_data,
> > +                       struct rockchip_cpuclk_rate_table *rate_table,
> > +                       void __iomem *reg_base, spinlock_t *lock)
> > +{
> > +       struct rockchip_cpuclk *cpuclk;
> > +       struct clk_init_data init;
> > +       struct clk *clk, *cclk;
> > +       int ret;
> > +
> > +       if (!reg_data) {
> > +               pr_err("%s: no soc register information\n", __func__);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> 
> Do we really think it likely that we'll get passed a NULL reg_data?
> 
> > +
> > +       if (num_parents != 2) {
> > +               pr_err("%s: needs two parent clocks\n", __func__);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> 
> I guess this is just future proofing things?  I notice that the most
> recently posted exynos driver just takes two strings, the main parent
> and an alternate parent.  That does seem slightly cleaner.

As the regular clock register functions use the parent_names, num_parents form 
it somehow seemed cleaner to me to continue this, but I don't have a hard 
preference here.


> 
> > +
> > +       cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
> > +       if (!cpuclk)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       init.name = name;
> > +       init.parent_names = &parent_names[0];
> > +       init.num_parents = 1;
> > +       init.ops = &rockchip_cpuclk_ops;
> > +
> > +       /* only allow rate changes when we have a rate table */
> > +       init.flags = rate_table ? CLK_SET_RATE_PARENT : 0;
> > +
> > +       /* disallow automatic parent changes by ccf */
> > +       init.flags |= CLK_SET_RATE_NO_REPARENT;
> > +
> > +       init.flags |= CLK_GET_RATE_NOCACHE;
> > +
> > +       cpuclk->reg_base = reg_base;
> > +       cpuclk->lock = lock;
> > +       cpuclk->reg_data = reg_data;
> > +       cpuclk->clk_nb.notifier_call = rockchip_cpuclk_notifier_cb;
> > +       cpuclk->hw.init = &init;
> > +
> > +       cpuclk->alt_parent = __clk_lookup(parent_names[1]);
> > +       if (!cpuclk->alt_parent) {
> > +               pr_err("%s: could not lookup alternate parent\n",
> > +                      __func__);
> > +               ret = -EINVAL;
> > +               goto free_cpuclk;
> > +       }
> > +
> > +       ret = clk_prepare_enable(cpuclk->alt_parent);
> > +       if (ret) {
> > +               pr_err("%s: could not enable alternate parent\n",
> > +                      __func__);
> > +               goto free_cpuclk;
> > +       }
> > +
> > +       clk = __clk_lookup(parent_names[0]);
> > +       if (!clk) {
> > +               pr_err("%s: could not lookup parent clock %s\n",
> > +                      __func__, parent_names[0]);
> > +               ret = -EINVAL;
> > +               goto free_cpuclk;
> > +       }
> > +
> > +       ret = clk_notifier_register(clk, &cpuclk->clk_nb);
> > +       if (ret) {
> > +               pr_err("%s: failed to register clock notifier for %s\n",
> > +                               __func__, name);
> > +               goto free_cpuclk;
> > +       }
> > +
> > +       if (rate_table) {
> > +               int nrates;
> > +
> > +               /* find count of rates in rate_table */
> > +               for (nrates = 0; rate_table[nrates].prate != 0; )
> > +                       nrates++;
> > +
> > +               cpuclk->rate_count = nrates;
> > +               cpuclk->rate_table = kmemdup(rate_table,
> > +                                            sizeof(*rate_table) * nrates,
> > +                                            GFP_KERNEL);
> 
> Ah, I think I see what Derek was saying earlier.  It's a little
> awkward that you pass this in as a table with a sentinel at the end
> and then at runtime convert it to an array with a stored length.
> Given that all of these are compiled-in tables, it wouldn't be crazy
> to just pass in nrates (which is just ARRAY_SIZE in all callers) and
> get rid of the sentinel.  ...but I won't insist on it.

This would also be true for the pll rate tables then ... mixing concepts 
between such tables in clock drivers would be strange somehow.

I guess this was originally simply getting a lot of inpsiration from the 
samsung pll-clock driver, which does use the same style (including the 
copying). Not sure if there was a rationale behind the original.

Interestingly (I just looked it up) the new samsung cpuclk uses the rates + 
nrates approach.

So I guess I would be ok with using the other approach as well :-)


Heiko
