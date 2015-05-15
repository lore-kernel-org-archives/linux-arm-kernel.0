From: bintian.wang@huawei.com (Bintian)
Date: Fri, 15 May 2015 15:42:51 +0800
Subject: [PATCH v4 4/5] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <20150515002527.GD31753@codeaurora.org>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-5-git-send-email-bintian.wang@huawei.com>
 <20150515002527.GD31753@codeaurora.org>
Message-ID: <5555A37B.1090105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On 2015/5/15 8:25, Stephen Boyd wrote:
> On 05/05, Bintian Wang wrote:
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 9897f35..935c44b 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -152,6 +152,8 @@ config COMMON_CLK_CDCE706
>>
>>   source "drivers/clk/qcom/Kconfig"
>>
>> +source "drivers/clk/hisilicon/Kconfig"
>> +
>
> Please move this above qcom to maintain alphabet sort.
OK, fix in next version.

>
>>   endmenu
>>
>>   source "drivers/clk/bcm/Kconfig"
>> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
>> new file mode 100644
>> index 0000000..8034739
>> --- /dev/null
>> +++ b/drivers/clk/hisilicon/Kconfig
>> @@ -0,0 +1,6 @@
>> +config COMMON_CLK_HI6220
>> +	bool "Hi6220 Clock Driver"
>> +	depends on OF && ARCH_HISI
>> +	default y
>
> Can this be
>
> 	depends on ARCH_HISI || COMPILE_TEST
> 	default ARCH_HISI
>
> instead? I'd like to increase build coverage.
No problem, will fix in next version.

>
>> +	help
>> +	  Build the Hisilicon Hi6220 clock driver based on the common clock framework.
>> diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
>> new file mode 100644
>> index 0000000..91b1cd7
>> --- /dev/null
>> +++ b/drivers/clk/hisilicon/clk-hi6220.c
>> @@ -0,0 +1,292 @@
>> +/*
>> + * Hisilicon Hi6220 clock driver
>> + *
>> + * Copyright (c) 2015 Hisilicon Limited.
>> + *
>> + * Author: Bintian Wang <bintian.wang@huawei.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>
> Do we need to include linux/clk.h? I don't see any consumer
> usage here.
You are right, remove in next version.

>
>> +
>> +#include <dt-bindings/clock/hi6220-clock.h>
>> +
>> +#include "clk.h"
>> +
>> diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
>> index a078e84..5d2305c 100644
>> --- a/drivers/clk/hisilicon/clk.c
>> +++ b/drivers/clk/hisilicon/clk.c
>> @@ -108,4 +123,6 @@ void __init hisi_clk_register_gate(struct hisi_gate_clock *,
>>   					int, struct hisi_clock_data *);
>>   void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *,
>>   					int, struct hisi_clock_data *);
>> +void __init hi6220_clk_register_divider(struct hi6220_divider_clock *,
>> +					int, struct hisi_clock_data *);
>
> __init markings on function prototypes are useless. Please remove them.
OK

>
>>   #endif	/* __HISI_CLK_H */
>> diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
>> +
>> +/**
>> + * struct hi6220_clk_divider - divider clock for hi6220
>> + *
>> + * @hw:		handle between common and hardware-specific interfaces
>> + * @reg:	register containing divider
>> + * @shift:	shift to the divider bit field
>> + * @width:	width of the divider bit field
>> + * @mask:	mask for setting divider rate
>> + * @table:	the div table that the divider supports
>> + * @lock:	register lock
>> + */
>> +struct hi6220_clk_divider {
>> +	struct clk_hw	hw;
>> +	void __iomem	*reg;
>> +	u8		shift;
>> +	u8		width;
>> +	u32		mask;
>> +	const struct clk_div_table *table;
>> +	spinlock_t	*lock;
>> +};
>
> The clk-divider.c code has been made "reusable". Can you please
> try to use the functions that it now exposes instead of
> copy/pasting it and modifying it to suit your needs? A lot of
> this code looks the same.
In fact, I discussed this problem with Rob Herring and Mike Turquette
in the 96boards internal mail list before.

The divider in hi6220 has a mask bit to guarantee writing the correct
bits in register when setting rate, but the index of this mask bit has
no rules to get (e.g. by left shift some fixed bits), so I add this
divider clock to handle it, we can regard hi6220_clk_divider as a
special case of generic divider clock.

If I don't add this divider clock for hi6220 chip, then I should change
the core APIs "clk_register_divider" and "clk_register_divider_table",
and then many other drivers will be updated.
So I think just add this divider clock is a good solution now.

>
>> +
>> +#define to_hi6220_clk_divider(_hw)	\
> [..]
>> +
>> +static struct clk_ops hi6220_clkdiv_ops = {
>
> const?
Add in next version.

>
>> +	.recalc_rate = hi6220_clkdiv_recalc_rate,
>> +	.round_rate = hi6220_clkdiv_round_rate,
>> +	.set_rate = hi6220_clkdiv_set_rate,
>> +};
>> +
>> +struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
>> +	const char *parent_name, unsigned long flags, void __iomem *reg,
>> +	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock)
>> +{
>> +	struct hi6220_clk_divider *div;
>> +	struct clk *clk;
>> +	struct clk_init_data init;
>> +	struct clk_div_table *table;
>> +	u32 max_div, min_div;
>> +	int i;
>> +
>> +	/* allocate the divider */
>> +	div = kzalloc(sizeof(struct hi6220_clk_divider), GFP_KERNEL);
>> +	if (!div) {
>> +		pr_err("%s: could not allocate divider clk\n", __func__);
>
> Useless error message on allocation failure. Please run
> checkpatch. I've sent a patch to remove these from basic clock
> types.
Remove in next version.
>
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	/* Init the divider table */
>> +	max_div = div_mask(width) + 1;
>> +	min_div = 1;
>> +
>> +	table = kzalloc(sizeof(struct clk_div_table) * (max_div + 1), GFP_KERNEL);
>> +	if (!table) {
>> +		kfree(div);
>> +		pr_err("%s: failed to alloc divider table!\n", __func__);
>
> ditto.
Will remove in next version.
>
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	for (i = 0; i < max_div; i++) {
>> +		table[i].div = min_div + i;
>> +		table[i].val = table[i].div - 1;
>> +	}
>> +
>> +	init.name = name;
>> +	init.ops = &hi6220_clkdiv_ops;
>> +	init.flags = flags | CLK_IS_BASIC;
>
> It's basic?
I rechecked this flag, it's really useless to us, so I can remove it.
But can you tell me which case I should use it?

How about just send this patch for review not the whole patch set in 
next version?

Thanks,

Bintian
>
>> +	init.parent_names = parent_name ? &parent_name : NULL;
>> +	init.num_parents = parent_name ? 1 : 0;
>
