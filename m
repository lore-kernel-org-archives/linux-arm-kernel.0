From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 18 May 2015 14:25:27 +0200
Subject: [PATCH v6 12/25] iommu: exynos: add support for runtime_pm
In-Reply-To: <20150510223811.e9ea24574e67a6a55b0b1cd4@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-13-git-send-email-m.szyprowski@samsung.com>
 <20150510223811.e9ea24574e67a6a55b0b1cd4@samsung.com>
Message-ID: <5559DA37.8090307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-05-10 15:38, Cho KyongHo wrote:
> On Mon, 04 May 2015 10:16:07 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
>> This patch fixes support for runtime power management for SYSMMU
>> controllers, so they are enabled when master device is attached.
>>
> You should later think that this style of runtime PM support
> will increase the leakage current because some devices may
> enable System MMUs during they are not working.
> If a device driver of a master device attaches its iommu domain
> in probe, its local power will be never gated.

Yes, true, but let's merge something that WORKS first and add more 
fine-grained
runtime-pm later as a separate patch. Some time ago I've posted a 
fully-blown
patchset for Exynos IOMMU will all features 
(https://lkml.org/lkml/2014/8/5/183)
- but it turned out that it will be to hard to agree on all needed 
features and
dependencies, so I simplified the code as much as possible. All 
remaining features
(like fine-grained power management and access for more than one iommu 
controller
per device) will be posted separately.

>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/iommu/exynos-iommu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index 598660c87410..734107ec78fa 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -702,6 +702,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
>>   		return -ENODEV;
>>   
>>   	list_for_each_entry(data, &owner->clients, owner_node) {
>> +		pm_runtime_get_sync(data->sysmmu);
>>   		ret = __sysmmu_enable(data, pagetable, domain);
>>   		if (ret >= 0) {
>>   			data->master = dev;
>> @@ -743,6 +744,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
>>   				data->master = NULL;
>>   				list_del_init(&data->domain_node);
>>   			}
>> +			pm_runtime_put(data->sysmmu);
>>   			found = true;
>>   		}
>>   	}
>> -- 
>> 1.9.2

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
