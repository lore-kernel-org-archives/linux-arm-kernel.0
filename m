From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 20 Mar 2015 15:21:15 +0530
Subject: [PATCH v3 1/6] clk: qcom: Add support for GDSCs
In-Reply-To: <550BCE7C.3030000@linaro.org>
References: <1426832483-27026-1-git-send-email-rnayak@codeaurora.org>
 <1426832483-27026-2-git-send-email-rnayak@codeaurora.org>
 <550BCE7C.3030000@linaro.org>
Message-ID: <550BED93.3000305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ...
>> +
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/export.h>
> ?? Do you need this?

Maybe not, now that the EXPORT_SYMBOL() is gone.
I will remove it.

>
>> +#include <linux/jiffies.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include "gdsc.h"
>> +
>> +#define PWR_ON_MASK        BIT(31)
>> +#define EN_REST_WAIT_MASK    GENMASK(23, 20)
>> +#define EN_FEW_WAIT_MASK    GENMASK(19, 16)
>> +#define CLK_DIS_WAIT_MASK    GENMASK(15, 12)
>> +#define SW_OVERRIDE_MASK    BIT(2)
>> +#define HW_CONTROL_MASK        BIT(1)
>> +#define SW_COLLAPSE_MASK    BIT(0)
>> +
>> +/* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
>> +#define EN_REST_WAIT_VAL    (0x2 << 20)
>> +#define EN_FEW_WAIT_VAL        (0x8 << 16)
>> +#define CLK_DIS_WAIT_VAL    (0x2 << 12)
>> +
>> +#define TIMEOUT_US        100
>> +
>> +static int gdsc_is_enabled(struct gdsc *sc)
>> +{
>> +    u32 val;
>> +    int ret;
>> +
>> +    ret = regmap_read(sc->regmap, sc->gdscr, &val);
>> +    if (ret)
>> +        return ret;
> Line after this would be good.
>> +    return !!(val & PWR_ON_MASK);
>> +}
>> +
>> +static int gdsc_toggle_logic(struct gdsc *sc, bool en)
>> +{
>> +    int ret;
>> +    u32 val = en ? 0 : SW_COLLAPSE_MASK;
>> +    u32 check = en ? PWR_ON_MASK : 0;
>> +    unsigned long timeout;
>> +
>> +    ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK,
>> val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
>> +    do {
>> +        ret = regmap_read(sc->regmap, sc->gdscr, &val);
>> +        if (ret)
>> +            return ret;
>> +        if ((val & PWR_ON_MASK) == check)
>> +            return 0;
>> +    } while (time_before(jiffies, timeout));
>> +
>> +    ret =  regmap_read(sc->regmap, sc->gdscr, &val);
>> +    if (ret)
>> +        return ret;
> New line here.
>> +    if ((val & PWR_ON_MASK) == check)
>> +        return 0;
>> +
>> +    return -ETIMEDOUT;
>> +}
>> +
> ...
>
>> +
>> +int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
>> +          struct regmap *regmap)
>> +{
>> +    int i, ret;
>> +    struct genpd_onecell_data *data;
>> +
>> +    if (!num || !scs || !dev || !dev->of_node)
>> +        return 0;
> Should it not return -EINVAL here?

so we have gdsc_register() getting called from qcom_cc_really_probe()
and we might have devices with no gdscs as part of gcc. So the way to 
identify those is the num and scs aren't really initialized.
I should probably move this check into the common clk probe function
and not call gdsc_register() if these are not inited, and return a
-EINVAL for (!dev || !dev->of_node) here.

>
>> +
>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    data->domains = devm_kzalloc(dev, sizeof(*data->domains) * num,
>> +                     GFP_KERNEL);
>> +    if (!data->domains)
>> +        return -ENOMEM;
>> +
>> +    data->num_domains = num;
>> +    for (i = 0; i < num; i++) {
>> +        if (!scs[i])
>> +            continue;
>> +        scs[i]->regmap = regmap;
>> +        ret = gdsc_init(scs[i]);
>> +        if (ret)
>> +            return ret;
>> +        data->domains[i] = &scs[i]->pd;
>> +    }
> New line?
>> +    return of_genpd_add_provider_onecell(dev->of_node, data);
>> +}
>> +
>> +void gdsc_unregister(struct device *dev)
>> +{
>> +    of_genpd_del_provider(dev->of_node);
>> +}
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> new file mode 100644
>> index 0000000..02e2990
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -0,0 +1,46 @@
>> +/*
>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __QCOM_GDSC_H__
>> +#define __QCOM_GDSC_H__
>> +
>> +#include <linux/pm_domain.h>
>> +
>> +struct regmap;
>> +
>> +/**
>> + * struct gdsc - Globally Distributed Switch Controller
>> + * @pd: generic power domain
>> + * @regmap: regmap for MMIO accesses
>> + * @gdscr: gsdc control register
>> + */
>> +struct gdsc {
>> +    struct generic_pm_domain    pd;
>> +    struct regmap            *regmap;
>> +    unsigned int            gdscr;
>> +};
>> +
>> +#define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
>> +
>> +#ifdef CONFIG_QCOM_GDSC
>> +int gdsc_register(struct device *, struct gdsc **, size_t n, struct
>> regmap *);
>> +void gdsc_unregister(struct device *);
>> +#else
>> +int gdsc_register(struct device *d, struct gdsc **g, size_t n, struct
>> regmap *r)
>
> static inline here??? else it would result in muliple definitions?

It shouldn't result in mutiple defs, but static inline would be good.
I will fix it.

>
>> +{
>> +    return 0;
> return -ENOSYS;

This should work once I put checks for non inited desc->num_gdscs as
part of  qcom_cc_really_probe().

Thanks for the review. I'll post a v4 with the changes.
regards,
Rajendra

>> +}
>> +
>> +void gdsc_unregister(struct device *d) {};
> same static inline...
> Braces should be in next line too.
>> +#endif /* CONFIG_QCOM_GDSC */
>> +#endif /* __QCOM_GDSC_H__ */
>>
>
>
> --srini

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
