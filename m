From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 22 Jul 2015 13:46:53 +0530
Subject: [PATCH 3/4] clk: 88pm800: Add clk provider driver for 88pm800
 family of devices
In-Reply-To: <55AF3C2E.7010205@samsung.com>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55AE990E.2040004@codeaurora.org> <55AE9F48.20600@linaro.org>
 <55AEB103.9010205@codeaurora.org> <55AF37D9.3000006@linaro.org>
 <55AF3C2E.7010205@samsung.com>
Message-ID: <55AF5175.2010701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 22 July 2015 12:16 PM, Krzysztof Kozlowski wrote:
> On 22.07.2015 15:27, Vaibhav Hiremath wrote:
>>
>>
>> On Wednesday 22 July 2015 02:22 AM, Stephen Boyd wrote:
>>> On 07/21/2015 12:36 PM, Vaibhav Hiremath wrote:
>>>>
>>>> On Wednesday 22 July 2015 12:40 AM, Stephen Boyd wrote:
>>>>> On 07/21/2015 04:07 AM, Vaibhav Hiremath wrote:
>>>>>> +
>>
>> <snip>
>>
>>>>>> +static int pm800_clk_remove(struct platform_device *pdev)
>>>>>> +{
>>>>>> +    struct pm800_clk *pm800_clks = platform_get_drvdata(pdev);
>>>>>> +    int i;
>>>>>> +
>>>>>> +    of_clk_del_provider(pm800_clks[0].clk_np);
>>>>>> +    /* Drop the reference obtained in pm800_clk_parse_dt */
>>>>>> +    of_node_put(pm800_clks[0].clk_np);
>>>>>
>>>>> This is odd. Why are we keeping the reference in the driver?
>>>>>
>>>>
>>>> Honestly I do not have any good answer here. I have to admit that it is
>>>> getting carry forwarded from legacy driver.
>>>>
>>>
>>> Well we shouldn't do things if we don't know why we're doing them.
>>> Krzysztof?
>
> I am really busy now so I am not following closely other discussions. I
> assume you are referring to clk-s2mps11.c. The of_node_put() matches
> of_get_child_by_name() when parsing DT.
>
> So why not of_node_put() just after parsing DT? Well, the result of
> of_get_child_by_name() is stored in state container for entire device
> life-cycle so we can use it in of_clk_del_provider().
>
> That was the idea behind it. If it looks incorrect I would be happy to
> see a patch :) .
>

About to respond, I digged more on kobject stuff and sequence in
of/dynamic.c and

I think you are right, we need of_node_put, as a result of
of_get_child_by_name().

Stephen,
Please let me know if you think otherwise.

Thanks,
Vaibhav
