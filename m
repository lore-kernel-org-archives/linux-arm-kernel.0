From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 14 Mar 2018 13:09:50 +0000
Subject: [PATCH 31/37] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <20180308171725.0000763c@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-32-jean-philippe.brucker@arm.com>
 <20180308171725.0000763c@huawei.com>
Message-ID: <31673218-f051-3e31-e5fe-37de44edd443@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/18 16:17, Jonathan Cameron wrote:
>> +	arm_smmu_enable_ats(master);
> It's a bit nasty not to handle the errors that this could output (other than
> the ENOSYS for when it's not available). Seems that it would be nice to at
> least add a note to the log if people are expecting it to work and it won't
> because some condition or other isn't met.

I agree it's not ideal. Last time this came up the problem was that
checking if ATS is supported requires an ugly ifdef. A proper
implementation requires more support in the PCI core, e.g. a
pci_ats_supported() function.

https://www.spinics.net/lists/kvm/msg145932.html

>> +
>>  	group = iommu_group_get_for_dev(dev);
>> -	if (!IS_ERR(group)) {
>> -		arm_smmu_insert_master(smmu, master);
>> -		iommu_group_put(group);
>> -		iommu_device_link(&smmu->iommu, dev);
>> +	if (IS_ERR(group)) {
>> +		ret = PTR_ERR(group);
>> +		goto err_disable_ats;
>>  	}
>>  
>> -	return PTR_ERR_OR_ZERO(group);
>> +	iommu_group_put(group);
>> +	arm_smmu_insert_master(smmu, master);
>> +	iommu_device_link(&smmu->iommu, dev);
>> +
>> +	return 0;
>> +
>> +err_disable_ats:
>> +	arm_smmu_disable_ats(master);
> master is leaked here I think...
> Possibly other things as this doesn't line up with the
> remove which I'd have mostly expected it to do.

> There are some slightly fishy bits of ordering in the original code
> anyway that I'm not seeing justification for (why is
> the iommu_device_unlink later than one might expect for
> example).

Yeah, knowing the rest of the probing code, there may exist subtle legacy
reasons for not freeing the master here and the strange orderings. I try
to keep existing behaviors where possible since I barely even have the
bandwidth to fix my own code.

Thanks,
Jean
