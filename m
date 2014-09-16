From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Sep 2014 17:49:01 -0700
Subject: [PATCH v2 5/7] clk: rockchip: add new clock-type for the cpuclk
In-Reply-To: <CAD=FV=XJEL1QDRHUGL=g5BKEhLWve0uUko7ZH=dM7btWkU4+1w@mail.gmail.com>
References: <1410561030-19127-1-git-send-email-heiko@sntech.de>
 <1410561030-19127-6-git-send-email-heiko@sntech.de>
 <CAD=FV=XJEL1QDRHUGL=g5BKEhLWve0uUko7ZH=dM7btWkU4+1w@mail.gmail.com>
Message-ID: <CAD=FV=XiPd7AFj1YCb4WdR5FU2YQ4tDbZ2FYMz3MFDu8wyKawQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 15, 2014 at 4:58 PM, Doug Anderson <dianders@chromium.org> wrote:
> Heiko,
>
> On Fri, Sep 12, 2014 at 3:30 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>> When changing the armclk on Rockchip SoCs it is supposed to be reparented
>> to an alternate parent before changing the underlying pll and back after
>> the change. Additionally there exist clocks that are very tightly bound to
>> the armclk whose divider values are set according to the armclk rate.
>>
>> Add a special clock-type to handle all that. The rate table and divider
>> values will be supplied from the soc-specific clock controllers.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  drivers/clk/rockchip/Makefile  |   1 +
>>  drivers/clk/rockchip/clk-cpu.c | 316 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/rockchip/clk.c     |  20 +++
>>  drivers/clk/rockchip/clk.h     |  36 +++++
>>  4 files changed, 373 insertions(+)
>>  create mode 100644 drivers/clk/rockchip/clk-cpu.c
>>
>> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
>> index ee6b077..bd8514d 100644
>> --- a/drivers/clk/rockchip/Makefile
>> +++ b/drivers/clk/rockchip/Makefile
>> @@ -5,6 +5,7 @@
>>  obj-y  += clk-rockchip.o
>>  obj-y  += clk.o
>>  obj-y  += clk-pll.o
>> +obj-y  += clk-cpu.o
>>  obj-$(CONFIG_RESET_CONTROLLER) += softrst.o
>>
>>  obj-y  += clk-rk3188.o
>> diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
>> new file mode 100644
>> index 0000000..b8382b1
>> --- /dev/null
>> +++ b/drivers/clk/rockchip/clk-cpu.c
>> @@ -0,0 +1,316 @@
>> +/*
>> + * Copyright (c) 2014 MundoReader S.L.
>> + * Author: Heiko Stuebner <heiko@sntech.de>
>> + *
>> + * based on clk/samsung/clk-cpu.c
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + * Author: Thomas Abraham <thomas.ab@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This file contains the utility function to register CPU clock for Samsung
>> + * Exynos platforms. A CPU clock is defined as a clock supplied to a CPU or a
>> + * group of CPUs. The CPU clock is typically derived from a hierarchy of clock
>> + * blocks which includes mux and divider blocks. There are a number of other
>> + * auxiliary clocks supplied to the CPU domain such as the debug blocks and AXI
>> + * clock for CPU domain. The rates of these auxiliary clocks are related to the
>> + * CPU clock rate and this relation is usually specified in the hardware manual
>> + * of the SoC or supplied after the SoC characterization.
>> + *
>> + * The below implementation of the CPU clock allows the rate changes of the CPU
>> + * clock and the corresponding rate changes of the auxillary clocks of the CPU
>> + * domain. The platform clock driver provides a clock register configuration
>> + * for each configurable rate which is then used to program the clock hardware
>> + * registers to acheive a fast co-oridinated rate change for all the CPU domain
>> + * clocks.
>> + *
>> + * On a rate change request for the CPU clock, the rate change is propagated
>> + * upto the PLL supplying the clock to the CPU domain clock blocks. While the
>> + * CPU domain PLL is reconfigured, the CPU domain clocks are driven using an
>> + * alternate clock source. If required, the alternate clock source is divided
>> + * down in order to keep the output clock rate within the previous OPP limits.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/clk-provider.h>
>> +#include "clk.h"
>> +
>> +/**
>> + * struct rockchip_cpuclk: information about clock supplied to a CPU core.
>> + * @hw:                handle between ccf and cpu clock.
>> + * @alt_parent:        alternate parent clock to use when switching the speed
>> + *             of the primary parent clock.
>> + * @reg_base:  base register for cpu-clock values.
>> + * @clk_nb:    clock notifier registered for changes in clock speed of the
>> + *             primary parent clock.
>> + * @rate_count:        number of rates in the rate_table
>> + * @rate_table:        pll-rates and their associated dividers
>> + * @reg_data:  cpu-specific register settings
>> + * @lock:      clock lock
>> + */
>> +struct rockchip_cpuclk {
>> +       struct clk_hw                           hw;
>> +
>> +       struct clk_mux                          cpu_mux;
>> +       const struct clk_ops                    *cpu_mux_ops;
>> +
>> +       struct clk                              *alt_parent;
>> +       void __iomem                            *reg_base;
>> +       struct notifier_block                   clk_nb;
>> +       unsigned int                            rate_count;
>> +       struct rockchip_cpuclk_rate_table       *rate_table;
>> +       const struct rockchip_cpuclk_reg_data   *reg_data;
>> +       spinlock_t                              *lock;
>> +};
>> +
>> +#define to_rockchip_cpuclk_hw(hw) container_of(hw, struct rockchip_cpuclk, hw)
>> +#define to_rockchip_cpuclk_nb(nb) \
>> +                       container_of(nb, struct rockchip_cpuclk, clk_nb)
>> +
>> +static const struct rockchip_cpuclk_rate_table *rockchip_get_cpuclk_settings(
>> +                           struct rockchip_cpuclk *cpuclk, unsigned long rate)
>> +{
>> +       const struct rockchip_cpuclk_rate_table *rate_table =
>> +                                                       cpuclk->rate_table;
>> +       int i;
>> +
>> +       for (i = 0; i < cpuclk->rate_count; i++) {
>> +               if (rate == rate_table[i].prate)
>> +                       return &rate_table[i];
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static unsigned long rockchip_cpuclk_recalc_rate(struct clk_hw *hw,
>> +                                       unsigned long parent_rate)
>> +{
>> +       struct rockchip_cpuclk *cpuclk = to_rockchip_cpuclk_hw(hw);
>> +       const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
>> +       u32 clksel0 = readl_relaxed(cpuclk->reg_base + reg_data->core_reg);
>> +
>> +       clksel0 >>= reg_data->div_core_shift;
>> +       clksel0 &= reg_data->div_core_mask;
>> +       return parent_rate / (clksel0 + 1);
>> +}
>> +
>> +static const struct clk_ops rockchip_cpuclk_ops = {
>> +       .recalc_rate = rockchip_cpuclk_recalc_rate,
>> +};
>> +
>> +static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
>> +                                          struct clk_notifier_data *ndata)
>> +{
>> +       const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
>> +       const struct rockchip_cpuclk_rate_table *rate;
>> +       unsigned long alt_prate, alt_div;
>> +       int i;
>> +
>> +       rate = rockchip_get_cpuclk_settings(cpuclk, ndata->new_rate);
>> +       if (!rate) {
>> +               pr_err("%s: Invalid rate : %lu for cpuclk\n",
>> +                      __func__, ndata->new_rate);
>> +               return -EINVAL;
>> +       }
>> +
>> +       alt_prate = clk_get_rate(cpuclk->alt_parent);
>> +
>> +       spin_lock(cpuclk->lock);
>> +
>> +       /*
>> +        * If the old parent clock speed is less than the clock speed
>> +        * of the alternate parent, then it should be ensured that at no point
>> +        * the armclk speed is more than the old_rate until the dividers are
>> +        * set.
>> +        */
>> +       if (alt_prate > ndata->old_rate) {
>> +               alt_div =  DIV_ROUND_UP(alt_prate, ndata->old_rate) - 1;
>> +               if (alt_div > reg_data->div_core_mask) {
>> +                       pr_warn("%s: limiting alt-divider %lu to %d\n",
>> +                               __func__, alt_div, reg_data->div_core_mask);
>> +                       alt_div = reg_data->div_core_mask;
>> +               }
>> +
>> +               pr_debug("%s: setting div %lu as alt-rate %lu > old-rate %lu\n",
>> +                        __func__, alt_div, alt_prate, ndata->old_rate);
>> +               writel_relaxed(HIWORD_UPDATE(alt_div,
>> +                                            reg_data->div_core_mask,
>> +                                            reg_data->div_core_shift),
>> +                             cpuclk->reg_base + reg_data->core_reg);
>> +       }
>> +
>> +       /* select alternate parent */
>> +       writel(HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
>> +              cpuclk->reg_base + reg_data->core_reg);
>
> In the "alt_prate > ndata->old_rate" case there's a period of time
> where you can be running super slow.
>
> If we start as 126000 and we're going to switch to 594000, we decide
> we need a divide by 5.  We apply the divide by 5 in one statement and
> switch to 594MHz in a second statement.  That means there's a very
> short period of time where we're at 126000 / 5 = 25200.  That's 25MHz.
>
> I've found that when I stress out CPUfreq and have a lot of interrupts
> coming in (like from USB) the my system hangs here.
>
> Since the "alt div" and reparenting touch the same register, I think
> we can do them in a single operation.  That works for me.
>
> ...but something isn't adding up for me, so I'm hesitant to suggest
> this.  Somehow I only end up with the hang here and not down in the
> post_rate_change().  I'll keep debugging...  It strangely enough seems
> related to the rockchip_pll_notifier_cb()???

Oh.  Out of time to debug again, but it almost looks like we go down
to the 24MHz clock in rockchip_pll_notifier_cb().  Then we do a / 5 on
that.  ...so it's not 25MHz that we're running at.  It's 5.

I'll do more to confirm / debug tomorrow.

-Doug
