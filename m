From: thunder.leizhen@huawei.com (leizhen)
Date: Fri, 21 Nov 2014 10:59:21 +0800
Subject: [PATCH 1/1] iommu/arm-smmu: forbid userspace IO devices access
 memory through SMMU by default
In-Reply-To: <20141120135339.GM19126@arm.com>
References: <1416477421-1288-1-git-send-email-thunder.leizhen@huawei.com>
 <20141120101340.GC19126@arm.com> <546DE3A5.4030500@huawei.com>
 <20141120135339.GM19126@arm.com>
Message-ID: <546EAA89.4000704@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/20 21:53, Will Deacon wrote:
> On Thu, Nov 20, 2014 at 12:50:45PM +0000, leizhen wrote:
>> On 2014/11/20 18:13, Will Deacon wrote:
>>> On Thu, Nov 20, 2014 at 09:57:01AM +0000, Zhen Lei wrote:
>>>> It's dangerous to set pte with ARM_SMMU_PTE_AP_UNPRIV. A hacker can use any
>>>> devices running at userspace to access the memory which originally mapped for
>>>> kernel devices, suppose they have the same StreamID. The userspace devices
>>>> should through vfio to dynamic create mapping.
>>>
>>> I don't fully understand the problem here. vfio will create a set of private
>>> page tables for the container, so I can't see why the privilege really
>>> matters, given that the whole thing is sandboxed anyway.
>>
>> Suppose DMA-0 can be running both at kernel space and user space. And kernel
>> APP use DMA-0 to access the lowest 4G(physical memory address range: 0~4G,
>> because some old DMA devices can only output 32bit address, and phys_to_dma() in
>> arch/arm64/include/asm/dma-mapping.h take iova and pa as the same). We can use
>> bypass mode or create mapping iova=pa for the lowest 4G. Now, the user APP can
>> use DMA-0 to access all the lowest 4G(may contain kernel information and user APP
>> originally access prohibitted).
> 
> What's a kernel APP? Is DMA-0 some sort of device? How is it running at both
> kernel and userspace?

The APP running at kernel mode, like a driver. DMA-0 is not a really device, just for
easier to communicate. Yes, a device can not running at both kernel and userspace. It
emits either PRIV or UNPRIV attribute. But if there two devices with the same StreamID,
one running at kernel and the other running at userspace, that's possible.

> 
>> Through vfio, the user APP can only create mapping for the physical memory which
>> it can access through cpu. That's the memory which belong to the user APP, vfio
>> should check this.
> 
> Yes, so there is no issue when using VFIO.
> 
>> And now, arm64 have not support vfio. I don't know how to deal with: a iommu_group
>> used by both user devices(through vfio) and kernel devices. They may specify the same
>> iova but different pa or diffrent attributes. Maybe we should not support this scene.
>> But if all(iova,pa,attr) is the same, we can simply add ARM_SMMU_PTE_AP_UNPRIV in PTE to
>> satisfy vfio requirment.
> 
> arm64 does support VFIO. Please check the patches queued for 3.19.

Ok, thank you for your imformation.

> 
>>> Furthermore, if we change the default to PRIV, then it will break for any
>>> devices wired to emit unprivileged transactions only.
>>
>> if so, it's the problem of hardware. I think.
> 
> If you have a device that emits the same streamid for privileged and
> unprivileged transactions, then I think you have the problem of hardware :)
> 

As I mentioned above. There maybe two devices: one emits PRIV and the other emits UNPRIV.

My originally meaning: If a device selected running at kernel, it should only emits PRIV.
But if a device selected running at kernel and emits UNPRIV, that's a hardware problem.
Because now arm-smmu driver are only support device running at kernel, so we only need set PRIV.
If user APP through vfio to create mapping, the PTE is set at UNPRIV. Otherwise, PRIV/UNPRIV in
smmu have no meaning.

Now, many devices are mem-mapped, the register space of devices(running at kernel) should user
access prohibitted. I will check whether it ensured by hardware or OS later.

> The right way to solve this would be to add a new IOMMU_PRIV flag (I think
> this was discussed in the past) which can be passed to iommu_map.
> 
> Will
> 
> .
> 
