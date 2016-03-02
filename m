From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Wed, 2 Mar 2016 03:23:57 +0000
Subject: [PATCH] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
In-Reply-To: <20160302030756.GC7637@arm.com>
References: <1456348433-3337-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160302030756.GC7637@arm.com>
Message-ID: <C2D36A36-8247-4432-BE50-14129D9D8E5B@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org






On 3/1/16, 7:07 PM, "Will Deacon" <will.deacon@arm.com> wrote:

>On Wed, Feb 24, 2016 at 01:13:53PM -0800, Tirumalesh Chalamarla wrote:
>> Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
>> namespaces; specifically within a given node SMMU0 and SMMU1 share,
>> as does SMMU2 and SMMU3.
>> 
>> This patch address these issuee by supplying asid and vmid
>> while calculating ASID and VMID for Thunder SMMUv2.
>> 
>> NOTE: resending with commit message fix.
>> 
>> changes from V2:
>> 	- removed *_base from DT, and replaced with compatible string
>> 
>> changes from V1:
>> 	- rebased on top of 16 bit VMID patch
>> 	- removed redundent options from DT
>> 	- insted of transform, DT now supplies starting ASID/VMID
>> 
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>> Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula@caviumnetworks.com>
>> ---
>>  .../devicetree/bindings/iommu/arm,smmu.txt         |  1 +
>>  drivers/iommu/arm-smmu.c                           | 48 +++++++++++++++++-----
>>  2 files changed, 38 insertions(+), 11 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 7180745..19fe6f2 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -16,6 +16,7 @@ conditions.
>>                          "arm,mmu-400"
>>                          "arm,mmu-401"
>>                          "arm,mmu-500"
>> +                        "cavium,smmu-v2"
>>  
>>                    depending on the particular implementation and/or the
>>                    version of the architecture implemented.
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 247a469..c704f88 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -326,6 +326,12 @@ struct arm_smmu_device {
>>  
>>  	struct list_head		list;
>>  	struct rb_root			masters;
>> +	/*
>> +	 *The following fields are specific to Cavium, Thunder
>> +	 */
>> +	u32				cavium_smmu_id;
>
>Why do you need this field as well as the base?
Will be removed. 
>
>> +	u32				cavium_id_base;
>> +
>>  };
>>  
>>  struct arm_smmu_cfg {
>> @@ -335,8 +341,8 @@ struct arm_smmu_cfg {
>>  };
>>  #define INVALID_IRPTNDX			0xff
>>  
>> -#define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
>> -#define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
>> +#define ARM_SMMU_CB_ASID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx)
>> +#define ARM_SMMU_CB_VMID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx + 1)
>>  
>>  enum arm_smmu_domain_stage {
>>  	ARM_SMMU_DOMAIN_S1 = 0,
>> @@ -364,6 +370,8 @@ struct arm_smmu_option_prop {
>>  	const char *prop;
>>  };
>>  
>> +static int cavium_smmu_count;
>
>I'd be more comfortable if this was an atomic_t.

Sure.
>
>> +	/*
>> +	 * Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
>> +	 * namespaces; specifically within a given node SMMU0 and SMMU1 share,
>> +	 * as does SMMU2 and SMMU3. see if this is a Cavium SMMU, if so
>> +	 * set asid and vmid base such that each SMMU gets unique
>> +	 * asid/vmid space.
>> +	 */
>> +	if (!strcasecmp(of_id->compatible, "cavium,smmu-v2")) {
>
>of_device_is_compatible
Sure.
>
>> +		/* VMID16 must be present on Cavium SMMUv2*/
>> +		if (!(smmu->features & ARM_SMMU_FEAT_VMID16))
>> +			goto out_free_irqs;
>
>This check seems a bit overkill. I think you can remove it.
I don?t think it is possible to support unique ASID space with out 16 bit VMID.
But I can remove this check if that?s implicit. 
>
>> +		smmu->cavium_smmu_id = cavium_smmu_count;
>> +		cavium_smmu_count++;
>> +		smmu->cavium_id_base =
>> +			(smmu->cavium_smmu_id * ARM_SMMU_MAX_CBS);
>
>Can you not use num_context_banks here, instead of the constant?
We need total context banks so far, so ARM_SMMU_MAX_CBS is best option.
For Thunder both are same anyway.  
>
>Will
