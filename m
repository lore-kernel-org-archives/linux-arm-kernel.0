From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 12:00:06 -0600
Subject: [PATCH v2 16/22] iommu/tegra: smmu: Get "nvidia,swgroup" from DT
In-Reply-To: <20130729.143950.524913713971518557.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-17-git-send-email-hdoyu@nvidia.com><51E84FFA.8020509@wwwdotorg.org>
 <20130729.143950.524913713971518557.hdoyu@nvidia.com>
Message-ID: <51F6ADA6.3040006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 05:39 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Thu, 18 Jul 2013 22:28:42 +0200:
> 
>> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
>>> This provides the info about which H/W Accelerators are supported on
>>> Tegra SoC. This info is passed from DT. This is necessary to have the
>>> unified SMMU driver among Tegra SoCs. Instead of using platform data,
>>> DT passes "nvidia,swgroup" now. DT is mandatory in Tegra.
>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
>>
>>> +- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
>>> +  Each bit represents one swgroup. The assignments may be found in header
>>> +  file <dt-bindings/memory/tegra-swgroup.h>.
>>
>> There needs to be a default for this field if one is not specified so
>> that existing DTs continue to work without modification.
> 
> Only enabling PPCS(AHB) can be an option because PPCS has SD/MMC where
> rootfs can be located ususally.

There's no reason that the root filesystem has to be on SD/MMC. Either
way, the DT binding shouldn't be influenced by the root fs location at all.

I think more explanation of exactly what this property does and why is
required.

>> How many cells big is this property?
> 
> 64

I assume that's bits, so 2 cells? To be clear: the document needs to
include this information, not just this email thread.

>> Is this really a bitmap of HWAs? Surely it's a bitmap of SMMU client
>> IDs?
> 
> At least this info can be used for PMC too.

How and why? A complete explanation of how the SMMU and PMC are expected
to interact is required.

The PMC DT binding should include all information related to the PMC;
the binding definitions probably shouldn't expect a PMC driver to go
grovelling in an SMMU node to find information.

> .....
>>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>>
>>> @@ -265,7 +265,7 @@ struct smmu_client {
>>>  	struct device		*dev;
>>>  	struct list_head	list;
>>>  	struct smmu_as		*as;
>>> -	u32			hwgrp;
>>> +	u64			hwgrp;
>>
>> Why is that "hwgrp" not "swgrp"? Don't they represent the same
>> thing?
> 
> They are same but initial SMMU driver used the term "hwgroup". Should
> this be renamed with another patch or can it be left as it is?

I thought there had already been a patch to do this rename. Was it not
complete? If so, that work should probably be completed.

> ....
>>>  static int __smmu_client_set_hwgrp(struct smmu_client *c,
>>> -				   unsigned long map, int on)
>>> +				   u64 map, int on)
>>>  {
>>>  	int i;
>>>  	struct smmu_as *as = c->as;
>>> @@ -398,12 +400,11 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
>>>  	if (!on)
>>>  		map = smmu_client_hwgrp(c);
>>>  
>>> -	for_each_set_bit(i, &map, HWGRP_COUNT) {
>>> +	for_each_set_bit(i, (unsigned long *)&map,
>>> +			 sizeof(map) * BITS_PER_BYTE) {
>>
>> Why change the type if it just forces you to add this cast?
> 
> u32 map; -> u64 map;
> 
> for_each_set_bit() expects "unsigned long *" for any length of bitmap.

Shouldn't the map just be an "unsigned long map[]" then, so no casts are
needed anywhere? Equally, that pointer could just be passed to the
function rather than copying the data to the stack?
