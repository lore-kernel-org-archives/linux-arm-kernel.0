From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 18 Sep 2018 20:22:21 +0100
Subject: [PATCH v7 6/6] iommu/arm-smmu: Support non-strict mode
In-Reply-To: <20180918171020.GM16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
 <09be4304bf23dde899be48dbddd93b09296f76bd.1536935328.git.robin.murphy@arm.com>
 <20180918171020.GM16498@arm.com>
Message-ID: <a6738582-2b18-8463-b525-73deb70797d1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-18 6:10 PM, Will Deacon wrote:
> On Fri, Sep 14, 2018 at 03:30:24PM +0100, Robin Murphy wrote:
>> All we need is to wire up .flush_iotlb_all properly and implement the
>> domain attribute, and iommu-dma and io-pgtable-arm will do the rest for
>> us. Rather than bother implementing it for v7s format for the highly
>> unlikely chance of that being relevant, we can simply hide the
>> non-strict flag from io-pgtable for that combination just so anyone who
>> does actually try it will simply get over-invalidation instead of
>> failure to initialise domains.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 40 +++++++++++++++++++++++++++++++++-------
>>   1 file changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index fd1b80ef9490..aa5be334753b 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -246,6 +246,7 @@ struct arm_smmu_domain {
>>   	const struct iommu_gather_ops	*tlb_ops;
>>   	struct arm_smmu_cfg		cfg;
>>   	enum arm_smmu_domain_stage	stage;
>> +	bool				non_strict;
>>   	struct mutex			init_mutex; /* Protects smmu pointer */
>>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>>   	struct iommu_domain		domain;
>> @@ -863,6 +864,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>>   
>> +	if (smmu_domain->non_strict && cfg->fmt != ARM_SMMU_CTX_FMT_AARCH32_S)
>> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> 
> Does this mean we end up over-invalidating when using short-descriptor?
> Could we not bypass the flush queue in this case instead? Ideally, we'd
> just reject the domain attribute but I don't know if we know about the
> page-table format early enough for that. Alternatively, we could force
> long format if the attribute is set.
> 
> What do you think?

If someone manages to run an arm64 kernel on a theoretical SMMUv2 
implementation which only supports short-descriptor, *and* explicitly 
sets the command-line option, then yes, they'll get both the synchronous 
TLBIs and the periodic TLBIALLs. As implied by the commit message, my 
natural response is "don't do that".

However, it will almost certainly take more effort to argue about it or 
come up with other bodges than it will to just implement the quirk in 
the v7s code, so if you really think it's a valid concern just shout.

Robin.
