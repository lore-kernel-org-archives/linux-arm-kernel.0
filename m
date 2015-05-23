From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Fri, 22 May 2015 19:15:17 -0500
Subject: [V5 PATCH 1/5] ACPI / scan: Parse _CCA and setup device coherency
In-Reply-To: <2939517.7sXtxU6TkU@vostro.rjw.lan>
References: <1432159758-4486-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1815824.lIg0NQ97lU@vostro.rjw.lan> <555FAC8F.4010306@amd.com>
 <2939517.7sXtxU6TkU@vostro.rjw.lan>
Message-ID: <555FC695.1000404@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2015 6:05 PM, Rafael J. Wysocki wrote:
> On Friday, May 22, 2015 05:24:15 PM Suravee Suthikulanit wrote:
>> Not sure if this went out earlier. So I am resending.
>>
>> On 5/22/15 16:56, Rafael J. Wysocki wrote:
>>>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>>>>> index 39c485b..b9657af 100644
>>>>> --- a/drivers/acpi/glue.c
>>>>> +++ b/drivers/acpi/glue.c
>>>>> @@ -13,6 +13,7 @@
>>>>>   #include <linux/slab.h>
>>>>>   #include <linux/rwsem.h>
>>>>>   #include <linux/acpi.h>
>>>>> +#include <linux/dma-mapping.h>
>>>>>
>>>>>   #include "internal.h"
>>>>>
>>>>> @@ -167,6 +168,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>>>>>   	struct list_head *physnode_list;
>>>>>   	unsigned int node_id;
>>>>>   	int retval = -EINVAL;
>>>>> +	bool coherent;
>>>>>
>>>>>   	if (has_acpi_companion(dev)) {
>>>>>   		if (acpi_dev) {
>>>>> @@ -223,6 +225,9 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>>>>>   	if (!has_acpi_companion(dev))
>>>>>   		ACPI_COMPANION_SET(dev, acpi_dev);
>>>>>
>>>>> +	if (acpi_check_dma(acpi_dev, &coherent))
>>>>> +		arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
>>>>> +
>>> Well, so is this going to work for PCI too after all?
>>>
>>
>> No, as Bjorn suggested, PCI changes for setting DMA coherent from _CCA
>> (patch 3/6 in V4) will be submitted separately. We are working on
>> cleaning up and up-streaming the PCI ACPI support for ARM64.
>
> OK, but acpi_bind_one() is called for PCI devices too.  Won't that be a problem?
>
>
 >
In this case, we would be going through the following call path:

   --> pci_device_add()
    |--> pci_dma_configure() ** 1 **
    |--> device_add()
      |--> platform_notify()
        |--> acpi_platform_notify()
         |--> acpi_bind_one() ** 2 **

At (1), we would be calling arch_setup_dma_ops() with the PCI host 
bridge _CCA information. So, it should have already taken care of 
setting up device coherency here.

At (2), if there is no acpi_dev for endpoint devices (which I believe 
this is normally the case), it would return early and skip 
arch_setup_dma_ops().

At (2), if there is an acpi_dev, the coherent_dma flag should have 
already been setup by the acpi_init_device_object during ACPI scan. 
However, I am not certain about this case since I don't have the DSDT 
containing  PCI endpoint devices to test with.

Thanks,

Suravee
