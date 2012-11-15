From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 15 Nov 2012 11:25:55 +0100
Subject: [PATCH v3 01/11] clk: samsung: add common clock framework helper
 functions for Samsung platforms
In-Reply-To: <CAJuYYwR=9Gx5kx-JwVNUaa8Tej-3NG03U4zbYBKr36rPAOtPvw@mail.gmail.com>
References: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
 <3129811.yIGKilgVGz@flatron>
 <CAJuYYwR=9Gx5kx-JwVNUaa8Tej-3NG03U4zbYBKr36rPAOtPvw@mail.gmail.com>
Message-ID: <1419971.gveAuG3NSW@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 of November 2012 14:03:12 Thomas Abraham wrote:
> Hi Tomasz,
> 
> Thanks for reviewing these patches!
> 
> On 15 November 2012 04:42, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > Hi Thomas,
> > 
> > Looks mostly good, but I have some minor comments inline.
> > 
> > On Thursday 15 of November 2012 03:37:23 Thomas Abraham wrote:
> >> All Samsung platforms include different types of clock including
> >> fixed-rate, mux, divider and gate clock types. There are typically
> >> hundreds of such clocks on each of the Samsung platforms. To enable
> >> Samsung platforms to register these clocks using the common clock
> >> framework, a bunch of utility functions are introduced here which
> >> simplify the clock registration process. The clocks are usually
> >> statically instantiated and registered with common clock framework.
> >> 
> >> Cc: Mike Turquette <mturquette@linaro.org>
> >> Cc: Kukjin Kim <kgene.kim@samsung.com>
> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> >> ---
> >> 
> >>  drivers/clk/Makefile         |    1 +
> >>  drivers/clk/samsung/Makefile |    5 +
> >>  drivers/clk/samsung/clk.c    |  176
> >>  ++++++++++++++++++++++++++++++++++
> >>  drivers/clk/samsung/clk.h    |  218
> >> 
> >> ++++++++++++++++++++++++++++++++++++++++++ 4 files changed, 400
> >> insertions(+), 0 deletions(-)
> >> 
> >>  create mode 100644 drivers/clk/samsung/Makefile
> >>  create mode 100644 drivers/clk/samsung/clk.c
> >>  create mode 100644 drivers/clk/samsung/clk.h
> >> 
> >> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> >> index 2701235..808f8e1 100644
> >> --- a/drivers/clk/Makefile
> >> +++ b/drivers/clk/Makefile
> >> @@ -19,6 +19,7 @@ endif
> >> 
> >>  obj-$(CONFIG_MACH_LOONGSON1) += clk-ls1x.o
> >>  obj-$(CONFIG_ARCH_U8500)     += ux500/
> >>  obj-$(CONFIG_ARCH_VT8500)    += clk-vt8500.o
> >> 
> >> +obj-$(CONFIG_PLAT_SAMSUNG)   += samsung/
> >> 
> >>  # Chip specific
> >>  obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
> >> 
> >> diff --git a/drivers/clk/samsung/Makefile
> >> b/drivers/clk/samsung/Makefile new file mode 100644
> >> index 0000000..3f926b0
> >> --- /dev/null
> >> +++ b/drivers/clk/samsung/Makefile
> >> @@ -0,0 +1,5 @@
> >> +#
> >> +# Samsung Clock specific Makefile
> >> +#
> >> +
> >> +obj-$(CONFIG_PLAT_SAMSUNG)   += clk.o
> >> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> >> new file mode 100644
> >> index 0000000..ebc6fb6
> >> --- /dev/null
> >> +++ b/drivers/clk/samsung/clk.c
> >> @@ -0,0 +1,176 @@
> >> +/*
> >> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> >> + * Copyright (c) 2012 Linaro Ltd.
> >> + * Author: Thomas Abraham <thomas.ab@samsung.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> modify + * it under the terms of the GNU General Public License
> >> version 2 as + * published by the Free Software Foundation.
> >> + *
> >> + * This file includes utility functions to register clocks to common
> >> + * clock framework for Samsung platforms.
> >> +*/
> >> +
> >> +#include "clk.h"
> >> +
> >> +static DEFINE_SPINLOCK(lock);
> >> +static struct clk **clk_table;
> >> +static struct clk_onecell_data clk_data;
> >> +void __iomem *reg_base;
> > 
> > Shouldn't it be static?
> 
> Yes, I missed that. Will fix.
> 
> >> +
> >> +/* setup the essentials required to support clock lookup using ccf
> >> */
> >> +void __init samsung_clk_init(struct device_node *np, void __iomem
> >> *base, +                              unsigned long nr_clks)
> >> +{
> >> +     reg_base = base;
> >> +     if (!np)
> >> +             return;
> >> +
> >> +     clk_table = kzalloc(sizeof(struct clk *) * nr_clks,
> >> GFP_KERNEL);
> >> +     if (!clk_table)
> >> +             panic("could not allocate clock lookup table\n");
> >> +
> >> +     clk_data.clks = clk_table;
> >> +     clk_data.clk_num = nr_clks;
> >> +     of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> >> +}
> >> +
> >> +/* add a clock instance to the clock lookup table used for dt based
> >> lookup */ +void samsung_clk_add_lookup(struct clk *clk, unsigned int
> >> id) +{
> >> +     if (clk_table && id)
> > 
> > I'm not sure if we really need this kind of checks, but if we do, then
> > shouldn't we also check id against clk_data.clk_num to prevent out of
> > bound index?
> 
> The entry into the lookup table is required only for device tree based
> platforms. And clk_table is a dynamically allocated table if booting
> with device tree support. Since the call to samsung_clk_add_lookup is
> made for non-dt platforms as well, the check for clk_table ensures
> that the entry to lookup table is done only for device tree enabled
> platforms. The check for 'id' ensures that the lookup entry index 0 is
> not used. There is no clock which has id as 0.
> 
> >> +             clk_table[id] = clk;
> >> +}
> >> +
> >> +/* register a list of fixed clocks */
> >> +void __init samsung_clk_register_fixed_rate(
> >> +             struct samsung_fixed_rate_clock *list, unsigned int
> >> nr_clk) +{
> >> +     struct clk *clk;
> >> +     unsigned int idx, ret;
> >> +
> >> +     for (idx = 0; idx < nr_clk; idx++, list++) {
> >> +             clk = clk_register_fixed_rate(NULL, list->name,
> >> +                     list->parent_name, list->flags,
> >> list->fixed_rate); +             if (IS_ERR(clk)) {
> >> +                     pr_err("%s: failed to register clock %s\n",
> >> __func__, +                             list->name);
> >> +                     continue;
> >> +             }
> >> +
> >> +             samsung_clk_add_lookup(clk, list->id);
> >> +
> >> +             /*
> >> +              * Unconditionally add a clock lookup for the fixed
> >> rate
> > 
> > clocks.
> > 
> >> +              * There are not many of these on any of Samsung
> >> platforms. +              */
> >> +             ret = clk_register_clkdev(clk, list->name, NULL);
> >> +             if (ret)
> >> +                     pr_err("%s: failed to register clock lookup for
> >> %s", +                             __func__, list->name);
> >> +     }
> >> +}
> >> +
> >> +/* register a list of mux clocks */
> >> +void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
> >> +                                     unsigned int nr_clk)
> >> +{
> >> +     struct clk *clk;
> >> +     unsigned int idx, ret;
> >> +
> >> +     for (idx = 0; idx < nr_clk; idx++, list++) {
> >> +             clk = clk_register_mux(NULL, list->name,
> >> list->parent_names, +                     list->num_parents,
> >> list->flags, reg_base + list->offset, +                    
> >> list->shift, list->width, list->mux_flags, &lock); +             if
> >> (IS_ERR(clk)) {
> >> +                     pr_err("%s: failed to register clock %s\n",
> >> __func__, +                             list->name);
> >> +                     continue;
> >> +             }
> >> +
> >> +             samsung_clk_add_lookup(clk, list->id);
> >> +
> >> +             /* register a clock lookup only if a clock alias is
> >> specified> 
> > */
> > 
> >> +             if (list->alias) {
> >> +                     ret = clk_register_clkdev(clk, list->alias,
> >> +                                             list->dev_name);
> >> +                     if (ret)
> >> +                             pr_err("%s: failed to register lookup
> >> %s\n", +                                             __func__,
> >> list->alias); +             }
> >> +     }
> >> +}
> >> +
> >> +/* register a list of div clocks */
> >> +void __init samsung_clk_register_div(struct samsung_div_clock *list,
> >> +                                     unsigned int nr_clk)
> >> +{
> >> +     struct clk *clk;
> >> +     unsigned int idx, ret;
> >> +
> >> +     for (idx = 0; idx < nr_clk; idx++, list++) {
> >> +             clk = clk_register_divider(NULL, list->name, list-
> >>
> >>parent_name,
> >>
> >> +                     list->flags, reg_base + list->offset,
> >> list->shift, +                     list->width, list->div_flags,
> >> &lock);
> >> +             if (IS_ERR(clk)) {
> >> +                     pr_err("clock: failed to register clock %s\n",
> >> +                             list->name);
> >> +                     continue;
> >> +             }
> >> +
> >> +             samsung_clk_add_lookup(clk, list->id);
> >> +
> >> +             /* register a clock lookup only if a clock alias is
> >> specified> 
> > */
> > 
> >> +             if (list->alias) {
> >> +                     ret = clk_register_clkdev(clk, list->alias,
> >> +                                             list->dev_name);
> >> +                     if (ret)
> >> +                             pr_err("%s: failed to register lookup
> >> %s\n", +                                             __func__,
> >> list->alias); +             }
> >> +     }
> >> +}
> >> +
> >> +/* register a list of gate clocks */
> >> +void __init samsung_clk_register_gate(struct samsung_gate_clock
> >> *list,
> >> +                                             unsigned int nr_clk)
> >> +{
> >> +     struct clk *clk;
> >> +     unsigned int idx, ret;
> >> +
> >> +     for (idx = 0; idx < nr_clk; idx++, list++) {
> >> +             clk = clk_register_gate(NULL, list->name,
> >> list->parent_name, +                             list->flags,
> >> reg_base + list->offset, +                            
> >> list->bit_idx, list->gate_flags, &lock); +             if
> >> (IS_ERR(clk)) {
> >> +                     pr_err("clock: failed to register clock %s\n",
> >> +                             list->name);
> >> +                     continue;
> >> +             }
> >> +
> >> +             /* register a clock lookup only if a clock alias is
> >> specified> 
> > */
> > 
> >> +             if (list->alias) {
> >> +                     ret = clk_register_clkdev(clk, list->alias,
> >> +                                                    
> >> list->dev_name);
> >> +                     if (ret)
> >> +                             pr_err("%s: failed to register lookup
> >> %s\n", +                                     __func__, list->alias);
> >> +             }
> >> +
> >> +             samsung_clk_add_lookup(clk, list->id);
> >> +     }
> >> +}
> >> +
> >> +/* utility function to get the rate of a specified clock */
> >> +unsigned long _get_rate(const char *clk_name)
> >> +{
> >> +     struct clk *clk;
> >> +     unsigned long rate;
> >> +
> >> +     clk = clk_get(NULL, clk_name);
> >> +     if (IS_ERR(clk))
> >> +             return 0;
> >> +     rate = clk_get_rate(clk);
> >> +     clk_put(clk);
> >> +     return rate;
> >> +}
> >> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> >> new file mode 100644
> >> index 0000000..ab43498
> >> --- /dev/null
> >> +++ b/drivers/clk/samsung/clk.h
> >> @@ -0,0 +1,218 @@
> >> +/*
> >> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> >> + * Copyright (c) 2012 Linaro Ltd.
> >> + * Author: Thomas Abraham <thomas.ab@samsung.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> modify + * it under the terms of the GNU General Public License
> >> version 2 as + * published by the Free Software Foundation.
> >> + *
> >> + * Common Clock Framework support for all Samsung platforms
> >> +*/
> >> +
> >> +#ifndef __SAMSUNG_CLK_H
> >> +#define __SAMSUNG_CLK_H
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/clkdev.h>
> >> +#include <linux/io.h>
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +
> >> +#include <mach/map.h>
> >> +
> >> +/**
> >> + * struct samsung_fixed_rate_clock: information about fixed-rate
> >> clock
> >> + * @id: platform specific id of the clock.
> >> + * @name: name of this fixed-rate clock.
> >> + * @parent_name: optional parent clock name.
> >> + * @flags: optional fixed-rate clock flags.
> >> + * @fixed-rate: fixed clock rate of this clock.
> >> + */
> >> +struct samsung_fixed_rate_clock {
> >> +     unsigned int            id;
> >> +     char                    *name;
> > 
> > Shouldn't it be const char *name?
> 
> Yes, I will fix this.
> 
> >> +     const char              *parent_name;
> >> +     unsigned long           flags;
> >> +     unsigned long           fixed_rate;
> >> +};
> >> +
> >> +#define FRATE(_id, cname, pname, f, frate)   \
> >> +     {                                               \
> >> +             .id             = _id,                  \
> >> +             .name           = cname,                \
> >> +             .parent_name    = pname,                \
> >> +             .flags          = f,                    \
> >> +             .fixed_rate     = frate,                \
> >> +     }
> >> +
> >> +/**
> >> + * struct samsung_mux_clock: information about mux clock
> >> + * @id: platform specific id of the clock.
> >> + * @dev_name: name of the device to which this clock belongs.
> >> + * @name: name of this mux clock.
> >> + * @parent_names: array of pointer to parent clock names.
> >> + * @num_parents: number of parents listed in @parent_names.
> >> + * @flags: optional flags for basic clock.
> >> + * @offset: offset of the register for configuring the mux.
> >> + * @shift: starting bit location of the mux control bit-field in
> >> @reg.
> >> + * @width: width of the mux control bit-field in @reg.
> >> + * @mux_flags: flags for mux-type clock.
> >> + * @alias: optional clock alias name to be assigned to this clock.
> >> + */
> >> +struct samsung_mux_clock {
> >> +     const unsigned int      id;
> > 
> > Is const unsigned int really correct?
> 
> Sorry, I did not get the problem here.

Basically this const does not give us anything, while it could make 
problems in future.

Let's say that one would want to register a clock in runtime, dynamically 
allocating a samsung_*_clock structure. It wouldn't be possible, because 
he wouldn't be able to set the id field.

Instead of making particular fields in the structures constant, I would 
prefer making the arrays of these structures constant, as they are 
statically initialized anyway.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
