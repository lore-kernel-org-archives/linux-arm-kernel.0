From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Jan 2018 19:08:39 +0000
Subject: [PATCH] iommu/arm-smmu-v3: suppress MSI allocation failure message
In-Reply-To: <2f651cfe-e006-cf1d-b624-08e2ba5340fc@arm.com>
References: <1516214399-24012-1-git-send-email-nwatters@codeaurora.org>
 <2f651cfe-e006-cf1d-b624-08e2ba5340fc@arm.com>
Message-ID: <66706458-d971-be9b-4390-80a9be39248c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/18 18:54, Robin Murphy wrote:
> [ +Marc just in case ]
> 
> On 17/01/18 18:39, Nate Watterson wrote:
>> From: Sinan Kaya <okaya@codeaurora.org>
>>
>> Even though QDF2400 supports MSI interrupts with SMMUv3, it is not enabled
>> in ACPI FW to preserve compatibility with older kernel versions. Code is
>> emitting warning message during boot.
>>
>> This is causing some test tools to record a false warning and is causing
>> support issues.
>>
>> Better reduce the message level.
> 
> Ugh, that's unfortunate, since there are also plenty of genuine error 
> conditions encapsulated in there which we *would* want to report as such 
> (but still then fall back to wired IRQs if possible). Is the return 
> value sufficient to differentiate the "there is no MSI parent" and 
> "there are MSIs but something went wrong" cases, or is it more 
> complicated than that?

Indeed. How about checking dev->msi_domain first, which should tell you
whether it is even possible to allocate MSIs, and fallback to wired IRQs
instead. That way, we keep the warning on genuine failures to allocate
MSIs, and you get to add a nice "Falling back to wired interrupts"
message when msi_domain is NULL.

Thoughts?

	M.

> 
> Robin.
> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 744592d..2118fda 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -2331,7 +2331,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>   	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
>>   	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
>>   	if (ret) {
>> -		dev_warn(dev, "failed to allocate MSIs\n");
>> +		dev_info(dev, "failed to allocate MSIs\n");
>>   		return;
>>   	}
>>   
>>


-- 
Jazz is not dead. It just smells funny...
