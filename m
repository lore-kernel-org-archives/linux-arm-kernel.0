From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Jul 2015 13:52:19 -0700
Subject: [PATCH 3/4] clk: 88pm800: Add clk provider driver for 88pm800
 family of devices
In-Reply-To: <55AE9F48.20600@linaro.org>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55AE990E.2040004@codeaurora.org> <55AE9F48.20600@linaro.org>
Message-ID: <55AEB103.9010205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2015 12:36 PM, Vaibhav Hiremath wrote:
>
> On Wednesday 22 July 2015 12:40 AM, Stephen Boyd wrote:
>> On 07/21/2015 04:07 AM, Vaibhav Hiremath wrote:
>>> +
>>> +    pm800_clks = devm_kzalloc(&pdev->dev,
>>> +                sizeof(*pm800_clks) * PM800_CLKS_NUM,
>>> +                GFP_KERNEL);
>>
>> devm_kcalloc()
>>
>>> +    if (!pm800_clks)
>>> +        return -ENOMEM;
>>> +
>>> +    clk_table = devm_kzalloc(&pdev->dev,
>>> +                sizeof(struct clk *) * PM800_CLKS_NUM,
>>> +                GFP_KERNEL);
>>
>> devm_kcalloc()
>>
>
> why kcalloc?
> Is it because it take another argument for to allocate array?
>

Yes. See Chapter 14 of Documentation/CodingStyle for why devm_kcalloc() 
is preferred.

>
>>> +    if (!clk_table)
>>> +        return -ENOMEM;
>>> +
>
>
> < snip >
>
>>> +            of_clk_data);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "Fail to add OF clk provider : %d\n", 
>>> ret);
>>> +        goto err;
>>> +    }
>>> +
>>> +    /* Common for all 32KHz clock output */
>>> +    ret = pm800_init_clk(&pm800_clks[0]);
>>
>> Shouldn't we do this before registering the clocks with the framework?
>>
>
> Actually I thought of this, but moved it at the end because, I feel
> this init should happen only when we are sure that clock is ready for
> consumption. This is HW initialization where we will be setting
> FREERUNNIG mode (and similar stuffs), so thought it would be bad idea
> to set it first and then on error (later in probe) clear it. Not sure
> whether it has any impact on HW behaviour.
> Also, specially internal reference counter is changing in the init.
> Just tried to avoid back-n-forth set-n-clear of this.

Ok.

>
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "Failed to initialize clk : %d\n", ret);
>>> +        goto err;
>>> +    }
>>> +
>>> +    platform_set_drvdata(pdev, pm800_clks);
>>> +
>>> +    return 0;
>>> +
>>> +err:
>>> +    for (i = 0; i < PM800_CLKS_NUM; i++) {
>>> +        if (pm800_clks[i].lookup)
>>> +            clkdev_drop(pm800_clks[i].lookup);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int pm800_clk_remove(struct platform_device *pdev)
>>> +{
>>> +    struct pm800_clk *pm800_clks = platform_get_drvdata(pdev);
>>> +    int i;
>>> +
>>> +    of_clk_del_provider(pm800_clks[0].clk_np);
>>> +    /* Drop the reference obtained in pm800_clk_parse_dt */
>>> +    of_node_put(pm800_clks[0].clk_np);
>>
>> This is odd. Why are we keeping the reference in the driver?
>>
>
> Honestly I do not have any good answer here. I have to admit that it is
> getting carry forwarded from legacy driver.
>

Well we shouldn't do things if we don't know why we're doing them. 
Krzysztof?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
