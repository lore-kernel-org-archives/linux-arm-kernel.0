From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 18 Apr 2013 13:22:10 -0700
Subject: [PATCH] clk: vexpress: Add separate SP810 driver
In-Reply-To: <1366305802.3077.37.camel@hornet>
References: <1363358409-5693-1-git-send-email-pawel.moll@arm.com>
 <20130417222630.19887.75481@quantum> <1366305802.3077.37.camel@hornet>
Message-ID: <20130418202210.22729.13362@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pawel Moll (2013-04-18 10:23:22)
> On Wed, 2013-04-17 at 23:26 +0100, Mike Turquette wrote:
> > In this case you are using clk_prepare for one-time configuration.  I
> > agree that no alternative exists yet, but there have been discussions
> > recently about using DT for configuration details that are not strictly
> > descriptions of the hardware.  I've added a comment block in the patch
> > below which notes this with a FIXME since there isn't a graceful
> > alternative to using clk_prepare for ont-time configuration.
> 
> Fair enough.
> 
> > Can you test the patch below against the latest clk-next and let me know
> > if it working on your platform?
> 
> It wasn't:
> 
> WARNING: at [...]/drivers/clk/clk.c:808 __clk_enable+0x94/0xa0()
> 
> because the new parent is not prepared automagically. This simple change
> heals the problem and now everything is just fine:
> 
>         /* Switch the parent if necessary */
> -       if (old_parent != new_parent)
> +       if (old_parent != new_parent) {
> +               clk_prepare(new_parent);
>                 clk_set_parent(hw->clk, new_parent);
> +               clk_unprepare(old_parent);
> +       }
> 
> So, to summarize, the patch that works for me is below.
> 

Ah yes, that's a bit tricky.  All of the parents of the sp810 clk will
have prepare_count >= 1, but not the sp810 clk itself when this code is
executed.  Otherwise clk_set_prepare would have migrated the
prepare_count(s) over automagically.  Another reason to revisit this
code some day.

I've gone ahead and merged the patch below.

Thanks!
Mike

