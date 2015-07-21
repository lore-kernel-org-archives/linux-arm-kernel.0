From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 22 Jul 2015 01:06:40 +0530
Subject: [PATCH 3/4] clk: 88pm800: Add clk provider driver for 88pm800
 family of devices
In-Reply-To: <55AE990E.2040004@codeaurora.org>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55AE990E.2040004@codeaurora.org>
Message-ID: <55AE9F48.20600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 22 July 2015 12:40 AM, Stephen Boyd wrote:
> On 07/21/2015 04:07 AM, Vaibhav Hiremath wrote:
>> diff --git a/drivers/clk/clk-88pm800.c b/drivers/clk/clk-88pm800.c
>> new file mode 100644
>> index 0000000..cf1c162
>> --- /dev/null
>> +++ b/drivers/clk/clk-88pm800.c
>> @@ -0,0 +1,345 @@
>> +/*
>> + * clk-88pm800.c - Clock driver for 88PM800 family of devices
>> + *
>> + * This driver is created based on clk-s2mps11.c
>> + *
>> + * Copyright (C) 2015 Linaro Ltd.
>> + *
>> + * This program is free software; you can redistribute  it and/or
>> modify it
>> + * under  the terms of  the GNU General  Public License as published
>> by the
>> + * Free Software Foundation;  either version 2 of the  License, or
>> (at your
>> + * option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +

<snip>

>> +    struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
>> +    struct pm800_clk *pm800_clks;
>> +    struct clk_init_data *clks_init;
>> +    static struct clk **clk_table;
>> +    static struct clk_onecell_data *of_clk_data;
>> +    int i, ret = 0;
>
> Drop assignment to ret please.
>

Agreed to this and all above comments.

>> +
>> +    pm800_clks = devm_kzalloc(&pdev->dev,
>> +                sizeof(*pm800_clks) * PM800_CLKS_NUM,
>> +                GFP_KERNEL);
>
> devm_kcalloc()
>
>> +    if (!pm800_clks)
>> +        return -ENOMEM;
>> +
>> +    clk_table = devm_kzalloc(&pdev->dev,
>> +                sizeof(struct clk *) * PM800_CLKS_NUM,
>> +                GFP_KERNEL);
>
> devm_kcalloc()
>

why kcalloc?
Is it because it take another argument for to allocate array?


>> +    if (!clk_table)
>> +        return -ENOMEM;
>> +


< snip >

>> +            of_clk_data);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Fail to add OF clk provider : %d\n", ret);
>> +        goto err;
>> +    }
>> +
>> +    /* Common for all 32KHz clock output */
>> +    ret = pm800_init_clk(&pm800_clks[0]);
>
> Shouldn't we do this before registering the clocks with the framework?
>

Actually I thought of this, but moved it at the end because, I feel
this init should happen only when we are sure that clock is ready for
consumption. This is HW initialization where we will be setting
FREERUNNIG mode (and similar stuffs), so thought it would be bad idea
to set it first and then on error (later in probe) clear it. Not sure
whether it has any impact on HW behaviour.
Also, specially internal reference counter is changing in the init.
Just tried to avoid back-n-forth set-n-clear of this.

>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Failed to initialize clk : %d\n", ret);
>> +        goto err;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, pm800_clks);
>> +
>> +    return 0;
>> +
>> +err:
>> +    for (i = 0; i < PM800_CLKS_NUM; i++) {
>> +        if (pm800_clks[i].lookup)
>> +            clkdev_drop(pm800_clks[i].lookup);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int pm800_clk_remove(struct platform_device *pdev)
>> +{
>> +    struct pm800_clk *pm800_clks = platform_get_drvdata(pdev);
>> +    int i;
>> +
>> +    of_clk_del_provider(pm800_clks[0].clk_np);
>> +    /* Drop the reference obtained in pm800_clk_parse_dt */
>> +    of_node_put(pm800_clks[0].clk_np);
>
> This is odd. Why are we keeping the reference in the driver?
>

Honestly I do not have any good answer here. I have to admit that it is
getting carry forwarded from legacy driver.

>> +
>> +    for (i = 0; i < PM800_CLKS_NUM; i++) {
>> +        if (pm800_clks[i].lookup)
>> +            clkdev_drop(pm800_clks[i].lookup);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> [..]
>> +
>> +static int __init pm800_clk_init(void)
>> +{
>> +    return platform_driver_register(&pm800_clk_driver);
>> +}
>> +subsys_initcall(pm800_clk_init);
>> +
>> +static void __init pm800_clk_cleanup(void)
>
> s/__init/__exit/
>

I will all other comments.  Thanks for your review.

Thanks,
Vaibhav
