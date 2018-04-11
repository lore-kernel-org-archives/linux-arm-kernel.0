From: sgoel@codeaurora.org (Goel, Sameer)
Date: Wed, 11 Apr 2018 09:54:49 -0600
Subject: [PATCH] iommu/arm-smmu-v3: Set GBPA to abort all transactions
In-Reply-To: <20180405112622.GE23485@arm.com>
References: <1522247980-31892-1-git-send-email-timur@codeaurora.org>
 <20180405112622.GE23485@arm.com>
Message-ID: <0b58c706-e2f9-83c0-7936-f13de79e2010@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/5/2018 5:26 AM, Will Deacon wrote:
> On Wed, Mar 28, 2018 at 09:39:40AM -0500, Timur Tabi wrote:
>> From: Sameer Goel <sgoel@codeaurora.org>
>>
>> Set SMMU_GBPA to abort all incoming translations during the SMMU reset
>> when SMMUEN==0.
>>
>> This prevents a race condition where a stray DMA from the crashed primary
>> kernel can try to access an IOVA address as an invalid PA when SMMU is
>> disabled during reset in the crash kernel.
>>
>> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 3f2f1fc68b52..c04a89310c59 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -2458,6 +2458,18 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>>  	if (reg & CR0_SMMUEN)
>>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>>  
>> +	/*
>> +	 * Abort all incoming translations. This can happen in a kdump case
>> +	 * where SMMU is initialized when a prior DMA is pending. Just
>> +	 * disabling the SMMU in this case might result in writes to invalid
>> +	 * PAs.
>> +	 */
>> +	ret = arm_smmu_update_gbpa(smmu, 1, GBPA_ABORT);
>> +	if (ret) {
>> +		dev_err(smmu->dev, "GBPA not responding to update\n");
>> +		return ret;
>> +	}
> 
> This needs to be predicated on the disable_bypass option, otherwise I think
> it will cause regressions for systems that rely on passthrough.
Ok, I'll make the change.
> 
> Will
> 

-- 
 Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
