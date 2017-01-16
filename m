From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 16 Jan 2017 21:21:04 +0800
Subject: [PATCH v7 09/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <20170116112556.GA23703@red-moon>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-10-git-send-email-hanjun.guo@linaro.org>
 <20170113121144.GE20837@red-moon> <5879A8F3.7030303@huawei.com>
 <20170116112556.GA23703@red-moon>
Message-ID: <587CC8C0.3040602@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/16 19:25, Lorenzo Pieralisi wrote:
> On Sat, Jan 14, 2017 at 12:28:35PM +0800, Hanjun Guo wrote:
>> Hi Lorenzo,
>>
>> On 2017/1/13 20:11, Lorenzo Pieralisi wrote:
>>> On Wed, Jan 11, 2017 at 11:06:33PM +0800, Hanjun Guo wrote:
>>>> For devices connecting to ITS, it needs dev id to identify itself, and
>>>> this dev id is represented in the IORT table in named component node
>>>> [1] for platform devices, so in this patch we will scan the IORT to
>>>> retrieve device's dev id.
>>>>
>>>> For named components we know that there are always two steps
>>>> involved (second optional):
>>>>
>>>> (1) Retrieve the initial id (this may well provide the final mapping)
>>>> (2) Map the id (optional if (1) represents the map type we need), this
>>>>     is needed for use cases such as NC (named component) -> SMMU -> ITS
>>>>     mappings.
>>>>
>>>> we have API iort_node_get_id() for step (1) above and
>>>> iort_node_map_rid() for step (2), so create a wrapper
>>>> iort_node_map_platform_id() to retrieve the dev id.
>>>>
>>>> [1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf
>>> This patch should be split and IORT changes should be squashed with
>>> patch 10.
>> If split the changes for IORT and its platform msi, API introduced in IORT will
>> not be used in a single patch, seems violate the suggestion of "new introduced API
>> needs to be used in the same patch", did I miss something?
> Yes, I would introduce iort_node_map_platform_id() and in the same
> patch update current iort_node_get_id() users (ie iort_iommu_configure())
> to it. No functional change intended.
>
> Then in subsequent patches you can retrieve the ITS device id for
> platform devices through it.

Good point, I will update the patch set.

>
> Code is in your series, you just have to reshuffle it slightly.
>
>>>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Suggested-by: Tomasz Nowicki <tn@semihalf.com>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Cc: Sinan Kaya <okaya@codeaurora.org>
>>>> Cc: Tomasz Nowicki <tn@semihalf.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> ---
>>>>  drivers/acpi/arm64/iort.c                     | 56 +++++++++++++++++++++++++++
>>>>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  4 +-
>>>>  include/linux/acpi_iort.h                     |  8 ++++
>>>>  3 files changed, 67 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>> index 069a690..95fd20b 100644
>>>> --- a/drivers/acpi/arm64/iort.c
>>>> +++ b/drivers/acpi/arm64/iort.c
>>>> @@ -30,6 +30,7 @@
>>>>  #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
>>>>  #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
>>>>  				(1 << ACPI_IORT_NODE_SMMU_V3))
>>>> +#define IORT_TYPE_ANY		(IORT_MSI_TYPE | IORT_IOMMU_TYPE)
>>>>  
>>>>  struct iort_its_msi_chip {
>>>>  	struct list_head	list;
>>>> @@ -406,6 +407,34 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>>>  	return NULL;
>>>>  }
>>>>  
>>>> +static
>>>> +struct acpi_iort_node *iort_node_map_platform_id(struct acpi_iort_node *node,
>>>> +						 u32 *id_out, u8 type_mask,
>>>> +						 int index)
>>>> +{
>>>> +	struct acpi_iort_node *parent;
>>>> +	u32 id;
>>>> +
>>>> +	/* step 1: retrieve the initial dev id */
>>>> +	parent = iort_node_get_id(node, &id, IORT_TYPE_ANY, index);
>>>> +	if (!parent)
>>>> +		return NULL;
>>>> +
>>>> +	/*
>>>> +	 * optional step 2: map the initial dev id if its parent is not
>>>> +	 * the target type we wanted, map it again for the use cases such
>>>> +	 * as NC (named component) -> SMMU -> ITS. If the type is matched,
>>>> +	 * return the parent pointer directly.
>>>> +	 */
>>>> +	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
>>>> +		parent = iort_node_map_id(parent, id, id_out, type_mask);
>>>> +	else
>>>> +		if (id_out)
>>> Remove this pointer check.
>> This was added because of NULL pointer reference, I passed NULL for id_out because I
>> only want to get its parent node, I think we have four options:
>>
>>  - Introduce a new API to get the parent only from the scratch, but it will duplicate the code
>>     a lot;
>>
>>  - Don't check the id_out in iort_node_map_platform_id(), and introduce a wrapper and pass the
>>    dummy id for iort_node_map_platform_id() :
>> static
>> struct acpi_iort_node *iort_node_get_platform_parent{struct device *dev, u8 type_mask}
>> {
>>         struct acpi_iort_node *node, *parent = NULL;
>>         int i;
>>         u32 dummy_id;
>>
>>         node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>>                               iort_match_node_callback, dev);
>>
>>         if (!node)
>>                 return NULL;
>>
>>         for (i = 0; i < node->mapping_count; i++) {
>>                 /* we just want to get the parent node */
>>                 parent = iort_node_map_platform_id(node, &dummy_id,
>>                                                    IORT_MSI_TYPE, i);
>>                 if (parent)
>>                         break;
>>         }
>>
>>         return parent;
>> }
>>
>>  - Similar solution as above but don't introduce wrapper, just use dummy_id if
>>    iort_node_map_platform_id() is called;
>>
>> - Use the solution I proposed in this patch.
>>
>> Please share you suggestion on this :)
> I see. I would like to change the IORT mapping API functions to always pass
> in an argument:
>
> struct iort_idmap {
> 	struct acpi_iort_node *parent;
> 	u32 id;
> };
>
> and return an int, because current functions (eg iort_node_map_rid())
> return a parent IORT node but also the mapped id as a value-result
> and that's not easy to follow (also Sinan raised this point which I
> think it is fair).
>
> I think we'd better postpone this change to next cycle, so you can
> leave the pointer check:
>
> if (id_out)
>
> I will clean this up later, basically what we would end up doing to just
> retrieve the parent pointer would be the IORT equivalent of what we have
> in DT:
>
> of_parse_phandle()
>   -> __of_parse_phandle_with_args() #we call it with cell_count == 0
>
>
> at the end of the day it is just to make code easier to follow, since it
> is functions internal to IORT compilation unit it is ok for now to leave
> it as-is.
>

OK, thank you very for the review.

Hanjun
