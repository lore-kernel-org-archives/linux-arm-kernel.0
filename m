From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Feb 2016 16:51:05 +0000
Subject: [RFC v3 07/15] iommu: iommu_get/put_single_reserved
In-Reply-To: <56C5F472.1020003@linaro.org>
References: <1455264797-2334-1-git-send-email-eric.auger@linaro.org>
 <1455264797-2334-8-git-send-email-eric.auger@linaro.org>
 <20160218110616.05108071@arm.com> <56C5F472.1020003@linaro.org>
Message-ID: <56C5F679.8000002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/16 16:42, Eric Auger wrote:
> Hello,
> On 02/18/2016 12:06 PM, Marc Zyngier wrote:
>> On Fri, 12 Feb 2016 08:13:09 +0000
>> Eric Auger <eric.auger@linaro.org> wrote:
>>
>>> This patch introduces iommu_get/put_single_reserved.
>>>
>>> iommu_get_single_reserved allows to allocate a new reserved iova page
>>> and map it onto the physical page that contains a given physical address.
>>> It returns the iova that is mapped onto the provided physical address.
>>> Hence the physical address passed in argument does not need to be aligned.
>>>
>>> In case a mapping already exists between both pages, the IOVA mapped
>>> to the PA is directly returned.
>>>
>>> Each time an iova is successfully returned a binding ref count is
>>> incremented.
>>>
>>> iommu_put_single_reserved decrements the ref count and when this latter
>>> is null, the mapping is destroyed and the iova is released.
>>
>> I wonder if there is a requirement for the caller to find out about the
>> size of the mapping, or to impose a given size... MSIs clearly do not
>> have that requirement (this is always a 32bit value), but since. 
>> allocations usually pair address and size, I though I'd ask...
> Yes. Currently this only makes sure the host PA is mapped and returns
> the corresponding IOVA. It is part of the discussion we need to have on
> the API besides the problematic of which API it should belong to.

One of the issues I have with the API at the moment is that there is no
control on the page size. Imagine you have allocated a 4kB IOVA window
for your MSI, but your IOMMU can only map 64kB (not unreasonable to
imagine on arm64). What happens then?

Somehow, userspace should be told about it, one way or another.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
