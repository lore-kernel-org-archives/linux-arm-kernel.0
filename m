From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Mon, 18 May 2015 21:07:42 +0800
Subject: [PATCH v2] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150515190058.GN31753@codeaurora.org>
References: <1429521950-16431-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150515190058.GN31753@codeaurora.org>
Message-ID: <CALx668UqfAjf+x94qGX+LiuSDX+o+k5OAD5qPn35ykgK3hGtVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sat, May 16, 2015 at 3:00 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 04/20, pi-cheng.chen wrote:
>> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
>> new file mode 100644
>> index 0000000..dc14074
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-cpumux.c
>> @@ -0,0 +1,122 @@
>> +/*
>> + * Copyright (c) 2015 Linaro Ltd.
>> + * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>
> Do you need this include for some reason?

No. I think I forgot to remove it after adding it for some debugging purpose.
Will remove it.

>
>> +#include <linux/clk-provider.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/slab.h>
>> +
>> +#include "clk-mtk.h"
>> +#include "clk-cpumux.h"
>> +
> [...]
>> +
>> +static struct clk_ops clk_cpumux_ops = {
>
> const?

Yes. Will add it.

>
>> +     .get_parent = clk_cpumux_get_parent,
>> +     .set_parent = clk_cpumux_set_parent,
>> +};
>> +
>> +static struct clk *mtk_clk_register_cpumux(const struct mtk_composite *mux,
>> +                                        struct regmap *regmap)
>> +{
>> +     struct mtk_clk_cpumux *cpumux;
>> +     struct clk *clk;
>> +     struct clk_init_data init;
>> +
>> +     cpumux = kzalloc(sizeof(*cpumux), GFP_KERNEL);
>> +     if (!cpumux)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     init.name = mux->name;
>> +     init.ops = &clk_cpumux_ops;
>> +     init.parent_names = mux->parent_names;
>> +     init.num_parents = mux->num_parents;
>> +
>> +     cpumux->reg = mux->mux_reg;
>> +     cpumux->shift = mux->mux_shift;
>> +     cpumux->mask = (BIT(mux->mux_width) - 1);
>
> Unnecessary parenthesis.

Will fix it.

>
>> +     cpumux->regmap = regmap;
>> +     cpumux->hw.init = &init;
>> +
>> +     clk = clk_register(NULL, &cpumux->hw);
>> +     if (IS_ERR(clk))
>> +             kfree(cpumux);
>> +
>> +     return clk;
>> +}
>> +
>> +int mtk_clk_register_cpumuxes(struct device_node *node,
>> +                           const struct mtk_composite *clks, int num,
>> +                           struct clk_onecell_data *clk_data)
>> +{
>> +     int i;
>> +     struct clk *clk;
>> +     struct regmap *regmap;
>> +
>> +     if (!clk_data)
>> +             return -ENOMEM;
>
> Why would we call the function with NULL clk_data? Please remove
> this check.

Will remove it.

>
>> +
>> +     regmap = syscon_node_to_regmap(node);
>> +     if (IS_ERR(regmap)) {
>> +             pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
>> +                    PTR_ERR(regmap));
>> +             return PTR_ERR(regmap);
>> +     }
>> +
>> diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
>> new file mode 100644
>> index 0000000..b82ad20
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-cpumux.h
>> @@ -0,0 +1,31 @@
>> +/*
>> + * Copyright (c) 2015 Linaro Ltd.
>> + * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __DRV_CLK_CPUMUX_H
>> +#define __DRV_CLK_CPUMUX_H
>> +
>> +#include <linux/regmap.h>
>
> Looks unnecessary. Just forward declare the type you need, struct
> regmap.

Yes. Will fix.

Thanks for reviewing.

Best Regards,
Pi-Cheng

>
>> +
>> +struct mtk_clk_cpumux {
>> +     struct clk_hw   hw;
>> +     struct regmap   *regmap;
>> +     u32             reg;
>> +     u32             mask;
>> +     u8              shift;
>> +};
>> +
>> +int mtk_clk_register_cpumuxes(struct device_node *node,
>> +                           const struct mtk_composite *clks, int num,
>> +                           struct clk_onecell_data *clk_data);
>> +#endif /* __DRV_CLK_CPUMUX_H */
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
