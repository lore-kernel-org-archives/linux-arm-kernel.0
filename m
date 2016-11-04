From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 4 Nov 2016 20:46:06 +0530
Subject: [PATCH V3 0/8] IOMMU probe deferral support
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <60ee8066-f167-e9df-ae3e-4138f1133bad@arm.com>
 <003a01d22f97$82534c70$86f9e550$@codeaurora.org>
 <421e2b14-0231-d376-02a0-097423120b3d@arm.com>
Message-ID: <006f01d236ae$61751c40$245f54c0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

>>>Yikes, on second look, that definitely shouldn't be happening.
>>>Everything below is probably the resulting fallout.
>>
>>[   40.206703] vfio-pci 0000:08:00.0: Failed to setup iommu ops
>>
>>I think the above print which says "failed to setup iommu_ops"
>>because the call ops->add_device failed in of_pci_iommu_configure
>>is the reason for the failure, in my case i simply do not get this even with
>>your scripts. ops->add_device succeeds in the rebind as well. So still
>>checking what could be happening in your case.
>
>I was looking at your code base from [1].The ops->add_device
>callback from of_pci_iommu_configure on the rebind is the
>one which is causing the failure. But not able to spot out
>from code which point is causing the failure. It would be very helpful
>if i can know which is the return value from the add_device callback
>or point inside add_device callback which fails in your setup.
>
>
>[1] git://linux-arm.org/linux-rm iommu/misc

With little more try, i saw an issue where i had an failure
similar to what you reported. The issue happens when multiple
devices fall in to same group due to matching sids. I ended up
doing a fix like below and it would be nice to verify if it is the same
that we are seeing in your setup and if the fix makes a difference ?

From: Sricharan R <sricharan@codeaurora.org>
Date: Fri, 4 Nov 2016 20:28:49 +0530
Subject: [PATCH] iommu/arm-smmu: Fix group's reference counting

iommu_group_get_for_dev which gets called in the add_device
callback, increases the reference count of the iommu_group,
so we do an iommu_group_put after that. iommu_group_get_for_dev
inturn calls device_group callback and in the case of arm-smmu
we call generic_device_group/pci_device_group which takes
care of increasing the group's reference. But when we return
an already existing group(when multiple devices have same group)
the reference is not incremented, resulting in issues when the
remove_device callback for the devices is invoked.
Fixing the same here.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 71ce4b6..a1d0b3c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1516,8 +1516,10 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 		group = smmu->s2crs[idx].group;
 	}
 
-	if (group)
+	if (group) {
+		iommu_group_get_by_id(iommu_group_id(group));
 		return group;
+	}
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
-- 
1.8.2.1
