From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Jul 2015 15:03:11 -0700
Subject: [PATCH 3/4] clk: 88pm800: Add clk provider driver for 88pm800
 family of devices
In-Reply-To: <55AF5175.2010701@linaro.org>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55AE990E.2040004@codeaurora.org> <55AE9F48.20600@linaro.org>
 <55AEB103.9010205@codeaurora.org> <55AF37D9.3000006@linaro.org>
 <55AF3C2E.7010205@samsung.com> <55AF5175.2010701@linaro.org>
Message-ID: <55B0131F.80404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 01:16 AM, Vaibhav Hiremath wrote:
>
>
> On Wednesday 22 July 2015 12:16 PM, Krzysztof Kozlowski wrote:
>>
>> I am really busy now so I am not following closely other discussions. I
>> assume you are referring to clk-s2mps11.c. The of_node_put() matches
>> of_get_child_by_name() when parsing DT.
>>
>> So why not of_node_put() just after parsing DT? Well, the result of
>> of_get_child_by_name() is stored in state container for entire device
>> life-cycle so we can use it in of_clk_del_provider().
>>
>> That was the idea behind it. If it looks incorrect I would be happy to
>> see a patch :) .
>>
>
> About to respond, I digged more on kobject stuff and sequence in
> of/dynamic.c and
>
> I think you are right, we need of_node_put, as a result of
> of_get_child_by_name().
>
> Stephen,
> Please let me know if you think otherwise.
>

Yes, sounds fine. I was thinking that we grab the reference to the node 
in of_clk_add_provider() so dropping it here was to undo that, but that 
isn't true. It probably can be dropped after we register the provider 
because adding the provider will keep it pinned, but this way is more 
symmetric so it's fine.

Either way, the error path on probe doesn't call of_node_put(), so 
that's a leak.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
