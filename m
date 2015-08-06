From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 06 Aug 2015 17:31:24 +0100
Subject: [PATCH V2] iommu/arm-smmu-v2: ThunderX mis-extends 64bit registers
In-Reply-To: <20150806161625.GJ25483@arm.com>
References: <1438793668-15597-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20150806161625.GJ25483@arm.com>
Message-ID: <55C38BDC.4030304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/15 17:16, Will Deacon wrote:
> Hi Tirumalesh,
>
> I think this looks pretty good now, just one small comment below.
>
> On Wed, Aug 05, 2015 at 05:54:28PM +0100, Tirumalesh Chalamarla wrote:
[...]
>> -#define TTBRn_HI_ASID_SHIFT            16
>> +#define TTBRn_ASID_SHIFT		48
>>
>>   #define FSR_MULTI			(1 << 31)
>>   #define FSR_SS				(1 << 30)
>> @@ -762,22 +774,17 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>
>>   	/* TTBRs */
>>   	if (stage1) {
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
>> -		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
>> -
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
>> -		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
>> +		u64 reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>
> Can we move this declaration to the start of the function along with
> u32 reg, please? It's used in both cases of the if/else block so it
> might be a tad cleaner.

We could also drop the _LO suffix from the relevant #defines (so they 
match the architectural names) and remove the now-unused _HI versions 
entirely.

Robin.

>
> Will
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
