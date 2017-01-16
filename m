From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 16 Jan 2017 17:09:05 +0300
Subject: [RFC PATCH] IOMMU: SMMUv2: Support for Extended Stream ID (16 bit)
In-Reply-To: <63d66004-bf8c-146d-2af4-b5f035159480@arm.com>
References: <20170110115755.19102-1-aleksey.makarov@linaro.org>
 <63d66004-bf8c-146d-2af4-b5f035159480@arm.com>
Message-ID: <9572b6db-478e-051f-d1db-adf40c69299f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/11/2017 05:15 PM, Robin Murphy wrote:
> On 10/01/17 11:57, Aleksey Makarov wrote:
>> Enable the Extended Stream ID feature when available.
>>
>> This patch on top of series "[PATCH v7 00/19] KVM PCIe/MSI passthrough
>> on ARM/ARM64 and IOVA reserved regions" by Eric Auger allows
>> to passthrough an external PCIe network card on a ThunderX server
>> successfully.
>>
>> Without this patch that card caused a warning like
>>
>> 	pci 0006:90:00.0: stream ID 0x9000 out of range for SMMU (0x7fff)
>>
>> during boot.
>>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 53 +++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 37 insertions(+), 16 deletions(-)
>>

[...]

>> @@ -1761,7 +1772,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>  			   "\t(IDR0.CTTW overridden by FW configuration)\n");
>>  
>>  	/* Max. number of entries we have for stream matching/indexing */
>> -	size = 1 << ((id >> ID0_NUMSIDB_SHIFT) & ID0_NUMSIDB_MASK);
>> +	if (smmu->version == ARM_SMMU_V2 && id & ID0_EXIDS) {
>> +		smmu->features |= ARM_SMMU_FEAT_EXIDS;
>> +		size = (1 << 16);
> 
> Unnecessary parentheses.

Thank you

>> +	} else {
>> +		size = 1 << ((id >> ID0_NUMSIDB_SHIFT) & ID0_NUMSIDB_MASK);
>> +	}
> 
> Given what the architecture says about the relationship between EXIDS
> and NUMSIDB, I suppose an even shorter version could be:
> 
> 	if (smmu->version == ARM_SMMU_V2 && id & ID0_EXIDS)
> 		size *= 2;
> 
> but I'm not sure that's actually any nicer to read.

I think it is not nicer: the one who reads this needs to know what is the value of NUMSIDB
in the case id & ID0_EXIDS == true; and also this makes the code depend on this, i. e.
on the correct implementation of hardware.

So I would like to leave it as is.  If you are not agree, I will change it.

>>  	smmu->streamid_mask = size - 1;
>>  	if (id & ID0_SMS) {
>>  		u32 smr;
>> @@ -1774,20 +1790,25 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>  			return -ENODEV;
>>  		}
>>  
>> -		/*
>> -		 * SMR.ID bits may not be preserved if the corresponding MASK
>> -		 * bits are set, so check each one separately. We can reject
>> -		 * masters later if they try to claim IDs outside these masks.
>> -		 */
>> -		smr = smmu->streamid_mask << SMR_ID_SHIFT;
>> -		writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
>> -		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
>> -		smmu->streamid_mask = smr >> SMR_ID_SHIFT;
>> -
>> -		smr = smmu->streamid_mask << SMR_MASK_SHIFT;
>> -		writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
>> -		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
>> -		smmu->smr_mask_mask = smr >> SMR_MASK_SHIFT;
>> +		if (smmu->features & ARM_SMMU_FEAT_EXIDS) {
>> +			smmu->smr_mask_mask = smmu->streamid_mask;
>> +		} else {
>> +			/*
>> +			 * SMR.ID bits may not be preserved if the corresponding
>> +			 * MASK bits are set, so check each one separately.
>> +			 * We can reject masters later if they try to claim IDs
>> +			 * outside these masks.
>> +			 */
>> +			smr = smmu->streamid_mask << SMR_ID_SHIFT;
>> +			writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
>> +			smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
>> +			smmu->streamid_mask = smr >> SMR_ID_SHIFT;
>> +
>> +			smr = smmu->streamid_mask << SMR_MASK_SHIFT;
>> +			writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
>> +			smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
>> +			smmu->smr_mask_mask = smr >> SMR_MASK_SHIFT;
>> +		}
> 
> This hunk is quite possibly wrong. I don't see any guarantee in the
> architecture that all EXMASK/EXID bits *must* be implemented, and even
> so there's still no harm in the driver determining that experimentally.
> It looks like we need a bit of refactoring such that we move the probing
> of SMR fields to after counting and allocating the SME structures, then
> in the EXIDS case we can explicitly clear the SMEs and poke EXIDENABLE
> inbetween.

I am not quite sure I understand where you are suggesting to poke EXIDENABLE.
I am going to send v2 of the patch, I'd appreciate if you would review that please.

Thank you for review
Aleksey Makarov
