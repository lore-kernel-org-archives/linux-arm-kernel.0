From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jul 2015 15:46:06 +0900
Subject: [PATCH 3/4] clk: 88pm800: Add clk provider driver for 88pm800
 family of devices
In-Reply-To: <55AF37D9.3000006@linaro.org>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55AE990E.2040004@codeaurora.org> <55AE9F48.20600@linaro.org>
 <55AEB103.9010205@codeaurora.org> <55AF37D9.3000006@linaro.org>
Message-ID: <55AF3C2E.7010205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.07.2015 15:27, Vaibhav Hiremath wrote:
> 
> 
> On Wednesday 22 July 2015 02:22 AM, Stephen Boyd wrote:
>> On 07/21/2015 12:36 PM, Vaibhav Hiremath wrote:
>>>
>>> On Wednesday 22 July 2015 12:40 AM, Stephen Boyd wrote:
>>>> On 07/21/2015 04:07 AM, Vaibhav Hiremath wrote:
>>>>> +
> 
> <snip>
> 
>>>>> +static int pm800_clk_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +    struct pm800_clk *pm800_clks = platform_get_drvdata(pdev);
>>>>> +    int i;
>>>>> +
>>>>> +    of_clk_del_provider(pm800_clks[0].clk_np);
>>>>> +    /* Drop the reference obtained in pm800_clk_parse_dt */
>>>>> +    of_node_put(pm800_clks[0].clk_np);
>>>>
>>>> This is odd. Why are we keeping the reference in the driver?
>>>>
>>>
>>> Honestly I do not have any good answer here. I have to admit that it is
>>> getting carry forwarded from legacy driver.
>>>
>>
>> Well we shouldn't do things if we don't know why we're doing them.
>> Krzysztof?

I am really busy now so I am not following closely other discussions. I
assume you are referring to clk-s2mps11.c. The of_node_put() matches
of_get_child_by_name() when parsing DT.

So why not of_node_put() just after parsing DT? Well, the result of
of_get_child_by_name() is stored in state container for entire device
life-cycle so we can use it in of_clk_del_provider().

That was the idea behind it. If it looks incorrect I would be happy to
see a patch :) .

>>
> 
> Hold on,
> After looking more in to this, it seems we really do not need it.
> It is already taken care by
> 
> of_clk_add_provider() and
> of_clk_del_provider()
> 
> Sorry for not investigating this before. Just left out from my eyes
> somehow.
> 
> 
> Actually I can cleanup clk-s2mps11.c driver as well, but only thing is
> I can validate it, as I do not have platform to test it.
> It should be trivial changes.
> 
> If somebody can help me out in validation I can submit the patch for
> clk-s2mps11.c driver as well.

Sure, I can do this. The clock is present on few devices I can test.
Depending on the current workqueue it may take few days. Just please
mark the patch RFT so it won't be applied before receiving
reviewed/tested tags.

Best regards,
Krzysztof
