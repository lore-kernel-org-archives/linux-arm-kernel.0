From: nwatters@codeaurora.org (Nate Watterson)
Date: Thu, 29 Jun 2017 18:20:00 -0400
Subject: [PATCH] iommu/arm-smmu-v3: Implement shutdown method
In-Reply-To: <20170629183438.GF5592@arm.com>
References: <1498758015-7072-1-git-send-email-nwatters@codeaurora.org>
 <20170629183438.GF5592@arm.com>
Message-ID: <5f655f54-a843-af16-e9e3-0e0d84565994@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/29/2017 2:34 PM, Will Deacon wrote:
> On Thu, Jun 29, 2017 at 01:40:15PM -0400, Nate Watterson wrote:
>> The shutdown method disables the SMMU and its interrupts to avoid
>> potentially corrupting a new kernel started with kexec.
>>
>> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
> 
> We should update arm-smmu.c as well.
> 
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 380969a..907d576 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -2765,9 +2765,19 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>   	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>>   
>>   	arm_smmu_device_disable(smmu);
>> +
>> +	/* Disable IRQs */
>> +	arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
>> +				ARM_SMMU_IRQ_CTRLACK);
>> +
> 
> Can you justify the need for this? If we actually need to disable
> interrupts, then I'd like to understand why so that we can make sure we
> get the ordering right with respect to disabling the device. Also, do we
> need to clear the MSI registers too?

I have no justification. Based on the number of drivers that take care
to prevent their HW from generating an interrupt, I thought it would be
required, but I can't find any such requirement explicitly laid out in
the documentation.

When you mention the MSI registers do you mean, for instance,
SMMU_GERROR_IRQ_CFG0? It looks like those are always cleared while
initializing the SMMU so the case where an SMMU transitions from using
MSIs to using wired interrupts between kernels will be handled properly.

> 
> My understanding is that kexec will mask irqs at the GIC, so there's not
> actually an issue here.
> 
> Will
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
