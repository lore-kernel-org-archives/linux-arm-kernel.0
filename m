From: thunder.leizhen@huawei.com (leizhen)
Date: Thu, 20 Nov 2014 20:50:45 +0800
Subject: [PATCH 1/1] iommu/arm-smmu: forbid userspace IO devices access
 memory through SMMU by default
In-Reply-To: <20141120101340.GC19126@arm.com>
References: <1416477421-1288-1-git-send-email-thunder.leizhen@huawei.com>
 <20141120101340.GC19126@arm.com>
Message-ID: <546DE3A5.4030500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/20 18:13, Will Deacon wrote:
> On Thu, Nov 20, 2014 at 09:57:01AM +0000, Zhen Lei wrote:
>> It's dangerous to set pte with ARM_SMMU_PTE_AP_UNPRIV. A hacker can use any
>> devices running at userspace to access the memory which originally mapped for
>> kernel devices, suppose they have the same StreamID. The userspace devices
>> should through vfio to dynamic create mapping.
> 
> I don't fully understand the problem here. vfio will create a set of private
> page tables for the container, so I can't see why the privilege really
> matters, given that the whole thing is sandboxed anyway.

Suppose DMA-0 can be running both at kernel space and user space. And kernel
APP use DMA-0 to access the lowest 4G(physical memory address range: 0~4G,
because some old DMA devices can only output 32bit address, and phys_to_dma() in
arch/arm64/include/asm/dma-mapping.h take iova and pa as the same). We can use
bypass mode or create mapping iova=pa for the lowest 4G. Now, the user APP can
use DMA-0 to access all the lowest 4G(may contain kernel information and user APP
originally access prohibitted).

Through vfio, the user APP can only create mapping for the physical memory which
it can access through cpu. That's the memory which belong to the user APP, vfio
should check this.

And now, arm64 have not support vfio. I don't know how to deal with: a iommu_group
used by both user devices(through vfio) and kernel devices. They may specify the same
iova but different pa or diffrent attributes. Maybe we should not support this scene.
But if all(iova,pa,attr) is the same, we can simply add ARM_SMMU_PTE_AP_UNPRIV in PTE to
satisfy vfio requirment.

> 
> Furthermore, if we change the default to PRIV, then it will break for any
> devices wired to emit unprivileged transactions only.

if so, it's the problem of hardware. I think.

> 
> Will
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 60558f7..e31517b 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -92,7 +92,7 @@
>>  #define ARM_SMMU_PTE_CONT_MASK		(~(ARM_SMMU_PTE_CONT_SIZE - 1))
>>
>>  /* Stage-1 PTE */
>> -#define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
>> +#define ARM_SMMU_PTE_AP_PRIV		(((pteval_t)0) << 6)
>>  #define ARM_SMMU_PTE_AP_RDONLY		(((pteval_t)2) << 6)
>>  #define ARM_SMMU_PTE_ATTRINDX_SHIFT	2
>>  #define ARM_SMMU_PTE_nG			(((pteval_t)1) << 11)
>> @@ -1296,7 +1296,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
>>  	}
>>
>>  	if (stage == 1) {
>> -		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
>> +		pteval |= ARM_SMMU_PTE_AP_PRIV | ARM_SMMU_PTE_nG;
>>  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>>  			pteval |= ARM_SMMU_PTE_AP_RDONLY;
>>
>> --
>> 1.8.0
>>
>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
