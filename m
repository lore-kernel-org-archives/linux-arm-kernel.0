From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 23 May 2016 14:17:01 +0530
Subject: [RFC 8/9] drivers: of: call iommu_bus_add_dev after
 iommu_configure_ops
In-Reply-To: <898fef51-39a0-09af-4eb9-9a6581ffbe77@samsung.com>
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
 <1461599894-1969-9-git-send-email-sricharan@codeaurora.org>
 <898fef51-39a0-09af-4eb9-9a6581ffbe77@samsung.com>
Message-ID: <000801d1b4cf$af951cb0$0ebf5610$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

>On 2016-04-25 17:58, Sricharan R wrote:
>> Now that the device's iommu ops are configured at probe time,
>> the device has to be added to the iommu late.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>   drivers/of/device.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 57a5f2d..722115c 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/of_iommu.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/init.h>
>> +#include <linux/iommu.h>
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/slab.h>
>> @@ -154,6 +155,9 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
>>   	dev_dbg(dev, "device is%sbehind an iommu\n",
>>   		iommu ? " " : " not ");
>>
>> +	if (iommu)
>> +		iommu_bus_add_dev(dev);
>> +
>
>This causes build break when IOMMU subsystem is not enabled:
>
>drivers/of/device.c: In function 'of_dma_configure_ops':
>drivers/of/device.c:159:3: error: implicit declaration of function
>'iommu_bus_add_dev' [-Werror=implicit-function-declaration]
>    iommu_bus_add_dev(dev);
>    ^

Ah ok. Thanks for pointing this out. I will repost, with this fixed.
I also realised that PATCH 9, might cause a issue in NON-DT
builds and needs a correction. But otherwise, i am waiting for
suggestions/feedback on how to proceed with this series.

Regards,
 Sricharan
