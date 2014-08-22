From: ohaugan@codeaurora.org (Olav Haugan)
Date: Fri, 22 Aug 2014 16:56:23 -0700
Subject: [PATCH v3 1/1] iommu/arm-smmu: Do not access non-existing S2CR
 registers
In-Reply-To: <20140822152215.GC17255@arm.com>
References: <1408403858-16766-1-git-send-email-ohaugan@codeaurora.org>
 <20140822152215.GC17255@arm.com>
Message-ID: <53F7D8A7.4010508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/2014 8:22 AM, Will Deacon wrote:
> Hi Olav,
> 
> Some really minor comments, but this looks good.
> 
> On Tue, Aug 19, 2014 at 12:17:38AM +0100, Olav Haugan wrote:
>> The number of S2CR registers is not properly set when stream
>> matching is not supported. Fix this and add check that we do not try to
>> access outside of the number of S2CR regisrers.
>>
>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 9fd8754d..a050f7a 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -548,9 +548,16 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
>>  	master->of_node			= masterspec->np;
>>  	master->cfg.num_streamids	= masterspec->args_count;
>>  
>> -	for (i = 0; i < master->cfg.num_streamids; ++i)
>> +	for (i = 0; i < master->cfg.num_streamids; ++i) {
>> +		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
>> +		     (masterspec->args[i] >= smmu->num_mapping_groups)) {
> 
> Can we stick masterspec->args[i] into a loop-local streamid variable,
> please?
> 
>> +			dev_err(dev,
>> +				"stream ID for master device %s greater than maximum allowed (%d)\n",
>> +				masterspec->np->name, smmu->num_mapping_groups);
>> +			return -ENOSPC;
> 
> -ERANGE might be better.
> 

Sure, will post v4 with these changes.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
