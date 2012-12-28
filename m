From: prathyush@chromium.org (Prathyush K)
Date: Fri, 28 Dec 2012 09:53:47 +0530
Subject: [PATCH] arm: dma mapping: export arm iommu functions
In-Reply-To: <50DC580C.7080507@samsung.com>
References: <1356592458-11077-1-git-send-email-prathyush.k@samsung.com>
 <50DC580C.7080507@samsung.com>
Message-ID: <CAH=HWYP5r18qjQSc_2121vikbTMpYv6DKOfW=hpOpGB7rUyNRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 7:45 PM, Marek Szyprowski
<m.szyprowski@samsung.com>wrote:

> Hello,
>
>
> On 12/27/2012 8:14 AM, Prathyush K wrote:
>
>> This patch adds EXPORT_SYMBOL calls to the three arm iommu
>> functions - arm_iommu_create_mapping, arm_iommu_free_mapping
>> and arm_iommu_attach_device. These functions can now be called
>> from dynamic modules.
>>
>
> Could You describe a bit more why those functions might be needed by
> dynamic modules?
>
> Hi Marek,

We are adding iommu support to exynos gsc and s5p-mfc.
And these two drivers need to be built as modules to improve boot time.

We're calling these three functions from inside these drivers:
e.g.
mapping = arm_iommu_create_mapping(&platform_bus_type, 0x20000000, SZ_256M,
4);
arm_iommu_attach_device(mdev, mapping);



>
>  Signed-off-by: Prathyush K <prathyush.k@samsung.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 6b2fb87..c0f0f43 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1797,6 +1797,7 @@ err2:
>>   err:
>>         return ERR_PTR(err);
>>   }
>> +EXPORT_SYMBOL(arm_iommu_**create_mapping);
>>
>
> EXPORT_SYMOBL_GPL() ?
>
>
Right, it should be EXPORT_SYMOBL_GPL().

Will update in next patch.



>
>    static void release_iommu_mapping(struct kref *kref)
>>   {
>> @@ -1813,6 +1814,7 @@ void arm_iommu_release_mapping(**struct
>> dma_iommu_mapping *mapping)
>>         if (mapping)
>>                 kref_put(&mapping->kref, release_iommu_mapping);
>>   }
>> +EXPORT_SYMBOL(arm_iommu_**release_mapping);
>>     /**
>>    * arm_iommu_attach_device
>> @@ -1841,5 +1843,6 @@ int arm_iommu_attach_device(struct device *dev,
>>         pr_debug("Attached IOMMU controller to %s device.\n",
>> dev_name(dev));
>>         return 0;
>>   }
>> +EXPORT_SYMBOL(arm_iommu_**attach_device);
>>     #endif
>>
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
> Regards,
Prathyush
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121228/4aee24a0/attachment-0001.html>
