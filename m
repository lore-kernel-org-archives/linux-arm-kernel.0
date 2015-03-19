From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 19 Mar 2015 17:52:54 +0000
Subject: [UPDATED] [PATCH 3/5] arm-cci: Get rid of secure transactions
 for PMU driver
In-Reply-To: <550B09A1.4020801@arm.com>
References: <1426000735-14375-4-git-send-email-suzuki.poulose@arm.com>
 <1426585901-19137-1-git-send-email-suzuki.poulose@arm.com>
 <20150319173252.GC10153@leverpostej> <550B09A1.4020801@arm.com>
Message-ID: <550B0CF6.8070205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/15 17:38, Sudeep Holla wrote:
>
>
> On 19/03/15 17:32, Mark Rutland wrote:
>> One more thing:
>>
>>> @@ -883,7 +894,11 @@ static inline const struct cci_pmu_model *get_cci_model(struct platform_device *
>>>    							pdev->dev.of_node);
>>>    	if (!match)
>>>    		return NULL;
>>> +	if (match->data)
>>> +		return match->data;
>>>
>>> +	dev_warn(&pdev->dev, "DEPRECATED compatible property,"
>>> +			 "requires secure access to CCI registers");
>>>    	return probe_cci_model(pdev);
>>>    }
>>
>> Before the probe, could we please have:
>>
>> 	if (!IS_ENABLED(CONFIG_ARM))
>> 		return -EINVAL;
>>
>> On arm64 we require a model-specific string, and we shouldn't go
>> touching secure-only registers.
>>
>
> IIUC platform_has_secure_cci_access always return false for ARM64
> preventing any secure access. No ?
>
Yes, you are right. The check has been abstracted away with the 
platform_has_secure_cci_access().

Cheers
Suzuki
