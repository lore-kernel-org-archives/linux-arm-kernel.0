From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Nov 2014 13:53:39 +0000
Subject: [PATCH 1/1] iommu/arm-smmu: forbid userspace IO devices access
 memory through SMMU by default
In-Reply-To: <546DE3A5.4030500@huawei.com>
References: <1416477421-1288-1-git-send-email-thunder.leizhen@huawei.com>
 <20141120101340.GC19126@arm.com> <546DE3A5.4030500@huawei.com>
Message-ID: <20141120135339.GM19126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 12:50:45PM +0000, leizhen wrote:
> On 2014/11/20 18:13, Will Deacon wrote:
> > On Thu, Nov 20, 2014 at 09:57:01AM +0000, Zhen Lei wrote:
> >> It's dangerous to set pte with ARM_SMMU_PTE_AP_UNPRIV. A hacker can use any
> >> devices running at userspace to access the memory which originally mapped for
> >> kernel devices, suppose they have the same StreamID. The userspace devices
> >> should through vfio to dynamic create mapping.
> > 
> > I don't fully understand the problem here. vfio will create a set of private
> > page tables for the container, so I can't see why the privilege really
> > matters, given that the whole thing is sandboxed anyway.
> 
> Suppose DMA-0 can be running both at kernel space and user space. And kernel
> APP use DMA-0 to access the lowest 4G(physical memory address range: 0~4G,
> because some old DMA devices can only output 32bit address, and phys_to_dma() in
> arch/arm64/include/asm/dma-mapping.h take iova and pa as the same). We can use
> bypass mode or create mapping iova=pa for the lowest 4G. Now, the user APP can
> use DMA-0 to access all the lowest 4G(may contain kernel information and user APP
> originally access prohibitted).

What's a kernel APP? Is DMA-0 some sort of device? How is it running at both
kernel and userspace?

> Through vfio, the user APP can only create mapping for the physical memory which
> it can access through cpu. That's the memory which belong to the user APP, vfio
> should check this.

Yes, so there is no issue when using VFIO.

> And now, arm64 have not support vfio. I don't know how to deal with: a iommu_group
> used by both user devices(through vfio) and kernel devices. They may specify the same
> iova but different pa or diffrent attributes. Maybe we should not support this scene.
> But if all(iova,pa,attr) is the same, we can simply add ARM_SMMU_PTE_AP_UNPRIV in PTE to
> satisfy vfio requirment.

arm64 does support VFIO. Please check the patches queued for 3.19.

> > Furthermore, if we change the default to PRIV, then it will break for any
> > devices wired to emit unprivileged transactions only.
> 
> if so, it's the problem of hardware. I think.

If you have a device that emits the same streamid for privileged and
unprivileged transactions, then I think you have the problem of hardware :)

The right way to solve this would be to add a new IOMMU_PRIV flag (I think
this was discussed in the past) which can be passed to iommu_map.

Will
