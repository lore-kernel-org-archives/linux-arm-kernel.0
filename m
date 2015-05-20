From: bintian.wang@huawei.com (Bintian)
Date: Wed, 20 May 2015 14:42:45 +0800
Subject: [PATCH v6 5/6] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <20150520013941.GD31054@codeaurora.org>
References: <1431762000-8311-1-git-send-email-bintian.wang@huawei.com>
 <20150520013941.GD31054@codeaurora.org>
Message-ID: <555C2CE5.4010706@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

I will fix in version 7 based on all comments.

Thanks,

Bintian

On 2015/5/20 9:39, Stephen Boyd wrote:
> On 05/16, Bintian Wang wrote:
>> @@ -94,18 +106,23 @@ struct clk *hisi_register_clkgate_sep(struct device *, const char *,
>>   				const char *, unsigned long,
>>   				void __iomem *, u8,
>>   				u8, spinlock_t *);
>> +struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
>> +	const char *parent_name, unsigned long flags, void __iomem *reg,
>> +	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
>>
>> -struct hisi_clock_data __init *hisi_clk_init(struct device_node *, int);
>> -void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
>> +struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
>> +void hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
>>   					int, struct hisi_clock_data *);
>> -void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
>> +void hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
>>   					int, struct hisi_clock_data *);
>> -void __init hisi_clk_register_mux(struct hisi_mux_clock *, int,
>> +void hisi_clk_register_mux(struct hisi_mux_clock *, int,
>>   				struct hisi_clock_data *);
>> -void __init hisi_clk_register_divider(struct hisi_divider_clock *,
>> +void hisi_clk_register_divider(struct hisi_divider_clock *,
>>   				int, struct hisi_clock_data *);
>> -void __init hisi_clk_register_gate(struct hisi_gate_clock *,
>> +void hisi_clk_register_gate(struct hisi_gate_clock *,
>> +					int, struct hisi_clock_data *);
>> +void hisi_clk_register_gate_sep(struct hisi_gate_clock *,
>>   					int, struct hisi_clock_data *);
>> -void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *,
>> +void hi6220_clk_register_divider(struct hi6220_divider_clock *,
>>   					int, struct hisi_clock_data *);
>
> Please don't do the mass __init removal in this patch. Do it in a
> separate patch.
>
>>   #endif	/* __HISI_CLK_H */
>> diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
>> new file mode 100644
>> index 0000000..bc85ef6
>> --- /dev/null
>> +++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
>> @@ -0,0 +1,157 @@
>> +/*
>> + * Hisilicon hi6220 SoC divider clock driver
>> + *
>> + * Copyright (c) 2015 Hisilicon Limited.
>> + *
>> + * Author: Bintian Wang <bintian.wang@huawei.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>
> #include <linux/spinlock.h> ?
>
>> +
>> +#define div_mask(width)	((1 << (width)) - 1)
>> +
> [..]
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
>
> nitpick: Use sizeof(*div) please.
>
>> +	if (!div)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/* Init the divider table */
>> +	max_div = div_mask(width) + 1;
>> +	min_div = 1;
>> +
>> +	table = kzalloc(sizeof(struct clk_div_table) * (max_div + 1),
>
> And kcalloc() here please
>
>> +			GFP_KERNEL);
>> +	if (!table) {
>> +		kfree(div);
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
>> +	init.flags = flags;
>> +	init.parent_names = parent_name ? &parent_name : NULL;
>> +	init.num_parents = parent_name ? 1 : 0;
>> +
>> +	/* struct hi6220_clk_divider assignments */
>> +	div->reg = reg;
>> +	div->shift = shift;
>> +	div->width = width;
>> +	div->mask = mask_bit ? BIT(mask_bit) : 0;
>> +	div->lock = lock;
>> +	div->hw.init = &init;
>> +	div->table = table;
>> +
>> +	/* register the clock */
>> +	clk = clk_register(dev, &div->hw);
>> +
>
> Drop the newline here.
>
>> +	if (IS_ERR(clk)) {
>> +		kfree(table);
>> +		kfree(div);
>> +	}
>> +
>> +	return clk;
>> +}
>
