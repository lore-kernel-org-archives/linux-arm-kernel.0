From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 10 Aug 2017 17:41:34 +0800
Subject: [RFC PATCH 3/4] ACPI: IORT: Skip SMMUv3 device ID map for two
 steps mappings
In-Reply-To: <20170809171245.GA13377@red-moon>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
 <1502276017-63108-4-git-send-email-guohanjun@huawei.com>
 <a5d9600e-1461-492a-05d8-338f93fa04c4@arm.com>
 <CAGHbJ3Bif=Lg7AOErohFG_wkdXAJi+E+zbud4hJGHCzh=VTegQ@mail.gmail.com>
 <20170809171245.GA13377@red-moon>
Message-ID: <91dbc8b9-d53b-547f-e64c-fe208551cadb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/8/10 1:12, Lorenzo Pieralisi wrote:
> On Wed, Aug 09, 2017 at 10:48:00PM +0800, Hanjun Guo wrote:
>> Hi Robin,
>>
>> On 9 August 2017 at 19:50, Robin Murphy <robin.murphy@arm.com> wrote:
>>> Hi Hanjun,
>>>
>>> It's a nice surprise to see this already; one less thing for us to do :)
>>
>> Glad to hear this patch set helps :)
>>
>>>
>>> On 09/08/17 11:53, Hanjun Guo wrote:
>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>
>>>> IORT revision C introduced SMMUv3 MSI support which adding a
>>>> device ID mapping index in SMMUv3 sub table, to get the SMMUv3
>>>> device ID mapping for the output ID (dev ID for ITS) and the
>>>> link to which ITS.
>>>>
>>>> So if a platform supports SMMUv3 MSI for control interrupt,
>>>> there will be a additional single map entry under SMMU, this
>>>> will not introduce any difference for devices just use one
>>>> step map to get its output ID and parent (ITS or SMMU), such
>>>> as PCI/NC/PMCG ---> ITS or PCI/NC ---> SMMU, but we need to
>>>> do the spcial handling for two steps map case such as
>>>> PCI/NC--->SMMUv3--->ITS.
>>>>
>>>> Take a PCI hostbridge for example,
>>>>
>>>> |----------------------|
>>>> |  Root Complex Node   |
>>>> |----------------------|
>>>> |    map entry[x]      |
>>>> |----------------------|
>>>> |       id value       |
>>>> | output_reference     |
>>>> |---|------------------|
>>>>      |
>>>>      |   |----------------------|
>>>>      |-->|        SMMUv3        |
>>>>          |----------------------|
>>>>          |     SMMU dev ID      |
>>>>          |     mapping index 0  |
>>>>          |----------------------|
>>>>          |      map entry[0]    |
>>>>          |----------------------|
>>>>          |       id value       |
>>>>          | output_reference-----------> ITS 1 (SMMU MSI domain)
>>>>          |----------------------|
>>>>          |      map entry[1]    |
>>>>          |----------------------|
>>>>          |       id value       |
>>>>          | output_reference-----------> ITS 2 (PCI MSI domain)
>>>>          |----------------------|
>>>>
>>>> When the SMMU dev ID mapping index is 0, there is entry[0]
>>>> to map to a ITS, we need to skip that map entry for PCI
>>>> or NC (named component), or we may get the wrong ITS parent.
>>>>
>>>> For now we have two APIs for ID mapping, iort_node_map_id()
>>>> and iort_node_map_platform_id(), and iort_node_map_id() is
>>>> used for optional two steps mapping, so we just need to
>>>> skip the map entry in iort_node_map_id() for non-SMMUv3
>>>> devices.
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>   drivers/acpi/arm64/iort.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>> index 32bd4a4..9439f02 100644
>>>> --- a/drivers/acpi/arm64/iort.c
>>>> +++ b/drivers/acpi/arm64/iort.c
>>>> @@ -366,6 +366,28 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>>>>        return NULL;
>>>>   }
>>>>
>>>> +static int iort_get_smmu_v3_id_mapping_index(struct acpi_iort_node *node,
>>>> +                                          u32 *index)
>>>> +{
>>>> +     struct acpi_iort_smmu_v3 *smmu;
>>>> +
>>>> +     /*
>>>> +      * SMMUv3 dev ID mapping index was introdueced in revision 1
>>>> +      * table, not avaible in revision 0
>>>> +      */
>>>> +     if (node->revision < 1)
>>>> +             return -EINVAL;
>>>> +
>>>> +     smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>>>> +     /* if any of the gsi for control interrupts is not 0, ignore the MSI */
>>>
>>> IORT says "If all the SMMU control interrupts are GSIV based, this
>>> field is ignored" - not "any". There doesn't seem to be any reason to
>>> disallow a mixture of MSIs and GSIs.
>>
>> Hmm, since GSIV for control interrupts are SPI, those GSIVs should not
>> be zero, does it mean we need the code below?
>>
>> if (smmu->event_gsiv && smmu->pri_gsiv && smmu->gerr_gsiv && smmu->sync_gsiv)
>>          return -EINVAL;
>>
>> This seems not consistent with the code for now (parsing
>> the SMMU GSIV for SMMU platform device).
>>
>>>
>>>> +     if (smmu->event_gsiv || smmu->pri_gsiv || smmu->gerr_gsiv
>>>> +         || smmu->sync_gsiv)
>>>> +             return -EINVAL;
>>>> +
>>>> +     *index = smmu->id_mapping_index;
>>>> +     return 0;
>>>> +}
>>>> +
>>>>   static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>>>                                               u32 id_in, u32 *id_out,
>>>>                                               u8 type_mask)
>>>> @@ -375,7 +397,9 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>>>        /* Parse the ID mapping tree to find specified node type */
>>>>        while (node) {
>>>>                struct acpi_iort_id_mapping *map;
>>>> -             int i;
>>>> +             int i, ret = -EINVAL;
>>>> +             /* big enough for an invalid id index in practical */
>>>> +             u32 index = U32_MAX;
>>>>
>>>>                if (IORT_TYPE_MASK(node->type) & type_mask) {
>>>>                        if (id_out)
>>>> @@ -396,8 +420,19 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>>>                        goto fail_map;
>>>>                }
>>>>
>>>> +             /*
>>>> +              *  we need to get SMMUv3 dev ID mapping index and skip its
>>>> +              *  associated ID map for single mapping cases.
>>>> +              */
>>>> +             if (node->type == ACPI_IORT_NODE_SMMU_V3)
>>>> +                     ret = iort_get_smmu_v3_id_mapping_index(node, &index);
>>>> +
>>>>                /* Do the ID translation */
>>>>                for (i = 0; i < node->mapping_count; i++, map++) {
>>>> +                     /* if it's a SMMUv3 device id mapping index, skip it */
>>>> +                     if (!ret && i == index)
>>>
>>> Given that i is an int anyway, there doesn't seem to be much need for
>>> the ret dance - iort_get_smmu_v3_id_mapping_index() could just return
>>> the index/error value as an int directly. You can rely on (i == index)
>>> being false if index is negative, because for node->mapping_count to
>>> overflow INT_MAX the IORT would have to be over 40GB in size, which is
>>> definitely impossible.
>>
>> Good point, it will simplify the code, I will update this patch :)
> 
> How about:
> 
> (1) Ignoring SMMU_V3 single mappings in iort_id_map() (as we do today -
>      minus the warning) - we will never need them, just ignore them all
>      regarless of id_mapping_index

I was thinking the same when I prepare the code, but one thing stopped
me to do that, which is if we have multi single mappings under SMMU,
such as PCI/NC---->SMMU---(single mapping)-->ITS, then all the single
mappings will be skipped.

I'm didn't see such mapping (HW) in practical for now, and I'm not
sure if it's a valid mapping, from the spec, IORT doesn't forbid such
mapping.

> (2) Write some simple code that instead of relying on the
>      iort_pmsi_get_dev_id() API just get the SMMU V3 IORT node mapping
>      entry (at id_mapping_index), grab a reference to the ITS and
>      look-up the MSI domain

That will be pretty the same as iort_node_get_id() then to use the
parent to get the MSI irq domain.

> 
> ?
> 
> I do not see the point in making any of this generic for IORT kernel
> code, it is a one-off kludge for SMMU_V3 and can easily be
> self-contained IORT code.
> 
> Thoughts ?

Please see above :)

Thanks
Hanjun
