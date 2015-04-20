From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 20 Apr 2015 13:44:23 +0800
Subject: [PATCH 1/2] drm: rockchip: Don't pass DRM fake offset to dma-api
In-Reply-To: <55349001.80304@rock-chips.com>
References: <1429195312-25898-1-git-send-email-orjan.eide@arm.com>
 <1743547.3D2D8THGkI@diego> <55349001.80304@rock-chips.com>
Message-ID: <55349237.3050901@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?04?20? 13:34, Mark yao wrote:
> On 2015?04?19? 00:55, Heiko St?bner wrote:
>> Am Donnerstag, 16. April 2015, 16:41:51 schrieb ?rjan Eide:
>>> Set vm_pgoff to 0 after using it to look up the GEM node, before 
>>> passing
>>> it on rockchip_gem_mmap_buf() where the offset must be from the 
>>> start of
>>> the buffer.
>>>
>>> Passing in the fake offset currently works because the
>>> dma_mmap_attrs implementation that is used for this device,
>>> arm_iommu_mmap_attrs, ignores the offset completely.
>>>
>>> Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
>> both patches on a rk3288-veyron-pinky
>>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>
>> Through which tree do you want to take these patches? I guess the 
>> rockchip-drm
>> related patch should go through the tree that will take the 
>> dma-mapping patch,
>> so you'll probably need an "Ack" from Mark Yao (Cc'ed).
>>
>>
>> Heiko
>>
>>> ---
>>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c index 7ca8799e..69f01c3
>>> 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> @@ -94,6 +94,11 @@ int rockchip_gem_mmap(struct file *filp, struct
>>> vm_area_struct *vma) return -EACCES;
>>>       }
>>>
>>> +    /* Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and 
>>> map the
>>> +     * whole buffer from the start.
>>> +     */
>>> +    vma->vm_pgoff = 0;
>>> +
>>>       obj = container_of(node, struct drm_gem_object, vma_node);
>>>       ret = rockchip_gem_mmap_buf(obj, vma);
>>
>>
>>
> Thanks for this fix,
> Acked-by: Mark Yao <mark.yao@rock-chips.com>
>
I met this problem when work with gem non-iommu path, set vma->vm_pgoff 
= 0 solved it. :-)

-- 
?ark
