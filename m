From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 07 Jul 2015 17:03:36 +0100
Subject: [PATCH v4 3/8] clk: add support for clocks provided by SCP(System
 Control Processor)
In-Reply-To: <559ADC94.4080505@codeaurora.org>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-4-git-send-email-sudeep.holla@arm.com>
 <20150702172310.GF4301@codeaurora.org> <5596A1B6.8020307@arm.com>
 <559ADC94.4080505@codeaurora.org>
Message-ID: <559BF858.1020301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/07/15 20:52, Stephen Boyd wrote:
> On 07/03/2015 07:52 AM, Sudeep Holla wrote:
>> Hi Stephen,
>>
>>
>> Thanks for the review.
>>
>> On 02/07/15 18:23, Stephen Boyd wrote:
>>> On 06/08, Sudeep Holla wrote:

[...]

>>>> +
>>>> +    clk = devm_clk_register(dev, &sclk->hw);
>>>> +    if (!IS_ERR(clk) && max)
>>>> +        clk_set_rate_range(clk, min, max);
>>>
>>> Hm.. we're planning to make clk_register() return a struct
>>> clk_hw, so this will block that. We need some sort of clk_hw API
>>> that allows us to setup min/max limits on the clock from the
>>> provider side. Care to add that?
>>>
>>
>> Can you provide pointer to the patches or the tree containing those
>> changes ? Are they targeted for v4.3 ?
>>
>
> If I have time I may try to start doing the clk_register() conversion,
> but it will take a while so I doubt it will be in v4.3. I'm asking if
> you can add a clk_hw based API that does something like
> clk_set_rate_range() without requiring a struct clk pointer. i.e.
> clk_hw_set_rate_range(struct clk_hw *hw, min, max) that constraints the
> min/max rate of the clock. This way, the driver is only using clk
> provider APIs and not clk consumer APIs.
>

I understand the intention of separating clk provider helpers/APIs
and clk consumer APIs. Since {min,max}_rate are part of struct clk
itself, I was thinking that you would have moved it to struct clk_core
as part of the rework you mentioned and hence asked about the patches.

IIUC, if {min,max}_rate remain part of struct clk, then how are we
restricting that operation to just the clk providers ? clk consumer
can still directly modify or use clk_set_rate_range.

Do we continue to provide that feature for both provider and consumer ?
If so I assume {min,max}_rate range requested by consumer should be
within the limits set by provider and do we maintain both the limits ?

Sorry if I am missing something fundamental since I don't have much
knowledge of clk layer internals.

Regards,
Sudeep
