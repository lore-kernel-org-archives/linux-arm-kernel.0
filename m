From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 9 Aug 2017 14:41:52 -0700
Subject: [PATCH v2] iommu/arm-smmu: fix null-pointer dereference in
 arm_smmu_add_device
In-Reply-To: <20170808112144.GE13355@arm.com>
References: <20170808092614.GB12887@arm.com>
 <1502187962-16861-1-git-send-email-asavkov@redhat.com>
 <d7a07e48-862d-a6f7-8bad-9c71f5a5be5b@arm.com>
 <20170808112144.GE13355@arm.com>
Message-ID: <c399a57d-074f-71ee-b467-91cf4e65b3d9@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2017 04:21 AM, Will Deacon wrote:
> [+ Joerg]
> 
> On Tue, Aug 08, 2017 at 11:37:40AM +0100, Robin Murphy wrote:
>> On 08/08/17 11:26, Artem Savkov wrote:
>>> Commit c54451a "iommu/arm-smmu: Fix the error path in arm_smmu_add_device"
>>> removed fwspec assignment in legacy_binding path as redundant which is
>>> wrong. It needs to be updated after fwspec initialisation in
>>> arm_smmu_register_legacy_master() as it is dereferenced later. Without
>>> this there is a NULL-pointer dereference panic during boot on some hosts.
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>> Thanks for fixing it up, and sorry for failing to document the
>> unfortunately subtle logic in the first place!
> 
> Well, I was the one that messed it up:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Joerg, can you pick this up as a fix for 4.13, please?

I hit the Oops as well.  This patch fixes it for me on a Cavium CN88xx 
system, so:

Acked-by: David Daney <david.daney@cavium.com>

Thanks for working on this.



> 
> Will
> 
>>> Signed-off-by: Artem Savkov <asavkov@redhat.com>
>>> ---
>>>   drivers/iommu/arm-smmu.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index b97188a..2d80fa8 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1519,6 +1519,13 @@ static int arm_smmu_add_device(struct device *dev)
>>>   
>>>   	if (using_legacy_binding) {
>>>   		ret = arm_smmu_register_legacy_master(dev, &smmu);
>>> +
>>> +		/*
>>> +		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
>>> +		 * will allocate/initialise a new one. Thus we need to update fwspec for
>>> +		 * later use.
>>> +		 */
>>> +		fwspec = dev->iommu_fwspec;
>>>   		if (ret)
>>>   			goto out_free;
>>>   	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
>>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
