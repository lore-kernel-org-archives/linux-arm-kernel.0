From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 Sep 2017 03:04:11 +0800
Subject: [RFC PATCH v2 3/4] ACPI: IORT: Skip SMMUv3 device ID map for
 two steps mappings
In-Reply-To: <d9f33a08-a1b8-002c-53d6-ce43b273c7df@arm.com>
References: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
 <1505999838-52530-4-git-send-email-guohanjun@huawei.com>
 <d9f33a08-a1b8-002c-53d6-ce43b273c7df@arm.com>
Message-ID: <59CAA4AB.3010309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Sorry for the late reply, in Linaro Connect now..

On 09/22/2017 09:21 PM, Robin Murphy wrote:
> On 21/09/17 14:17, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> IORT revision C introduced SMMUv3 MSI support which adding a
>> device ID mapping index in SMMUv3 sub table, to get the SMMUv3
>> device ID mapping for the output ID (dev ID for ITS) and the
>> link to which ITS.
>>
>> So if a platform supports SMMUv3 MSI for control interrupt,
>> there will be a additional single map entry under SMMU, this
>> will not introduce any difference for devices just use one
>> step map to get its output ID and parent (ITS or SMMU), such
>> as PCI/NC/PMCG ---> ITS or PCI/NC ---> SMMU, but we need to
>> do the special handling for two steps map case such as
>> PCI/NC--->SMMUv3--->ITS.
>>
>> Take a PCI hostbridge for example,
>>
>> |----------------------|
>> |  Root Complex Node   |
>> |----------------------|
>> |    map entry[x]      |
>> |----------------------|
>> |       id value       |
>> | output_reference     |
>> |---|------------------|
>>      |
>>      |   |----------------------|
>>      |-->|        SMMUv3        |
>>          |----------------------|
>>          |     SMMU dev ID      |
>>          |     mapping index 0  |
>>          |----------------------|
>>          |      map entry[0]    |
>>          |----------------------|
>>          |       id value       |
>>          | output_reference-----------> ITS 1 (SMMU MSI domain)
>>          |----------------------|
>>          |      map entry[1]    |
>>          |----------------------|
>>          |       id value       |
>>          | output_reference-----------> ITS 2 (PCI MSI domain)
>>          |----------------------|
>>
>> When the SMMU dev ID mapping index is 0, there is entry[0]
>> to map to a ITS, we need to skip that map entry for PCI
>> or NC (named component), or we may get the wrong ITS parent.
>>
>> For now we have two APIs for ID mapping, iort_node_map_id()
>> and iort_node_map_platform_id(), and iort_node_map_id() is
>> used for optional two steps mapping, so we just need to
>> skip the map entry in iort_node_map_id() for non-SMMUv3
>> devices.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/arm64/iort.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index db71d7f..269959e 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -366,6 +366,34 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>>   	return NULL;
>>   }
>>
>> +static int iort_get_smmu_v3_id_mapping_index(struct acpi_iort_node *node,
>> +					     u32 *index)
>> +{
>> +	struct acpi_iort_smmu_v3 *smmu;
>> +
>> +	/*
>> +	 * SMMUv3 dev ID mapping index was introdueced in revision 1
>> +	 * table, not avaible in revision 0
>> +	 */
>> +	if (node->revision < 1)
>> +		return -EINVAL;
>> +
>> +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>> +	/* if any of the gsi for control interrupts is not 0, ignore the MSI */
>> +	if (smmu->event_gsiv || smmu->pri_gsiv || smmu->gerr_gsiv
>> +	    || smmu->sync_gsiv)
>
> To repeat my previous comments, the ID mapping index is only ignored if
> *all* interrupts are GSIV-based.
>
> It would be quite reasonable for gerr to be wired while everything else
> uses MSIs, especially since that's effectively the only reliable way to
> get MSI aborts reported if things are completely hosed.

OK, I missed this point, so I will modify the code as below

if (smmu->event_gsiv && smmu->pri_gsiv && smmu->gerr_gsiv
     && smmu->sync_gsiv)
	return -EINVAL;

Am I doing this right with above code?

>
>> +		return -EINVAL;
>> +
>> +	if (smmu->id_mapping_index >= node->mapping_count) {
>> +		pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
>> +		       node, node->type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	*index = smmu->id_mapping_index;
>> +	return 0;
>> +}
>> +
>>   static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>   					       u32 id_in, u32 *id_out,
>>   					       u8 type_mask)
>> @@ -375,7 +403,9 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>   	/* Parse the ID mapping tree to find specified node type */
>>   	while (node) {
>>   		struct acpi_iort_id_mapping *map;
>> -		int i;
>> +		int i, ret = -EINVAL;
>> +		/* big enough for an invalid id index in practical */
>> +		u32 index = U32_MAX;
>
> And again, more of a style nit, but indices must be sufficiently small
> to fit into the positive half of an int, so *_id_mapping_index() really
> doesn't need this complication of passing a separate output argument.

Sorry, I reused the code which Lorenzo sent me, will update the code
in next version.

Thanks
Hanjun
