From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 12 Oct 2011 07:59:19 -0700
Subject: [PATCH v2 4/7] clk: Add simple gated clock
In-Reply-To: <20111012064646.GA31037@b20223-02.ap.freescale.net>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-5-git-send-email-mturquette@ti.com>
	<20111012064646.GA31037@b20223-02.ap.freescale.net>
Message-ID: <CAJOA=zPw7BF1iNFaG9js2k6++qPnXz5S3dq4rsPmUWOcUztL0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 11:46 PM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> On Thu, Sep 22, 2011 at 03:26:59PM -0700, Mike Turquette wrote:
>> From: Jeremy Kerr <jeremy.kerr@canonical.com>
>>
>> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> ---
>> Changes since v1:
>> Add copyright header
>> Fold in Jamie's patch for set-to-disable clks
>> Use BIT macro instead of shift
>>
>> ?drivers/clk/Kconfig ? ?| ? ?4 ++
>> ?drivers/clk/Makefile ? | ? ?1 +
>> ?drivers/clk/clk-gate.c | ? 78 ++++++++++++++++++++++++++++++++++++++++++++++++
>> ?include/linux/clk.h ? ?| ? 13 ++++++++
>> ?4 files changed, 96 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/clk/clk-gate.c
>
> I feel hard to tell the tree the clk parent, at register/init time. For the
> simple gate clk, the only way is to set .get_parent. But normally, for clk
> without any divider we set .get_parent to NULL. Maybe we can put .parent to
> struct clk_hw?

For non-mux clocks, whose parent is *always* going to be the same, you
should create a duplicate .parent in the clk_hw_* structure and then
have .get_parent return clk_hw_*->parent.

This is analogous to the way clk_hw_fixed returns clk_hw_fixed->rate
when .recalc is called on it.

Regards,
Mike

> Thanks
> Richard
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index d8313d7..a78967c 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -12,3 +12,7 @@ config GENERIC_CLK
>> ?config GENERIC_CLK_FIXED
>> ? ? ? bool
>> ? ? ? depends on GENERIC_CLK
>> +
>> +config GENERIC_CLK_GATE
>> + ? ? bool
>> + ? ? depends on GENERIC_CLK
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index 9a3325a..d186446 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -2,3 +2,4 @@
>> ?obj-$(CONFIG_CLKDEV_LOOKUP) ?+= clkdev.o
>> ?obj-$(CONFIG_GENERIC_CLK) ? ?+= clk.o
>> ?obj-$(CONFIG_GENERIC_CLK_FIXED) ? ? ?+= clk-fixed.o
>> +obj-$(CONFIG_GENERIC_CLK_GATE) ? ? ? += clk-gate.o
>> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
>> new file mode 100644
>> index 0000000..a1d8e79
>> --- /dev/null
>> +++ b/drivers/clk/clk-gate.c
>> @@ -0,0 +1,78 @@
>> +/*
>> + * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * Simple clk gate implementation
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <asm/io.h>
>> +
>> +#define to_clk_gate(clk) container_of(clk, struct clk_gate, hw)
>> +
>> +static unsigned long clk_gate_get_rate(struct clk_hw *clk)
>> +{
>> + ? ? return clk_get_rate(clk_get_parent(clk->clk));
>> +}
>> +
>> +static void clk_gate_set_bit(struct clk_hw *clk)
>> +{
>> + ? ? struct clk_gate *gate = to_clk_gate(clk);
>> + ? ? u32 reg;
>> +
>> + ? ? reg = __raw_readl(gate->reg);
>> + ? ? reg |= BIT(gate->bit_idx);
>> + ? ? __raw_writel(reg, gate->reg);
>> +}
>> +
>> +static void clk_gate_clear_bit(struct clk_hw *clk)
>> +{
>> + ? ? struct clk_gate *gate = to_clk_gate(clk);
>> + ? ? u32 reg;
>> +
>> + ? ? reg = __raw_readl(gate->reg);
>> + ? ? reg &= ~BIT(gate->bit_idx);
>> + ? ? __raw_writel(reg, gate->reg);
>> +}
>> +
>> +static int clk_gate_enable_set(struct clk_hw *clk)
>> +{
>> + ? ? clk_gate_set_bit(clk);
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static void clk_gate_disable_clear(struct clk_hw *clk)
>> +{
>> + ? ? clk_gate_clear_bit(clk);
>> +}
>> +
>> +struct clk_hw_ops clk_gate_set_enable_ops = {
>> + ? ? .recalc_rate = clk_gate_get_rate,
>> + ? ? .enable = clk_gate_enable_set,
>> + ? ? .disable = clk_gate_disable_clear,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_gate_set_enable_ops);
>> +
>> +static int clk_gate_enable_clear(struct clk_hw *clk)
>> +{
>> + ? ? clk_gate_clear_bit(clk);
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static void clk_gate_disable_set(struct clk_hw *clk)
>> +{
>> + ? ? clk_gate_set_bit(clk);
>> +}
>> +
>> +struct clk_hw_ops clk_gate_set_disable_ops = {
>> + ? ? .recalc_rate = clk_gate_get_rate,
>> + ? ? .enable = clk_gate_enable_clear,
>> + ? ? .disable = clk_gate_disable_set,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_gate_set_disable_ops);
>> diff --git a/include/linux/clk.h b/include/linux/clk.h
>> index 1903dd8..626fd0d 100644
>> --- a/include/linux/clk.h
>> +++ b/include/linux/clk.h
>> @@ -124,6 +124,19 @@ extern struct clk_hw_ops clk_fixed_ops;
>>
>> ?#endif /* CONFIG_GENERIC_CLK_FIXED */
>>
>> +#ifdef CONFIG_GENERIC_CLK_GATE
>> +
>> +struct clk_gate {
>> + ? ? struct clk_hw ? hw;
>> + ? ? void __iomem ? ?*reg;
>> + ? ? u8 ? ? ? ? ? ? ?bit_idx;
>> +};
>> +
>> +extern struct clk_hw_ops clk_gate_set_enable_ops;
>> +extern struct clk_hw_ops clk_gate_set_disable_ops;
>> +
>> +#endif /* CONFIG_GENERIC_CLK_GATE */
>> +
>> ?/**
>> ? * clk_register - register and initialize a new clock
>> ? *
>> --
>> 1.7.4.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
