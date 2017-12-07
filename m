From: lollivier@baylibre.com (Loys Ollivier)
Date: Thu, 7 Dec 2017 10:34:11 +0100
Subject: [PATCH v2] firmware: qcom: scm: Fix incorrect of_node_put call in
 scm_init
In-Reply-To: <40113581-4b8c-defe-ba90-0aabc30a1b6d@linaro.org>
References: <1512555692-14439-1-git-send-email-lollivier@baylibre.com>
 <20171206200601.GH4283@codeaurora.org>
 <40113581-4b8c-defe-ba90-0aabc30a1b6d@linaro.org>
Message-ID: <c049d689-44f0-3ee6-ca50-af4873545fce@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/12/2017 09:42, Jerome Forissier wrote:
> 
> 
> On 12/06/2017 09:06 PM, Stephen Boyd wrote:
>> On 12/06, Loys Ollivier wrote:
>>> When using other platform architectures, in the init of the qcom_scm
>>> driver, of_node_put is called on /firmware if no qcom dt is found.
>>> This results in a kernel error: Bad of_node_put() on /firmware.
>>>
>>> The call to of_node_put from the qcom_scm init is unnecessary as
>>> of_find_matching_node is calling it automatically.
>>>
>>> Remove this of_node_put().
>>>
>>> Fixes: d0f6fa7ba2d6 ("firmware: qcom: scm: Convert SCM to platform driver")
>>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>>> ---
>>
>> This still looks wrong. Especially if of_find_matching_node() is
>> going to look for siblings of the /firmware node for the
>> compatible string for scm device. Why do we check at all? Can't
>> we just delete this and let of_platform_populate() take care of
>> it? BTW, OP-TEE driver seems to have a similar problem.
> 
> https://lkml.org/lkml/2017/11/29/230
>
Well, the patch I sent is a fix for a specific bug I am encountering.
I tested the patch and it solves my problem. Stephen, your changes looks
good but it's a change in the driver's behavior. Maybe it could be
another patch ?
It looks like OP-TEE had the same idea.
>>
>> ---8<----
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index af4c75217ea6..440d8f796faa 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -626,23 +626,11 @@ static int __init qcom_scm_init(void)
>>  	int ret;
>>  
>>  	fw_np = of_find_node_by_name(NULL, "firmware");
>> -
>>  	if (!fw_np)
>> -		return -ENODEV;
>> -
>> -	np = of_find_matching_node(fw_np, qcom_scm_dt_match);
>> -
>> -	if (!np) {
>> -		of_node_put(fw_np);
>> -		return -ENODEV;
>> -	}
>> -
>> -	of_node_put(np);
>> +		return 0;
>>  
>>  	ret = of_platform_populate(fw_np, qcom_scm_dt_match, NULL, NULL);
>> -
>>  	of_node_put(fw_np);
>> -
>>  	if (ret)
>>  		return ret;
>>  
>>
