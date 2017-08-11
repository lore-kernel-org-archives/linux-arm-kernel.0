From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 11 Aug 2017 21:56:31 +0800
Subject: [RFC PATCH 4/4] ACPI: IORT: Add SMMUv3 MSI support
In-Reply-To: <20170811093348.GC26039@red-moon>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
 <1502276017-63108-5-git-send-email-guohanjun@huawei.com>
 <20170811093348.GC26039@red-moon>
Message-ID: <CAGHbJ3AgEvbpsPdeqJ+bFWa5hBMqxBX6g1eC4HiUvHarJf8H+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 11 August 2017 at 17:33, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Wed, Aug 09, 2017 at 06:53:37PM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> Since we have a mapping index for SMMUv3 MSI, we can
>> directly use that index to get the map entry, then
>> retrieve dev ID and ITS parent to add SMMUv3 MSI
>> support.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/arm64/iort.c | 46 ++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 9439f02..ce03298 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -313,7 +313,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>>       /* Single mapping does not care for input id */
>>       if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>>               if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>> -                 type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>> +                 type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
>> +                 type == ACPI_IORT_NODE_SMMU_V3) {
>>                       *rid_out = map->output_base;
>>                       return 0;
>>               }
>> @@ -357,7 +358,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>>
>>       if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>>               if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>> -                 node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>> +                 node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
>> +                 node->type == ACPI_IORT_NODE_SMMU_V3) {
>>                       *id_out = map->output_base;
>>                       return parent;
>>               }
>> @@ -549,9 +551,21 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>>       if (!node)
>>               return -ENODEV;
>>
>> -     for (i = 0; i < node->mapping_count; i++) {
>> -             if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
>> +     if (node->type == ACPI_IORT_NODE_SMMU_V3) {
>> +             u32 index;
>> +
>> +             if (iort_get_smmu_v3_id_mapping_index(node, &index))
>> +                     return -ENODEV;
>> +
>> +             if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE,
>> +                 index))
>>                       return 0;
>> +     } else {
>> +             for (i = 0; i < node->mapping_count; i++) {
>> +                     if (iort_node_map_platform_id(node, dev_id,
>> +                         IORT_MSI_TYPE, i))
>> +                             return 0;
>> +             }
>>       }
>>
>>       return -ENODEV;
>> @@ -626,20 +640,30 @@ static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
>>       struct acpi_iort_node *node, *msi_parent;
>>       struct fwnode_handle *iort_fwnode;
>>       struct acpi_iort_its_group *its;
>> -     int i;
>>
>>       /* find its associated iort node */
>> -     node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>> -                           iort_match_node_callback, dev);
>> +     node = iort_find_dev_node(dev);
>>       if (!node)
>>               return NULL;
>>
>>       /* then find its msi parent node */
>> -     for (i = 0; i < node->mapping_count; i++) {
>> +     if (node->type == ACPI_IORT_NODE_SMMU_V3) {
>> +             u32 index;
>> +
>> +             if (iort_get_smmu_v3_id_mapping_index(node, &index))
>> +                     return NULL;
>> +
>>               msi_parent = iort_node_map_platform_id(node, NULL,
>> +                                                    IORT_MSI_TYPE, index);
>> +     } else {
>> +             int i;
>> +
>> +             for (i = 0; i < node->mapping_count; i++) {
>> +                     msi_parent = iort_node_map_platform_id(node, NULL,
>>                                                      IORT_MSI_TYPE, i);
>> -             if (msi_parent)
>> -                     break;
>> +                     if (msi_parent)
>> +                             break;
>> +             }
>>       }
>>
>>       if (!msi_parent)
>> @@ -1233,6 +1257,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
>>       /* Configure DMA for the page table walker */
>>       acpi_dma_configure(&pdev->dev, attr);
>>
>> +     acpi_configure_pmsi_domain(&pdev->dev);
>
> I think this is just overkill. There are two separate things to solve
> here:
>
> 1) Make single mappings valid for SMMUv3 (and PMCG); that's fair enough
>    and goes with the logic to skip the ITS DeviceID index for "normal"
>    mappings, I can live with that
> 2) Find the MSI domain for an SMMUv3 (or any other IORT table node); I
>    do not think you need all this complexity to do it via
>    acpi_configure_pmsi_domain(), it can be done in a easier way with
>    an ad-hoc stub (it does not even have to be SMMUv3 specific)
>
> My worry is that we are peppering the generic IORT mapping code with
> node types specific kludges and it is becoming a mess.

Agreed.

>
> I can rework the patch to show you what I have in mind, please let
> me know.

Please, thank you very much for doing so.

Thanks
Hanjun
