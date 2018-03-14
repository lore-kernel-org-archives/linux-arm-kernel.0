From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 14 Mar 2018 13:08:25 +0000
Subject: [PATCH 27/37] iommu/arm-smmu-v3: Register fault workqueue
In-Reply-To: <20180308184454.00000b4e@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-28-jean-philippe.brucker@arm.com>
 <20180308184454.00000b4e@huawei.com>
Message-ID: <78551b46-2a54-76cf-da61-72aeae4b0002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/18 17:44, Jonathan Cameron wrote:
>> @@ -3168,6 +3260,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI)) {
>> +		smmu->faultq_nb.notifier_call = arm_smmu_flush_queues;
>> +		ret = iommu_fault_queue_register(&smmu->faultq_nb);
> Here you register only if this smmu supports stalls or pri which is fine, but
> see the unregister path.
> 
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	/* And we're up. Go go go! */
>>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>>  				     "smmu3.%pa", &ioaddr);
>> @@ -3210,6 +3309,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>  {
>>  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>>  
>> +	iommu_fault_queue_unregister(&smmu->faultq_nb);
> 
> Here you unregister from the fault queue unconditionally.  That is mostly
> safe but it seems to decrement and potentially destroy the work queue that
> is in use by another smmu instance that does support page faulting.

Ah yes, we'll need to check this

Thanks,
Jean
