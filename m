From: b51431@freescale.com (Peng Fan)
Date: Wed, 4 Nov 2015 10:48:28 +0800
Subject: [RFC] iommu: arm-smmu: correct reference count
In-Reply-To: <20151103131734.GE14159@arm.com>
References: <1446555557-3097-1-git-send-email-van.freenix@gmail.com>
 <20151103131734.GE14159@arm.com>
Message-ID: <20151104024825.GA27479@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Nov 03, 2015 at 01:17:34PM +0000, Will Deacon wrote:
>On Tue, Nov 03, 2015 at 08:59:17PM +0800, Peng Fan wrote:
>> iommu_group_alloc will initialize the reference count for group to 1.
>> iommu_group_add_device also increase the group reference count,
>> if nothing bad happends. And we need to add iommu_group_put to
>> decrease the reference count for group.
>> 
>> Signed-off-by: Peng Fan <van.freenix@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> ---
>> 
>> Not sure whether my understanding is correct or not. I checked rockchip-iommu.c
>> exynos-iommu.c and fsl_pamu_domain.c, and they all have iommu_group_put after
>> iommu_group_add_device.
>
>Doesn't this pair up with the iommu_group_remove_device in
>arm_smmu_remove_device? Are you actually seeing an issue in practice?

In arm_smmu_add_platform_device,
iommu_group_alloc --> group->device_kobj ref count will be init to 1.
iommu_group_add_device --> group->device_kobj ref count will be added 1 to 2.

In arm_smmu_remove_device:
iommu_group_remove_device --> Decrease group->device_kobj ref count by 1.
After arm_smmu_remove_device, the ref count of group->device_kobj is not 0.

So I think need to add iommu_group_put after iommu_group_add_device.
If I am wrong, please correct me.

Just code inspection, not have a platform to test this.

Regards,
Peng.

>
>Will
>_______________________________________________
>iommu mailing list
>iommu at lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

-- 
