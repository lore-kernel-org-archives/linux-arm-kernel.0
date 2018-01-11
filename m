From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 11 Jan 2018 12:24:11 +0000
Subject: [PATCH 1/9] iommu/of: Drop early initialisation hooks
In-Reply-To: <5A57471E.7020304@rock-chips.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
 <CGME20180111082537epcas3p274f6bfeb31f10742e8129dc0c877745e@epcas3p2.samsung.com>
 <20180111082229.24011-2-jeffy.chen@rock-chips.com>
 <60fdd375-ca74-0fea-c598-39a68b9e7735@samsung.com>
 <5A57471E.7020304@rock-chips.com>
Message-ID: <faeccc75-79e9-ddb6-446d-88ab63fe4e1f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

On 11/01/18 11:14, JeffyChen wrote:
> Hi Marek,
> 
> Thanks for your reply.
> 
> On 01/11/2018 05:40 PM, Marek Szyprowski wrote:
>> Hi Jeffy,
>>
>> On 2018-01-11 09:22, Jeffy Chen wrote:
>>> With the probe-deferral mechanism, early initialisation hooks are no
>>> longer needed.
>>>
>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>

In fact, shortly after I said that I had a "how hard can it be?" moment 
and took a crack at it myself - sorry, I should probably have cc'd you 
on that series[1].

>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> ---
>>>
>>> ? drivers/iommu/arm-smmu-v3.c? |? 2 +-
>>> ? drivers/iommu/arm-smmu.c???? | 12 ++++++------
>>> ? drivers/iommu/exynos-iommu.c |? 2 +-
>>
>> For Exynos IOMMU:
>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> IPMMU and MSM IOMMU are no longer multi-platform safe after this patch.
>> It breaks them in the same way as my commit 928055a01b3f ("iommu/exynos:
>> Remove custom platform device registration code") broke Exynos IOMMU.
>>
>> You need a similar fix for them:
>> https://www.spinics.net/lists/arm-kernel/msg627648.html
> 
> hmmm, right, i did saw this fix in the rockchip iommu driver too.
> 
> and there're also some other iommu drivers put bus_set_iommu in their 
> probe() to avoid that.
> 
> maybe we can do it in the iommu framework?
> 
> for example:
> 1/ add a bus type member to struct iommu_device
> 2/ and a iommu_device_set_bus()
> 3/ do the bus_set_iommu stuff in iommu_device_register()
> 4/ undo bus_set_iommu in iommu_device_unregister()

Ultimately we'd like to get rid of the bus relationship altogether, so I 
don't think it's really worth adding more infrastructure around it. 
Having of-iommu-based drivers set bus ops at probe time, and others 
conditionally from an initcall, is pretty clean and simple, so I'd 
rather stick with that approach for now.

Robin.

[1] 
https://lists.linuxfoundation.org/pipermail/iommu/2018-January/025395.html
