From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 21 Mar 2018 13:24:22 +0000
Subject: [PATCH 27/37] iommu/arm-smmu-v3: Register fault workqueue
In-Reply-To: <f2841aac-4c5e-4ac2-fa4d-81d6b2857503@huawei.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-27-git-send-email-xieyisheng1@huawei.com>
 <f2841aac-4c5e-4ac2-fa4d-81d6b2857503@huawei.com>
Message-ID: <cabd71fd-c54c-c21a-a5b7-227e69fa4286@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yisheng,

On 19/03/18 11:03, Yisheng Xie wrote:
> Hi Jean,
> 
> [...]
>> @@ -3168,6 +3260,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI)) {
>> +		smmu->faultq_nb.notifier_call = arm_smmu_flush_queues;
>> +		ret = iommu_fault_queue_register(&smmu->faultq_nb);
>> +		if (ret)
>> +			return ret;
> 
> I find a case here: CONFIG_IOMMU_FAULT=n, and smmu support feature STALLS or PRI,
> the device probe will failed here, is this what we want?

Since CONFIG_ARM_SMMU_V3 selects CONFIG_IOMMU_FAULT, I don't think it
can happen. I'm not sure what the best practices are, but I feel like it
would be too much work to guard against config combinations that violate
an explicit "select" in Kconfig

Thanks,
Jean
