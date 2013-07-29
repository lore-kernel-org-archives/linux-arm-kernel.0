From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 11:41:23 -0600
Subject: [PATCH v2 21/22] iommu/tegra: smmu: Support Multiple ASID
In-Reply-To: <20130729.133155.1836775489422797370.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-22-git-send-email-hdoyu@nvidia.com><51E8535A.30605@wwwdotorg.org>
 <20130729.133155.1836775489422797370.hdoyu@nvidia.com>
Message-ID: <51F6A943.8000004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 04:31 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Thu, 18 Jul 2013 22:43:06 +0200:
> 
>> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
>>> Support Multiple Address Space(AS). Tegra SMMU can have multiple
>>> ASes. We reserve 2 of them for static assignment, AS[0] for system
>>> default, AS[1] for AHB clusters as protected domain from others, where
>>> there are many traditional pheripheral devices like USB, SD/MMC. They
>>> should be isolated from some smart devices like host1x for system
>>> robustness. Even if smart devices behaves wrongly, the traditional
>>> devices(SD/MMC, USB) wouldn't be affected, and the system could
>>> continue most likely.
>>
>>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>>
>>>  static int smmu_iommu_add_device(struct device *dev)
>>>  {
>>>  	int err;
>>> -	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
>>> +	u64 swgroup;
>>> +	struct dma_iommu_mapping *map = NULL;
>>> +
>>> +	swgroup = smmu_of_get_memory_client(dev);
>>> +	switch (swgroup) {
>>> +	case TEGRA_SWGROUP_BIT(PPCS):
>>> +		map = smmu_handle->map[SYSTEM_PROTECTED];
>>> +		break;
>>> +	default:
>>> +		map = smmu_handle->map[SYSTEM_DEFAULT];
>>
>> I already mentioned this, but just for completeness: What is
>> smmu->num_as <= SYSTEM_DEFAULT?
> 
> I think that this belongs to the system operation policy. Which H/W
> should be configured to which Address Space(AS). This put all AHB
> clients(PPCS) into AS[1](SYSTEM_PROTECTED), and the rest into
> AS[0](SYSTEM_DEFAULT). AHB clients are mainly traditional H/Ws like
> USB and SD/MMC so that they should be kept separated from the smart
> IOMMU clients like host1x.
> 
> Is there any place to configure this kind of board specific policy
> rather than here?

I'm not sure that answers the question I asked.

I mean that the driver expects that two AS always exist;
SYSTEM_PROTECTED and SYSTEM_DEFAULT. However, the set of extant ASs is
IIRC defined by the DT content. What if the DT doesn't define two ASs?
Shouldn't there at least be an error-check for this case, so the driver
doesn't just blindly continue and access smmu_handle->map[1] when the
map[] array only has 1 entry?
