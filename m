From: yang.shi@linaro.org (Shi, Yang)
Date: Fri, 15 Apr 2016 10:53:47 -0700
Subject: [PATCH] iommu/arm-smmu: Fix stream-match conflict with
 IOMMU_DOMAIN_DMA
In-Reply-To: <5711043C.5040308@linaro.org>
References: <1459527597-10740-1-git-send-email-will.deacon@arm.com>
 <5711043C.5040308@linaro.org>
Message-ID: <57112AAB.6050209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/15/2016 8:09 AM, Eric Auger wrote:
> Hi Will,
> On 04/01/2016 06:19 PM, Will Deacon wrote:
>> Commit cbf8277ef456 ("iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass
>> for now") ignores requests to attach a device to the default domain
>> since, without IOMMU-basked DMA ops available everywhere, the default
>> domain will just lead to unexpected transaction faults being reported.
>>
>> Unfortunately, the way this was implemented on SMMUv2 causes a
>> regression with VFIO PCI device passthrough under KVM on AMD Seattle.
>> On this system, the host controller device is associated with both a
>> pci_dev *and* a platform_device, and can therefore end up with duplicate
>> SMR entries, resulting in a stream-match conflict at runtime.
>>
>> This patch amends the original fix so that attaching to IOMMU_DOMAIN_DMA
>> is rejected even before configuring the SMRs. This restores the old
>> behaviour for now, but we'll need to look at handing host controllers
>> specially when we come to supporting the default domain fully.
>>
> Tested-by: Eric Auger <eric.auger@linaro.org>

Tested on my LS2085A board too.

Tested-by: Yang Shi <yang.shi@linaro.org>

Regards,
Yang

>
> Best Regards
>
> Eric
>> Reported-by: Eric Auger <eric.auger@linaro.org>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index e933679a3266..2f186d22477f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1098,18 +1098,20 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>   	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>>
>> -	/* Devices in an IOMMU group may already be configured */
>> -	ret = arm_smmu_master_configure_smrs(smmu, cfg);
>> -	if (ret)
>> -		return ret == -EEXIST ? 0 : ret;
>> -
>>   	/*
>>   	 * FIXME: This won't be needed once we have IOMMU-backed DMA ops
>> -	 * for all devices behind the SMMU.
>> +	 * for all devices behind the SMMU. Note that we need to take
>> +	 * care configuring SMRs for devices both a platform_device and
>> +	 * and a PCI device (i.e. a PCI host controller)
>>   	 */
>>   	if (smmu_domain->domain.type == IOMMU_DOMAIN_DMA)
>>   		return 0;
>>
>> +	/* Devices in an IOMMU group may already be configured */
>> +	ret = arm_smmu_master_configure_smrs(smmu, cfg);
>> +	if (ret)
>> +		return ret == -EEXIST ? 0 : ret;
>> +
>>   	for (i = 0; i < cfg->num_streamids; ++i) {
>>   		u32 idx, s2cr;
>>
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
