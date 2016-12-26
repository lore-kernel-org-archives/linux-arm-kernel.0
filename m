From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 26 Dec 2016 09:31:21 +0800
Subject: [PATCH v5 09/14] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <CAJZ5v0itKF-uo7vGxK3+-X4OwBVYPdBw-b8v-8-CTBygpKMGoQ@mail.gmail.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-10-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0g4AoU-g4UWZFxLgQ_yfTC7KSBnZ_Ve945d+i58e=GuDQ@mail.gmail.com>
 <585E24FB.9050805@huawei.com>
 <CAJZ5v0itKF-uo7vGxK3+-X4OwBVYPdBw-b8v-8-CTBygpKMGoQ@mail.gmail.com>
Message-ID: <586072E9.3060609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Happy holidays! reply inline.

On 2016/12/26 8:31, Rafael J. Wysocki wrote:
> On Sat, Dec 24, 2016 at 8:34 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
>> Hi Rafael,
>>
>> Thank you for your comments, when I was demoing your suggestion,
>> I got a little bit confusions, please see my comments below.
>>
> [cut]
>
>>>> +
>>>> +/**
>>>>   * acpi_create_platform_device - Create platform device for ACPI device node
>>>>   * @adev: ACPI device node to create a platform device for.
>>>>   * @properties: Optional collection of build-in properties.
>>>> @@ -109,6 +119,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>>>>         pdevinfo.num_res = count;
>>>>         pdevinfo.fwnode = acpi_fwnode_handle(adev);
>>>>         pdevinfo.properties = properties;
>>>> +       pdevinfo.pre_add_cb = acpi_platform_pre_add_cb;
>>> Why don't you point that directly to acpi_configure_pmsi_domain()?  It
>>> doesn't look like the wrapper is necessary at all.
>> I was thinking that we can add something more in the future
>> if we need to extend the function of the callback, I can just
>> use acpi_configure_pmsi_domain() here.
> So you can add the wrapper in the future just fine as well.  At this
> point it is just redundant.
>
>>> And I'm not sure why the new callback is necessary ->
>> I was demoing your suggestion but...
>>
>>>>         if (acpi_dma_supported(adev))
>>>>                 pdevinfo.dma_mask = DMA_BIT_MASK(32);
>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>> index bc68d93..6b72fcb 100644
>>>> --- a/drivers/acpi/arm64/iort.c
>>>> +++ b/drivers/acpi/arm64/iort.c
>>>> @@ -527,6 +527,49 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
>>>>         return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
>>>>  }
>>>>
>>>> +/**
>>>> + * iort_get_platform_device_domain() - Find MSI domain related to a
>>>> + * platform device
>>>> + * @dev: the dev pointer associated with the platform device
>>>> + *
>>>> + * Returns: the MSI domain for this device, NULL otherwise
>>>> + */
>>>> +static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
>>>> +{
>>>> +       struct acpi_iort_node *node, *msi_parent;
>>>> +       struct fwnode_handle *iort_fwnode;
>>>> +       struct acpi_iort_its_group *its;
>>>> +
>>>> +       /* find its associated iort node */
>>>> +       node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>>>> +                             iort_match_node_callback, dev);
>>>> +       if (!node)
>>>> +               return NULL;
>>>> +
>>>> +       /* then find its msi parent node */
>>>> +       msi_parent = iort_node_get_id(node, NULL, IORT_MSI_TYPE, 0);
>>>> +       if (!msi_parent)
>>>> +               return NULL;
>>>> +
>>>> +       /* Move to ITS specific data */
>>>> +       its = (struct acpi_iort_its_group *)msi_parent->node_data;
>>>> +
>>>> +       iort_fwnode = iort_find_domain_token(its->identifiers[0]);
>>>> +       if (!iort_fwnode)
>>>> +               return NULL;
>>>> +
>>>> +       return irq_find_matching_fwnode(iort_fwnode, DOMAIN_BUS_PLATFORM_MSI);
>>>> +}
>>>> +
>>>> +void acpi_configure_pmsi_domain(struct device *dev)
>>>> +{
>>>> +       struct irq_domain *msi_domain;
>>>> +
>>>> +       msi_domain = iort_get_platform_device_domain(dev);
>>>> +       if (msi_domain)
>>>> +               dev_set_msi_domain(dev, msi_domain);
>>>> +}
>>>> +
>>>>  static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>>>>  {
>>>>         u32 *rid = data;
>>>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>>>> index c4af003..3e68f31 100644
>>>> --- a/drivers/base/platform.c
>>>> +++ b/drivers/base/platform.c
>>>> @@ -537,6 +537,9 @@ struct platform_device *platform_device_register_full(
>>>>                         goto err;
>>>>         }
>>>>
>>>> +       if (pdevinfo->pre_add_cb)
>>>> +               pdevinfo->pre_add_cb(&pdev->dev);
>>>> +
>>> -> because it looks like this might be done in acpi_platform_notify()
>>> for platform devices.
>> It works and I just simply add the code below:
>>
>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>> index f8d6564..e0cd649 100644
>> --- a/drivers/acpi/glue.c
>> +++ b/drivers/acpi/glue.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/rwsem.h>
>>  #include <linux/acpi.h>
>> +#include <linux/acpi_iort.h>
>>  #include <linux/dma-mapping.h>
>>
>>  #include "internal.h"
>> @@ -315,6 +316,8 @@ static int acpi_platform_notify(struct device *dev)
>>         if (!adev)
>>                 goto out;
>>
>> + acpi_configure_pmsi_domain(dev);
>> +
> But that should apply to platform devices only I suppose?

Yes, it's only for the platform device.

>
>>         if (type && type->setup)
>>                 type->setup(dev);
>>         else if (adev->handler && adev->handler->bind)
>>
>> Do you suggesting to configure the msi domain in this way?
>> or add the function in the type->setup() callback (which needs
>> to introduce a new acpi bus type)?
> A type->setup() would be somewhat cleaner I think, but then it's more
> code.  Whichever works better I guess. :-)

Agree, I will demo the type->setup() way and send out the patch for review,
also I find one minor issue for the IORT code, will update that also for next
version.

Thanks
Hanjun
