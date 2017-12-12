From: lollivier@baylibre.com (Loys Ollivier)
Date: Tue, 12 Dec 2017 16:35:03 +0100
Subject: [PATCH v2] firmware: qcom: scm: Fix incorrect of_node_put call in
 scm_init
In-Reply-To: <20171208170449.GD4283@codeaurora.org>
References: <1512555692-14439-1-git-send-email-lollivier@baylibre.com>
 <20171206200601.GH4283@codeaurora.org>
 <40113581-4b8c-defe-ba90-0aabc30a1b6d@linaro.org>
 <c049d689-44f0-3ee6-ca50-af4873545fce@baylibre.com>
 <20171208170449.GD4283@codeaurora.org>
Message-ID: <ba7de5fe-512a-a0d2-84c9-017831e4ef91@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/12/2017 18:04, Stephen Boyd wrote:
> On 12/07, Loys Ollivier wrote:
>>
>>
>> On 07/12/2017 09:42, Jerome Forissier wrote:
>>>
>>>
>>> On 12/06/2017 09:06 PM, Stephen Boyd wrote:
>>>> On 12/06, Loys Ollivier wrote:
>>>>> When using other platform architectures, in the init of the qcom_scm
>>>>> driver, of_node_put is called on /firmware if no qcom dt is found.
>>>>> This results in a kernel error: Bad of_node_put() on /firmware.
>>>>>
>>>>> The call to of_node_put from the qcom_scm init is unnecessary as
>>>>> of_find_matching_node is calling it automatically.
>>>>>
>>>>> Remove this of_node_put().
>>>>>
>>>>> Fixes: d0f6fa7ba2d6 ("firmware: qcom: scm: Convert SCM to platform driver")
>>>>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>>>>> ---
>>>>
>>>> This still looks wrong. Especially if of_find_matching_node() is
>>>> going to look for siblings of the /firmware node for the
>>>> compatible string for scm device. Why do we check at all? Can't
>>>> we just delete this and let of_platform_populate() take care of
>>>> it? BTW, OP-TEE driver seems to have a similar problem.
>>>
>>> https://lkml.org/lkml/2017/11/29/230
>>>
>> Well, the patch I sent is a fix for a specific bug I am encountering.
>> I tested the patch and it solves my problem. Stephen, your changes looks
>> good but it's a change in the driver's behavior. Maybe it could be
>> another patch ?
> 
> Sure. But there's another of_node_put(fw_np) in this function, so
> why isn't that also removed? Assuming of_find_matching_node() is
> calling of_node_put() on what's passed in, then the node is going
> to get put twice in the "working" case.
> 
> Andy?
>
Agreed, I had a look and this second call to of_node_put(fw_np) seem to
be unnecessary as well. Unfortunately I can't test your suggestion as I
am using another platform arch. I am just testing that this driver does
not break my arch.
I can submit a v3 removing this of_node_put as well if you want.
