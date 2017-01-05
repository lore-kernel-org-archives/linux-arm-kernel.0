From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 5 Jan 2017 20:45:37 +0800
Subject: [PATCH v6 05/14] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <20170104191805.GE8604@red-moon>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-6-git-send-email-hanjun.guo@linaro.org>
 <20170104191805.GE8604@red-moon>
Message-ID: <eb1a8149-7c46-39bc-f655-58ca6345f40a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2017/1/5 3:18, Lorenzo Pieralisi wrote:
> On Mon, Jan 02, 2017 at 09:31:36PM +0800, Hanjun Guo wrote:
>> For devices connecting to ITS, it needs dev id to identify
>> itself, and this dev id is represented in the IORT table in
>> named componant node [1] for platform devices, so in this
>> patch we will scan the IORT to retrieve device's dev id.
>>
>> Introduce iort_pmsi_get_dev_id() with pointer dev passed
>> in for that purpose.
>>
>> [1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Sinan Kaya <okaya@codeaurora.org>
>> Tested-by: Majun <majun258@huawei.com>
>> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Tomasz Nowicki <tn@semihalf.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/acpi/arm64/iort.c                     | 26 ++++++++++++++++++++++++++
>>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  4 +++-
>>  include/linux/acpi_iort.h                     |  8 ++++++++
>>  3 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 174e983..ab7bae7 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -444,6 +444,32 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>>  }
>>
>>  /**
>> + * iort_pmsi_get_dev_id() - Get the device id for a device
>> + * @dev: The device for which the mapping is to be done.
>> + * @dev_id: The device ID found.
>> + *
>> + * Returns: 0 for successful find a dev id, errors otherwise
>> + */
>> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>> +{
>> +	struct acpi_iort_node *node;
>> +
>> +	if (!iort_table)
>> +		return -ENODEV;
>> +
>> +	node = iort_find_dev_node(dev);
>> +	if (!node) {
>> +		dev_err(dev, "can't find related IORT node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if(!iort_node_get_id(node, dev_id, IORT_MSI_TYPE, 0))
>
> I disagree with this approach. For named components we know that
> there are always two steps involved (second optional):
>
> (1) Retrieve the initial id (this may well provide the final mapping)
> (2) Map the id (optional if (1) represents the map type we need)
>
> That's the reason why I kept iort_node_get_id() and iort_node_map_rid()
> separated.
>
> Now, what we can do is to create an iort_node_map_id() function that is
> PCI agnostic (ie rename rid to id :)), whose rid_in is either a PCI RID
> or the outcome of a previous call to iort_node_get_id() for named
> components, that's in my opinion cleaner.

iort_node_map_rid() was designed for that purpose, and we can use it
for platform device, the issue that we need to pass a req id
unconditionally which is not needed for platform device, Tomasz
proposed a similar solution to rework iort_node_map_rid(), and
I think it makes sense.

>
> It would be even cleaner if you passed a type_mask (or write a
> wrapper function for that) that is:
>
> (IORT_MSI_TYPE | IORT_IOMMU_TYPE)

Sorry, I got little lost here, could you explain it in detail?

>
> and we just use the returned parent pointer to check if the mapping
> providing the initial id correspond to the type we are looking for (eg
> ITS) or we need to map the retrieved initial id any further, with
> iort_node_map_id(), to get to the final identifier.
>
> Thoughts ?

I think rework iort_node_map_rid() and not extend iort_node_get_id()
is the right direction, could you explain a bit more then I can demo
the code?

Thanks
Hanjun