> Thanks for you help!
> 
> Pawel
> 
> 8<--------------------------------
> From 58807cc1930edd092f1bc54b2ec381ddc9209671 Mon Sep 17 00:00:00 2001
> From: Pawel Moll <pawel.moll@arm.com>
> Date: Thu, 18 Apr 2013 18:20:54 +0100
> Subject: [PATCH] clk: vexpress: Add separate SP810 driver
> 
> Factor out the SP810 clocking code into a separate driver,
> selecting better (faster) parent at clk_prepare() time.
> This is to avoid problems with clocking infrastructure
> initialisation order, in particular to avoid dependency
> of fixed clock being initialized before SP810. It also
> makes vexpress platform OF-based clock initialisation code
> unnecessary.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> [mturquette at linaro.org: add .unprepare, FIXME comment, cleaned up code]
> ---
>  arch/arm/mach-vexpress/v2m.c         |    8 +-
>  drivers/clk/versatile/Makefile       |    2 +-
>  drivers/clk/versatile/clk-sp810.c    |  188 ++++++++++++++++++++++++++++++++++
>  drivers/clk/versatile/clk-vexpress.c |   49 ---------
>  4 files changed, 196 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/clk/versatile/clk-sp810.c
> 
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 915683c..c5e20b5 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -21,6 +21,8 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/vexpress.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
>  
>  #include <asm/arch_timer.h>
>  #include <asm/mach-types.h>
> @@ -433,7 +435,7 @@ static void __init v2m_dt_timer_init(void)
>  {
>         struct device_node *node = NULL;
>  
> -       vexpress_clk_of_init();
> +       of_clk_init(NULL);
>  
>         do {
>                 node = of_find_compatible_node(node, NULL, "arm,sp804");
> @@ -441,6 +443,10 @@ static void __init v2m_dt_timer_init(void)
>         if (node) {
>                 pr_info("Using SP804 '%s' as a clock & events source\n",
>                                 node->full_name);
> +               WARN_ON(clk_register_clkdev(of_clk_get_by_name(node,
> +                               "timclken1"), "v2m-timer0", "sp804"));
> +               WARN_ON(clk_register_clkdev(of_clk_get_by_name(node,
> +                               "timclken2"), "v2m-timer1", "sp804"));
>                 v2m_sp804_init(of_iomap(node, 0),
>                                 irq_of_parse_and_map(node, 0));
>         }
> diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
> index ec3b88f..c16ca78 100644
> --- a/drivers/clk/versatile/Makefile
> +++ b/drivers/clk/versatile/Makefile
> @@ -3,5 +3,5 @@ obj-$(CONFIG_ICST)              += clk-icst.o
>  obj-$(CONFIG_ARCH_INTEGRATOR)  += clk-integrator.o
>  obj-$(CONFIG_INTEGRATOR_IMPD1) += clk-impd1.o
>  obj-$(CONFIG_ARCH_REALVIEW)    += clk-realview.o
> -obj-$(CONFIG_ARCH_VEXPRESS)    += clk-vexpress.o
> +obj-$(CONFIG_ARCH_VEXPRESS)    += clk-vexpress.o clk-sp810.o
>  obj-$(CONFIG_VEXPRESS_CONFIG)  += clk-vexpress-osc.o
> diff --git a/drivers/clk/versatile/clk-sp810.c b/drivers/clk/versatile/clk-sp810.c
> new file mode 100644
> index 0000000..bf9b15a
> --- /dev/null
> +++ b/drivers/clk/versatile/clk-sp810.c
> @@ -0,0 +1,188 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2013 ARM Limited
> + */
> +
> +#include <linux/amba/sp810.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define to_clk_sp810_timerclken(_hw) \
> +               container_of(_hw, struct clk_sp810_timerclken, hw)
> +
> +struct clk_sp810;
> +
> +struct clk_sp810_timerclken {
> +       struct clk_hw hw;
> +       struct clk *clk;
> +       struct clk_sp810 *sp810;
> +       int channel;
> +};
> +
> +struct clk_sp810 {
> +       struct device_node *node;
> +       int refclk_index, timclk_index;
> +       void __iomem *base;
> +       spinlock_t lock;
> +       struct clk_sp810_timerclken timerclken[4];
> +       struct clk *refclk;
> +       struct clk *timclk;
> +};
> +
> +static u8 clk_sp810_timerclken_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
> +       u32 val = readl(timerclken->sp810->base + SCCTRL);
> +
> +       return !!(val & (1 << SCCTRL_TIMERENnSEL_SHIFT(timerclken->channel)));
> +}
> +
> +static int clk_sp810_timerclken_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
> +       struct clk_sp810 *sp810 = timerclken->sp810;
> +       u32 val, shift = SCCTRL_TIMERENnSEL_SHIFT(timerclken->channel);
> +       unsigned long flags = 0;
> +
> +       if (WARN_ON(index > 1))
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&sp810->lock, flags);
> +
> +       val = readl(sp810->base + SCCTRL);
> +       val &= ~(1 << shift);
> +       val |= index << shift;
> +       writel(val, sp810->base + SCCTRL);
> +
> +       spin_unlock_irqrestore(&sp810->lock, flags);
> +
> +       return 0;
> +}
> +
> +/*
> + * FIXME - setting the parent every time .prepare is invoked is inefficient.
> + * This is better handled by a dedicated clock tree configuration mechanism at
> + * init-time.  Revisit this later when such a mechanism exists
> + */
> +static int clk_sp810_timerclken_prepare(struct clk_hw *hw)
> +{
> +       struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
> +       struct clk_sp810 *sp810 = timerclken->sp810;
> +       struct clk *old_parent = __clk_get_parent(hw->clk);
> +       struct clk *new_parent;
> +
> +       if (!sp810->refclk)
> +               sp810->refclk = of_clk_get(sp810->node, sp810->refclk_index);
> +
> +       if (!sp810->timclk)
> +               sp810->timclk = of_clk_get(sp810->node, sp810->timclk_index);
> +
> +       if (WARN_ON(IS_ERR(sp810->refclk) || IS_ERR(sp810->timclk)))
> +               return -ENOENT;
> +
> +       /* Select fastest parent */
> +       if (clk_get_rate(sp810->refclk) > clk_get_rate(sp810->timclk))
> +               new_parent = sp810->refclk;
> +       else
> +               new_parent = sp810->timclk;
> +
> +       /* Switch the parent if necessary */
> +       if (old_parent != new_parent) {
> +               clk_prepare(new_parent);
> +               clk_set_parent(hw->clk, new_parent);
> +               clk_unprepare(old_parent);
> +       }
> +
> +       return 0;
> +}
> +
> +static void clk_sp810_timerclken_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
> +       struct clk_sp810 *sp810 = timerclken->sp810;
> +
> +       clk_put(sp810->timclk);
> +       clk_put(sp810->refclk);
> +}
> +
> +static const struct clk_ops clk_sp810_timerclken_ops = {
> +       .prepare = clk_sp810_timerclken_prepare,
> +       .unprepare = clk_sp810_timerclken_unprepare,
> +       .get_parent = clk_sp810_timerclken_get_parent,
> +       .set_parent = clk_sp810_timerclken_set_parent,
> +};
> +
> +struct clk *clk_sp810_timerclken_of_get(struct of_phandle_args *clkspec,
> +               void *data)
> +{
> +       struct clk_sp810 *sp810 = data;
> +
> +       if (WARN_ON(clkspec->args_count != 1 || clkspec->args[0] >
> +                       ARRAY_SIZE(sp810->timerclken)))
> +               return NULL;
> +
> +       return sp810->timerclken[clkspec->args[0]].clk;
> +}
> +
> +void __init clk_sp810_of_setup(struct device_node *node)
> +{
> +       struct clk_sp810 *sp810 = kzalloc(sizeof(*sp810), GFP_KERNEL);
> +       const char *parent_names[2];
> +       char name[12];
> +       struct clk_init_data init;
> +       int i;
> +
> +       if (!sp810) {
> +               pr_err("Failed to allocate memory for SP810!\n");
> +               return;
> +       }
> +
> +       sp810->refclk_index = of_property_match_string(node, "clock-names",
> +                       "refclk");
> +       parent_names[0] = of_clk_get_parent_name(node, sp810->refclk_index);
> +
> +       sp810->timclk_index = of_property_match_string(node, "clock-names",
> +                       "timclk");
> +       parent_names[1] = of_clk_get_parent_name(node, sp810->timclk_index);
> +
> +       if (parent_names[0] <= 0 || parent_names[1] <= 0) {
> +               pr_warn("Failed to obtain parent clocks for SP810!\n");
> +               return;
> +       }
> +
> +       sp810->node = node;
> +       sp810->base = of_iomap(node, 0);
> +       spin_lock_init(&sp810->lock);
> +
> +       init.name = name;
> +       init.ops = &clk_sp810_timerclken_ops;
> +       init.flags = CLK_IS_BASIC;
> +       init.parent_names = parent_names;
> +       init.num_parents = ARRAY_SIZE(parent_names);
> +
> +       for (i = 0; i < ARRAY_SIZE(sp810->timerclken); i++) {
> +               snprintf(name, ARRAY_SIZE(name), "timerclken%d", i);
> +
> +               sp810->timerclken[i].sp810 = sp810;
> +               sp810->timerclken[i].channel = i;
> +               sp810->timerclken[i].hw.init = &init;
> +
> +               sp810->timerclken[i].clk = clk_register(NULL,
> +                               &sp810->timerclken[i].hw);
> +               WARN_ON(IS_ERR(sp810->timerclken[i].clk));
> +       }
> +
> +       of_clk_add_provider(node, clk_sp810_timerclken_of_get, sp810);
> +}
> +CLK_OF_DECLARE(sp810, "arm,sp810", clk_sp810_of_setup);
> diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
> index 82b45aa..a4a728d 100644
> --- a/drivers/clk/versatile/clk-vexpress.c
> +++ b/drivers/clk/versatile/clk-vexpress.c
> @@ -15,8 +15,6 @@
>  #include <linux/clkdev.h>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/vexpress.h>
>  
>  static struct clk *vexpress_sp810_timerclken[4];
> @@ -86,50 +84,3 @@ void __init vexpress_clk_init(void __iomem *sp810_base)
>         WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[1],
>                                 "v2m-timer1", "sp804"));
>  }
> -
> -#if defined(CONFIG_OF)
> -
> -struct clk *vexpress_sp810_of_get(struct of_phandle_args *clkspec, void *data)
> -{
> -       if (WARN_ON(clkspec->args_count != 1 || clkspec->args[0] >
> -                       ARRAY_SIZE(vexpress_sp810_timerclken)))
> -               return NULL;
> -
> -       return vexpress_sp810_timerclken[clkspec->args[0]];
> -}
> -
> -void __init vexpress_clk_of_init(void)
> -{
> -       struct device_node *node;
> -       struct clk *clk;
> -       struct clk *refclk, *timclk;
> -
> -       of_clk_init(NULL);
> -
> -       node = of_find_compatible_node(NULL, NULL, "arm,sp810");
> -       vexpress_sp810_init(of_iomap(node, 0));
> -       of_clk_add_provider(node, vexpress_sp810_of_get, NULL);
> -
> -       /* Select "better" (faster) parent for SP804 timers */
> -       refclk = of_clk_get_by_name(node, "refclk");
> -       timclk = of_clk_get_by_name(node, "timclk");
> -       if (!WARN_ON(IS_ERR(refclk) || IS_ERR(timclk))) {
> -               int i = 0;
> -
> -               if (clk_get_rate(refclk) > clk_get_rate(timclk))
> -                       clk = refclk;
> -               else
> -                       clk = timclk;
> -
> -               for (i = 0; i < ARRAY_SIZE(vexpress_sp810_timerclken); i++)
> -                       WARN_ON(clk_set_parent(vexpress_sp810_timerclken[i],
> -                                       clk));
> -       }
> -
> -       WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[0],
> -                               "v2m-timer0", "sp804"));
> -       WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[1],
> -                               "v2m-timer1", "sp804"));
> -}
> -
> -#endif
> -- 
> 1.7.10.4
