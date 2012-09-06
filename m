From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 6 Sep 2012 10:57:11 -0700
Subject: [PATCH v3] clk: add Loongson1B clock support
In-Reply-To: <CAJhJPsXdCn0u9aefehsTd1ZLLnbBgZZFExq=PC_Z-jv4F9XqWg@mail.gmail.com>
References: <1345457135-12737-1-git-send-email-keguang.zhang@gmail.com>
 <CAJhJPsXdCn0u9aefehsTd1ZLLnbBgZZFExq=PC_Z-jv4F9XqWg@mail.gmail.com>
Message-ID: <CAJOA=zM8CDjiGX_Wk0TAQhOiVWp2qQtFxRD1F8KcaKn9PBtsdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 11:55 PM, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
>
> Ping?
>

No ping necessary.  I think mails are getting dropped somewhere on
your end.  I've already taken this into clk-next.  See this thread on
MARC:
http://marc.info/?l=linux-arm-kernel&m=134643752523847&w=2

And here is the patch on clk-next:
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commitdiff;h=5175cb5894d606f1756c07a685e6dcabd2d8745a;hp=e5ad7ac73cdd43c48998f1f43261c6209aebe00b

Regards,
Mike

>
> 2012/8/20 Kelvin Cheung <keguang.zhang@gmail.com>
>>
>> This adds clock support to Loongson1B SoC using the common clock
>> infrastructure.
>>
>> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
>> ---
>>  drivers/clk/Makefile   |    1 +
>>  drivers/clk/clk-ls1x.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 112 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/clk/clk-ls1x.c
>>
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index 5869ea3..018ec57 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)    += socfpga/
>>  obj-$(CONFIG_PLAT_SPEAR)       += spear/
>>  obj-$(CONFIG_ARCH_U300)                += clk-u300.o
>>  obj-$(CONFIG_ARCH_INTEGRATOR)  += versatile/
>> +obj-$(CONFIG_MACH_LOONGSON1)   += clk-ls1x.o
>>
>>  # Chip specific
>>  obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
>> diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
>> new file mode 100644
>> index 0000000..f20b750
>> --- /dev/null
>> +++ b/drivers/clk/clk-ls1x.c
>> @@ -0,0 +1,111 @@
>> +/*
>> + * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/err.h>
>> +
>> +#include <loongson1.h>
>> +
>> +#define OSC    33
>> +
>> +static DEFINE_SPINLOCK(_lock);
>> +
>> +static int ls1x_pll_clk_enable(struct clk_hw *hw)
>> +{
>> +       return 0;
>> +}
>> +
>> +static void ls1x_pll_clk_disable(struct clk_hw *hw)
>> +{
>> +}
>> +
>> +static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
>> +                                            unsigned long parent_rate)
>> +{
>> +       u32 pll, rate;
>> +
>> +       pll = __raw_readl(LS1X_CLK_PLL_FREQ);
>> +       rate = ((12 + (pll & 0x3f)) * 1000000) +
>> +               ((((pll >> 8) & 0x3ff) * 1000000) >> 10);
>> +       rate *= OSC;
>> +       rate >>= 1;
>> +
>> +       return rate;
>> +}
>> +
>> +static const struct clk_ops ls1x_pll_clk_ops = {
>> +       .enable = ls1x_pll_clk_enable,
>> +       .disable = ls1x_pll_clk_disable,
>> +       .recalc_rate = ls1x_pll_recalc_rate,
>> +};
>> +
>> +static struct clk * __init clk_register_pll(struct device *dev,
>> +        const char *name, const char *parent_name, unsigned long flags)
>> +{
>> +       struct clk_hw *hw;
>> +       struct clk *clk;
>> +       struct clk_init_data init;
>> +
>> +       /* allocate the divider */
>> +       hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
>> +       if (!hw) {
>> +               pr_err("%s: could not allocate clk_hw\n", __func__);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>> +       init.name = name;
>> +       init.ops = &ls1x_pll_clk_ops;
>> +       init.flags = flags | CLK_IS_BASIC;
>> +       init.parent_names = (parent_name ? &parent_name : NULL);
>> +       init.num_parents = (parent_name ? 1 : 0);
>> +       hw->init = &init;
>> +
>> +       /* register the clock */
>> +       clk = clk_register(dev, hw);
>> +
>> +       if (IS_ERR(clk))
>> +               kfree(hw);
>> +
>> +       return clk;
>> +}
>> +
>> +void __init ls1x_clk_init(void)
>> +{
>> +       struct clk *clk;
>> +
>> +       clk = clk_register_pll(NULL, "pll_clk", NULL, CLK_IS_ROOT);
>> +       clk_prepare_enable(clk);
>> +
>> +       clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
>> +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_CPU_SHIFT,
>> +                       DIV_CPU_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
>> +       clk_prepare_enable(clk);
>> +       clk_register_clkdev(clk, "cpu", NULL);
>> +
>> +       clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
>> +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
>> +                       DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
>> +       clk_prepare_enable(clk);
>> +       clk_register_clkdev(clk, "dc", NULL);
>> +
>> +       clk = clk_register_divider(NULL, "ahb_clk", "pll_clk",
>> +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
>> +                       DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
>> +       clk_prepare_enable(clk);
>> +       clk_register_clkdev(clk, "ahb", NULL);
>> +       clk_register_clkdev(clk, "stmmaceth", NULL);
>> +
>> +       clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1, 2);
>> +       clk_prepare_enable(clk);
>> +       clk_register_clkdev(clk, "apb", NULL);
>> +       clk_register_clkdev(clk, "serial8250", NULL);
>> +}
>> --
>> 1.7.1
>>
>
>
>
> --
> Best Regards!
> Kelvin
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
