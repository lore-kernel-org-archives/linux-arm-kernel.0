From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 14 Mar 2018 13:09:10 +0000
Subject: [PATCH 28/37] iommu/arm-smmu-v3: Maintain a SID->device structure
In-Reply-To: <20180308183431.00005f86@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-29-jean-philippe.brucker@arm.com>
 <20180308183431.00005f86@huawei.com>
Message-ID: <4d83c676-604c-6003-5284-81e3535689a8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/18 17:34, Jonathan Cameron wrote:
>>  static int arm_smmu_add_device(struct device *dev)
>> @@ -2198,6 +2298,7 @@ static int arm_smmu_add_device(struct device *dev)
>>  
>>  	group = iommu_group_get_for_dev(dev);
>>  	if (!IS_ERR(group)) {
>> +		arm_smmu_insert_master(smmu, master);
> There are some error cases it would be good to take notice off when
> inserting the master.  Admittedly the same is true of iommu_device_link
> so I guess you are keeping with the existing code style.
> 
> Would also be nice if the later bit of rework to drop these out
> of the if statement was done before this patch in the series.

Not sure that's worth a separate patch, maybe we can do it here.

Thanks,
Jean

> 
>>  		iommu_group_put(group);
>>  		iommu_device_link(&smmu->iommu, dev);
>>  	}
>> @@ -2218,6 +2319,7 @@ static void arm_smmu_remove_device(struct device *dev)
>>  	smmu = master->smmu;
>>  	if (master && master->ste.assigned)
>>  		arm_smmu_detach_dev(dev);
>> +	arm_smmu_remove_master(smmu, master);
>>  	iommu_group_remove_device(dev);
>>  	iommu_device_unlink(&smmu->iommu, dev);
>>  	kfree(master);
>> @@ -2527,6 +2629,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>>  	int ret;
>>  
>>  	atomic_set(&smmu->sync_nr, 0);
>> +	mutex_init(&smmu->streams_mutex);
>> +	smmu->streams = RB_ROOT;
>> +
>>  	ret = arm_smmu_init_queues(smmu);
>>  	if (ret)
>>  		return ret;
> 
> 
