From: nleeder@codeaurora.org (Leeder, Neil)
Date: Mon, 7 Aug 2017 17:00:40 -0400
Subject: [PATCH 1/2] acpi: arm64: add iort support for PMCG
In-Reply-To: <20170807164400.GA27830@red-moon>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
 <20170807164400.GA27830@red-moon>
Message-ID: <c5349817-f64a-e28d-50e9-3d23bec96747@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 8/7/2017 12:44 PM, Lorenzo Pieralisi wrote:
> On Fri, Aug 04, 2017 at 03:59:13PM -0400, Neil Leeder wrote:
[...]
>> +		} else if (iort_node->type == ACPI_IORT_NODE_PMCG) {
>> +			if (iort_add_smmu_platform_device(iort_node))
>> +				return;
> 
> 
> It is becoming a bit messy, probably it makes sense to rework the
> iommu platform device creation to make room for more generic (ie
> iommu platform device creation is not really iommu specific) behaviour
> that can accommodate the PMCG too, it can be made cleaner.
> 
> I do not know if we can make it for this cycle but I am happy to put
> a patch together shortly with this in mind.
> 
Ok, I will rebase on top of it when it's ready.

>>  		}
>>  
>>  		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 707dda74..2169b6f 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -695,7 +695,8 @@ enum acpi_iort_node_type {
>>  	ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
>>  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
>>  	ACPI_IORT_NODE_SMMU = 0x03,
>> -	ACPI_IORT_NODE_SMMU_V3 = 0x04
>> +	ACPI_IORT_NODE_SMMU_V3 = 0x04,
>> +	ACPI_IORT_NODE_PMCG = 0x05
>>  };
>>  
>>  struct acpi_iort_id_mapping {
>> @@ -811,6 +812,12 @@ struct acpi_iort_smmu_v3 {
>>  #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
>>  #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
>>  
>> +struct acpi_iort_pmcg {
>> +	u64 base_address;	/* PMCG base address */
>> +	u32 overflow_gsiv;
>> +	u32 node_reference;
>> +};
> 
> As Robin already said this hunk should be made an ACPICA pull but
> NOT before seeking IORT specs clarification as per his comments.
> 
OK, I will add this through ACPICA once the IORT decision is made.

Thanks,

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
